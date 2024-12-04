---
title: Metadata of the RO-Crate
redirect_from:
  - /1.2-DRAFT/metadata
excerpt: |
  RO-Crate aims to capture and describe the Research Object using
  structured metadata. The RO-Crate Metadata Descriptor contains the
  metadata that describes the RO-Crate and its content. This machine-readable
  metadata can also be represented for human consumption in the RO-Crate Website,
  linking to data and Web resources.
nav_order: 4
parent: RO-Crate 1.2-DRAFT 
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2024 The University of Manchester UK 
   Copyright 2019-2024 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# RO-Crate Metadata {#metadata}
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

RO-Crate aims to capture and describe the [Research Object][ResearchObject] using structured _metadata_.

The _RO-Crate Metadata Descriptor_ contains the metadata that describes the RO-Crate and its content, in particular:

* [Root Data Entity](root-data-entity) - the RO-Crate `Dataset` itself, a gathering of data
* [Data Entities](data-entities) - the _data_ payload, in the form of files and folders
* [Contextual Entities](contextual-entities) - related things in the world (e.g. people, organizations, places), providing provenance for the data entities and the RO-Crate.

This machine-readable metadata can also be represented for human consumption in the _RO-Crate Website_, linking to data and Web resources.

## RO-Crate uses Linked Data principles

RO-Crate makes use of the [Linked Data principles] for its description. In particular:

1. (Meta)data should be made available as **Open Data** on the web.
2. (Meta)data should be **machine-readable** in a structured format.
3. (Meta)data should _not_ require proprietary software packages.
4. (Meta)data should use [open standards from W3C], such as RDF and SPARQL.
5. (Meta)data should **link** to other people’s data to provide context, using _URIs_ as global identifiers

RO-Crate realizes these principles using a particular set of technologies and best practices:

1. The _RO-Crate Metadata Document_ can be stored in an _RO-Crate Metadata File_. The _RO-Crate Metadata File_ and an _RO-Crate Website_ can be directly published on the web together with the RO-Crate payload. In addition, a data package (e.g. BagIt Zip archive) that contain the RO-Crate can also be published on the web.
2. The _RO-Crate Metadata Document_ is based on the structured data format [JSON-LD]. 
3. Multiple open source tools/libraries are available [for JSON][JSON] and [for JSON-LD][JSON-LD].
4. The _RO-Crate Website_ is [HTML 5], and the _RO-Crate Metadata Document_ is [JSON-LD], one of the [W3C RDF 1.1 formats].
5. The _RO-Crate Metadata Document_ reuse common vocabularies like [Schema.org], and this specification [recommend identifiers](#recommended-identifiers) it should link to.

## Common principles for RO-Crate entities

For all entities listed in an _RO-Crate Metadata Document_ the following principles apply:

1. The entity MUST have a `@id` (see [Describing entities in JSON-LD](appendix/jsonld#describing-entities-in-json-ld))
2. The entity MUST have a `@type`, which MAY be an array. 
3. The `@type` SHOULD include at least one [Schema.org] type that accurately describe the entity. [Thing] or [CreativeWork] are valid fallbacks if no alternative external or ad-hoc term is found (see [Extending RO-Crate](appendix/jsonld#extending-ro-crate)).
5. The entity SHOULD have a human-readable `name`, in particular if its `@id` do not go to a human-readable Web page
6. The properties used on the entity SHOULD be applicable to the `@type` (or superclass) according to their definitions. For instance, the property [publisher] can be used on a [Dataset] as it applies to its superclass [CreativeWork].
7. Property references to other entities (e.g. `author` property to a `Person` entity) SHOULD use the `{ "@id": "..."}` object form (see [JSON-LD appendix](appendix/jsonld))
8. The entity SHOULD be ultimately referencable from the root data set (possibly through another reachable data- or [contextual entity](contextual-entities))


## Base metadata standard: Schema.org

[Schema.org] is the base metadata standard for RO-Crate. Schema.org was chosen because it is widely used on the World Wide Web and supported by search engines, on the assumption that discovery is likely to be maximized if search engines index the content. 

{% include callout.html type="note" content="As far as we know there is no alternative, well-maintained linked-data schema for research data with the coverage needed for this project - i.e. a single standard for expressing all the examples presented in this specification." %}

RO-Crate relies heavily on [Schema.org], using a constrained subset of [JSON-LD], and this specification gives opinionated recommendations on how to represent the metadata using existing [linked data] best practices.

{% include callout.html type="tip" content="The main principle of RO-Crate is to use a [Schema.org] whenever possible, even if its official definition may seem broad or related to every day objects. For instance, [IndividualProduct] can describe scientific equipment and instruments (see [Provenance of entities](provenance)). RO-Crate implementers are free to use additional properties and types beyond this specification (see also appendix [Extending RO-Crate(appendix/jsonld#extending-ro-crate)])." %}


### Differences from Schema.org

Generally, the standard _type_ and _property_ names (_terms_) from [Schema.org] should be used. However, RO-Crate uses variant names for some elements, specifically:

* `File` is mapped to <http://schema.org/MediaObject> which was chosen as a compromise as it has many of the properties that are needed to describe a generic file. Future versions of Schema.org or a research data extension may re-define `File`.
* `Journal` is mapped to <http://schema.org/Periodical>.

{% include callout.html type="warning" content="JSON-LD examples given on the [Schema.org] website may not be in _flattened_ form; any nested entities in _RO-Crate JSON-LD_ SHOULD be described as separate contextual entities in the flat `@graph` list. " %}

To simplify processing and avoid confusion with string values, the _RO-Crate JSON-LD Context_ requires URIs and entity references to be given in the form `"author": {"@id": "http://example.com/alice"}`, even where [Schema.org] for some properties otherwise permit shorter forms like `"author": "http://example.com/alice"`.

See the appendix [RO-Crate JSON-LD](appendix/jsonld) for details.

## Additional metadata standards

RO-Crate also uses the _Portland Common Data Model_ ([PCDM] version <https://pcdm.org/2016/04/18/models>) to describe repositories or collections of digital objects and imports these terms:
 
- `RepositoryObject` mapped to <http://pcdm.org/models#Object>
- `RepositoryCollection` mapped to <http://pcdm.org/models#Collection>
- `RepositoryFile` mapped to <http://pcdm.org/models#File>
- `hasMember` mapped to <http://pcdm.org/models#hasMember>
- `hasFile` mapped to <http://pcdm.org/models#hasFile>

{% include callout.html type="note" content="The terms `RepositoryObject` and `RepositoryCollection` are renamed to avoid collision between other vocabularies and the PCDM terms `Collection` and `Object`. The term `RepositoryFile` is renamed to avoid clash with RO-Crate's `File` mapping to <http://schema.org/MediaObject>." %}

RO-Crate use the [Profiles Vocabulary](https://www.w3.org/TR/2019/NOTE-dx-prof-20191218/) to describe [profiles](profiles) using these terms and definitions:

- `ResourceDescriptor` mapped to <http://www.w3.org/ns/dx/prof/ResourceDescriptor> ([definition](https://www.w3.org/TR/2019/NOTE-dx-prof-20191218/#Class:ResourceDescriptor))
- `ResourceRole` mapped to <http://www.w3.org/ns/dx/prof/ResourceRole> ([definition](https://www.w3.org/TR/2019/NOTE-dx-prof-20191218/#Class:ResourceRole))
- `Profile` mapped to <http://www.w3.org/ns/dx/prof/Profile>  ([definition](https://www.w3.org/TR/2019/NOTE-dx-prof-20191218/#Class:Profile))
- `hasArtifact` mapped to <http://www.w3.org/ns/dx/prof/hasArtifact>  ([definition](https://www.w3.org/TR/2019/NOTE-dx-prof-20191218/#Property:hasArtifact))
- `hasResource` mapped to <http://www.w3.org/ns/dx/prof/hasResource> ([definition](https://www.w3.org/TR/2019/NOTE-dx-prof-20191218/#Property:hasResource))
- `hasRole` mapped to <http://www.w3.org/ns/dx/prof/hasRole> ([definition](https://www.w3.org/TR/2019/NOTE-dx-prof-20191218/#Property:hasRole))

From [Dublin Core Terms](http://purl.org/dc/terms/) RO-Crate uses:

- `conformsTo` mapped to <http://purl.org/dc/terms/conformsTo>
- `Standard` mapped to <http://purl.org/dc/terms/Standard>

From the [IANA link relations] registry:
- `cite-as` mapped to <http://www.iana.org/assignments/relation/cite-as> (defined by [RFC8574])

These terms are being proposed by [Bioschemas profile ComputationalWorkflow 1.0-RELEASE][ComputationalWorkflow profile 1.0] and [FormalParameter 1.0-RELEASE][FormalParameter profile 1.0] to be integrated into Schema.org: 

* `ComputationalWorkflow` mapped to <https://bioschemas.org/ComputationalWorkflow>
* `FormalParameter` mapped to <https://bioschemas.org/FormalParameter>
* `input` mapped to <https://bioschemas.org/properties/input>
* `output` mapped to <https://bioschemas.org/properties/output>

To support geometry in [Places](contextual-entities#places), these terms from the [GeoSPARQL ontology]:

* `Geometry` mapped to <http://www.opengis.net/ont/geosparql#Geometry>
* `asWKT` mapped to <http://www.opengis.net/ont/geosparql#asWKT>

{% include callout.html type="note" content="In this specification the proposed Bioschemas terms use the temporary <https://bioschemas.org/> namespace; future releases of RO-Crate may reflect mapping to the <http://schema.org/> namespace." %}

From [CodeMeta 3.0](https://w3id.org/codemeta/3.0):

* `buildInstructions` mapped to <https://codemeta.github.io/terms/buildInstructions>
* `developmentStatus` mapped to <https://codemeta.github.io/terms/developmentStatus>
* `continuousIntegration` mapped to <https://codemeta.github.io/terms/continuousIntegration>
* `embargoEndDate` mapped to <https://codemeta.github.io/terms/embargoEndDate>
* `hasSourceCode` mapped to <https://codemeta.github.io/terms/hasSourceCode>
* `isSourceCodeOf` mapped to <https://codemeta.github.io/terms/isSourceCodeOf>
* `issueTracker` mapped to <https://codemeta.github.io/terms/issueTracker>
* `readme` mapped to <https://codemeta.github.io/terms/readme>
* `referencePublication` mapped to <https://codemeta.github.io/terms/referencePublication>
* `softwareSuggestions` mapped to <https://codemeta.github.io/terms/softwareSuggestions>

{% include callout.html type="warning" content="As of 2024-05-23, the CodeMeta URIs do not resolve correctly, but are used here to match the Codemeta JSON-LD context <https://w3id.org/codemeta/3.0> (issue [#275](https://github.com/ResearchObject/ro-crate/issues/275)).
The CodeMeta terms `maintainer` and `funding` are not mapped, as these are already defined by schema.org." %}


## Summary of Coverage

RO-Crate is simply a way to make metadata assertions about a set of files and folders that make up a _Dataset_. These assertions can be made at two levels:

* Assertions at the RO-Crate level: for an RO-Crate to be useful, some metadata should be provided about the dataset as a whole (see minimum requirements for different use-cases below). In the _RO-Crate Metadata Document_, we distinguish the _Root Data Entity_ which represents the RO-Crate as a whole, from other _Data Entities_ (files and folders contained in the RO-Crate) and _Contextual Entities_, e.g. a person, organisation, place related to an RO-Crate _Data Entity_
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
