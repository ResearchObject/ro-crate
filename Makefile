## See RELEASE_PROCEDURE.md

# Where to copy from
DRAFT=1.1-RC
# Official release
RELEASE=1.1
# Semantic versioning
TAG=1.1.2
NEXT=1.2-DRAFT
# Prepare (but do not Publish!) the next version of https://zenodo.org/record/3541888
# then copy its DOI here so it can be included in generated HTML/PDF
DOI=10.5281/zenodo.5841615

all: dependencies release

# Check dependencies before we do the rest
dependencies: node_modules/.bin/rochtml
	scripts/schema-context.py --version
	node_modules/.bin/rochtml --version
	pandoc --version
	xelatex --version


clean:
	rm -rf release "docs/${RELEASE}/"

release: release/ro-crate-${TAG}.html release/ro-crate-${TAG}.pdf release/ro-crate-context-${TAG}.jsonld release/ro-crate-metadata.json release/ro-crate-preview.html

# Install dependencies for node
node_modules/.bin/rochtml:
	npm install lodash
	npm install ro-crate-html-js

docs/${RELEASE}/:
	mkdir -p docs/${RELEASE}/

docs/${RELEASE}/_metadata.liquid: docs/${RELEASE}/ docs/${DRAFT}/_metadata.liquid
	sed s/${DRAFT}/${RELEASE}/g < docs/${DRAFT}/_metadata.liquid > docs/${RELEASE}/_metadata.liquid
	sed -i s/TAG/${TAG}/g docs/${RELEASE}/_metadata.liquid
	sed -i "/^<!-- NOTE: Before release.*/ d" docs/${RELEASE}/_metadata.liquid
	sed -i "/^END NOTE -->/ d" docs/${RELEASE}/_metadata.liquid
	sed -i "s/^* Status:.*/* Status: Recommendation/" docs/${RELEASE}/_metadata.liquid
	sed -i "s/^* Published:.*/* Published: `date -I`/" docs/${RELEASE}/_metadata.liquid
	sed -i "s,^* Cite as:.*,* Cite as: <https://doi.org/${DOI}> (this version)," docs/${RELEASE}/_metadata.liquid
	

docs/${RELEASE}/.references.md: docs/${RELEASE}/ docs/_includes/references.liquid
	echo "---\ntitle: References\n---\n\n" > docs/${RELEASE}/.references.md
	echo "# References" >> docs/${RELEASE}/.references.md
	sed 's,^\[,* \\[,' < docs/_includes/references.liquid | \
		sed 's,\]: ,\\]: <,' |\
		sed 's,^\*.*$$,\0>,' \
		>> docs/${RELEASE}/.references.md


docs/${RELEASE}/*.md: docs/${RELEASE}/ docs/${DRAFT}/*.md docs/${DRAFT}/_metadata.liquid docs/${RELEASE}/.references.md
	for f in docs/${DRAFT}/*.md ; do \
		sed s/${DRAFT}/${RELEASE}/g < $$f > docs/${RELEASE}/`basename $$f`;\
    done	

docs/${RELEASE}/appendix/:
	mkdir -p docs/${RELEASE}/appendix/

docs/${RELEASE}/appendix/*.md: docs/${RELEASE}/appendix/ docs/${DRAFT}/appendix/*.md
	for f in docs/${DRAFT}/appendix/*.md ; do \
		sed s/${DRAFT}/${RELEASE}/g < $$f > docs/${RELEASE}/appendix/`basename $$f` ;\
	done

docs/${RELEASE}/ro-crate-metadata.json: docs/${DRAFT}/ro-crate-metadata.json
	sed s/${DRAFT}/${RELEASE}/g < docs/${DRAFT}/ro-crate-metadata.json > docs/${RELEASE}/ro-crate-metadata.json
	sed -i "s/UNPUBLISHED/`date -I`/g" docs/${RELEASE}/ro-crate-metadata.json
	sed -i "s/TAG/${TAG}/g" docs/${RELEASE}/ro-crate-metadata.json
	sed -i "s,DOI,${DOI},g" docs/${RELEASE}/ro-crate-metadata.json
	sed -i "s;ZENODO;`echo ${DOI}|sed s,10.5281/zenodo.,,`;g" docs/${RELEASE}/ro-crate-metadata.json
	rm -f docs/${RELEASE}/ro-crate-metadata.jsonld
	ln -s ro-crate-metadata.json docs/${RELEASE}/ro-crate-metadata.jsonld

docs/${RELEASE}/ro-crate-preview.html: dependencies docs/${RELEASE}/ro-crate-metadata.json
	node_modules/.bin/rochtml docs/${RELEASE}/ro-crate-metadata.json

docs/${RELEASE}/context.jsonld: dependencies docs/${RELEASE}/ scripts/schema-context.py
	scripts/schema-context.py ${RELEASE} ${TAG} > docs/${RELEASE}/context.jsonld

release/:
	mkdir -p release

release/ro-crate-${TAG}.md: dependencies release/ docs/${RELEASE}/_metadata.liquid docs/${RELEASE}/.references.md docs/${RELEASE}/*.md docs/${RELEASE}/appendix/*.md docs/_includes/references.liquid
	cp docs/${RELEASE}/_metadata.liquid docs/${RELEASE}/.metadata.md
	pandoc --from=markdown+gfm_auto_identifiers --to=markdown+gfm_auto_identifiers \
	   docs/${RELEASE}/.metadata.md \
	   `grep ^nav_order: docs/${RELEASE}/*.md | sort -n -k 2 | grep -v index.md| grep -v about.md | sed s/:.*//` \
	   docs/${RELEASE}/appendix/*.md docs/_includes/references.liquid docs/${RELEASE}/.references.md |\
	   grep -v '{%' > release/ro-crate-${TAG}.md
	# Fix internal links to work in single-page
	sed -i -E 's,]\(([^:)]*/)*([^:)]*)\.md\),](#\2),g' release/ro-crate-${TAG}.md
	sed -i -E 's,]\([^):]*\.md#([^)]*)\),](#\1),g' release/ro-crate-${TAG}.md


release/ro-crate-${TAG}.html: dependencies release/ release/ro-crate-${TAG}.md
	egrep -v '^{:(\.no_)?toc}' release/ro-crate-${TAG}.md | \
	pandoc --standalone --number-sections --toc --section-divs \
	  --filter scripts/pandoc-admonition.py \
	  --metadata pagetitle="RO-Crate Metadata Specification ${RELEASE}" \
	  --from=markdown+gfm_auto_identifiers -o release/ro-crate-${TAG}.html

release/ro-crate-${TAG}.pdf: dependencies release/ release/ro-crate-${TAG}.md
	egrep -v '^{:(\.no_)?toc}' release/ro-crate-${TAG}.md | \
	pandoc --pdf-engine xelatex --variable=hyperrefoptions:colorlinks=true,allcolors=blue \
	  --variable papersize=a4 --filter scripts/pandoc-admonition.py \
	  --number-sections --toc  --metadata pagetitle="RO-Crate Metadata Specification ${RELEASE}" \
	  --from=markdown+gfm_auto_identifiers -o release/ro-crate-${TAG}.pdf

release/ro-crate-context-${TAG}.jsonld: dependencies release/ docs/${RELEASE}/context.jsonld
	cp docs/${RELEASE}/context.jsonld release/ro-crate-context-${TAG}.jsonld

release/ro-crate-metadata.json: dependencies release/ docs/${RELEASE}/ro-crate-metadata.json
	cp docs/${RELEASE}/ro-crate-metadata.json release/ro-crate-metadata.json

release/ro-crate-preview.html: dependencies release/ docs/${RELEASE}/ro-crate-preview.html
	cp docs/${RELEASE}/ro-crate-preview.html release/ro-crate-preview.html

# From https://stackoverflow.com/a/18137056
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_absdir := $(dir $(mkfile_path))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

podman-pre:
	chmod go+w "${mkfile_absdir}/docs" "${mkfile_absdir}/docs/Gemfile.lock"

docker-fix-permissions:
	docker run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume="${mkfile_absdir}/docs:/srv/jekyll" jekyll/jekyll chown -R $(shell id -u):$(shell id -g) /srv/jekyll

jekyll-podman-serve:	podman-pre
	podman run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume="${mkfile_absdir}/docs:/srv/jekyll" -p 4000:4000 jekyll/jekyll jekyll serve --incremental

jekyll-podman-oneshot:	podman-pre
	podman run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume="${mkfile_absdir}/docs:/srv/jekyll" jekyll/jekyll jekyll build

jekyll-docker-serve:
	docker run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume="${mkfile_absdir}/docs:/srv/jekyll" -p 4000:4000 jekyll/jekyll jekyll serve --incremental
	# Next one fixes permissions
	docker run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume="${mkfile_absdir}/docs:/srv/jekyll" jekyll/jekyll chown -R $(shell id -u):$(shell id -g) /srv/jekyll

jekyll-docker-oneshot:
	docker run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume="${mkfile_absdir}/docs:/srv/jekyll" jekyll/jekyll jekyll build
	# Next one fixes permissions
	docker run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume="${mkfile_absdir}/docs:/srv/jekyll" jekyll/jekyll chown -R $(shell id -u):$(shell id -g) /srv/jekyll
