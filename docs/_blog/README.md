# Developer notes for the blog

First read the [template](.template.md) to understand how posts should be structured. These notes add to that.

## File structure

Each post is contained within a folder whose name should be set to the intended publication date. 

_blog/
├─ yy-mm-dd/
│  ├─ post-name.md
│  ├─ my_image.png

All images or other supplementary files related to the post should be included in the same folder.

## Duplication of metadata?

The duplicated date metadata between the folder and the front matter is necessary because of the inner workings of the Jekyll static site generator, plus a desire for ease of use. Having folders ordered by date is beneficial when the number of posts becomes large, and is useful for the permalink, but retrieving this folder name to use in Jekyll variables is not straightforward. Setting `date` in each post's front matter makes it easy to reference the date both within the page and when iterating over the whole collection, but the front matter `date` can't be used in the permalink as image files do not have that front matter. It is not a disaster if the date in the front matter changes slightly from the folder name, but we should aspire to keep these consistent and check for this when reviewing.

## Blog permalinks

The blog post URLs are generated from the filenames using the permalink format defined in `_config.yml`, for example:

```
collections:
  blog:
    permalink: /blog/:path
```

This example means that a post file at the path `2025-06-12/demo-post.md` will have the link `/blog/2025-06-12/demo-post`.

The Jekyll docs on [collections](https://jekyllrb.com/docs/collections/) and [permalinks](https://jekyllrb.com/docs/permalinks/) are useful references for changing any of the configuration.

## Why not use Jekyll's [built-in blogging features](https://jekyllrb.com/docs/posts/)?

Jekyll's [posts](https://jekyllrb.com/docs/posts/) feature automates much of what we have manually configured. However, it is very strict about filenames, and will only process Markdown or HTML files with filenames which start with a date (e.g. `2012-09-12-how-to-write-a-blog.md`). As of July 2025, the posts feature does *not* support including images next to the Markdown files (instead they have to go in `assets/img` with all the other website images). 

Keeping the post and the images together was deemed important to the RO-Crate blog, as it will make it easier to migrate to another website/blog framework should we ever decide to do that. For this reason, we created a custom `_blog` collection which would work with our desired file structure.

If we desire to add tags or categories in future, this will have to be done manually rather than using the built-in options.
