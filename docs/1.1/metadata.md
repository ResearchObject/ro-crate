---
layout: default
title: Metadata of the RO-Crate
redirect_from:
  - /1.1-DRAFT/metadata
excerpt: |
  RO-Crate aims to capture and describe the Research Object using
  structured metadata. The RO-Crate Metadata File Descriptor contains the
  metadata that describes the RO-Crate and its content. This machine-readable
  metadata can also be represented for human consumption in the RO-Crate Website,
  linking to data and Web resources.
sort: 5
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2020 The University of Manchester UK 
   Copyright 2019-2020 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

<div id="metadata"></div>

# RO-Crate Metadata

RO-Crate aims to capture and describe the [Research Object][ResearchObject] using structured _metadata_.

The _RO-Crate Metadata File Descriptor_ contains the metadata that describes the RO-Crate and its content, in particular:

* [Root Data Entity](root-data-entity.md) - the RO-Crate `Dataset` itself, a gathering of data
* [Data Entities](data-entities.md) - the _data_ payload, in the form of files and folders
* [Contextual Entities](contextual-entities.md) - related things in the world (e.g. people, organizations, places), providing provenance for the data entities and the RO-Crate.

This machine-readable metadata can also be represented for human consumption in the _RO-Crate Website_, linking to data and Web resources.

## RO-Crate uses Linked Data principles

RO-Crate makes use of the [Linked Data principles] for its description. In particular:

1. (Meta)data should be made available as **Open Data** on the web.
2. (Meta)data should be **machine-readable** in a structured format.
3. (Meta)data should _not_ require proprietary software packages.
4. (Meta)data should use [open standards from W3C], such as RDF and SPARQL.
5. (Meta)data should **link** to other people’s data to provide context, using _URIs_ as global identifiers

RO-Crate realize these principles using a particular set of technologies and best practices:

1. The _RO-Crate Metadata File_ and _RO-Crate Website_ can be directly published on the web together with the RO-Crate payload. In addition, a data package (e.g. BagIt Zip archive) that contain the RO-Crate can also be published on the web.
2. The _RO-Crate Metadata File_ is based on the structured data format [JSON-LD]. 
3. Multiple open source tools/libraries are available [for JSON][JSON] and [for JSON-LD][JSON-LD].
4. The _RO-Crate Website_ is [HTML 5], and the _RO-Crate Metadata File_ is [JSON-LD], one of the [W3C RDF 1.1 formats].
5. The _RO-Crate Metadata File_ reuse common vocabularies like [Schema.org], and this specification [recommend identifiers](#recommended-identifiers) it should link to.

## Base metadata standard: Schema.org

[Schema.org] is the base metadata standard for RO-Crate. Schema.org was chosen because it is widely used on the World Wide Web and supported by search engines, on the assumption that discovery is likely to be maximized if search engines index the content. 

```note
As far as we know there is no alternative, well-maintained linked-data schema for research data with the coverage needed for this project - i.e. a single standard for expressing all the examples presented in this specification.
```

RO-Crate relies heavily on [Schema.org], using a constrained subset of [JSON-LD], and this document gives opinionated recommendations on how to represent the metadata using existing [linked data] best practices.

### Differences from Schema.org

Generally, the standard _type_ and _property_ names (_terms_) from [Schema.org] should be used. However, RO-Crate uses variant names for some elements, specifically:

* `File` is mapped to <http://schema.org/MediaObject> which was chosen as a compromise as it has many of the properties that are needed to describe a generic file. Future versions of Schema.org or a research data extension may re-define `File`.
* `Journal` is mapped to <http://schema.org/Periodical>.

```warning
JSON-LD examples given on the [Schema.org website] may not be in _flattened_ form; any nested entities in _RO-Crate JSON-LD_ SHOULD be described as separate contextual entities in the flat `@graph` list. 
```

To simplify processing and avoid confusion with string values, the _RO-Crate JSON-LD Context_ requires URIs and entity references to be given in the form `"author": {"@id": "http://example.com/alice"}`, even where [Schema.org] for some properties otherwise permit shorter forms like `"author": "http://example.com/alice"`.

See the appendix [RO-Crate JSON-LD](appendix/jsonld.md) for details.

## Additional metadata standards

RO-Crate also uses the _Portland Common Data Model_ ([PCDM] version <https://pcdm.org/2016/04/18/models>) to describe repositories or collections of digital objects and imports these terms:
 
- `RepositoryObject` mapped to <http://pcdm.org/models#Object>
- `RepositoryCollection` mapped to <http://pcdm.org/models#Collection>
- `RepositoryFile` mapped to <http://pcdm.org/models#File>
- `hasMember` mapped to <http://pcdm.org/models#hasMember>
- `hasFile` mapped to <http://pcdm.org/models#hasFile>

```note
The terms `RepositoryObject` and `RepositoryCollection` are renamed to avoid collision between other vocabularies and the PCDM terms `Collection` and `Object`. The term `RepositoryFile` is renamed to avoid clash with RO-Crate's `File` mapping to <http://schema.org/MediaObject>.
```

From [Dublin Core Terms](http://purl.org/dc/terms/) RO-Crate use:

- `conformsTo` mapped to <http://purl.org/dc/terms/conformsTo>

These terms are being proposed by [Bioschemas profile ComputationalWorkflow 0.5-DRAFT](https://bioschemas.org/profiles/ComputationalWorkflow/0.5-DRAFT-2020_07_21) and [FormalParameter 0.1-DRAFT](https://bioschemas.org/profiles/FormalParameter/0.1-DRAFT-2020_07_21) to be integrated into Schema.org: 

* `ComputationalWorkflow` mapped to <https://bioschemas.org/ComputationalWorkflow>
* `FormalParameter` mapped to <https://bioschemas.org/FormalParameter>
* `input` mapped to <https://bioschemas.org/ComputationalWorkflow#input>
* `output` mapped to <https://bioschemas.org/ComputationalWorkflow#output>
* `funding` mapped to <http://schema.org/funding> ([schemaorg #383](https://github.com/schemaorg/schemaorg/issues/383))

```note
In this specification the proposed Bioschemas terms use the temporary <https://bioschemas.org/> namespace; future releases of RO-Crate may reflect mapping to the <http://schema.org/> namespace.
```

## Summary of Coverage

RO-Crate is simply a way to make metadata assertions about a set of files and folders that make up a _Dataset_. These assertions can be made at two levels:

* Assertions at the RO-Crate level: for an RO-Crate to be useful, some metadata should be provided about the dataset as a whole (see minimum requirements for different use-cases below). In the _RO-Crate Metadata File_, we distinguish the _Root Data Entity_ which represents the RO-Crate as a whole, from other _Data Entities_ (files and folders contained in the RO-Crate) and _Contextual Entities_, e.g. a person, organisation, place related to an RO-Crate _Data Entity_
* Assertions about files and folders contained in the RO-Crate: in addition to providing metadata about the RO-Crate as a whole, RO-Crate allows metadata assertions to be made about any other _Data Entity_


This document has guidelines for ways to represent common requirements for describing data in a research context, e.g.:

* Contact information for a data set.
* Descriptive information for a dataset and the files within it and their contexts such as an abstract, spatial and temporal coverage.
* Associated publications.
* Funding relationships.
* Provenance information of various kinds; who (people and organizations) and what (instruments and computer programs) created or contributed to the data set and individual files within it.
* Workflows that operate on the data using standard workflow descriptions including ‘single step workflows’; executable files or environments such as singularity containers or Jupyter notebooks.

However, as RO-Crate uses the [Linked Data principles], adopters of RO-Crate are free to supplement RO-Crate using [Schema.org] metadata and/or assertions using other _Linked Data_ vocabularies.

## Future coverage

A future version of this specification aim to cater for variable-level assertions: In some cases, e.g. for tabular data, additional metadata may be provided about the structure and variables within a given file. See the use case [Describe a tabular data file directly in RO-Crate metadata](https://github.com/ResearchObject/ro-crate/issues/27) for work-in-progress.


## Recommended Identifiers

_RO-Crate JSON-LD_ SHOULD use the following IDs where possible:

* For a _Root Data Entity_, an `identifier` which is RECOMMENDED to be a  <https://doi.org/> URI. 
* For a [Person] participating in the research process: [ORCID] identifiers, e.g. <https://orcid.org/0000-0002-1825-0097>
* For [Organization]s including [funder]s,  [Research Organization Registry URIs], e.g. <https://ror.org/0384j8v12>
* For entities of type [Place], a [geonames] URL, e.g. <http://sws.geonames.org/8152662/>
* For file formats, a [Pronom] URL, for example <https://www.nationalarchives.gov.uk/PRONOM/fmt/831>.

In the absence of the above, RO-Crates SHOULD contain stable persistent URIs to identify all entities wherever possible.


{% include references.liquid %}
