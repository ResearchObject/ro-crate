---
title:  "RO-Crates at the FAIR Digital Objects Conference 2026"
author: ["Eli Chadwick"]
date: 2026-04-01
related_pages:
    use_cases: [page_id1, page_id2] # should match items in pages/use_cases
---

The [3rd FAIR Digital Objects (FDO) Conference] was held from 25-27 March 2026, with a pre-conference training day on 24 March. Representatives of many projects spanning academia, industry, and government gathered together to discuss how to advance FAIR and open science through the adoption of the FAIR Digital Objects.

## How RO-Crate relates to FDOs

Intro paragraph

## Pre-conference Training Day

Stian Soiland-Reyes and Thivisha ? delivered a training session covering FAIR Signposting and RO-Crate. There were also training sessions on two other FDO flavours: Handle FDOs and Nanopublications.

## Day 1: Trust Day

Trust day notes...

## Day 2

On Day 2 the programme zoomed in on specific implementations of FDOs for particular use cases.

[? from CLARIN] highlighted their vision for RO-Crates for their "virtual collections" - collections of datasets which are linked together using web-based data entities within RO-Crate.

[The morning panel] produced a call for community building, and making FDOs an invisible part of the research infrastructure. Adaptability is essential, as is interoperability - working together toward a shared goal.

[Lukas Weil from DataPLANT] provided an overview of the ARC (Annotated Research Context) Framework, [just link to this]

[Theodor Strauch from IPK Gatersleben] shared their use of the ARC framework in FAIRagro - applying ARC to measurements of seeds, plants, samples in agriculture studies.

[KIK-IPRA guy] presented the H-SEARCH project -a cultural heritage project with multiple strands, one of which focuses on digitising and archiving datasets using BagIt and RO-Crate.

[Esteban from Madrid/FAIR2Adapt] shared how his project combines the best features of both RO-Crate and Nanopublications - Ro-Crate for linked datasets and publications, and Nanopublications to describe claims made within or by the data and publications.

## Writing the post

You could write about:
* how you're using RO-Crate in your project or domain
* an event you attended where RO-Crate was mentioned
* a tool you've created for handling RO-Crates
* an idea you've been exploring and want to share.

When writing the post, make sure to expand any acronyms you use, and link out to other pages where it's useful.

If you're writing about a particular domain, give some background to help community members outside 
the domain understand your work.

## Including images

If you want to include an image in your blog post, add the image to the same folder as the post's Markdown file:

```
_blog/
├─ yyyy-mm-dd/
│  ├─ post-name.md
│  ├─ my_image.png
```

 You can then include the image in the Markdown text with the following code:

```
{% include image.html src="my_image.png" caption="A test image" alt="Description of image" %}
```

Set `src` to the image path, then set `caption` and `alt` to appropriate descriptions of the image. The `caption` will be displayed on the page, while the `alt` will be used for the image alternative description (used by screen readers).

## Including internal links

If you want to link to another page on the RO-Crate website, format the link as follows:

```
[link text]({{baseurl}}{% link path/to/markdown/file.md %})
```

Here the path should be relative to the `docs/` folder. Do not edit the `{{ baseurl }}` part.

This is necessary because the blog posts have automatically-generated permalinks that don't match the location of the Markdown files in the folder structure, so using a relative path to another page doesn't work as you might expect. This format lets Jekyll handle setting the correct URL for the linked page.

Pages outside the RO-Crate website can be linked in the usual fashion: `[link text](url)`.

## Submit the post

When your blog post is ready, open a pull request to the [ro-crate repository](https://github.com/ResearchObject/ro-crate). One of the website maintainers will review it and merge.

Once merged, your post will appear at the path `https://www.researchobject.org/ro-crate/blog/yyyy-mm-dd/title-of-your-post`.
