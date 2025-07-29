# Developer notes for the blog

First read the [template](.template.md) to understand how posts should be structured. These notes add to that.

## Duplication of metadata?

The duplicated metadata between the file name and the front matter is necessary because of the inner workings of the Jekyll static site generator. Specifically, we make use of Jekyll's [built-in blogging system](https://jekyllrb.com/docs/posts/), which generates post URLs based on the filename and won't process files without the date in the filename. It is not a disaster if the date or title in the front matter change slightly from the file name, but we should aspire to keep these consistent.

## Blog permalinks

The blog post URLs are generated from the filenames using the permalink format defined in `_config.yml`, for example:

```
collections:
  posts:
    permalink: /blog/:year/:month/:title
```

This example means that a post file named `2025-06-12-demo-post` will have the link `/blog/2025/06/demo-post`.

The Jekyll docs on [posts](https://jekyllrb.com/docs/posts/) and [permalinks](https://jekyllrb.com/docs/permalinks/) are useful references for changing any of the configuration.
