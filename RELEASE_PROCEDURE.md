# Release Procedure

This documents the release procedure for RO-Crate from the GitHub repository <https://github.com/ResearchObject/ro-crate>

Versions assumed by this document is that `1.1-DRAFT` is to be released as `1.1` (tag `1.1.0`), replacing `1.0` and making new draft `1.2-DRAFT`. Consistent use of `-DRAFT` simplifies the search-replace operations at release time, as replacing`1.0` could match other strings.

Overview:
* GitHub housekeeping
  * Update team list in `docs/index.md` with new members in <https://github.com/ResearchObject/ro-crate/issues/1>
  * Ensure contributors of recent PRs are in team
* Update changelog - note the use of [Semantic Versioning](https://semver.org/) - RO-Crate 1.1 will have GitHub tag `1.1.0`
  * If this is a later patch update (e.g. typo in `context.jsonld`) then tag as `1.1.1` while all `1.1` strings stays the same. No need for new DOI etc, just add to changelog as new patch version.
* Update author-list in `docs/1.1-DRAFT/index.md` based on 
* Update `docs/1.1-DRAFT/ro-crate-metadata.json` (eat our own dogfood)
* Announce Release Candidate to RO-Crate community - "fire in the hole"!
  * Check for typos, MArkdown rendering errors, JSON errors
  * Test examples and DRAFT @context in <https://json-ld.org/playground/>
  * .. ideally wait 1 week, wait for typo fixes etc.
* Copy `docs/1.1-DRAFT/` to `docs/1.1/`
* Search-replace `1.1-DRAFT` to `1.1` in `docs/1.1/*`
* Prepare a new version of the Zenodo record <https://zenodo.org/record/3541888>
  * **Important** Do not yet click **Publish**! * 
  * Delete the old uploads
  * Update author list for new members.
  * Update description if needed
  * Update version
  * Update (planned) release date
  * Under _Related identifiers_ set the _Alternative Identifier_ to the future w3id permalink  <https://w3id.org/ro/crate/1.1> and the _Previous version_ to the old permalink <https://w3id.org/ro/crate/1.0>
  * **Important** Copy the pre-allocated DOI from the **draft** Zenodo entry
* Check/update permalink <https://w3id.org/ro/crate/1.1> in `docs/1.1/*`. Note that it won't work until `doc/1.1/` folder exists!
* Add **DOI** and (planned) release date to `docs/1.1/index.md` and `docs/1.1/ro-crate-metadata.json`
 * Note, there are two DOIs at Zenodo:
   - Version-independent <https://doi.org/10.5281/zenodo.3406497> pointing to latest version
   - Version-specific DOI - which you got from the draft 
* Render `docs/1.1/ro-crate-preview.html` using [ro-crate from npm](https://www.npmjs.com/package/ro-crate)
  * Make sure output uses the (not-yet released) permalinks <https://w3id.org/ro/crate/1.1> and <<https://w3id.org/ro/crate/1.1/context>
* Push `docs/1.1` to GitHub and verify GitHub Pages rendering and permalinks.
* Convert docs/1.1/index.md to PDF using `pandoc`
  * `apt install pandoc texlive-latex-recommended`
  * `release/ro-crate-1.1.0.pdf`
* Convert docs/1.1/index.md to PDF using `pandoc`
  * `apt install pandoc wkhtmltopdf`
  * `mkdir release` (do not check in this folder!)
  * `pandoc -i docs/1.1/index.md -o release/ro-crate-1.1.0.html`
  * `pandoc --pdf-engine wkhtmltopdf -i docs/1.1/index.md -o release/ro-crate-1.1.0.pdf`
* Tag in GitHub. [Semantic Versioning](https://semver.org/) so RO-Crate 1.1 will be tagged `1.1.0`
* Prepare release artifacts by copying from `docs/1.1` to a temporary folder. Rename to include version in filename and upload artifacts to the **release**:
    - `ro-crate-1.1.0.html` 
    - `ro-crate-1.1.0.pdf`
    - `ro-crate-context-1.1.0.jsonld`
    - `ro-crate-metadata.jsonld`
    - `ro-crate-preview.html`
* Update Release notes in GitHub
  * Paste in from Changelog section and the permalink/date headers from `docs/1.1/index.md` 
  * Example <https://github.com/ResearchObject/ro-crate/releases/tag/1.0.0>
* Upload same artifacts to Zenodo from the GitHub release. 
  - Under _Related identifiers_ modify _Identical to_ to point to the new GitHub release tag
  - Verify and click **Publish**
* Add released version to `docs/index.md`
* Announce new version to:
  * [RO-Crate team](https://github.com/orgs/ResearchObject/teams/ro-crate)
  * [public-rosc](https://lists.w3.org/Archives/Public/public-rosc/)
  * [researchobject.org](https://github.com/ResearchObject/ResearchObject.github.io)
  * Twitter
  * Websites of related projects/groups
  * Announcement should only include main point from changelog. Include permalink <https://w3id.org/ro/crate/1.1>  **and** DOI as well as link to RO-Crate community [issue #1](<https://github.com/ResearchObject/ro-crate/issues/1>)
* Prepare next draft:
  * Copy `docs/1.1-DRAFT/` to `docs/1.2-DRAFT/` and search-replace to `1.2-DRAFT`
  * Delete `docs/1.1-DRAFT/*`, but copy released `1.1/context.jsonld` back to `1.1-DRAFT/context.jsonld` (avoid breaking existing use)
  * Add link to draft on `docs/index.md`


## GitHub issues

Check state of [GitHub project](https://github.com/ResearchObject/ro-crate/projects/1) and [Milestones](https://github.com/ResearchObject/ro-crate/milestones). _If there was no milestone for this release, add one._

Close/split resolved issues still open, and remove milestone from issues that did not make the cut.

Check [recently updated issues](https://github.com/ResearchObject/ro-crate/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc) and any [open pull requests](https://github.com/ResearchObject/ro-crate/pulls).

Ensure [merged pull requests](https://github.com/ResearchObject/ro-crate/pulls?q=is%3Apr+is%3Aclosed) and [closed issues](https://github.com/ResearchObject/ro-crate/issues?q=is%3Aissue+is%3Aclosed) have the corresponding milestone.

Check the current draft, e.g. <https://www.researchobject.org/ro-crate/1.1-DRAFT/> and corresponding JSON-LD context <https://www.researchobject.org/ro-crate/1.1-DRAFT/context.jsonld> are as expected. If you have recently committed to the git repository you may have to do Ctrl-Shift-R to refresh your browser.



## Preparing next draft version

Create new [milestone](https://github.com/ResearchObject/ro-crate/milestones) for next release.

Manually copy release the old draft (say `1.1-DRAFT`) to next (e.g. `1.2-DRAFT`). This means commits within the new folder will only reflect changes since this release. We copy draft-to-draft so we don't have to undo the release-specific header (e.g. publication date, DOI).

Make sure the diff between the release directory `1.1` and `1.2-DRAFT` only reflect metadata/version changes. If not, some changes have been done directly on `1.1`.

Search-replace old version string `1.1-DRAFT` to new `1.2-DRAFT` in `1.2-DRAFT/index.md` `1.2-DRAFT/context.jsonld` `1.2-DRAFT/ro-crate-metadata.json` and `scripts/schema-context.py`

