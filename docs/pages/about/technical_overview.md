---
title: RO-Crate Technical Overview
---

# RO-Crate Technical Overview
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC 
{:toc}

## What is an RO-Crate?

An RO-Crate is a [Research Object](background#research-object-background) (or _RO_) formed of a collection of data (a _crate_) and a special `ro-crate-metadata.json` file which describes the collection.

The collection may contain any kind of research data - papers, data files, software, references to other research, and so on. It may be a folder full of files, an abstract grouping of connected references, or a combination of both.

The `ro-crate-metadata.json` file (also known as the _RO-Crate Metadata Document_) is a plain text file, readable by humans and machines, that includes metadata for each item within the collection - the authors, license, identifier, provenance, and so on. Any folder can be turned into an RO-Crate by adding an `ro-crate-metadata.json` file.

Researchers can distribute their work as an RO-Crate to ensure their data travels with its metadata, so that key components are correctly tracked, archived, and attributed.

RO-Crate uses the [JSON-LD](https://json-ld.org) format, which is based on [JSON](https://www.json.org/json-en.html). The `ro-crate-metadata.json` file can be written by hand or by using one of the existing [tools](tools). Some workflow managers (such as Galaxy) support exporting RO-Crates from their web interface.

Below is an example of an `ro-crate-metadata.json` file, which describes rainfall data published by an Australian institute under a Creative Commons license:

```
{
  "@context": "https://w3id.org/ro/crate/1.2/context",
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2"},
      "about": {"@id": "./"}
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "name": "Example dataset for RO-Crate specification",
      "description": "Official rainfall readings for Katoomba, NSW 2022, Australia",
      "datePublished": "2022-12-01",
      "publisher": {"@id": "https://ror.org/04dkp1p98"},
      "license": {"@id": "http://spdx.org/licenses/CC0-1.0"},
      "hasPart": [
        {"@id": "data.csv"}
      ]
    },
    {
      "@id": "data.csv",
      "@type": "File",
      "name": "Rainfall data for Katoomba, NSW Australia February 2022",
      "encodingFormat": "text/csv",
      "license": {"@id": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/"}
    },
    {
      "@id": "https://ror.org/04dkp1p98",
      "@type": "Organization",
      "name": "Bureau of Meteorology",
      "description": "Australian Government Bureau of Meteorology",
      "url": "http://www.bom.gov.au/"
    },
    {
      "@id": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/",
      "@type": "CreativeWork",
      "name": "CC BY-NC-SA 3.0 AU",
      "description": "Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia"
    }
  ]
}
```

See [Walkthrough of an RO-Crate](specification/1.2/introduction#walkthrough-an-initial-ro-crate) for an explanation of each element of the file, or [Tutorials](tutorials) for a hands-on introduction.


## About the RO-Crate Community

The [RO-Crate specification](specification) is developed openly on GitHub by research community members across the globe. RO-Crate [tools](tools) and [profiles](profiles) are also community-developed and open-source. 

Anyone can join the RO-Crate community and contribute to these outputs. See the [Community](community) pages for more information.


