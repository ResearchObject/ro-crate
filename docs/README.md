This folder has the [MarkDown](https://guides.github.com/features/mastering-markdown) content that is rendered to <https://researchobject.github.io/ro-crate/> by [GitHub pages](https://pages.github.com/).

A file like [background.md](background.md) appears rendered as <https://researchobject.github.io/ro-crate/background> (aka  <https://www.researchobject.org/ro-crate/background> - see `CNAME`). You may crosslink pages using relative links like `[background](background.md)` - the extension `.md` is replaced with `.html` in rendering.

Note that files outside `docs` are not accessible within `github.io` and must be linked to by absolute URLs, e.g. <https://github.com/ResearchObject/ro-crate/blob/master/CODE_OF_CONDUCT.md>

It is more important that pages render well at <https://researchobject.github.io/ro-crate/> than in this  preview within the GitHub repository, as some MarkDown features only apply to the GitHub Pages (e.g. the `{:toc}` macro and).

## Running Jekyll locally

To test out your changes locally it may be worth running [Jekyll](https://jekyllrb.com/) locally to generate the pages. However installing Jekyll, Ruby and their dependencies locally can be a bit of a challenge depending on your operating system, local permissions and paths.

With [Ruby 2.4](https://www.ruby-lang.org/) or newer installed (possibly using [rvm](https://rvm.io/)), try **from `docs/` folder** the equivalent of:

    sudo gem install bundler
    bundle install
    bundle exec jekyll serve

If you have [Docker] you can avoid the Ruby/Bundler/Jekyll install dance and run from a container:

    make jekyll-docker-serve

Then visit http://0.0.0.0:3000/ to browse a local rendering. 

Alternatively, to render HTML files into `site/` folder, run:

    make jekyll-docker-oneshot

Equivalent commands for using [Podman](https://podman.io/):

    make jekyll-podman-serve  
    # or
    make jekyll-podman-oneshot


## Using the just-the-docs theme

Note that the specification `1.1` onwards uses split files for different sections, these are indexed by the [RunDocs theme](https://rundocs.io/) aka [pmarsceill/just-the-docs](https://github.com/pmarsceill/just-the-docs). The `---` preamble is required on all `*.md` files to help the theme, e.g.:

```
---
title: Metadata of the RO-Crate
excerpt: |
  RO-Crate aims to capture and describe the Research Object using
  structured metadata. The RO-Crate Metadata File Descriptor contains the
  metadata that describes the RO-Crate and its content. This machine-readable
  metadata can also be represented for human consumption in the RO-Crate Website,
  linking to data and Web resources.
redirect_from:
  - /1.1/about
---
```

- `excerpt`: This attribute can be used to specify the metadata description of the page
- `redirect_from`: this can be used to list links from which you want to redirect to the page you are editing.

### Navigation

#### Ordering pages

Ordering pages
To specify a page order, you can use the nav_order parameter in your pages’ YAML front matter.

```
---
title: test
nav_order: 4
---
```

The parameter values determine the order of the top-level pages, and of child pages with the same parent. You can reuse the same parameter values (e.g., integers starting from 1) for the child pages of different parents.

#### Excluding pages form navigation and/or search
To hide a page from the main table of content, e.g. a draft, add `nav_exclude: true` to its preamble:

```
---
nav_exclude: true
search_exclude: true
title: Draft section
---
```

For the RO-Crate specification we should only show the **current** specification in the menu, the older and draft versions are indexed from [specificaton.md](specification.md), therefore `nav_exclude` and `search_exclude` is set to true automatically or manually.

#### Sub pages in a subdirectory

* Parent page:

    ```
    ---
    title: RO-Crate 1.2-DRAFT
    has_children: true
    nav_exclude: true
    ---
    ```

* Child page:

    ```
    ---
    title: Workflows and scripts
    excerpt: |
    Scientific workflows and Scripts that were used (or can be used) to 
    analyze or generate files contained in an RO-Crate can be embedded
    in an RO-Crate and described in detail.
    nav_order: 9
    parent: RO-Crate 1.2-DRAFT 
    ---
    ```

#### Table of Contents

```
# H1 Title
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}
```

### Sections and child pages

Note that the [concatination](Makefile) step to make single page HTML/PDF assumes `<div id="filename">` blobs in top of each section's markdown, as the `Makefile` replaces links to say `"appendix/jsonld.md"` with `#jsonld`. See commit [bfd9b2f530](https://github.com/ResearchObject/ro-crate/commit/bfd9b2f53075f464b069b017c9648460879dda94)

### Admonition cards

With theme it is possible to insert colourful admonition cards to bring attention to caveats and best practices. 
These are written as a Markdown code-block with the language set as `tip`, `note` or `warning`, and can
include a restricted set of Markdown.

```
{: .tip }
> JSON-LD supports [many other features](https://json-ld.org/) that SHOULD NOT be used excessively.
```

Try to keep the admonition card short, like a single paragraph.

For the [Makefile](Makefile) rendering to PDF, a rudimentary [Pandoc filter](scripts/admonition.py)
attempts to translate these blocks back to paragraph rendering, although they don't show up as a box. 
See the [release procedure](RELEASE_PROCEDURE.md).


### Theme config

This file specifies some site-wide properties like copyright text or which folders that need to be excluded from the navigation and/or search.

## References

The [_includes/references.liquid](_includes/references.liquid) file includes Markdown [hyperlink references](https://kramdown.gettalong.org/syntax.html#reference-links) that can be used on shortform, e.g. `[CreativeWork]` gets expanded to `[CreativeWork](http://schema.org/CreativeWork)`  or `[creative work][CreativeWork]` becomes  `[creative work](http://schema.org/CreativeWork)`. This only works on `*.md` pages that have the `{% include references.liquid %}` footer.



