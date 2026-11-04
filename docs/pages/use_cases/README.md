# Add your use case

If you are using RO-Crate in your project, we welcome you to add your use case here. The use case should be written in [Markdown](https://www.markdownguide.org/),  include a description of the project, how it uses RO-Crate, and any relevant links. You may also include a logo and screenshots.

See example: <https://www.researchobject.org/ro-crate/rohub>

## How to add a new use case
First upload logo in SVG or PNG format to [assets.img](../assets/img), naming it same as the new page, e.g. `example.svg` to match `example.md` - you may also add a `example-screenshot.png` to illustrate how RO-Crate is used.

Then in this folder, create a new Markdown file using the [template](.template.md), e.g. `example.md`.

Save a copy of the logo to [/docs/images](../../images) as required by the ETT template so we can use the `page_img` feature. This means the logo will appear in the sidebar of the page and on the list of all use cases.

Add the use case to the sidebar in [/docs/_data/sidebars/main.yml](../../_data/sidebars/main.yml) in the correct place alphabetically. 

## Template
The template [here](.template.md) provides a structure for your use case to get started. Your use case should contain the following page data values:

- **page_id**: example
- **title**: Example Use Case Title
- **description**: This is a short description of the project, how it uses RO-Crate, and what it does.
- **url**: https://example.org/
- **page_img**: example.svg

Replace _Example_ and _example.org_ in the template with the name/link for your project.


