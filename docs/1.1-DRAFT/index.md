<!--
   Copyright 2019 University of Technology Sydney
   Copyright 2019 The University of Manchester UK 
   Copyright 2019 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# RO-Crate Metadata Specification 1.1-DRAFT
{:.no_toc}


<!-- NOTE: Before release, update and uncomment below 
(permalink, DOI, published, authors)
* Permalink: <https://w3id.org/ro/crate/1.1>
* Status: Recommendation
* Published: 2019-11-15
* Publisher: [researchobject.org](http://researchobject.org/) community
-->
* Status: Editor's Draft
* JSON-LD context: <https://w3id.org/ro/crate/1.1-DRAFT/context>
* This version: <https://w3id.org/ro/crate/1.1-DRAFT>
* Previous version: <https://w3id.org/ro/crate/1.0>
* Cite as: <!-- <https://doi.org/10.5281/zenodo.3541888> (this version) -->
  <https://doi.org/10.5281/zenodo.3406497> (any version)
* Editors: [Peter Sefton](https://orcid.org/0000-0002-3545-944X), [Eoghan Ó Carragáin](https://orcid.org/0000-0001-8131-2150),  [Stian Soiland-Reyes](https://orcid.org/0000-0001-9842-9718)
* Authors: [Peter Sefton](https://orcid.org/0000-0002-3545-944X), [Eoghan Ó Carragáin](https://orcid.org/0000-0001-8131-2150),  [Stian Soiland-Reyes](https://orcid.org/0000-0001-9842-9718), [Oscar Corcho](https://orcid.org/0000-0002-9260-0753), [Daniel Garijo](https://orcid.org/0000-0003-0454-7145), [Raul Palma](https://orcid.org/0000-0003-4289-4922), [Frederik Coppens](https://orcid.org/0000-0001-6565-5145), [Carole Goble](https://orcid.org/0000-0003-1219-2137), [José María Fernández](https://orcid.org/0000-0002-4806-5140), [Kyle Chard](https://orcid.org/0000-0002-7370-4805), [Jose Manuel Gomez-Perez](https://orcid.org/0000-0002-5491-6431), [Michael R Crusoe](https://orcid.org/0000-0002-2961-9670), [Ignacio Eguinoa](https://orcid.org/0000-0002-6190-122X), [Nick Juty](https://orcid.org/0000-0002-2036-8350), [Kristi Holmes](https://orcid.org/0000-0001-8420-5254), [Jason A. Clark](https://orcid.org/0000-0002-3588-6257), [Salvador Capella-Gutierrez](https://orcid.org/0000-0002-0309-604X), [Alasdair J. G. Gray](https://orcid.org/0000-0002-5711-4872), [Stuart Owen](https://orcid.org/0000-0003-2130-0865), [Alan R Williams](https://orcid.org/0000-0003-3156-2105), [Giacomo Tartari](https://orcid.org/0000-0003-1130-2154), [Finn Bacall](https://orcid.org/0000-0002-0048-3300), [Thomas Thelen](https://orcid.org/0000-0002-1756-2128), [Hervé Ménager](https://orcid.org/0000-0002-7552-1009), [Laura Rodríguez Navas](https://orcid.org/0000-0003-4929-1219), [Paul Walk](https://orcid.org/0000-0003-1541-5631), [brandon whitehead](https://orcid.org/0000-0002-0337-8610), [Mark Wilkinson](https://orcid.org/0000-0001-6960-357X), [Paul Groth](https://orcid.org/0000-0003-0183-6910), [Erich Bremer](https://orcid.org/0000-0003-0223-1059), [LJ Garcia Castro](https://orcid.org/0000-0003-3986-0510), [Karl Sebby](https://orcid.org/0000-0001-6022-9825), [Alexander Kanitz](https://orcid.org/0000-0002-3468-0652)


<!-- Add new RO-Crate team members at end -->


1. Table of Contents
{:toc}

See <https://w3id.org/ro/crate> for further details about RO-Crate.

<small>
This specification is Copyright 2017-2020 University of Technology Sydney, 
The University of Manchester UK and the RO-Crate contributors.
</small>

<small>
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
</small>

<small>
<http://www.apache.org/licenses/LICENSE-2.0>
</small>

<small>
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
</small>

**Note**: The RO-Crate [JSON-LD context](https://w3id.org/ro/crate/1.1-DRAFT/context) and JSON-LD examples within this specification are distributed under [CC0 1.0 Universal (CC0 1.0) Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/). 

## Introduction & definition of an RO-Crate

> The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in [RFC 2119].

This document specifies a method, known as _RO-Crate_ (Research Object Crate), of organizing file-based data with associated metadata, using [linked data] principles, in both human and machine readable formats, with the ability to include additional domain-specific metadata.

The core of RO-Crate is a JSON-LD file, the _RO-Crate Metadata File_, named `ro-crate-metadata.jsonld`. This file contains structured metadata about the dataset as a whole (the _Root Data Entity_) and, optionally, about some or all of its files. This provides a simple way to, for example, assert the authors (e.g. people, organizations) of the RO-Crate or one its files, or to capture more complex provenance for files, such as how they were created using software and equipment. 

While providing the formal specification for RO-Crate, this document also aims to be a practical guide for software authors to create tools for generating and consuming research data packages, with explanation by examples. 


### Terminology

_RO-Crate_: A directory structure that contains a dataset, which is described in an _RO-Crate Metadata File_.

_RO-Crate Root_: The top-level directory of the _RO-Crate_, indicated by the presence of the _RO-Crate Metadata File_ `ro-crate-metadata.jsonld`

_RO-Crate Metadata File_: A JSON-LD file stored as `ro-crate-metadata.jsonld` in the _RO-Crate Root_. The metadata file describes the _RO-Crate_ with structured data in form of _RO-Crate JSON-LD_.

_RO-Crate Website_: Human-readable HTML pages which describe the RO-Crate (i.e. the _Root Data Entity_, its _Data Entities_ and _Context Entities_), with a home-page at `ro-crate-preview.html` (any additional files reside in `ro-crate-preview_files/`)

_Data Entity_: A JSON-LD representation, in the _RO-Crate Metadata File_, of a directory, file or other resource contained or described by the RO-Crate.

_Root Data Entity_: A _Data Entity_ of type [Dataset], representing the RO-Crate as a whole.  

_RO-Crate Metadata File Descriptor_: A _Contextual Entity_ of type [CreativeWork], which describes the _RO-Crate Metadata File_ and links it to the _Root Data Entity_.

_JSON-LD_: A JSON-based file format for storing _Linked Data_. This document assumes [JSON-LD 1.0](http://www.w3.org/TR/2014/REC-json-ld-20140116/). JSON-LD use a _context_ to map from JSON keys to _URIs_.

_JSON_: The _JavaScript Object Notation (JSON) Data Interchange Format_ as defined by [RFC 7159]; a structured text file format that can be programmatically consumed and generated in a wide range of programming languages.

_Contextual Entity_: A JSON-LD representation of an entity associated with a _Data Entity_, needed to adequately describe that _Data Entity_. For example, a [Person], [Organization] (including research projects), item of equipment ([IndividualProduct]), [license] or any other _thing_ or _event_ that forms part of the metadata for a _Data Entity_ or supporting information.

_Linked Data_: A data structure where properties, types and resources are identified with _URIs_, which if retrieved over the Web, further describe or provide the identified property/type/resource.

_URI_: A _Uniform Resource Identifier_ as defined in [RFC 3986], for example `http://example.com/path/file.html` - commonly known as _URL_. In this document the term _URI_ includes _IRI_, which also permit international Unicode characters.

_URI Path_: The relative _path_ element of an _URI_ as defined in [RFC3986 section 3.3](https://tools.ietf.org/html/rfc3986#section-3.3), e.g. `path/file.html`

_RO-Crate JSON-LD Context_: A JSON-LD [context](https://www.w3.org/TR/json-ld/#the-context) that provides Linked Data mapping for RO-Crate metadata to vocabularies like [schema.org].

_RO-Crate JSON-LD_: JSON-LD structure using the _RO-Crate JSON-LD Context_ and containing RO-Crate metadata, written as if [flattened](http://www.w3.org/TR/2014/REC-json-ld-20140116/#flattened-document-form) and then [compacted](http://www.w3.org/TR/2014/REC-json-ld-20140116/#compacted-document-form) according to the rules in JSON-LD 1.0. The _RO-Crate JSON-LD_ for an _RO-Crate_ is stored in the _RO-Crate Metadata File_.

### Linked Data conventions

Throughout this specification, RDF terms are referred to using the keys defined in the _RO-Crate JSON-LD Context_.

Following [schema.org] practice, `property` names start with lowercase letters and `Class` names start with uppercase letters.

In `ro-crate-metadata.jsonld` the RDF terms use their RO-Crate JSON-LD names as defined in the _RO-Crate JSON-LD Context_, which is available at <https://w3id.org/ro/crate/1.1-DRAFT/context>


## RO-Crate Structure

The structure an _RO-Crate_ MUST follow is:

```
<RO-Crate root directory>/
|   ro-crate-metadata.jsonld  # RO-Crate Metadata File MUST be present
|   ro-crate-preview.html     # RO-Crate Website homepage MAY be present
|   ro-crate-preview_files/   # MAY be present
|    | [other RO-Crate Website files]
|   [payload files and directories]  # 0 or more
```

The name of the _RO-Crate root_ directory is not defined, but a root directory is identifiable by the presence of `ro-crate-metadata.jsonld`. For instance, if an _RO-Crate_ is archived in a ZIP-file, the ZIP root directory correspond to _RO-Crate root_ directory if it contains `ro-crate-metadata.jsonld`.

[Data Entities](#core-metadata-for-data-entities) in the RO-Crate MUST either be _payload files/directories_ present within the RO-Crate root directory or its subdirectories, or be [Web-based Data Entities](#web-based-data-entities).

<!--
RO-Crates can be _nested_ by including payload directories that themselves contain `ro-crate-metadata.jsonld`.
-->

### RO-Crate Metadata File (`ro-crate-metadata.jsonld`)

* The _RO-Crate Metadata File_ MUST be named `ro-crate-metadata.jsonld` and appear in the _RO-Crate Root_
* The _RO-Crate Metadata File_ MUST contain _RO-Crate JSON-LD_; a valid [JSON-LD 1.0](https://www.w3.org/TR/2014/REC-json-ld-20140116/) document in [flattened](https://www.w3.org/TR/json-ld/#flattened-document-form) and [compacted](https://www.w3.org/TR/json-ld/#compacted-document-form) form
* The _RO-Crate JSON-LD_ SHOULD use the _RO-Crate JSON-LD Context_ <https://w3id.org/ro/crate/1.1-DRAFT/context> by reference.

[JSON-LD](https://json-ld.org/) is a structured form of [JSON] that can represent a _Linked Data_ graph. 

A valid _RO-Crate JSON-LD_ graph MUST describe:

1. The _RO-Crate Metadata File Descriptor_
2. The _Root Data Entity_
3. Zero or more _Data Entities_
4. Zero or more _Contextual Entities_

It is RECOMMENDED that any referenced _contextual entities_ are also described in the _RO-Crate Metadata File_ with the same identifier. Similarly it is RECOMMENDED that any _contextual entity_ in the _RO-Crate Metadata file_ is linked to from at least one of the other entities using the same identifier. 

The appendix [RO-Crate JSON-LD](#ro-crate-json-ld) details the general structure of the JSON-LD that is expected in the _RO-Crate Metadata File_. In short, the rest of this specification describe the different types of entities that can be added as `{}` objects to the _RO-Crate JSON-LD_ `@graph` array below:

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [

  ]
}
```


### RO-Crate Website (`ro-crate-preview.html` and `ro-crate-preview_files/`)

In addition to the machine-oriented _RO-Crate Metadata File_, the RO-Crate MAY include a human-readable HTML rendering of the same information, known as the _RO-Crate Website_.

If present in the root directory, `ro-crate-preview.html` MUST:

  *   Be a valid [HTML 5](https://www.w3.org/TR/html52/) document 
  *   Contain at least a human readable summary of metadata relating to the _Root Data Entity_
  *   Contain a copy of the _RO-Crate JSON-LD_ in a `script` element of the `head` element of the HTML, for example:
  ```html
    <script type="application/ld+json">
    {
        "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
        "@graph": [ ...]
    }
    </script>
  ```

`ro-crate-preview.html` SHOULD:
*   Contain at least the same information as the _RO-Crate JSON-LD_, with the exception that files which have no description, author or similar metadata MAY not be listed in the website.
*   Display at least the metadata relating to the _Root Data Enity_ as static HTML without the need for scripting. It MAY contain extra features enabled by JavaScript.
*   When a _Data Entity_ or _Contextual Entity_ is referenced by its ID:
  *   If it has a [name] property, provide a link to its HTML version.
  *   If it does not have a name (e.g. a [GeoCoordinates] location), show it embedded in the HTML for the entity.
*   For keys that resolve in the `RO-Crate JSON-LD Context` to a URI, indicate this (the simplest way is to link the key to its definition.
*   For external URI values, provide a link.
*   If there is sufficient metadata, contain a prominent _“Cite-as”_ text with a natural language data citation (see for example the [FORCE11 Data Citation Principles](https://doi.org/10.25490/a97f-egyk)).
*   If there are additional resources necessary to render the preview (e.g. CSS, JSON, HTML), link to them in a subdirectory `ro-crate-preview-files/`

### Payload files and directories

These are the actual files and directories that make up the dataset being described.

The base RO-Crate specification makes no assumptions about the presence of any specific files or folders beyond the reserved RO-Crate files described above. Payload files may appear directly in the _RO-Crate Root_ alongside the _RO-Crate Metadata File_, and/or appear in sub-directories of the _RO-Crate Root_. Each file and directory MAY be represented as Data Entities in the _RO-Crate Metadata File_.


### RO-Crates SHOULD be self-describing and self-contained

A minimal RO-Crate is a directory containing a single _RO-Crate Metadata File_. 

At the basic level, an RO-Crate is a collection of files and resources represented as a schema.org [Dataset], that together form a meaningful unit for the purposes of communication, citation, distribution, preservation, etc.  The _RO-Crate Metadata File_ describes the RO-Crate, and MUST be stored in the _RO-Crate Root_. 

While RO-Crate is well catered for describing a _Dataset_ as files and relevant metadata that are _contained_ by the RO-Crate in the sense of living within the same root directory, RO-Crates can also reference external resources which are stored or accessed separately, via absolute URIs. This is particularly recommended where some resources cannot be co-hosted for practical or legal reasons, or if the RO-Crate itself is primarily web-based.

It is important to note that the _RO-Crate Metadata File_ is not an exhaustive manifest or inventory, that is, it does not necessarily list or describe all files in the package.  Rather it is focused on providing sufficient amount of metadata to understand and use the content, and is designed to be compatible with existing and future approaches that _do_ have full inventories / manifest and integrity checks, e.g. by using checksums, such as [BagIt] and Oxford Common File Layout [OCFL Object]s.

The intention is that RO-Crates can work well with a variety of archive file formats, e.g. tar, zip, etc., and approaches to capturing file manifests and file fixity, such as [BagIt], [OCFL] and [git]. An RO-Crate can also be hosted on the web or mainly refer to web resources, although extra care to ensure persistence and consistency should be taken for archiving such RO-Crates.

## RO-Crate Metadata

RO-Crate aims to capture and describe the [Research Object](http://www.researchobject.org/overview/) using structured _metadata_.

The _RO-Crate Metadata File Descriptor_ contains the metadata that describes the RO-Crate and its content, in particular:

* Root Data Entity - the `Dataset` itself, a gathering of data
* Data Entities - the _data_ payload, in the form of files and folders
* Contextual Entities - related things in the world (e.g. people, organizations, places), providing provenance for the data entities and the RO-Crate.

This machine-readable metadata can also be represented for human consumption in the _RO-Crate Website_, linking to data and Web resources.

### RO-Crate uses Linked Data principles

RO-Crate makes use of [Linked Data principles](https://5stardata.info/en/) for its description. In particular:

1. (Meta)data should be made available as **Open Data** on the web.
2. (Meta)data should be **machine-readable** in a structured format.
3. (Meta)data should _not_ require proprietary software packages.
4. (Meta)data should use [open standards from W3C](https://www.w3.org/standards/), such as RDF and SPARQL.
5. (Meta)data should **link** to other people’s data to provide context, using _URIs_ as global identifiers

RO-Crate realize these principles using a particular set of technologies and best practices:

1. The _RO-Crate Metadata File_ and _RO-Crate Website_ can be directly published on the web together with the RO-Crate payload. In addition, a data package (e.g. BagIt Zip archive) that contain the RO-Crate can also be published on the web.
2. The _RO-Crate Metadata File_ is based on the structured data format [JSON](https://tools.ietf.org/html/rfc8259). 
3. Multiple open source tools/libraries are available [for JSON](http://json.org/) and [for JSON-LD](https://json-ld.org/).
4. The _RO-Crate Website_ is [HTML 5](https://www.w3.org/TR/html52/), and the _RO-Crate Metadata File_ is [JSON-LD](https://www.w3.org/TR/json-ld/), one of the [W3C RDF 1.1 formats](https://www.w3.org/TR/rdf11-primer/).
5. The _RO-Crate Metadata File_ reuse common vocabularies like [schema.org], and this specification [recommend identifiers](#recommended-identifiers) it should link to.

### Base metadata standard for RO-Crate: Schema.org

[schema.org] is the base metadata standard for RO-Crate. Schema.org was chosen because it is widely used on the World Wide Web and supported by search engines, on the assumption that discovery is likely to be maximized if search engines index the content. NOTE: As far as we know there is no alternative, well-maintained linked-data schema for research data with the coverage needed for this project - i.e. a single standard for expressing all the examples presented in this specification.

RO-Crate relies heavily on [schema.org] using a constrained subset of [JSON-LD], and this document gives opinionated recommendations on how to represent the metadata using existing [linked data] best practices.

#### Differences from schema.org

Generally, the standard keys from [schema.org] should be used. However, RO-Crate uses variant names for some elements, specifically:

* `File` is mapped to <http://schema.org/MediaObject> which was chosen as a compromise as it has many of the properties that are needed to describe a generic file. Future versions of schema.org or a research data extension may re-define `File`.
* `Journal` is mapped to <http://schema.org/Periodical>.

Note that JSON-LD examples given on the <http://schema.org/> website may not be in _flattened_ form; any nested entities in _RO-Crate JSON-LD_ SHOULD be described as separate contextual entities in the flat `@graph` list. 

To simplify processing and avoid confusion with string values, the _RO-Crate JSON-LD Context_ requires URIs and entity references to be given in the form `"author": {"@id": "http://example.com/alice"}`, even where [schema.org] for some properties otherwise permit shorter forms like `"author": "http://example.com/alice"`.

See the appendix [RO-Crate JSON-LD](#ro-crate-json-ld) for details.

### Additional metadata standards

The following terms from the from the [Research Object ontologies](https://w3id.org/ro/2016-01-28/) are used:

- `Workflow` for a workflow definition, mapped to [http://purl.org/wf4ever/wfdesc#Workflow](https://w3id.org/ro/2016-01-28/wfdesc#Workflow)
- `Script` for a script, mapped to [http://purl.org/wf4ever/wf4ever#Script](https://w3id.org/ro/2016-01-28/wf4ever#Script)
- `WorkflowSketch` for an image depicting a workflow, mapped to [http://purl.org/wf4ever/roterms#Sketch](https://w3id.org/ro/2016-01-28/roterms#Sketch).

RO-Crate also uses the _Portland Common Data Model_ ([PCDM])) and imports these terms:
 
- `RepositoryObject` mapped to <https://pcdm.org/2016/04/18/models#Object>
- `RepositoryCollection` mapped to <https://pcdm.org/2016/04/18/models#Collection>
- `RepositoryFile` mapped to <https://pcdm.org/2016/04/18/models#Collection>
- `hasMember` mapped to <https://pcdm.org/2016/04/18/models#hasMember>
- `hasFile` mapped to <https://pcdm.org/2016/04/18/models#hasFile>

The keys `RepositoryObject` and `RepositoryCollection` were chosen to avoid collision between the terms Collection and Object with other vocabularies.

From [Dublin Core Terms](http://purl.org/dc/terms/) RO-Crate use:
- `conformsTo` mapped to <http://purl.org/dc/terms/conformsTo>


### Summary of Coverage

RO-Crate is simply a way to make metadata assertions about a set of files and folders that make up a _Dataset_. These assertions can be made at three levels:

* Assertions at the RO-Crate level: for an RO-Crate to be useful, some metadata should be provided about the dataset as a whole (see minimum requirements for different use-cases below). In the _RO-Crate Metadata File_, we distinguish the _Root Data Entity_ which represents the RO-Crate as a whole, from other _Data Entities_ (files and folders contained in the RO-Crate) and _Contextual Entities_, e.g. a person, organisation, place related to an RO-Crate _Data Entity_
* Assertions about files and folders contained in the RO-Crate: in addition to providing metadata about the RO-Crate as a whole, RO-Crate allows metadata assertions to be made about any other _Data Entity_


This document has guidelines for ways to represent common requirements for describing data in a research context, e.g.:

* Contact information for a data set.
* Descriptive information for a dataset and the files within it and their contexts such as an abstract, spatial and temporal coverage.
* Associated Publications.
* Funding relationships.
* Provenance information of various kinds; who (people and organizations) and what (instruments and computer programs) created or contributed to the data set and individual files within it.
* Workflows that operate on the data using standard workflow descriptions including ‘single step workflows’; executable files or environments such as singularity containers or Jupyter notebooks.

However, as RO-Crate uses _Linked Data_ principles, adopters of RO-Crate are free to supplement RO-Crate using [schema.org] metadata and/or assertions using other _Linked Data_ vocabularies.

### Future coverage

A future version of this specification will allow for variable-level assertions: In some cases, e.g. for tabular data, additional metadata may be provided about the structure and variables within a given file see the Use Case [Describe a tabular data file directly in RO-Crate metadata](https://github.com/ResearchObject/ro-crate/issues/27) for work-in-progress.


### Recommended Identifiers

_RO-Crate JSON-LD_ SHOULD use the following IDs where possible: 

* For a _Root Data Entity_, an `identifier` which is RECOMMENDED to be a  <https://doi.org/> URI. 
* For a [Person] participating in the research process: [ORCID] identifiers, e.g. <https://orcid.org/0000-0002-1825-0097>
* For [Organization]s including [funder]s,  [Research Organization Registry URIs](https://ror.org/), e.g. <https://ror.org/0384j8v12>
* For items of type [Place], a [geonames] URL, e.g. <http://sws.geonames.org/8152662/>
* For file formats, a [Pronom] URL, for example <https://www.nationalarchives.gov.uk/PRONOM/fmt/831>.

In the absence of the above, RO-Crates SHOULD contain stable persistent URIs to identify all entities wherever possible.


### Core Metadata for the _Root Data Entity_

The _Root Data Entity_ is a [Dataset] that represent the RO-Crate as a whole;
a _Research Object_ that includes the _Data Entities_ and the related
_Contextual Entities_.

The _RO-Crate JSON-LD_ MUST contain a _RO-Crate Metadata File Descriptor_ 
with the `@id` value `ro-crate-metadata.jsonld` and `@type` [CreativeWork]. This descriptor 
MUST have an [about] property referencing the _Root Data Entity_, which SHOULD
have an `@id` of `./`.

```json

{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context", 
  "@graph": [
    {
        "@type": "CreativeWork",
        "@id": "ro-crate-metadata.jsonld",
        "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
        "about": {"@id": "./"}
    },
    
    {
      "@id": "./",
      "@type": "Dataset",
      ...
    }
  ]
}
```

The [conformsTo] of the _RO-Crate Metadata File Descriptor_ 
SHOULD be a versioned permalink URI of the RO-Crate specification
that the _RO-Crate JSON-LD_ conforms to. The URI SHOULD 
start with `https://w3id.org/ro/crate/`. 

Consumers processing the RO-Crate as an JSON-LD graph can thus reliably find
the the _Root Data Entity_ by following this algorithm:

1. For each entity in `@graph` array
2. ..if the `conformsTo` property is a URI that starts with `https://w3id.org/ro/crate/`
3. ....from this entity's `about` object keep the `@id` URI as variable _root_
4. For each entity in `@graph` array
5. .. if the entity has an `@id` URI that matches _root_ return it

To ensure a base-line interoperability between RO-Crates, and for an RO-Crate to
be considered a _Valid RO-Crate_, a minimum set of metadata is required for the
_Root Data Entity_. As stated above the _RO-Crate Metadata File_ is not an
exhaustive manifest or inventory, that is, it does not necessarily list or
describe all files in the package. For this reason, there are no minimum
metadata requirements in terms of describing _Data Entities_ (files and folders)
other than the _Root Data Entity_. Extensions of RO-Crate dealing with specific
types of dataset may put further constraints or requirements of metadata beyond
the Root Data Entity (see Extending RO-Crate below).


The _RO-Crate Metadata File Descriptor_ MAY contain information such as
licensing for the _RO-Crate Metadata File_ so metadata can be licensed
separately from Data.

The table below outlines the properties that the _Root Data Entity_ MUST have to be minimally valid and additionally highlights properties required to meet other common use-cases, including the minimum metadata necessary to mint a DataCite DOI:

#### Direct properties of the Root Data Entity

The _Root Data Entity_ MUST have the following properties:
*  `@type`: MUST be [Dataset]
*  `@id`:  MUST end with `/` and SHOULD be the string `./`
*  `name`: SHOULD identify the dataset to humans well enough to disambiguate it from other RO-Crates
*  `description`: SHOULD further elaborate on the name to provide a summary of the context in which the dataset is important.
*  `datePublished`: MUST be a string in ISO 8601 date format and SHOULD be specified to at least the precision of a day, MAY be a timestamp down to the millisecond. 
*  `license`: SHOULD link to a _Contextual Entity_ in the _RO-Crate Metadata File_ with a name and description. MAY have a URI (eg for Creative Commons or Open Source licenses). MAY, if necessary be a textual description of how the RO-Crate may be used.

NOTE: These requirements are stricter than those published for
[Google Dataset Search](https://developers.google.com/search/docs/data-types/dataset)
which requires a `Dataset` to have a `name` and `description`,

NOTE: The properties above are not sufficient to generate a DataCite citation.
Advice on integrating with DataCite will be provided in a future version of this
specification, or as an implementation guide.


The following _RO-Crate Metadata File_ represents a minimal description of an _RO-Crate_. 

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context", 
  "@graph": [

 {
    "@type": "CreativeWork",
    "@id": "ro-crate-metadata.jsonld",
    "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
    "about": {"@id": "./"}
 },  
 {
    "@id": "./",
    "identifier": "https://doi.org/10.4225/59/59672c09f4a4b",
    "@type": "Dataset",
    "datePublished": "2017",
    "name": "Data files associated with the manuscript:Effects of facilitated family case conferencing for ...",
    "description": "Palliative care planning for nursing home residents with advanced dementia ...",
    "license": {"@id": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/"}
 },
 {
  "@id": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/",
  "@type": "CreativeWork",
  "description": "This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/au/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.",
  "identifier": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/",
  "name": "Attribution-NonCommercial-ShareAlike 3.0 Australia (CC BY-NC-SA 3.0 AU)"
 }
 ]
}
```

### Referencing _Data Entities_ (files and folders) from the _Root Data Entity_

Where files and folders are represented as _Data Entities_ in the RO-Crate JSON-LD, these MUST be linked to, either directly or indirectly, from the Root Data Entity using the [hasPart] property. Directory hierarchies MAY be represented with nested Dataset _Data Entities_, or the Root Dataset MAY refer to files anywhere in the hierarchy using [hasPart].

_Data Entities_ representing files MUST have `File` as a value for `@type`.   `File` is an RO-Crate alias for <http://schema.org/MediaObject>. The term _File_ here is liberal, and includes "downloadable" resources where `@id` is an absolute URI.

_Data Entities_ representing directories MUST be of `@type: Dataset`. The term _directory_ here includes HTTP file listings where `@id` is an absolute URI, however "external" directories SHOULD have a programmatic listing of their content (e.g. another RO-Crate).

_Data Entities_ can also be other types, for instance an online database. These SHOULD be of `@type: CreativeWork` and typically have a `@id` which is an absolute URI.

In all cases, `@type` MAY be an array in order to also specify a more specific type, e.g. `@type: [File, Workflow]`

_Note: as indicated above, there is no requirement to represent every file and folder in an RO-Crate as Data Entities in the RO-Crate JSON-LD._

#### Example linking to a file and folders

```
<base directory>/
  |   ro-crate-metadata.jsonld
  |   cp7glop.ai
  |   lots_of_little_files/
  |    | file1
  |    | file2
  |    | ...
  |    | file54
```

An example _RO-Crate JSON-LD_ for the above would be as follows:

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [
    {
      "@type": "CreativeWork",
      "@id": "ro-crate-metadata.jsonld",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
      "about": {"@id": "./"}
    },  
    {
      "@id": "./",
      "@type": [
        "Dataset"
      ],
      "hasPart": [
        {
          "@id": "cp7glop.ai"
        },
        {
          "@id": "lots_of_little_files/"
        }
      ]
    },
    {
      "@id": "cp7glop.ai",
      "@type": "File",
      "contentSize": "383766",
      "description": "Illustrator file for Glop Pot",
      "encodingFormat": "application/pdf"
    },
    {
      "@id": "lots_of_little_files/",
      "@type": "Dataset",
      "description": "This directory contains many small files, that we're not going to describe in detail.",
      "name": "Too many files"
    }
  ]
}
```

#### Adding detailed descriptions of encodings

The above example provides a media type for the file `cp7glop.ai` - which is
useful as it may not be apparent that the file readable as a PDF file from the
extension. To add more detail, encodings SHOULD be linked using a [PRONOM]
identifier to a _Contextual Entity_ of `@type` Website.

``` json
  {
    "@id": "cp7glop.ai",
    "@type": "File",
    "contentSize": "383766",
    "description": "Illustrator file for Glop Pot",
    "encodingFormat": ["application/pdf", {"@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/19"}]
  },
  {
    "@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/19",
    "name": "Acrobat PDF 1.5 - Portable Document Format",
    "@type": "Website"
  }

```

If there is no PRONOM identifier, then a contextual entity with a URL as an `@id` MAY be used:

For example:

```json
 {
    "@id": "1st-tool.cwl",
    "@type": "File",
    "contentSize": "120",
    "description": "An example Common Workflow Language File",
    "encodingFormat": ["text/plain", {"@id": "https://www.commonwl.org/v1.0/Workflow.html"}]
  },
    {
    "@id": "https://www.commonwl.org/v1.0/Workflow.html",
    "name": "Common Workflow Language (CWL) Workflow Description, v1.0.2",
    "@type": "Website"
  }
```

If there is no web-accessible description for a file format it SHOULD be described locally in the dataset, for example in a file:

```json
 {
    "@id": "some-file.some_extension",
    "@type": "File",
    "contentSize": "120",
    "description": "A file in a non-standard format",
    "encodingFormat": ["text/plain", {"@id": "https://www.commonwl.org/v1.0/Workflow.html"}]
  },
  {
    "@id": "some_extension.md",
    "encodingFormat": "text/markdown",
    "name": "Description of some_extension file format",
    "@type": ["File", "CreativeWork"]
  }
```

### Core Metadata for _Data Entities_

The table below outlines the properties that Data Entities, when present, MUST have to be minimally valid.

#### File Data Entity

A `File` _Data Entity_ MUST have the following properties:
*  `@type`: MUST be `File`, or an array where `File` is one of the values.
*  `@id` MUST be either a _URI Path_ relative to the _RO Crate root_, or an absolute URI.

#### Directory File Entity

A `Dataset` (directory) _Data Entity_ MUST have the following properties:
*  `@type` MUST be `Dataset` or an array where `Dataset` is one of the values.
*  `@id`  MUST be either an a _URI Path_ relative to the _RO Crate root, or an absolute URI. The id SHOULD end with `/`

### Web-based Data Entities

While one use-case of RO-Crates is to describe _files_ contained within the _RO-Crate root_ directory, RO-Crates can also gather resources on the web, identified using _absolute URIs_ instead of relative _URI paths_.

Using Web-based data entities can be important particularly where a file can't be included in the _RO-Crate root_ because of licensing concerns, large data sizes, privacy, or where it is desirable to link to the latest online version.

Example of an RO-Crate where some of the _File Data Entities_ are external to the _RO-Crate root_:

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [
    {
        "@type": "CreativeWork",
        "@id": "ro-crate-metadata.jsonld",
        "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
        "about": {"@id": "./"}
  },  
  {
    "@id": "./",
    "@type": [
      "Dataset"
    ],
    "hasPart": [
      {
        "@id": "survey-responses-2019.csv"
      },
      {
        "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf"
      },
      ]
  },
  {
    "@id": "survey-responses-2019.csv",
    "@type": "File",
    "contentSize": "26452",
    "description": "Survey responses",
    "encodingFormat": "text/csv"
  },
  {
    "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf",
    "@type": "File",
    "contentSize": "310691",
    "description": "RO-Crate specification",
    "encodingFormat": "application/pdf"
  }
]
}
```

Additional care SHOULD be taken to improve persistence and longevity of web resources included 
in an RO-Crate, as they can be more difficult to archive or move along with the _RO-Crate root_, and
may change intentionally or unintentionally leaving the RO-Crate with partial or outdated information.

File Data Entries with an `@id` URI outside the _RO-Crate Root_ SHOULD at the time of RO-Crate creation be directly downloadable by a simple retrieval (e.g. HTTP GET), permitting redirections and HTTP authentication. For instance in the example above, <https://zenodo.org/record/3541888> and <https://doi.org/10.5281/zenodo.3541888> cannot be used as `@id` above as retrieving these URLS give a HTML landing page rather than the desired PDF as indicated by `encodingFormat`.

A files on the web may change, the timestamp property `sdDatePublished` SHOULD be included to indicate when the absolute URL was accessed, and derived metadata like `encodingFormat` and `contentSize` was considered to be representative:

```json
  {
    "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf",
    "@type": "File",
    "contentSize": "310691",
    "encodingFormat": "application/pdf",
    "sdDatePublished": "2020-04-09T13:09:21+01:00Z"
  }
```

#### Embedded data entities that are also on the web

File Data Entities may already have a corresponding web presence, for instance a landing page that describes the file, including persistent identifiers (e.g. DOI) that goes to an intermediate HTML page instead of the downloadable file directly. 

These can be included for File Data Entities as additional metadata, regardless of if the File is included in the _RO-Crate Root_ directory or exists on the Web, by using properties:

* `identifier` for formal identifier string such as DOIs
* `url` with a string URL for a *download* link (if not available, a download landing page) for this file
* `subjectOf` to a `CreativeWork` (or `WebPage`) that mentions this file or its content (but also other resources).
* `mainEntityOfPage` to a `CreativeWork`  (or `WebPage`) that primarily describes this file (or its content) 

```json
  {
    "@id": "survey-responses-2019.csv",
    "@type": "File",
    "encodingFormat": "text/csv",
    "url": "http://example.com/downloads/2019/survey-responses-2019.csv",
    "subjectOf": {"@id": "http://example.com/reports/2019/annual-survey.html"}
  },
  {
    "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf",
    "@type": "File",
    "encodingFormat": "application/pdf",
    "identifier": "https://doi.org/10.5281/zenodo.3541888",
    "url": "https://zenodo.org/record/3541888"
  }
```

#### Directories on the web; dataset distributions

A _Directory File Entry_ or `Dataset` identifier by an absolute URL on the web can be harder to download than a `File` because it consists of multiple resources. It is RECOMMENDED that such directories have a complete listing of their content in `hasPart`, enabling download traversal.

Alternatively a common mechanism to provide downloads of a reasonably sized directory is as an archive file in formats like `.zip` or `.tar.gz`, described as a [DataDownload]. 

  {
      "@id": "lots_of_little_files/",
      "@type": "Dataset",
      "description": "This directory contains many small files, that we're not going to describe in detail.",
      "name": "Too many files",
      "distribution": {"@id": "http://example.com/downloads/2020/lots_of_little_files.zip"}
  },
  {
    "@id": "http://example.com/downloads/2020/lots_of_little_files.zip",
    "@type": "DataDownload",
    "encodingFormat": "application/zip",
    "contentSize": "82818928"
  }

Similarly, the _RO-Crate root_ entity may also provide a `distribution` URL, in which case the download SHOULD be an archive that contain the _RO-Crate Metadata file_.

In all cases, consumers should be aware that a `DataDownload` is a snapshot that may not be reflecting the current state of the `Dataset` or RO-Crate.

## Representing _Contextual Entities_

The _RO-Crate JSON-LD_ @graph SHOULD contain additional information about _Contextual Entities_ for the use of both humans (in `ro-crate-preview.html`) and machines (in `ro-crate-metadata.jsonld`). This also helps to maximise the extent to which an _RO-Crate_ is self-contained and self-describing, in that it reduces the need for the consumer of an RO-Crate to refer to external information which may change or become unavailable over time.

### People

A core principle of Linked data is to use URIs to identify things such as people. The following is the minimum recommended way of representing a [author] in a RO-Crate. This property MAY be applied in the context of a directory ([Dataset]) or to a [File].

```json
{
    "@type": "Dataset",
    "@id": "./",
    "author": {"@id": "https://orcid.org/0000-0002-8367-6908"}
}
{
    "@id": "https://orcid.org/0000-0002-8367-6908",
    "@type": "Person",
    "affiliation": "University of Technology Sydney",
    "name": "J. Xuan"
}
```

This uses an [ORCID](https://orcid.org/) to unambiguously identify an author, with a _Contextual Entity_ of type [Person].

Note the string-value of the organizational affiliation. This SHOULD be improved by also providing a _Contextual Entity_ for the organization (see example below).


### Organizations as values

An [Organization] SHOULD be the value for the [publisher] property of a [Dataset] or [ScholarlyArticle] or [affiliation] property of a [Person].


```json
{
  "@type": "Dataset",
  "@id": "./",
  "publisher": {"@id": "https://ror.org/03f0f6041"}
}

{
  "@id": "https://ror.org/03f0f6041",
  "@type": "Organization",
  "name": "University of Technology Sydney",
  "url": "https://ror.org/03f0f6041"
}
```

An [Organization] SHOULD also be used for a [Person]'s [affiliation] property.

```json
{
  "@type": "Dataset",
  "@id": "./",
  "publisher": {"@id": "https://ror.org/03f0f6041"},
  "author": {"@id": "https://orcid.org/0000-0002-3545-944X"}
},
{
  "@id": "https://ror.org/03f0f6041",
  "@type": "Organization",
  "name": "University of Technology Sydney"
},
{
  "@id": "https://orcid.org/0000-0002-3545-944X",
  "@type": "Person",
  "affiliation": {"@id": "https://ror.org/03f0f6041"},
  "email": "peter.sefton@uts.edu.au",
  "name": "Peter Sefton"
}
```




### More detail on ContactPoint

A RO-Crate SHOULD have contact information, using a contextual entity of type [ContactPoint]. Note that in schema.org [Dataset] does not currently have the corresponding [contactPoint] property, so the contact point would need to be given through a [Person] or [Organization] contextual entity which are related to the Dataset via a [author] or [publisher] property.


```json
{
      "@id": "./",
      "@type": "Dataset",
      "author": {"@id": "https://orcid.org/0000-0001-6121-5409"}
},
{
      "@id": "https://orcid.org/0000-0001-6121-5409",
      "@type": "Person",
      "contactPoint": {
        "@id": "mailto:tim.luckett@uts.edu.au"
      },
      "familyName": "Luckett",
      "givenName": "Tim",
      "identifier": "https://orcid.org/0000-0001-6121-5409",
      "name": "Tim Luckett"
},
{
      "@id": "mailto:tim.luckett@uts.edu.au",
      "@type": "ContactPoint",
      "contactType": "customer service",
      "email": "tim.luckett@uts.edu.au",
      "identifier": "tim.luckett@uts.edu.au",
      "url": "https://orcid.org/0000-0001-6121-5409"
}
```



### Publications via citation property

To associate a publication with a dataset the _RO-Crate JSON-LD_ MUST include a URL (for example a DOI URL) as the `@id of a publication using the [citation] property.

For example:


```json
"citation": {"@id": "https://doi.org/10.1109/TCYB.2014.2386282"}
```


The publication SHOULD be described in the _RO-Crate JSON-LD_.


```json
{
  "@id": "https://doi.org/10.1109/TCYB.2014.2386282",
  "@type": "ScholarlyArticle",
  "author": [
    {
      "@id": "https://orcid.org/0000-0002-8367-6908"
    },
    {
      "@id": "https://orcid.org/0000-0003-0690-4732"
    },
    {
      "@id": "https://orcid.org/0000-0003-3960-0583"
    },
    {
      "@id": "https://orcid.org/0000-0002-6953-3986"
    }
  ],
  "identifier": "https://doi.org/10.1109/TCYB.2014.2386282",
  "issn": "2168-2267",
  "name": "Topic Model for Graph Mining",
  "journal": "IEEE Transactions on Cybernetics",
  "datePublished": "2015"
}
```





### Publisher

The _Root Data Entity_ SHOULD have a [publisher](http://schema.org/publisher) property. This SHOULD be an [Organization](http://schema.org/Organization) though it MAY be a [Person](http://schema.org/Person).


```json
{
  "@id": "https://doi.org/10.5281/zenodo.1009240",
  "@type": "Dataset",
  "name": "Sample dataset for RO-Crate v0.2",
  "publisher": {
    "@id": "https://ror.org/03f0f6041"
  },
  "temporalCoverage": "2017"
},

{
  "@id": "https://ror.org/03f0f6041",
  "@type": "Organization",
  "identifier": "https://ror.org/03f0f6041",
  "name": "University of Technology Sydney"
},
```





### Funding and grants

To associate a research project with a [Dataset], the _RO-Crate JSON-LD_ SHOULD contain an entity for the project using type [Organization], referenced by a [funder] property. The project `Organization` SHOULD in turn reference any external [funder], either by using its URL as an `@id` or via a _Contextual Entity_ describing the funder.

NOTE: To make it very clear where funding is coming from, the _Root Data Entity_ SHOULD also reference funders directly, as well as via a chain of references.


```json
{
  "@id": "https://doi.org/10.5281/zenodo.1009240",
  "@type": "Dataset",
  "funder": {
    "@id": "https://ror.org/038sjwq14"
  },
},
{
  "@id": "https://eresearch.uts.edu.au/projects/provisioner",
  "@type": "Organization",
  "description": "The University of Technology Sydney Provisioner project is ...",
  "funder": [
    {
      "@id": "https://ror.org/03f0f6041"
    },
    {
      "@id": "https://ands.org.au"
    }
  ],
  "identifier": "https://eresearch.uts.edu.au/projects/provisioner",
  "name": "Provisioner"
},
{
  "@id": "https://ror.org/03f0f6041",
  "@type": "Organisation",
  "identifier": "https://ror.org/03f0f6041",
  "name": "University of Technology Sydney"
},
{
  "@id": "https://ands.org.au",
  "@type": "Organization",
  "description": "The core purpose of the Australian National Data Service (ANDS) is ...",
  "identifier": "https://ands.org.au",
  "name": "Australian National Data Service"
},
```



### Licensing, Access control and copyright

If a _Data Entity_ has a [license] that is different from the license on the _Root Data Entity_, the entity SHOULD have a [license] property referencing a _Contextual Entity_ with a type [CreativeWork] to describe the license. The `@id` of the license SHOULD be its URL (e.g. a Creative Commons License URL) and, when possible, a summary of the license included using the [description] property.

The below _Data Entity_ has a [copyrightHolder] which is different from its [author]. There is a reference to an [Organization] describing the copyright holder and, to give credit, a [sameAs] relation to a web page. The [license] property here refers to <https://creativecommons.org/licenses/by/4.0/> which is expanded in a separate contextual entity.


```json
{
  "@id": "SciDataCon Presentations/AAA_Pilot_Project_Abstract.html",
  "@type": "File",
  "contentSize": "17085",
  "copyrightHolder": {
    "@id": "https://www.idrc.ca/"
  },
  "author": {
    "@id": "https://orcid.org/0000-0002-0068-716X"
  },
  "description": "Abstract for the Pilot Project initial findings",
  "encodingFormat": "text/html",
  "license": {
    "@id": "https://creativecommons.org/licenses/by/4.0/"
  },
  "sameAs": "https://www.scidatacon.org/2016/sessions/56/paper/265/"
},

{
  "@id": "https://creativecommons.org/licenses/by/4.0/",
  "@type": "CreativeWork",
  "name": "CC BY 4.0",
  "description": "Creative Commons Attribution 4.0 International License"
},

{
  "@id": "https://orcid.org/0000-0002-0068-716X",
  "@type": "Person",
  "identifier": "https://orcid.org/0000-0002-0068-716X",
  "name": "Cameron Neylon"
},

{
  "@id": "https://www.idrc.ca/",
  "@type": "Organization",
  "description": "Canadian Frown Corporation and funder of development research",
  "identifier": "IDRC",
  "name": "International Development Research Center"
}
```


#### Metadata license

In some cases the license of the RO-Crate metadata the (JSON-LD statements in the _RO-Crate Metadata File Descriptor_) is different from the license on the _Root Date Entity_ and its content (_data entities_ indicated by [hasPart]). 

For instance, a common pattern for repositories is to license metadata as [CC0 Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/), while data is licensed as [CC-BY](https://creativecommons.org/licenses/by/4.0/) or similar.  This pattern allow metadata to be combined freely (e.g. the DataCite knowledge graph), while redistribution of data files would require explicit attribution and statement of their license.

To express the metadata license is different from the _Root Data Entity_, expand the _RO-Crate Metadata File Descriptor_  to include `license`:

```json
{
  "@type": "CreativeWork",
  "@id": "ro-crate-metadata.jsonld",
  "identifier": "ro-crate-metadata.jsonld",
  "about": {"@id": "./"},
  "license": {
    "@id": "https://creativecommons.org/publicdomain/zero/1.0/"
  }
},

{
  "@id": "./",
  "@type": "Dataset",
  "license": {
    "@id": "https://creativecommons.org/licenses/by/4.0/"
  }
}

```

If no explicit `license` is expressed on the _RO-Crate Metadata File Descriptor_, the `license` expressed on the _Root Data Entity_ apply also on the RO-Crate metadata.

<!-- TODO: This got a bit to complicated, commented out for 1.0

### License of contextual entity metadata

In some cases, the JSON-LD metadata for some entities have been imported under a different (possibly more restrictive) license than the license of the _RO-Crate Metadata File Descriptor_ overall. For this the property [sdLicense] ("structured data license") MAY be used on the affected data entities or contextual entities. In this case it is RECOMMENDED to use [sdPublisher] ("structured data publisher") for attribution of the imported metadata:

```json
{
  "@id": "./",
  "@type": "Dataset",
  "license": {
    "@id": "https://www.gnu.org/licenses/gpl-3.0"
  },
  "contentLocation": {
    "@id": "http://sws.geonames.org/8152662/"
  }  
},
{
  "@id": "http://sws.geonames.org/8152662/",
  "@type": "Place",
  "sdLicense": {
    "@id": "https://creativecommons.org/licenses/by/4.0/"
  },
  "sdPublisher": {
    "@id": "http://www.geonames.org"
  },
  "http://www.geonames.org/ontology#countryCode": "AU",
  "http://www.geonames.org/ontology#wikipediaArticle": {
    "@id": "https://en.wikipedia.org/wiki/Catalina_Park"
  },
  ...
}
```

In the above (abridged) example, there is no explicit license on the _RO-Crate Metadata File Description_, so the _Root Date Entity_ license [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0) would apply to RO-Crate JSON-LD statements, except for the statements on the imported <http://sws.geonames.org/8152662/>,  which metadata is re-distributed under license <https://creativecommons.org/licenses/by/4.0/>. 

In this example the CC-BY license requires retaining "a notice that refers to this Public License" and "identification of the creator(s) of the Licensed Material", here respected using `sdLicense` and `sdPublisher`.  

As the RO-Crate uses _flattened_ JSON-LD, `sdLicense` should be expressed directly on each data/contextual entities where required. 

**Tip**: If metadata is imported from a source licensed as [CC0 Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/), no `sdLicense` statement is required.

-->

### Provenance: Equipment used to create files

To specify which equipment was used to create or update a _Data Entity_, the _RO-Crate_ JSON-LD SHOULD have a _Context Entity_ for each item of equipment which SHOULD be of `@type` [IndividualProduct]. The entity SHOULD have a serial number, manufacturer that identifies it as completely as possible. In this case the equipment is a bespoke machine. The equipment SHOULD be described on a web page, and the address of the description SHOULD be used as its `@id`.


```json
{
  "@id": "https://confluence.csiro.au/display/ASL/Hovermap",
  "@type": "IndividualProduct",
  "description": "The CSIRO bentwing is an unmanned aerial vehicle (UAV, commonly known as a drone) with a LIDAR ... ",
  "identifier": "https://confluence.csiro.au/display/ASL/Hovermap",
  "name": "Bentwing"
}
```


Uses [CreateAction] and [UpdateAction] class to model the contributions of _Context Entities_ of type [Person] or [Organization] in the creation of files.

In this example the CreateAction has a human [agent], the object is a Place (a cave) and the Hovermap drone is the [instrument] used in the file creation event.


```json
{
      "@id": "#DataCapture_wcc02",
      "@type": "CreateAction",
      "agent": {
        "@id": "https://orcid.org/0000-0002-1672-552X"
      },
      "instrument": {
        "@id": "https://confluence.csiro.au/display/ASL/Hovermap"
      },
      "object": {
        "@id": "#victoria_arch"
      },
      "result": [
        {
          "@id": "wcc02_arch.laz"
        },
        {
          "@id": "wcc02_arch_traj.txt"
        }
      ]
    },
  {
      "@id": "#victoria_arch",
      "@type": "Place",
      "address": "Wombeyan Caves, NSW 2580",
      "name": "Victoria Arch"
  }
```




### Provenance: Software used to create files

To specify which software was used to create or update a file the software application SHOULD be represented with an entity of type [SoftwareApplication], with a [version] property, e.g. from `tool --version`.

For example:

```json
{
      "@id": "https://www.imagemagick.org/",
      "@type": "SoftwareApplication",
      "url": "https://www.imagemagick.org/",
      "name": "ImageMagick",
      "version": "ImageMagick 6.9.7-4 Q16 x86_64 20170114 http://www.imagemagick.org"
}
```

The software SHOULD be associated with the [File] it created using a [CreateAction] with the [File] referenced by a [result] property. Any input files SHOULD be referenced by the [object] property.

In the below example, an image with the `@id` of `pics/2017-06-11%2012.56.14.jpg` was transformed into an new image `pics/sepia_fence.jpg` using the _ImageMagick_ software application. Actions MAY have human-readable names, which MAY be machine generated for use at scale.

```json
{
      "@id": "#Photo_Capture_1",
      "@type": "CreateAction",
      "agent": {
        "@id": "https://orcid.org/0000-0002-3545-944X"
      },
      "description": "Photo snapped on a photo walk on a misty day",
      "endTime": "2017-06-11T12:56:14+10:00",
      "instrument": [
        {
          "@id": "#EPL1"
        },
        {
          "@id": "#Panny20mm"
        }
      ],
      "result": {
        "@id": "pics/2017-06-11%2012.56.14.jpg"
      }
    },
    {
      "@id": "#SepiaConversion_1",
      "@type": "CreateAction",
      "name": "Convert dog image to sepia",
      "description": "convert -sepia-tone 80% test_data/sample/pics/2017-06-11\\ 12.56.14.jpg test_data/sample/pics/sepia_fence.jpg",
      "endTime": "2018-09-19T17:01:07+10:00",
      "instrument": {
        "@id": "https://www.imagemagick.org/"
      },
      "object": {
        "@id": "pics/2017-06-11%2012.56.14.jpg"
      },
      "result": {
        "@id": "pics/sepia_fence.jpg"
      }
    },
```

### Provenance: Changes to RO-Crates

To record an action which changes the DataSet's metadata, or changes its state in a publication or other workflow, a [CreateAction] or [UpdateAction] SHOULD be associated with a _Data Entity_.

A curation Action MUST have at least one [object] which associates it with either the DataSet or one of its components.

An Action which creates new _Data entities_ - for example, the creation of a new metadata file - SHOULD have these as [result]s.

An Action SHOULD have a [name] and MAY have a [description].

An Action SHOULD have an [endTime], which MUST be in ISO 8601 date format and SHOULD be specified to at least the precision of a day. An Action MAY have a [startTime] meeting the same specifications.

An Action SHOULD have a human [agent] who was responsible for authorizing the action, and MAY have an [instrument] which associates the action with a particular piece of software (for example, the content management system or data catalogue through which an update was approved) which SHOULD be of `@type` SoftwareApplication.

An Action's status MAY be recorded in an [actionStatus] property. The status must be one of the values enumerated by [ActionStatusType]: [ActiveActionStatus], [CompletedActionStatus], [FailedActionStatus] or [PotentialActionStatus].

An Action which has failed MAY record any error information in an [error](http://schema.org/error) property.

[UpdateAction] SHOULD only be used for actions which affect the DataSet as a whole, such as movement through a workflow.

To record curation actions which modify a [File] within a DataSet - for example, by correcting or enhancing metadata - the old version of the [File] SHOULD be retained, and a [CreateAction] added which has the original version as its [object] and the new version as its [result].

```json
{
    "@id": "#history-01",
    "@type": "CreateAction",
    "object": { "@id": "https://doi.org/10.5281/zenodo.1009240" },
    "name": "RO-Crate created",
    "endTime": "2018-08-31",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus":  { "@id": "http://schema.org/CompletedActionStatus" }
},

{
    "@id": "#history-02",
    "@type": "UpdateAction",
    "object": { "@id": "https://doi.org/10.5281/zenodo.1009240" },
    "name": "RO-Crate published",
    "endTime": "2018-09-10",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus":  {"@id":" http://schema.org/CompletedActionStatus" }
},

{ 
    "@id": "#history-03",
    "@type": "CreateAction",
    "object": { "@id": "metadata.xml.v0.1" },
    "result": { "@id": "metadata.xml" },
    "name": "metadata update",
    "endTime": "2018-09-12",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus": { "@id": "http://schema.org/CompletedActionStatus" }
},

{
    "@id": "#history-04",
    "@type": "UpdateAction",
    "object": { "@id": "https://doi.org/10.5281/zenodo.1009240" },
    "name": "RO-Crate published",
    "endTime": "2018-09-13",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus": { "@id": "http://schema.org/FailedActionStatus" },
    "error": "Record is already published"
},


{
    "@id": "https://stash.research.uts.edu.au",
    "@type": "IndividualProduct",
    "name": "Stash",
    "description": "UTS Research Data Catalogue",
    "identifier": "https://stash.research.uts.edu.au"
}
```


### Workflows and scripts


Scientific workflows and scripts that were used (or can be used) to analyze or generate files contained in an the RO-Crate MAY be embedded in an RO-Crate. Workflows and scripts SHOULD be described using the data entities of type [SoftwareSourceCode].

The distinction between [SoftwareSourceCode] and [SoftwareApplication] for [software](#software) is fluid, and comes down to availability and understandability. For instance, office spreadsheet applications are generally available and do not need further explanation (`SoftwareApplication`); while a Python script that is customized for a particular data analysis might be important to understand further and should therefore be included as `SoftwareSourceCode` in the RO-Crate dataset.  

A workflow is a _Data Entity_ which MUST have the following properties:
* `@type` is an array with at least `File` and `Workflow` as values.
* `@id` is a File URI linking to the workflow entry-point.
* [name]: a name for the workflow.

Minimal example describing a workflow:

```json
{
    "@id": "workflow/retropath.knime",  
    "@type": ["File", "SoftwareSourceCode", "Workflow"],
    "author": {"@id": "#thomas"},
    "name": "RetroPath Knime workflow",
    "description": "Retrosynthesis workflow calculating chemical reactions",
    "license": { "@id": "https://spdx.org/licenses/CC-BY-NC-SA-4.0"},
    "programmingLanguage": {"@id": "#knime"}
}
```

The `@type` property SHOULD be an array, to also indicate the particular nature of the source code as a _script_ or a _workflow_. The distinction is fluid, depending on if the code is primarily indicating **what** should be done (`Workflow`), or **how** tasks should be executed (`Script`).

To indicate that a `SoftwareSourceCode` is primarily in the form of an executable **script** (e.g. sequential batch/shell script that call other commands and manage files), use:

```json
  "@type": ["File", "SoftwareSourceCode", "Script"],
```


If the `SoftwareSourceCode` is primarily in the form of a **workflow** (e.g. a pipeline of steps with data flow), use:

```json
  "@type": ["File", "SoftwareSourceCode", "Workflow"],
```

Workflows and scripts saved on disk using a _programming language_ generally need a _runtime_, in RO-Crate this SHOULD be indicated using a liberal interpretation of [programmingLanguage]. 

Note that the language and its runtime MAY differ (e.g. multiple different C++-compilers), but for scripts and workflows, frequently the language and runtime are essentially the same, and thus the `programmingLanguage` can be described in one go as a hybrid of a [ComputerLanguage] and [SoftwareApplication]:

```json
{
  "@id": "scripts/analyse_csv.py",
  "@type": ["File", "SoftwareSourceCode", "Script"],
  "name": "Analyze CSV files",
  "programmingLanguage": {"@id": "https://www.python.org/downloads/release/python-380/"},
},
{
  "@id": "https://www.python.org/downloads/release/python-380/",
  "@type": ["ComputerLanguage", "SoftwareApplication"],
  "name": "Python 3.8.0",
  "version": "3.8.0"
}
```

A _contextual entity_ representing a [SoftwareApplication] or [ComputerLanguage] MUST have a [name], [url] and [version], which should indicate a known version the workflow/script was developed or tested with. [alternateName] MAY be provided if there is a shorter colloquial name, for instance _“R”_ instead of _“The R Project for Statistical Computing”_.

It is possible to indicate _steps_ that are executed as part of an `Workflow` or `Script`, by using [hasPart] to relate additional `SoftwareApplication` or nested `SoftwareSourceCode` contextual entities:

```json
{
    "@id": "workflow/analyze.cwl",  
    "@type": ["File", "SoftwareSourceCode", "Workflow"],
    "name": "CWL workflow to analyze CSV and make PNG",
    "programmingLanguage": {"@id": "https://w3id.org/cwl/v1.1/"},
    "hasPart": [
      {"@id": "scripts/analyse_csv.py"},
      {"@id": "https://www.imagemagick.org/"},
    ]
}
```


#### Workflow diagram/sketch

It can be beneficial to show a diagram or sketch to explain the script/workflow. This may have been generated from a workflow management system, or drawn manually as a diagram. This diagram MAY be included as an [ImageObject] which is [about] the `SoftwareSourceCode`. The `@type` parameter SHOULD be an array to also include `WorkflowSketch` to indicate that this is an image that represent a sketch or diagram of the workflow.

```json
{
  "@id": "workflow/workflow.svg",
  "@type": ["File", "ImageObject", "WorkflowSketch"],
  "encodingFormat":  "image/svg+xml",
  "name": "Diagram of RetroPath2.0 workflow",
  "about": {"@id": "workflow/workflow.knime"}
}
```

The image file format SHOULD be indicated with [encodingFormat] using an IANA registered [media type](https://www.iana.org/assignments/media-types) like `image/svg+xml` or `image/png`. Additionally a reference to [Pronom] identifier SHOULD be provided, which MAY be described as an additional contextual entity to give human-readable name to the format:

```json
{
  "@id": "workflow/workflow.svg",
  "@type": ["File", "ImageObject", "WorkflowSketch"],
  "encodingFormat":  ["image/svg+xml"],
  "description": "Diagram of RetroPath2.0 workflow",
  "about": {"@id": "workflow/workflow.knime"}
},

```

A _Sketch_ may still be provided even if there is no programmatic `SoftwareSourceCode` that can be executed (e.g. because the workflow was done by hand). In this case the sketch itself is a proxy for the workflow and SHOULD have `@type` of `Workflow` and an `about` property referring to the _RO-Crate dataset_ as a whole (assuming the RO-Crate represents the outcome of a single workflow), or to other `Data Entities` otherwise:

```json
{
  "@id": "workflow/workflow.svg",
  "@type": ["File", "ImageObject", "WorkflowSketch", "Workflow"],
  "encodingFormat":  ["image/svg+xml"],
  "name": "Diagram of an ad hoc workflow",
  "about": {"@id": "./"}
}
 
```



### Extra metadata such as Exif

Schema.org has a generic extension mechanism for encoding adding arbitrary properties and values which are not available as Schema.org properties. An example of of this is the Schema.org [recommended way (see example 2)](http://schema.org/ImageObject) of including [Exif](https://en.wikipedia.org/wiki/Exif) technical image metadata.

To include EXIF, or other data which can be encoded as property/value pairs, add an array of references to _Anonymous Entities_ which encode each property. This example shows one property of several hundred.

```json
{
      "@id": "pics/2017-06-11%2012.56.14.jpg",
      "@type": ["File", "ImageObject"],
      "contentSize": "5114778",
      "author": {
        "@id": "https://orcid.org/0000-0002-3545-944X"
      },
      "description": "Depicts a fence at a disused motor racing venue with the front part of a slightly out of focus black dog in the foreground.",
      "encodingFormat": "image/jpeg",
      "exifData": [
        {
          "@id": "#2eb90b09-a8b8-4946-805b-8cba077a7137"
        },
        {
          "@id": "#c2521494-9b94-4b23-a713-6b281f540823"
        },
      ]

{
      "@id": "#c2521494-9b94-4b23-a713-6b281f540823",
      "@type": "PropertyValue",
      "name": "InternalSerialNumber",
      "value": "4102011002108002               "
    },
```


### Places

To associate a _Data Entity_ with a _Contextual Entity_ representing a _geographical location or region_ the entity SHOULD have a property of [contentLocation] with a value of type [Place].

This example shows how to define a place, using a [geonames](https://www.geonames.org) ID:


```json
{
  "@id": "http://sws.geonames.org/8152662/",
  "@type": "Place",
  "description": "Catalina Park is a disused motor racing venue, located at Katoomba ...",
  "geo": {
    "@id": "#b4168a98-8534-4c6d-a568-64a55157b656"
  },
  "identifier": "http://sws.geonames.org/8152662/",
  "uri": "https://www.geonames.org/8152662/catalina-park.html",
  "name": "Catalina Park"
},
```

**Tip**: To find the `@id` and `identifier` corresponding to a GeoNames HTML page like <https://www.geonames.org/8152662/catalina-park.html> click it's `.rdf` button to find the identifier <http://sws.geonames.org/8152662/> referred from <https://sws.geonames.org/8152662/about.rdf>:

```xml
<gn:Feature rdf:about="http://sws.geonames.org/8152662/">
<!--... -->
```

The place has a [geo](http://schema.org/geo) property, referencing an _Contextual Entity_ of `@type` [GeoCoordinates]:


```json
{
  "@id": "#b4168a98-8534-4c6d-a568-64a55157b656",
  "@type": "GeoCoordinates",
  "latitude": "-33.7152",
  "longitude": "150.30119",
  "name": "Latitude: -33.7152 Longitude: 150.30119"
},
```


The [GeoCoordinates] item SHOULD have a human readable [name], which is used in  generating the `ro-crate-preview.html` file.

And the place is referenced from the [contentLocation] property of the dataset.


```json
{
  "@id": "./",
  "@type": "Dataset",
  "outputOf": "RO-Crate",
  "contact": {
    "@id": "https://orcid.org/0000-0002-3545-944X"
  },
  "contentLocation": {
    "@id": "http://sws.geonames.org/8152662/",
  }
}
{
  "@id": "http://sws.geonames.org/8152662/",
  "name": "Catalina Park",
}
```


[Place] MAY use any of the [resources available in Schema.org](http://schema.org/geo) to describe places. Future profiles of RO-Crate may mandate the use of a subset of these. Any directory or file or _Contextual Entity_ may be geo-located. For example this file:


```json
{
  "@id": "pics/19093074_10155469333581584_5707039334816454031_o.jpg",
  "@type": "File",
  "contentLocation": {
    "@id": "http://sws.geonames.org/8152662/"
  },
  "contentSize": "132765",
  "author": {
    "@id": "https://orcid.org/0000-0002-3545-944X"
  },
```

### Subjects & keywords

Subject properties (equivalent to a Dublin Core Subject) on RO-Crate or a data entity MUST use the [about] property.

Keyword properties MUST use [keywords]. Note that by schema.org convention, keywords are given as a single JSON string, with individual keywords separated by commas.

```json
{
  "keywords": "Gibraltar, Spain, British Overseas Territory, city, map",
  "about": { "@id": "http://dbpedia.org/resource/Gibraltar" },
}
```

### Time

To describe the time period which a RO-Crate Data Entity (or the RO-Crate itself) is _about_, use [temporalCoverage]:

```json
{
  "@id": "photos/",
  "@type": "Dataset",
  "name": "Photos of Gibraltar from 1950 till 1975",
  "about": {"@id": "http://dbpedia.org/resource/Gibraltar"},
  "temporalCoverage": "1950/1975"
}
```


### Digital Library and Repository content

To describe an export from a Digital Library or repository system, RO-Crate uses the _Portland Common Data Model_ ([PCDM]). A _Contextual Entity_ from a repository, representing an abstract entity such as a person, or a work, or a place SHOULD have a`@type` of [RepositoryObject](https://pcdm.org/2016/04/18/models#Object), in addition to any other types. Objects MAY be grouped together in [RepositoryCollection](https://pcdm.org/2016/04/18/models#Collection)s with [hasMember] pointing to the the [RepositoryObject](https://pcdm.org/2016/04/18/models#Object). The keys RepositoryObject and RepositoryCollection were chosen to avoid collision between the terms Collection and Object with other vocabularies.

NOTE: PCDM specifies that Files should have only technical metadata, not descriptive metadata, which is _not_ a restriction in RO-Crate. If the RO-Crate is to be imported into a strict PCDM repository, modeling of object/file relationships will be necessary.

For example, this data is exported from an [Omeka](https://omeka.org) repository:


```json
{
   "@id": "https://omeka.uws.edu.au/farmstofreeways/api/collections/6",
   "@type": "RepositoryCollection",
   "title":  "Project Materials",   
   "description": [
      "Materials associated with the project, including fliers seeking participants, lists of sources and question outline.   "
   ],
   "publisher": {"@id": "University of Western Sydney"},
   "rights": "Copyright University of Western Sydney 2015",
   "hasMember": [
      {
         "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/166"
      },
      {
         "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/167"
      },
      {
         "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/168"
      },
      {
         "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/169"
      }
   ]
},
{
   "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/166",
   "@type": "RepositoryObject",
   "title": [
      "Western Sydney Women's Oral History Project: Flier (illustrated)"
   ],
   "description": [
      "Flier (illustrated) seeking participants for the project."
   ],
   "publisher": { "@id": "https://westernsydney.edu.au"},
   "rights": "Copyright University of Western Sydney 2015",
   "originalFormat": "Paper",
   "identifier": "FTF_flier_illust"
   ],
   "rightsHolder": [
      "Western Sydney University"
   ],
   "license": { 
     "@id": "https://creativecommons.org/licenses/by/3.0/au/"
   },
   "hasFile": [
      {
         "@id": "content/166/original_eece70f73bf8979c0bcfb97065948531.pdf"
      },
     ...
   ]
},
{
   "@type": "File",
   "@id": "content/166/original_eece70f73bf8979c0bcfb97065948531.pdf"
}
```




### Thumbnails

A [File] or any other item MAY have a [thumbnail] property which references another file.

For example, the below [RepositoryObject](https://pcdm.org/2016/04/18/models#Object) is related to four files which are all versions of the same image (via [hasFile](https://pcdm.org/2016/04/18/models#hasFile)) one of which is a thumbnail. The thumbnail MUST be included in the RO-Crate.

If [thumbnail]s are incidental to the data set, they need not be referenced by [hasPart](http://schema.org/hasPart) or [hasFile](https://pcdm.org/2016/04/18/models#hasFile) relationships. but must be in the BagIt manifest if in a _Bagged RO-Crate_.


```json
{
  "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/383",
  "@type": [
    "RepositoryObject",
    "Image"
  ],
  "identifier": [
    "ftf_photo_stapleton1"
  ],
  "interviewee": [
    {
      "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/595",
    }
  ],
  "description": [
    "Photo of Eugenie Stapleton inside her home"
  ],
  "license": [
    "Content in the Western Sydney Women's Oral History Project: From farms to freeways collection is licensed under a Creative Commons CC BY 3.0 AU licence (https://creativecommons.org/licenses/by/3.0/au/)."
  ],
  "publisher": [
    "University of Western Sydney"
  ],
  "hasFile": [
    {
      "@id": "files/383/original_c0f1189ec13ca936e8f556161663d4ba.jpg"
    },
    {
      "@id": "files/383/fullsize_c0f1189ec13ca936e8f556161663d4ba.jpg"
    },
    {
      "@id": "files/383/thumbnail_c0f1189ec13ca936e8f556161663d4ba.jpg"
    },
    {
      "@id": "files/383/square_thumbnail_c0f1189ec13ca936e8f556161663d4ba.jpg"
    }
  ],
  "thumbnail": [
    {
      "@id": "files/383/thumbnail_c0f1189ec13ca936e8f556161663d4ba.jpg"
    }
  ],
  "name": [
    "Photo of Eugenie Stapleton 1"
  ],
  "relatedLink": [
    "<a href=\"https://omeka.uws.edu.au/farmstofreeways/items/show/512\">Audio recording of interview with Eugenie Stapleton</a><br /><a href=\"https://omeka.uws.edu.au/farmstofreeways/items/show/454\">Transcript of interview with Eugenie Stapleton</a> <br /><a href=\"https://omeka.uws.edu.au/farmstofreeways/items/show/384\">Photo of Eugenie Stapleton 2</a><br /><a href=\"https://omeka.uws.edu.au/farmstofreeways/items/show/464\">Letter from Eugenie Stapleton</a>"
  ],
  "copyrightHolder": [
    { "@id": "https://westernsydney.edu.au"}
  ],
  "copyright": [
    "Copyright University of Western Sydney 2015"
  ]
},
{
  "@type": "File",
  "@id": "files/384/original_2ebbe681aa6ec138776343974ce8a3dd.jpg"
},
{
  "@type": "File",
  "@id": "files/384/fullsize_2ebbe681aa6ec138776343974ce8a3dd.jpg"
},
{
  "@type": "File",
  "@id": "files/384/thumbnail_2ebbe681aa6ec138776343974ce8a3dd.jpg"
},
{
  "@type": "File",
  "@id": "files/384/square_thumbnail_2ebbe681aa6ec138776343974ce8a3dd.jpg"
},

 
```

## APPENDIX: RO-Crate JSON-LD

It is not necessary to use [JSON-LD tooling](https://json-ld.org/#developers) to generate or parse the _RO-Crate Metadata File_, although they may make it easier to conform to this specification, e.g. handling relative URIs. It is RECOMMENDED to use [JSON tooling](http://json.org/) to handle [JSON](https://tools.ietf.org/html/rfc7159) syntax and escaping rules.

This appendix shows a brief JSON-LD introduction for complying with the RO-Crate Metadata File requirements.

The below example shows the overall structure of a flattened, compacted `ro-crate-metadata.jsonld` where `@context` refers to the _RO-Crate JSON-LD Context_, while `@graph` is a flat list of the entities that constitute this RO-Crate.

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [

    {
      "@type": "CreativeWork",
      "@id": "ro-crate-metadata.jsonld",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
      "about": {"@id": "./"},
      "description": "RO-Crate Metadata File Descriptor (this file)"
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "name": "Example RO-Crate",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {"@id": "data1.txt"},
        {"@id": "data2.txt"}
      ]
    },


    {
      "@id": "data1.txt",
      "@type": "File",
      "description": "One of hopefully many Data Entities",
      "author": {"@id": "#alice"},
      "contentLocation":  {"@id": "http://sws.geonames.org/8152662/"}
    },
    {
      "@id": "data2.txt",
      "@type": "File"
    },

    {
      "@id": "#alice",
      "@type": "Person",
      "name": "Alice",
      "description": "One of hopefully many Contextual Entities"
    },
    {
      "@id": "http://sws.geonames.org/8152662/",
      "@type": "Place",
      "name": "Catalina Park"
    }
 ]
}
```

**Note**: entities above have been shortened for brevity, see their individual sections elsewhere in this specification.

The order of the `@graph` list is not significant. Above we see that the RO-Crate JSON-LD graph contain the _RO-Crate Metadata File Descriptor_, the _Root Data Entity_, any _Data Entities_ and any _Contextual Entities_.


### Describing entities in JSON-LD

Properties of an entity can refer to another URL or entity by using the form `{"@id": "uri-reference"}` as in the example above, where the [author] property in the [File] entity refer to the [Person] entity, identified as `#alice`. 

Identifiers in `@id` SHOULD be either a valid _absolute URIs_ like <http://example.com/>, or an _URI references_ _URI paths_ relative to the RO-Crate root directory. Care must be taken to express any relative paths using `/` separator and escape special characters like space (`%20`). As JSON-LD supports _IRIs_, international characters in identifiers SHOULD be encoded in UTF-8 rather than `%`-escaped.

Because the _RO-Crate JSON-LD_ is _flattened_, all described entities must be direct children of the `@graph` element rather than being nested under another property or list.

If no obvious identifier is available for a contextual entity, an identifier local to the _RO-Crate Metadata File_ can be generated, for instance `{"@id": "#alice"}` or `{"@id": "#ac0bd781-7d91-4cdf-b2ad-7305921c7650"}`. Although it is RECOMMENDED to use `#`-based local identifiers, identifiers in `@id` MAY alternatively be a _blank node_ identifier (e.g. `_:alice`).

Multiple values and references can be represented using JSON arrays, as exemplified in `hasPart` above, however as the `RO-Crate JSON-LD` is in _compacted form_ any single-element arrays like `"author": [{"@id": "#alice"}]` SHOULD be unpacked to a single value like `"author": {"@id": "#alice"}`.


### RO-Crate JSON-LD Context

The main purpose of the `@context` is to relate JSON property keys and `@type` references to their Linked Data identifiers, which in RO-Crate is based primarily on <http://schema.org/> URIs.

In other uses of JSON-LD the context may perform more automatic or detailed mapping, but the `RO-Crate JSON-LD context` is deliberately flat, listing every property and type.

To find the full description of a particular property or type, follow its URI from the context. For instance, we can find within the context <https://w3id.org/ro/crate/1.1-DRAFT/context> that `author` above is mapped to <http://schema.org/author>:

```json
   "author": "http://schema.org/author",
```

The _RO-Crate JSON-LD Context_ may either be set by reference to <https://w3id.org/ro/crate/1.1-DRAFT/context>, or by value (merging the two documents).

Consider the below (simplified) example of _by reference_ using a versioned permalink:

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [
    {
      "@id": "ro-crate-metadata.jsonld",
      "@type": "CreativeWork",
      "description": "RO-Crate Metadata File Descriptor (this file)",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
      "about": {"@id": "./"}
    }
  ]
}
```

The above is equivalent to this JSON-LD using an embedded context, by adding the subset of corresponding keys from the external `@context`:

```json
{ "@context": {
      "CreativeWork": "http://schema.org/CreativeWork",
      "about": "http://schema.org/about",
      "description": "http://schema.org/description",
      "conformsTo": "http://purl.org/dc/terms/conformsTo",
      "about": "http://schema.org/about"
  },
  "@graph": [
    {
      "@id": "ro-crate-metadata.jsonld",
      "@type": "CreativeWork",
      "description": "RO-Crate Metadata File Descriptor (this file)",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
      "about": {"@id": "./"}
    }
  ]
}
```

While the second form is more verbose, one advantage is that it is "archivable" as it does not require Internet access for retrieving the `@context` permalink. Tools consuming or archiving RO-Crate MAY replace by-reference `@context` URIs with an embedded context by using version-specific hard-coded contexts, see <https://github.com/ResearchObject/ro-crate/releases>

To check which RO-Crate version is used (in terms of properties and types expected), clients SHOULD check the property `conformsTo` on the _RO-Crate Metadata File Descriptor_ rather than the value of `@context`.

RO-Crate consumers SHOULD NOT do the opposite substitution from an embedded context, but MAY use the [JSON-LD flattening](https://www.w3.org/TR/json-ld-api/#flattening-algorithm) algorithm with _compaction_ to a referenced _RO-Crate JSON-LD context_ (but see notes on [handling relative URI references](#handling-relative-uri-references) below).

**Tip**: The [JSON-LD flattening & compaction](https://www.w3.org/TR/json-ld-api/#flattening-algorithm) algorithms can be used to rewrite to a different `@context`, e.g. to <http://schema.org> or a different version of the _RO-Crate JSON-LD Context_.

### RO-Crate JSON-LD Media type

The [media type][RFC 6838] for `ro-crate-metadata.jsonld` will, when following this specification, comply
with the [flattened/compacted JSON-LD profiles](https://www.w3.org/TR/json-ld/#application-ld-json) as well as `https://w3id.org/ro/crate`, which may be indicated in a [HTTP response](https://tools.ietf.org/html/rfc7231#section-3.1.1.5) as:

```http
    HEAD http://example.com/ro-123/ro-crate-metadata.jsonld HTTP/1.1

    HTTP/1.1 200 OK
    Content-Type: application/ld+json; profile="http://www.w3.org/ns/json-ld#flattened http://www.w3.org/ns/json-ld#compacted https://w3id.org/ro/crate"
```


### Extending RO-Crate

To extend RO-Crate, implementers SHOULD try to use existing <http://schema.org/> properties and classes and MAY use terms from other vocabularies and ontologies when this is not possible.

The terms (properties and classes) used SHOULD be added as keys to the `@context` in the _RO-Crate JSON-LD_ (if not present). To avoid duplicating the _RO-Crate JSON-LD Context_ the `@context: []` array form SHOULD be used as shown below.

URIs in the `@context` SHOULD resolve to a useful human readable page. Where this is not possible - for example if the URI resolves to an RDF ontology file, a human-readable URI SHOULD be provided using a [sameAs] description.

For example. The `@id` URI <http://purl.org/ontology/bibo/interviewee> from the [BIBO ontology](http://neologism.ecs.soton.ac.uk/bibo.html) ontology itends to resolve to an ontology file, which is not useful for humans, however the HTML section <http://neologism.ecs.soton.ac.uk/bibo.html#interviewee> is human-readable.


```json
{
  "@context": [ 
    "https://w3id.org/ro/crate/1.1-DRAFT/context",
    {"interviewee": "http://purl.org/ontology/bibo/interviewee"},
  ],
  "@graph": [
  {
      "@id": "http://purl.org/ontology/bibo/interviewee",
      "sameAs": "http://neologism.ecs.soton.ac.uk/bibo.html#interviewee",
      "@type": "Thing"
  }
 ]
}
```


When generating the _RO-Crate Website_ from _RO-Crate JSON-LD_, the code MUST use a [sameAs] URI (if present) as a target for an explanatory link for the term instead of the Linked Data URI supplied in the `@context`.

Where there is no RDF ontology available, then implementors SHOULD attempt to provide context by creating stable web-accessible URIs to document properties and classes, for example, by linking to page describing an XML element or attribute from an XML schema, pending the publication of a formal ontology.

### Handling relative URI references

The _RO-Crate Metadata File_ use _relative URI references_ to identify files and directories
contained within the _RO-Crate Root_ and its children.  As described in section
[Describing entities in JSON-LD](#describing-entities-in-json-ld) above, 
relative URI references are also frequently used for 
identifying _Contextual entities_.

When using JSON-LD tooling and RDF libraries to consume or generate RO-Crates, 
extra care should be taken to ensure these URI references are handled correctly.

For this, a couple of scenarios are sketched below with recommendations for
consistent handling:

#### Flattening JSON-LD from nested JSON

If performing
[JSON-LD flattening](https://www.w3.org/TR/json-ld-api/#flattening-algorithm) to generate a valid _RO-Crate Metadata File_ , add `@base: null` to the input JSON-LD `@context` array to avoid expanding relative URI references. The flattening `@context` SHOULD NOT need `@base: null`.

Example, this JSON-LD is in [compacted form](https://www.w3.org/TR/json-ld11/#compacted-document-form) which may be beneficial for processing, but is not yet valid _RO-Crate Metadata File_ as it has not been flattened into a `@graph` array.

```json
{ 
  "@context": [
    {"@base": null},
    "https://w3id.org/ro/crate/1.1-DRAFT/context"
  ],
  "@id": "ro-crate-metadata.jsonld",
  "@type": "CreativeWork",
  "description": "RO-Crate Metadata File Descriptor (this file)",
  "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
  "about": {
    "@id": "./",
    "@type": "Dataset",
    "name": "Example RO-Crate",
    "description": "The RO-Crate Root Data Entity"
    "hasPart": [
      { "@id": "data1.txt",
        "@type": "File",
        "description": "One of hopefully many Data Entities",
      },
      { "@id": "subfolder/",
        "@type": "Dataset"
      }
    ]
  }
}
```

Performing [JSON-LD flattening](https://www.w3.org/TR/json-ld-api/#flattening-algorithm) with:

```json
{ "@context": 
     "https://w3id.org/ro/crate/1.1-DRAFT/context"
}
```

Results in a valid _RO-Crate JSON-LD_ (actual order in `@graph` may differ):

```json
{
  "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [
    {
      "@id": "ro-crate-metadata.jsonld",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "./"
      },
      "description": "RO-Crate Metadata File Descriptor (this file)"
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {
          "@id": "data1.txt"
        },
        {
          "@id": "subfolder/"
        }
      ],
      "name": "Example RO-Crate"
    },
    {
      "@id": "data1.txt",
      "@type": "File",
      "description": "One of hopefully many Data Entities"
    },
    {
      "@id": "subfolder/",
      "@type": "Dataset"
    }
  ]
}
```

Note that the saved _RO-Crate JSON-LD_ SHOULD NOT include `{@base: null}` in its `@context`.


#### Expanding/parsing JSON-LD keeping relative referencing

[JSON-LD Expansion](https://www.w3.org/TR/json-ld-api/#expansion) can be used to 
resolve terms from the `@context` to absolute URIs, e.g. `http://schema.org/description`. This may be needed to parse [extended properties](#extending-ro-crate) or for combinations with other Linked Data.

This algorithm would normally also expand `@id` fields based on the current [base URI](https://www.w3.org/TR/json-ld11/#base-iri) of the _RO-Crate Metadata File_, but this may be a temporary location like `file:///tmp/rocrate54/ro-crate-metadata.jsonld`, meaning `@id`: `subfolder/` becomes `file:///tmp/rocrate54/subfolder/` after JSON-LD expansion.

To avoid absoluting local identifiers, before expanding, augment the JSON-LD `@context` to ensure it is an array that includes `{"@base": null}`.

For example, expanding

```json
{
  "@context": [
    "https://w3id.org/ro/crate/1.1-DRAFT/context",
    {"@base": null}
  ]
  "@graph": [
    {
      "@id": "ro-crate-metadata.jsonld",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "./"
      },
      "description": "RO-Crate Metadata File Descriptor (this file)"
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {
          "@id": "data1.txt"
        },
        {
          "@id": "subfolder/"
        }
      ],
      "name": "Example RO-Crate"
    }
  ]
}
```

Results in a [expanded form](https://www.w3.org/TR/json-ld11/#expanded-document-form) without `@context`, using absolute URIs for properties and types, but retains relative URI references for entities within the _RO-Crate Root_:

```json
[
  {
    "@id": "ro-crate-metadata.jsonld",
    "@type": [
      "http://schema.org/CreativeWork"
    ],
    "http://schema.org/about": [
      {
        "@id": "./"
      }
    ],
    "http://purl.org/dc/terms/conformsTo": [
      {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      }
    ],
    "http://schema.org/description": [
      {
        "@value": "RO-Crate Metadata File Descriptor (this file)"
      }
    ]
  },
  {
    "@id": "./",
    "@type": [
      "http://schema.org/Dataset"
    ],
    "http://schema.org/description": [
      {
        "@value": "The RO-Crate Root Data Entity"
      }
    ],
    "http://schema.org/hasPart": [
      {
        "@id": "data1.txt"
      },
      {
        "@id": "subfolder/"
      }
    ],
    "http://schema.org/name": [
      {
        "@value": "Example RO-Crate"
      }
    ]
  }
]
```

Note that `@base: null` will not relativize existing absolute URIs that happen to be contained by the _RO-Crate Root_ (see section [Relativizing absolute URIs within RO-Crate Root](#relativizing-absolute-uris-within-ro-crate-root)).

**Note**: Most RDF parsers supporting JSON-LD will perform this kind of expansion before generating triples, but not all RDF stores or serializations support relative URI references. Consider using an alternative `@base` as detailed in sections below.

#### Establishing absolute URI for RO-Crate Root

When loading _RO-Crate JSON-LD_ as RDF, or combining the crate's Linked Data into a larger JSON-LD, it is important to ensure correct
[base URI](https://www.w3.org/TR/2014/REC-json-ld-20140116/#base-iri)
to resolve URI references that are relative to the _RO-Crate Root_.

Note that when retrieving an RO-Crate over the web, servers might have performed HTTP redirections so that the base URI is different from what was requested. It is RECOMMENDED to follow section [Establishing a Base URI of RFC3986](http://tools.ietf.org/html/rfc3986#section-5.1) before resolving relative links from the _RO-Crate Metadata File_.

For instance, consider this HTTP redirection from a permalink (simplified):

```http
GET https://w3id.org/ro/crate/1.0/crate HTTP/1.1

HTTP/1.1 301 Moved Permanently
Location: https://researchobject.github.io/ro-crate/1.0/ro-crate-metadata.jsonld
```

```http
GET https://researchobject.github.io/ro-crate/1.0/ro-crate-metadata.jsonld HTTP/1.1

HTTP/1.1 200 OK
Content-Type: application/ld+json

{
    "@context": "https://w3id.org/ro/crate/1.0/context",
    "@graph": [
      {
        "@id": "ro-crate-metadata.jsonld",
        "@type": "CreativeWork",
        "conformsTo": {
          "@id": "https://w3id.org/ro/crate/1.0"
        },
        "about": {
          "@id": "./"
        },
        "license": {
          "@id": "https://creativecommons.org/publicdomain/zero/1.0/"
        }
      },
      {
        "@id": "./",
        "@type": "Dataset",
        "hasPart": [
          {
            "@id": "index.html"
          }
      }
    ]
}
```

Following redirection we see that the _base URI_ of the _RO-Crate Metadata File_ becomes `https://researchobject.github.io/ro-crate/1.0/ro-crate-metadata.jsonld`, and therefore the absolute URI for `index.html` is `https://researchobject.github.io/ro-crate/1.0/index.html` rather than `https://w3id.org/ro/crate/1.0/index.html` which would not redirect correctly.


##### Finding RO-Crate Root in RDF triple stores

When parsing _RO-Crate JSON-LD_ as RDF, where the RDF framework performs resolution to absolute URIs, it may be difficult to find the _RO-Crate Root_ in the parsed triples.

The algoritm proposed in section [Core Metadata for the Root Data Entity](#core-metadata-for-the-root-data-entity) allows finding the `ro-crate-metadata.jsonld`. We can adopt this for RDF triples, thus finding crates conforming to this specification can be queried with [SPARQL](https://www.w3.org/TR/sparql11-query/):

```sparql
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX schema:  <http://schema.org/>

SELECT ?crate ?metadatafile
WHERE {
  ?crate        a                  schema:Dataset .
  ?metadatafile schema:about       ?crate .
  ?metadatafile dcterms:conformsTo <https://w3id.org/ro/crate/1.1-DRAFT> .
}
```

..or (less efficient) for any RO-Crate version:

```sparql
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX schema:  <http://schema.org/>

SELECT ?crate ?metadatafile ?spec
WHERE {
  ?crate        a                  schema:Dataset .
  ?metadatafile schema:about       ?crate .
  ?metadatafile dcterms:conformsTo ?spec .

  FILTER STRSTARTS(str(?spec), "https://w3id.org/ro/crate/")
}
```


##### Parsing as RDF with a different RO-Crate Root

When parsing a _RO-Crate Metadata File_ into [RDF triples](https://www.w3.org/TR/rdf11-concepts/), for instance uploading it to a _graph store_ like [Apache Jena](https://jena.apache.org/)'s [Fuseki](https://jena.apache.org/documentation/fuseki2/), it is important to ensure consistent _base URI_:

* Some RDF stores and RDF formats don't support relative URI references in triples (see [RDF 1.1 concepts](https://www.w3.org/TR/rdf11-concepts/#note-iris))
* The _RO-Crate Root_ may depend on where the _RO-Crate Metadata File_ was parsed from, e.g. `<file:///tmp/ro-crate-metadata.jsonld>` (file) or `<http://localhost:3030/test/ro-crate-metadata.jsonld>` (web upload)
* Parsing multiple RO-Crates into the same RDF graph, using same base URI, may merge them into the same RO-Crate
* `ro-crate-metadata.json` may not be recognized as JSON-LD and must be renamed to `ro-crate-metadata.jsonld`
* If base URI is not correct it may be difficult to find the corresponding file and directory paths from an RDF query returning absolute URIs

**Tip**: If the RDF library can parse the _RO-Crate JSON-LD_ directly by retrieving from a `http`/`https` URI of the _RO-Crate Metadata File_ it should calculate the correct base URI as detailed in section [Establishing absolute URI for RO-Crate Root](#establishing-absolute-uri-for-ro-crate-root) and you should **not** need to override the base URI as detailed here.

If a web-based URI for the _RO-Crate root_ is known, then this can be supplied as a _base URI_. Most RDF tools support a `--base` option or similar. If this is not possible, then the `@context` of the `RO-Crate JSON-LD` can be modified by ensuring the `@context` is an array that sets the desired `@base`:

```json
{
  "@context": [
    "https://w3id.org/ro/crate/1.1-DRAFT/context",
    {"@base": "http://example.com/crate255/"}
  ],
  "@graph": [
    {
      "@id": "ro-crate-metadata.jsonld",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "./"
      }
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "name": "Example RO-Crate"
    },
    {
      "@id": "data1.txt",
      "@type": "File",
      "description": "One of hopefully many Data Entities"
    },
    {
      "@id": "subfolder/",
      "@type": "Dataset"
    }
  ]
}
```

Parsing this will generate triples like below using `http://example.com/crate255/` as the _RO-Crate Root_ (shortened):

```
<http://example.com/crate255/ro-crate-metadata.jsonld> <http://purl.org/dc/terms/conformsTo> <https://w3id.org/ro/crate/1.1-DRAFT> .

<http://example.com/crate255/ro-crate-metadata.jsonld> <http://schema.org/about> <http://example.com/crate255/> .

<http://example.com/crate255/> <http://schema.org/name> "Example RO-Crate" .

<http://example.com/crate255/> <http://schema.org/hasPart> <http://example.com/crate255/data1.txt> .

<http://example.com/crate255/> <http://schema.org/hasPart> <http://example.com/crate255/subfolder/> .

<http://example.com/crate255/data1.txt> <http://schema.org/description> "One of hopefully many Data Entities" .

```

Generating a _RO-Crate JSON-LD_ from such triples can be done by first [finding the RO-Crate Root](#finding-ro-crate-root-in-rdf-triple-stores) and then use it as base URI to [relativize absolute URIs within RO-Crate Root](#relativizing-absolute-uris-within-ro-crate-root).


##### Establishing a base URI inside a ZIP file

An RO-Crate may have been packaged as a ZIP file or similar archive. RO-Crates may exist in a temporary file path which should not determine its identifiers.

When parsing such crates it is recommended to use the
[Archive and Package (arcp) URI scheme](https://tools.ietf.org/id/draft-soilandreyes-arcp-03.html)
to establish a temporary/location-based UUID or hash-based (SHA256) _base URI_. 

For instance, given a randomly generated UUID `029bcde1-dfa3-43cf-b7d9-a4fb75ccd4eb` we can use `arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/` as the `@base`:


```json
{
  "@context": [
    "https://w3id.org/ro/crate/1.1-DRAFT/context",
    {"@base": "arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/"}
  ],
  "@graph": [
    {
      "@id": "ro-crate-metadata.jsonld",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "./"
      }
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {
          "@id": "data1.txt"
        },
        {
          "@id": "subfolder/"
        }
      ],
      "name": "Example RO-Crate"
    },
    {
      "@id": "data1.txt",
      "@type": "File",
      "description": "One of hopefully many Data Entities"
    },
    {
      "@id": "subfolder/",
      "@type": "Dataset"
    }
  ]
}
```

Parsing this as RDF will generate triples including:

```turtle
<arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/ro-crate-metadata.jsonld> <http://schema.org/about> <arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/> .

<arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/> <http://schema.org/hasPart> <arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/data1.txt> .
```

Here consumers can assume `/` is the _RO-Crate Root_ and generating relative URIs can safely be achieved by  search-replace as the arcp URI is unique. Saving _RO-Crate JSON-LD_ from the triples can be done by using the arcp URI to [relativize absolute URIs within RO-Crate Root](#relativizing-absolute-uris-within-ro-crate-root).

**Bagit**: The arcp specification suggests how [BagIt identifiers](https://tools.ietf.org/html/draft-soilandreyes-arcp-03#appendix-A.4) can be used to calculate the base URI. See also section [Combining with other packaging schemes](#combining-with-other-packaging-schemes) - note that in this approach the _RO-Crate Root_ will be the payload folder `/data/` under the calculated arcp base URI.

#### Relativizing absolute URIs within RO-Crate Root

Some applications may prefer working with absolute URIs, e.g. in a joint graph store or web-based repository, but should relativize URIs within the _RO-Crate Root_ before generating the _RO-Crate Metadata File_.

Assuming a repository at `example.com` has JSON-LD with absolute URIs:

```json
{
  "@context": "https://w3id.org/ro/crate/1.1-DRAFT",
  "@graph": [
    {
      "@id": "http://example.com/crate415/ro-crate-metadata.jsonld",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "http://example.com/crate415/"
      },
    },
    {
      "@id": "http://example.com/crate415/",
      "@type": "Dataset",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {
          "@id": "http://example.com/crate415/data1.txt"
        },
        {
          "@id": "http://example.com/crate415/subfolder/"
        }
      ],
      "name": "Example RO-Crate"
    }
  ]
}
```

Then performing [JSON-LD flattening](https://www.w3.org/TR/json-ld-api/#flattening-algorithm)
with this `@context`:

```json
{ "@context": [
    {"@base": "http://example.com/crate415/"},
     "https://w3id.org/ro/crate/1.1-DRAFT"
  ]
}
```

Will output _RO-Crate JSON-LD_ with relative URIs:

```json
{
  "@context": [
    {
      "@base": "http://example.com/crate415/"
    },
    "https://w3id.org/ro/crate/1.1-DRAFT"
  ],
  "@graph": [
    {
      "@id": "./",
      "@type": "Dataset",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {
          "@id": "data1.txt"
        },
        {
          "@id": "subfolder/"
        }
      ],
      "name": "Example RO-Crate"
    },
    {
      "@id": "ro-crate-metadata.jsonld",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "./"
      }
    }
  ]
}
```

**Warning**: This method would also relativize URIs outside the _RO-Crate Root_ that are on the same host, e.g. `http://example.com/crate255/other.txt` would become `../create255/other.txt` - this can particularly be a challenge with local `file:///` URIs. 


## APPENDIX: Implementation notes

### Programming with JSON-LD

When implementing tools to work with RO-Crate it is not necessary to use JSON-LD
software libraries, however, programmers should keep in mind the following:

-  _RO-Crate JSON-lD_ has a flat structure; every item is in a list in the `@graph` in the _RO-Crate Metadata File_. A useful strategy when processing a crate is to build a look-up table and/or function so that items can be found via their ID, for example provide a method such as `getItem(id)` which returns an item by its id or a null value if it's not there.

- Code defensively. Code should not assume that values will always be a String; values for properties may be single scalar values such as strings or integers (`"2"` or 2), or references to other items such as `{"@id", "_:1"}` (where the referenced item may or may not be in the crate, see the point above about having a `getItem()` method).

- Read the *whole* specification. In order to make the RO-Crate specification
  readable it deals with common use cases on a case by case basis, introducing
  aspects of the specification as well. Some key points, such as "items may have
  more than one value for @type" may not be apparent from a quick reading.


### Combining with other packaging schemes

RO-Crates may co-exist with other packaging schemes, such as [BagIt] using two
general approaches; either (a) _adding_ RO-Crate into a package as part of the payload
or (b) _wrapping_ another kind of package. Examples using BagIt follow.

BagIt is described in [RFC 8493]:

> [BagIt is] ... a set of hierarchical file layout conventions
> for storage and transfer of arbitrary digital content. A "bag" has just enough
> structure to enclose descriptive metadata "tags" and a file "payload" but does
> not require knowledge of the payload's internal semantics. This BagIt format
> is suitable for reliable storage and transfer.

BagIt and RO-Crate have largely separate concerns - RO-Crate is focussed on rich
metadata, the semantics of data, while BagIt is about reliable transfer.

#### Example of adding RO-Crate to Bagit

RO-Crate can be combined with BagIt simply by placing the RO-Crate files in the BagIt
payload (`data/`) directory.

```
<RO-Crate root directory>/
  |   bagit.txt                 # As per BagIt specification
  |   bag-info.txt              # As per BagIt specification
  |   manifest-<algorithm>.txt  # As per BagIt specification
  |   fetch.txt                 # Optional, per BagIt Specification
  |   data/
      |   ro-crate-metadata.jsonld  # RO-Crate Metadata File MUST be present
      |   ro-crate-preview.html     # RO-Crate Website homepage MAY be present
      |   ro-crate-preview_files/   # MAY be present
      |     [payload files and directories]  # 1 or more SHOULD be present
```

**Base URI**: The arcp specification suggests how [BagIt UUID identifiers](https://tools.ietf.org/html/draft-soilandreyes-arcp-03#appendix-A.4) can be used to calculate the base URI of a bag, see section [Establishing a base URI inside a ZIP file](#establishing-a-base-uri-inside-a-zip-file).  For this purpose it is RECOMMENDED that `bag-info.txt` includes a fresh UUID like:

    External-Identifier: urn:uuid:24e51ca2-5067-4598-935a-dac4e327d05a


#### Example of wrapping a BagIt bag in an RO-Crate

Alternatively, an RO-Crate can wrap a BagIt bag, so that the RO-Crate metadata
is outside of the bag directory and can be changed without changing the payload's checksums. 

```
<RO-Crate root directory>/
  |   ro-crate-metadata.jsonld  # RO-Crate Metadata File MUST be present
  |   ro-crate-preview.html     # RO-Crate Website homepage MAY be present
  |   ro-crate-preview_files/   # MAY be present
  |   bag/                      # "Wrapped" bag - could have any name
  |      bagit.txt                 # As per BagIt specification
  |      bag-info.txt              # As per BagIt specification
  |      manifest-<algorithm>.txt  # As per BagIt specification
  |      fetch.txt                 # Optional, per BagIt Specification
  |      data/
  |         [payload files and directories]  # 1 or more SHOULD be present
  |          example.txt 
```

A _Data Entity_ describing example.txt would have an `@id` of `bag/data/example.txt`:

```json
{
  "@id": "bag/data/example.txt",
  "name": "Example file"
}
```


### Repository-specific identifiers

_Root Data Entities_ MAY also have additional repository specific identifiers, described using `Contextual Entities` using a [PropertyValue], with a `name` that identifies the repository and the `identifier` as a value. The _same_ identifier MAY be used in multiple different repositories and effectively namespaced using the `name` of the ProperyValue.

```json
{
  "@id": "./",
  "@type": "Dataset",
  "identifier": ["https://doi.org/10.4225/59/59672c09f4a4b", {"@id": "_:localid:my-repo:my-id"}, {"@id": "_:localid:other-repo:https://doi.org/10.4225/59/59672c09f4a4b"}]
}

 {
   "@id": "_:localid:my-repo:my-id",
   "@type": "PropertyValue",
   "name": "my-repo",
   "value": "my-id"
 }

  {
   "@id": "_:localid:other-repo:https://doi.org/10.4225/59/59672c09f4a4b",
   "@type": "PropertyValue",
   "name": "other-repo",
   "value": "https://doi.org/10.4225/59/59672c09f4a4b"
 }
```



<!--  Below are reference links not rendered in HTML, see
https://kramdown.gettalong.org/syntax.html#reference-links
-->

[BagIt]: https://en.wikipedia.org/wiki/BagIt
[BagIt profile]: https://github.com/ruebot/bagit-profiles
[BIBO]: http://purl.org/ontology/bibo/interviewee
[conformsTo]: http://purl.org/dc/terms/conformsTo
[CURIE]: https://www.w3.org/TR/curie/
[DataCite]: https://www.datacite.org/
[DataCite Schema v4.0]: https://schema.datacite.org/meta/kernel-4.0/metadata.xsd
[DCAT]: https://www.w3.org/TR/vocab-dcat/
[Exif]: https://en.wikipedia.org/wiki/Exif
[Flattened Document Form]: https://json-ld.org/spec/latest/json-ld/#flattened-document-form
[FRAPO]: https://www.sparontologies.net/ontologies/frapo
[geonames]: https://www.geonames.org
[git]: https://git-scm.com/
[hasFile]: https://pcdm.org/2016/04/18/models#hasFile
[hasMember]: https://pcdm.org/2016/04/18/models#hasMember
[isOutputOf]: https://sparontologies.github.io/frapo/current/frapo.html#d4e526
[JSON]: http://json.org/
[JSON-LD]: https://json-ld.org/
[linked data]: https://en.wikipedia.org/wiki/Linked_data
[OCFL]: https://ocfl.io/
[OCFL Object]: https://ocfl.io/0.3/spec/#object-spec
[ORCID]: https://orcid.org
[Pairtree]: https://confluence.ucop.edu/display/Curation/PairTree
[Pairtree specification]: https://confluence.ucop.edu/display/Curation/PairTree?preview=/14254128/16973838/PairtreeSpec.pdf
[PCDM]: https://github.com/duraspace/pcdm/wiki
[Pronom]: https://www.nationalarchives.gov.uk/PRONOM/Default.aspx
[RepositoryCollection]: https://pcdm.org/2016/04/18/models#Collection
[RepositoryObject]: https://pcdm.org/2016/04/18/models#Object
[ResearchObject]: https://www.researchobject.org/
[schema.org]: http://schema.org
[WorkflowSketch]: http://wf4ever.github.io/ro/2016-01-28/roterms/#Sketch

[Action]: http://schema.org/Action
[ActionStatusType]: http://schema.org/ActionStatusType
[ActiveActionStatus]: http://schema.org/ActiveActionStatus
[CompletedActionStatus]: http://schema.org/CompletedActionStatus
[ComputerLanguage]: http://schema.org/ComputerLanguage
[CreateAction]: http://schema.org/CreateAction
[CreativeWork]: http://schema.org/CreativeWork
[DataDownload]: http://schema.org/DataDownload
[Dataset]: http://schema.org/Dataset
[FailedActionStatus]: http://schema.org/FailedActionStatus
[File]: http://schema.org/MediaObject
[Journal]: http://schema.org/Periodical
[GeoCoordinates]: http://schema.org/GeoCoordinates
[ImageObject]: http://schema.org/ImageObject
[MediaObject]: http://schema.org/MediaObject
[Organization]: http://schema.org/Organization
[Person]: http://schema.org/Person
[PotentialActionStatus]: http://schema.org/PotentialActionStatus
[Place]: http://schema.org/Place
[Product]: http://schema.org/Product
[PropertyValue]: http://schema.org/PropertyValue
[ScholarlyArticle]: http://schema.org/ScholarlyArticle
[SoftwareApplication]: http://schema.org/SoftwareApplication
[SoftwareSourceCode]: http://schema.org/SoftwareSourceCode
[UpdateAction]: http://schema.org/UpdateAction

[about]: http://schema.org/about
[accountablePerson]: http://schema.org/accountablePerson
[actionStatus]: http://schema.org/actionStatus
[affiliation]: http://schema.org/affiliation
[agent]: http://schema.org/agent
[alternateName]: http://schema.org/alternateName
[author]: http://schema.org/author
[citation]: http://schema.org/citation
[contact]: http://schema.org/accountablePerson
[contactPoint]: http://schema.org/contactPoint
[contactType]: http://schema.org/contactType
[contentLocation]: http://schema.org/contentLocation
[contributor]: http://schema.org/contributor
[copyrightHolder]: http://schema.org/copyrightHolder
[datePublished]: http://schema.org/datePublished
[description]: http://schema.org/description
[distribution]: http://schema.org/distribution
[email]: http://schema.org/email
[encodingFormat]: http://schema.org/encodingFormat
[endTime]: http://schema.org/endTime
[error]: http://schema.org/error
[event]: http://schema.org/event
[familyName]: http://schema.org/familyName
[funder]: http://schema.org/funder
[geo]: http://schema.org/geo
[givenName]: http://schema.org/givenName
[hasPart]: http://schema.org/hasPart
[identifier]: http://schema.org/identifier
[IndividualProduct]: http://schema.org/IndividualProduct
[instrument]: http://schema.org/instrument
[keywords]: http://schema.org/keywords
[license]: http://schema.org/license
[memberOf]: http://schema.org/memberOf
[name]: http://schema.org/name
[object]: http://schema.org/object
[phone]: http://schema.org/phone
[programmingLanguage]: http://schema.org/programmingLanguage
[publisher]: http://schema.org/publisher
[relatedItem]: http://schema.org/relatedItem
[result]: http://schema.org/result
[sameAs]: http://schema.org/sameAs
[sdLicense]: http://schema.org/sdLicense
[sdPublisher]: http://schema.org/sdPublisher
[startTime]: http://schema.org/startTime
[temporalCoverage]: http://schema.org/temporalCoverage
[thumbnail]: http://schema.org/thumbnail
[translationOf]: http://schema.org/translationOf
[translator]: http://schema.org/translator
[url]: http://schema.org/url
[version]: http://schema.org/version

[RFC 2119]: https://tools.ietf.org/html/rfc2119
[RFC 3986]: https://tools.ietf.org/html/rfc3986
[RFC 6838]: https://tools.ietf.org/html/rfc6838
[RFC 7159]: https://tools.ietf.org/html/rfc7159
[RFC 8493]: https://tools.ietf.org/html/rfc8493
