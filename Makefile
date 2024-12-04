## See RELEASE_PROCEDURE.md

# Where to copy from
DRAFT=1.2-DRAFT
# Official release
RELEASE=1.2
# Semantic versioning
TAG=1.2.0
NEXT=1.3-DRAFT
# Prepare (but do not Publish!) the next version of https://zenodo.org/record/3541888
# then copy its DOI here so it can be included in generated HTML/PDF
DOI=10.5281/zenodo.13751027

all: dependencies release

# Check dependencies before we do the rest
dependencies: node_modules/.bin/rochtml
	scripts/schema-context.py --version
	node_modules/.bin/rochtml --help
	pip --exists-action=s install 'panflute==2.1.3'
	pandoc --version
	xelatex --version


clean:
	rm -rf release "docs/_specification/${RELEASE}/"

release: release/ro-crate-${TAG}.html release/ro-crate-${TAG}.pdf release/ro-crate-context-${TAG}.jsonld release/ro-crate-metadata.json release/ro-crate-preview.html

# Install dependencies for node
node_modules/.bin/rochtml:
	npm install ro-crate-html

docs/_specification/${RELEASE}/:
	mkdir -p docs/_specification/${RELEASE}/

docs/_specification/${RELEASE}/_metadata.liquid: docs/_specification/${RELEASE}/ docs/_specification/${DRAFT}/_metadata.liquid
	sed s/${DRAFT}/${RELEASE}/g < docs/_specification/${DRAFT}/_metadata.liquid > docs/_specification/${RELEASE}/_metadata.liquid
	sed -i s/TAG/${TAG}/g docs/_specification/${RELEASE}/_metadata.liquid
	sed -i "/^<!-- NOTE: Before release.*/ d" docs/_specification/${RELEASE}/_metadata.liquid
	sed -i "/^END NOTE -->/ d" docs/_specification/${RELEASE}/_metadata.liquid
	sed -i "s/^* Status:.*/* Status: Recommendation/" docs/_specification/${RELEASE}/_metadata.liquid
	sed -i "s/^* Published:.*/* Published: `date -I`/" docs/_specification/${RELEASE}/_metadata.liquid
	sed -i "s,^* Cite as:.*,* Cite as: <https://doi.org/${DOI}> (this version)," docs/_specification/${RELEASE}/_metadata.liquid
	

docs/_specification/${RELEASE}/.references.md: docs/_specification/${RELEASE}/ docs/_includes/references.liquid
	echo "---\ntitle: References\n---\n\n" > docs/_specification/${RELEASE}/.references.md
	echo "# References" >> docs/_specification/${RELEASE}/.references.md
	sed 's,^\[,* \\[,' < docs/_includes/references.liquid | \
		sed 's,\]: ,\\]: <,' |\
		sed 's,^\*.*$$,\0>,' \
		>> docs/_specification/${RELEASE}/.references.md


docs/_specification/${RELEASE}/*.md: docs/_specification/${RELEASE}/ docs/_specification/${DRAFT}/*.md docs/_specification/${DRAFT}/_metadata.liquid docs/_specification/${RELEASE}/.references.md
	for f in docs/_specification/${DRAFT}/*.md ; do \
		sed s/${DRAFT}/${RELEASE}/g < $$f > docs/_specification/${RELEASE}/`basename $$f`;\
    done	

docs/_specification/${RELEASE}/appendix/:
	mkdir -p docs/_specification/${RELEASE}/appendix/

docs/_specification/${RELEASE}/appendix/*.md: docs/_specification/${RELEASE}/appendix/ docs/_specification/${DRAFT}/appendix/*.md
	for f in docs/_specification/${DRAFT}/appendix/*.md ; do \
		sed s/${DRAFT}/${RELEASE}/g < $$f > docs/_specification/${RELEASE}/appendix/`basename $$f` ;\
	done

docs/_specification/${RELEASE}/ro-crate-metadata.json: docs/_specification/${DRAFT}/ro-crate-metadata.json
	sed s/${DRAFT}/${RELEASE}/g < docs/_specification/${DRAFT}/ro-crate-metadata.json > docs/_specification/${RELEASE}/ro-crate-metadata.json
	sed -i "s/UNPUBLISHED/`date -I`/g" docs/_specification/${RELEASE}/ro-crate-metadata.json
	sed -i "s/TAG/${TAG}/g" docs/_specification/${RELEASE}/ro-crate-metadata.json
	sed -i "s,DOI,${DOI},g" docs/_specification/${RELEASE}/ro-crate-metadata.json
	sed -i "s;ZENODO;`echo ${DOI}|sed s,10.5281/zenodo.,,`;g" docs/_specification/${RELEASE}/ro-crate-metadata.json
	rm -f docs/_specification/${RELEASE}/ro-crate-metadata.jsonld
	ln -s ro-crate-metadata.json docs/_specification/${RELEASE}/ro-crate-metadata.jsonld

docs/_specification/${RELEASE}/ro-crate-preview.html: dependencies docs/_specification/${RELEASE}/ro-crate-metadata.json
	node_modules/.bin/rochtml docs/_specification/${RELEASE}/ro-crate-metadata.json

docs/_specification/${RELEASE}/context.jsonld: dependencies docs/_specification/${RELEASE}/ scripts/schema-context.py
	scripts/schema-context.py ${RELEASE} ${TAG} > docs/_specification/${RELEASE}/context.jsonld

release/:
	mkdir -p release

release/ro-crate-${TAG}.md: dependencies release/ docs/_specification/${RELEASE}/_metadata.liquid docs/_specification/${RELEASE}/.references.md docs/_specification/${RELEASE}/*.md docs/_specification/${RELEASE}/appendix/*.md docs/_includes/references.liquid
	cp docs/_specification/${RELEASE}/_metadata.liquid docs/_specification/${RELEASE}/.metadata.md
	pandoc --from=markdown+gfm_auto_identifiers --to=markdown+gfm_auto_identifiers \
	   docs/_specification/${RELEASE}/.metadata.md \
	   `grep ^nav_order: docs/_specification/${RELEASE}/*.md | sort -n -k 2 | grep -v index.md| grep -v about.md | sed s/:.*//` \
	   docs/_specification/${RELEASE}/appendix/*.md docs/_includes/references.liquid docs/_specification/${RELEASE}/.references.md \
	   > release/ro-crate-${TAG}.md
	# Our own rendering of Note/Warning/Tip
	sed -i -E 's/\{% include callout.html //g' release/ro-crate-${TAG}.md
	sed -i -E 's/\" %}//g' release/ro-crate-${TAG}.md
	sed -i -E 's/type=\"note\" content=\"/**Note**: /g' release/ro-crate-${TAG}.md
	sed -i -E 's/type=\"warning\" content=\"/**Warning** :/g' release/ro-crate-${TAG}.md
	sed -i -E 's/type=\"tip\" content=\"/**Tip**: /g' release/ro-crate-${TAG}.md
	sed -i -E 's/type=\"important\" content=\"/**Important**: /g' release/ro-crate-${TAG}.md
	# remove any remaining lines beginning with {%
	sed -i -E 's/\{%.*//g' release/ro-crate-${TAG}.md
	# Skip intermediate table-of-contents
	sed -i -E 's/1..*\{:toc\}//g' release/ro-crate-${TAG}.md
	sed -i -E 's/## Table of contents//g' release/ro-crate-${TAG}.md
	sed -i -E 's/\{:[^}]*\}//g' release/ro-crate-${TAG}.md
	# Fix internal links to work in single-page
	sed -r -i -E 's,]\(([^:)]*/)*([^:)]*)(\.md)?\),](#\2),g' release/ro-crate-${TAG}.md
	sed -r -i -E 's,]\([^):]*(\.md)?#([^)]*)\),](#\2),g' release/ro-crate-${TAG}.md


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

release/ro-crate-context-${TAG}.jsonld: dependencies release/ docs/_specification/${RELEASE}/context.jsonld
	cp docs/_specification/${RELEASE}/context.jsonld release/ro-crate-context-${TAG}.jsonld

release/ro-crate-metadata.json: dependencies release/ docs/_specification/${RELEASE}/ro-crate-metadata.json
	cp docs/_specification/${RELEASE}/ro-crate-metadata.json release/ro-crate-metadata.json

release/ro-crate-preview.html: dependencies release/ docs/_specification/${RELEASE}/ro-crate-preview.html
	cp docs/_specification/${RELEASE}/ro-crate-preview.html release/ro-crate-preview.html

# From https://stackoverflow.com/a/18137056
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_absdir := $(dir $(mkfile_path))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

podman-pre:
	chmod go+w "${mkfile_absdir}/docs" "${mkfile_absdir}/docs/Gemfile.lock"

docker-fix-permissions:
	docker run -it --volume="${mkfile_absdir}/docs:/srv/jekyll" alpine:3.15 chown -R $(shell id -u):$(shell id -g) /srv/jekyll

docker-clean: docker-fix-permissions
	docker volume inspect ro-crate-jekyll >/dev/null && docker volume rm ro-crate-jekyll
	docker rm jekyll-ro-crate

jekyll-podman-serve:	podman-pre
	podman run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate -e JEKYLL_ENV=docker --volume="${mkfile_absdir}/docs:/srv/jekyll" -p 4000:4000 jekyll/jekyll jekyll serve --incremental --config  _config.yml,_config.docker.yml

jekyll-podman-oneshot:	podman-pre
	podman run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume="${mkfile_absdir}/docs:/srv/jekyll" jekyll/jekyll jekyll build

jekyll-docker-dependencies:
	docker volume inspect ro-crate-jekyll 2>/dev/null >/dev/null || \
	(docker volume create ro-crate-jekyll && \
	 docker run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume ro-crate-jekyll:/usr/local/bundle --volume="${mkfile_absdir}/docs:/srv/jekyll" -p 4000:4000 jekyll/jekyll jekyll clean)

## See https://tonyho.net/jekyll-docker-windows-and-0-0-0-0/
jekyll-docker-serve: jekyll-docker-dependencies
	docker run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate -e JEKYLL_ENV=docker --volume ro-crate-jekyll:/usr/local/bundle --volume="${mkfile_absdir}/docs:/srv/jekyll" -p 4000:4000 jekyll/jekyll jekyll serve --incremental --config  _config.yml,_config.docker.yml
	# Next one fixes permissions
	docker run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume ro-crate-jekyll:/usr/local/bundle --volume="${mkfile_absdir}/docs:/srv/jekyll" jekyll/jekyll chown -R $(shell id -u):$(shell id -g) /srv/jekyll

jekyll-docker-oneshot: jekyll-docker-dependencies
	docker run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume ro-crate-jekyll:/usr/local/bundle --volume="${mkfile_absdir}/docs:/srv/jekyll" jekyll/jekyll jekyll build
	# Next one fixes permissions
	docker run -it --rm --name jekyll-ro-crate -e PAGES_REPO_NWO=researchobject/ro-crate --volume ro-crate-jekyll:/usr/local/bundle --volume="${mkfile_absdir}/docs:/srv/jekyll" jekyll/jekyll chown -R $(shell id -u):$(shell id -g) /srv/jekyll
