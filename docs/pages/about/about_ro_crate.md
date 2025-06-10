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

## About RO-Crate

RO-Crate aims to help people make their research [FAIR](https://www.go-fair.org/fair-principles/)
(Findable, Accessible, Interoperable, and Reusable).
Have you encountered questions like these?

- **Researcher:** How can I ensure people know how to (re)use my data and reproduce my analysis?
- **Data consumer:** How do I find and make sense of a dataset with a thousand cryptically named files?
- **Data steward:** I'm part of a new, large project - how can we manage the data we produce FAIRly?

These are all **metadata questions** that RO-Crate is designed to answer.

## What is an RO-Crate?

An RO-Crate is an integrated view through which you can see an entire [Research Object](background#research-object-background);
the methods, the data, the output and the outcomes of a project or a piece of work. 
Linking all this together enables the sharing of research outputs with their context,
as a coherent whole.

RO-Crates link data and metadata no matter where they are stored --
so that from a paper, you can find the data, and from the data, you can find its authors, and so on.

For example, an RO Crate won't just contain an author's name.
It would also contain their ORCID, which in turn is connected to their affiliations,
their funding, and their other publications.

<figure>
  <img src="assets/img/ro-crate_packaging.png" alt="Diagram representing RO-Crate connections. An open cardboard box labelled 'Describe package and parts' contains people with ORCIDs, and lab equipment with RRIDs. The box is linked through a DOI to a bubble labelled 'Integrated view', which contains other types of research object. Each type of object has an arrow pointing to an example repository or registry for that data, such as workflows to WorkflowHub, presentations to PubMed, and data to databases." />
  <figcaption>RO-Crates can link and be linked to research objects from many different sources using persistent identifiers like ORCIDs and DOIs. <br/>Image credit: Goble, C. (2024, February 16). FAIR Digital Research Objects: Metadata Journeys. University of Auckland Seminar, Auckland. Zenodo. <a href="https://doi.org/10.5281/zenodo.10710142">https://doi.org/10.5281/zenodo.10710142</a> </figcaption>
</figure>

## Applications of RO-Crate

An RO-Crate is a structured package for sharing research data. It can:

- Contain files and link to large datasets stored online
- Record an entire analysis, including inputs, outputs, and tools used
- Connect related publications and datasets
- Preserve datasets for long-term archiving
- Combine multiple uses to fit different needs

RO-Crate is used in fields like bioinformatics, digital humanities, and regulatory sciences. 
Different communities can also adapt and extend it to their specific data and requirements.

## How RO-Crate makes your research FAIR

**Findable:**
RO-Crates can be published to repositories like Zenodo and given a DOI, just like any other data.
The linked metadata helps consumers of the RO-Crate to find related work, people, and organisations.

**Accessible:**
RO-Crate is compatible with [FAIR Signposting](https://signposting.org/FAIR/),
enabling the metadata to be retrieved automatically as long as you have the DOI or other persistent identifier.

**Interoperable:** 
RO-Crate is based on standard,
widely-used web technologies (including JSON-LD and [schema.org](http://schema.org/)),
making it usable and interoperable across platforms.
It is flexible enough to reference any kind of external (meta)data,
whether that external data uses RO-Crate itself or not.

**Reusable:**
RO-Crate is designed to capture detailed provenance. For example,
an RO-Crate could include a full representation of the individual steps executed as part of an analysis,
including the inputs, outputs, computational environment, and the researchers involved.

RO-Crate, when combined with FAIR Signposting,
is a practical implementation of the [FAIR Digital Object Framework](https://fairdigitalobjectframework.org/).

## Where do I start?

#### Learn by example

To learn more about RO-Crate there are some [tutorials and resources here](tutorials).

You can also visit the [Use Cases](use_cases) page to browse projects using RO-Crate,
or find relevant information for your [domain](domains), [project role](roles), or [task](tasks).

#### Quick technical overview

For a technical introduction to RO-Crates see [RO-Crate Technical Overview](technical_overview).

Read the [Background](background) page to learn about the history of RO-Crate and its predecessors.

#### Speak to the RO-Crate Team

Come to one of our drop-in sessions suitable for all levels,
or email the team at [ro-crate@researchobject.org](mailto:ro-crate@researchobject.org).

See the [Community](community) pages for more information.

#### FAQ

Check the [FAQ](faq) for answers to common questions.

## Cite RO-Crate

#### Cite RO-Crate as project/approach

Stian Soiland-Reyes, Peter Sefton, Mercè Crosas, Leyla Jael Castro, Frederik Coppens, José M. Fernández, Daniel Garijo, Björn Grüning, Marco La Rosa, Simone Leo, Eoghan Ó Carragáin, Marc Portier, Ana Trisovic, RO-Crate Community, Paul Groth, Carole Goble (2022):  
**Packaging research artefacts with RO-Crate**.  
_Data Science_ **5**(2)  
<https://doi.org/10.3233/DS-210053>  

#### Cite RO-Crate Specification (any version)

Peter Sefton, Eoghan Ó Carragáin, Stian Soiland-Reyes, Oscar Corcho, Daniel Garijo, Raul Palma, Frederik Coppens, Carole Goble, José María Fernández, Kyle Chard, Jose Manuel Gomez-Perez, Michael R Crusoe, Ignacio Eguinoa, Nick Juty, Kristi Holmes, Jason A. Clark, Salvador Capella-Gutierrez, Alasdair J. G. Gray, Stuart Owen, Alan R Williams, Giacomo Tartari, Finn Bacall, Thomas Thelen, Hervé Ménager, Laura Rodríguez Navas, Paul Walk, brandon whitehead, Mark Wilkinson, Paul Groth, Erich Bremer, LJ Garcia Castro, Karl Sebby, Alexander Kanitz, Ana Trisovic, Gavin Kennedy, Mark Graves, Jasper Koehorst, Simone Leo, Marc Portier (2020):  
**RO-Crate Metadata Specification**  
_researchobject.org / Zenodo_  
<https://doi.org/10.5281/zenodo.3406497> 

For citing a particular [version of RO-Crate specification](specification) see its embedded _Cite this version_ DOI.

#### Other citations

See also [recent publications, presentations and citations](outreach).
