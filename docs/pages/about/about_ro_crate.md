---
title: About RO-Crate
sidebar: about
---

# About RO-Crate
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
  "@context": "https://w3id.org/ro/crate/1.1/context",
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1"},
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

See [Walkthrough of an RO-Crate](specification/1.2-DRAFT/introduction#walkthrough-an-initial-ro-crate) for an explanation of each element of the file, or [Tutorials](tutorials) for a hands-on introduction.

## Why should I use RO-Crate?

When someone else uses your data in their research, it's important for them to know where the data came from and how they should cite it. Using RO-Crate helps users of your data answer questions like:

* when and how was this data collected/generated?
* who should be cited as authors for this dataset?
* how do the different files in the dataset relate to each other?

A number of platforms currently support importing and/or exporting RO-Crates (see [Use Cases](use_cases)), and interoperability continues to grow thanks to the thriving [RO-Crate community](community).

## Who is RO-Crate for?

RO-Crate is for both producers and consumers of data. The RO-Crate community effort brings together practitioners from very different backgrounds, and with different motivations and use-cases. Among our core target users are:

* researchers engaged with computation and data-intensive, workflow-driven analysis
* digital repository managers and infrastructure providers
* individual researchers looking for a straight-forward tool or how-to guide to “FAIRify” their data
* data stewards supporting research projects in creating and curating datasets.

RO-Crates are suitable for any domain, as they are general-purpose and can contain arbitrary data, but they can also be specialised through the use of [RO-Crate Profiles](profiles). Profiles define additional conventions, types and properties that RO-Crates may use within a particular domain, application or framework. For example, the [Workflow RO-Crate profile](https://w3id.org/workflowhub/workflow-ro-crate/) provides guidance on constructing RO-Crates that describe executable workflows.

We continue to gather [use cases](use_cases), please help us by adding more.

## About the RO-Crate Community

The [RO-Crate specification](specification) is developed openly on GitHub by research community members across the globe. RO-Crate [tools](tools) and [profiles](profiles) are also community-developed and open-source. 

Anyone can join the RO-Crate community and contribute to these outputs. See the [Community](community) pages for more information.

## Cite RO-Crate

### Cite RO-Crate as project/approach

Stian Soiland-Reyes, Peter Sefton, Mercè Crosas, Leyla Jael Castro, Frederik Coppens, José M. Fernández, Daniel Garijo, Björn Grüning, Marco La Rosa, Simone Leo, Eoghan Ó Carragáin, Marc Portier, Ana Trisovic, RO-Crate Community, Paul Groth, Carole Goble (2022):  
**Packaging research artefacts with RO-Crate**.  
_Data Science_ **5**(2)  
<https://doi.org/10.3233/DS-210053>  

### Cite RO-Crate Specification (any version)

Peter Sefton, Eoghan Ó Carragáin, Stian Soiland-Reyes, Oscar Corcho, Daniel Garijo, Raul Palma, Frederik Coppens, Carole Goble, José María Fernández, Kyle Chard, Jose Manuel Gomez-Perez, Michael R Crusoe, Ignacio Eguinoa, Nick Juty, Kristi Holmes, Jason A. Clark, Salvador Capella-Gutierrez, Alasdair J. G. Gray, Stuart Owen, Alan R Williams, Giacomo Tartari, Finn Bacall, Thomas Thelen, Hervé Ménager, Laura Rodríguez Navas, Paul Walk, brandon whitehead, Mark Wilkinson, Paul Groth, Erich Bremer, LJ Garcia Castro, Karl Sebby, Alexander Kanitz, Ana Trisovic, Gavin Kennedy, Mark Graves, Jasper Koehorst, Simone Leo, Marc Portier (2020):  
**RO-Crate Metadata Specification**  
_researchobject.org / Zenodo_  
<https://doi.org/10.5281/zenodo.3406497> 

For citing a particular [version of RO-Crate specification](specification) see its embedded _Cite this version_ DOI.

### Other citations

See also [recent publications, presentations and citations](outreach).


## More information

Check the [FAQ](faq) for answers to common questions.

Visit the [Tutorials](tutorials) page for hands-on introductions to RO-Crate and common associated tools and profiles.

Visit the [Use Cases](use_cases) page to browse projects using RO-Crate, or find relevant information for your [domain](domains), [project role](roles), or [task](tasks).

Read the [Background](background) page to learn about the history of RO-Crate and its predecessors.
