---
layout: default
title: RO-Crate 0.2
exclude: true
---
<!--
   Copyright 2019 University of Technology Sydney
   Copyright 2019 The University of Manchester UK 
   Copyright 2019 RO Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# RO-Crate Metadata Specification 0.2

* Permalink: <https://w3id.org/ro/crate/0.2>
* Cite as: <https://doi.org/10.5281/zenodo.3406498> (this version)
  <https://doi.org/10.5281/zenodo.3406497> (any version)
* JSON-LD context: <https://w3id.org/ro/crate/0.2/context>
* Status: Working Draft
* Publisher: [researchobject.org](http://researchobject.org/) community
* Published: 2019-09-12
* Editors: [Peter Sefton](https://orcid.org/0000-0002-3545-944X), [Eoghan Ó Carragáin](https://orcid.org/0000-0001-8131-2150),  [Stian Soiland-Reyes](https://orcid.org/0000-0001-9842-9718)
* Authors: [Peter Sefton](https://orcid.org/0000-0002-3545-944X), [Eoghan Ó Carragáin](https://orcid.org/0000-0001-8131-2150),  [Stian Soiland-Reyes](https://orcid.org/0000-0001-9842-9718), [Oscar Corcho](https://orcid.org/0000-0002-9260-0753), [Daniel Garijo](https://orcid.org/0000-0003-0454-7145), [Raul Palma](https://orcid.org/0000-0003-4289-4922), [Frederik Coppens](https://orcid.org/0000-0001-6565-5145), [Carole Goble](https://orcid.org/0000-0003-1219-2137), [José María Fernández](https://orcid.org/0000-0002-4806-5140), [Kyle Chard](https://orcid.org/0000-0002-7370-4805), [Jose Manuel Gomez-Perez](https://orcid.org/0000-0002-5491-6431), [Michael R Crusoe](https://orcid.org/0000-0002-2961-9670), [Ignacio Eguinoa](https://orcid.org/0000-0002-6190-122X), [Nick Juty](https://orcid.org/0000-0002-2036-8350), [Kristi Holmes](https://orcid.org/0000-0001-8420-5254), [Jason A. Clark](https://orcid.org/0000-0002-3588-6257), [Salvador Capella-Gutierrez](https://orcid.org/0000-0002-0309-604X), [Alasdair J. G. Gray](https://orcid.org/0000-0002-5711-4872), [Stuart Owen](https://orcid.org/0000-0003-2130-0865), [Alan R Williams](https://orcid.org/0000-0003-3156-2105)

1. Table of Contents
{:toc}


See <https://w3id.org/ro/crate> for further details about RO-Crate.

<small>
This specification is Copyright 2017-2019 University of Technology Sydney and The University of Manchester UK.
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


## Introduction & definition of an RO-Crate

> The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

This document specifies a method, known as _RO-Crate_ (Research Object Crate), of organizing file-based data with associated metadata, using linked data principles, in both human and machine readable formats, with the ability to include additional domain-specific metadata.

The core of RO-Crate is a JSON-LD file, the _RO-Crate Metadata File_, named `ro-crate-metadata.jsonld`. This file contains structured metadata about the dataset as a whole (the _Root Data Entity_) and, optionally, about some or all of its files. This provides a simple way to, for example, assert the authors (e.g. people, organizations) of the RO-Crate or one its files, or to capture more complex provenance for files, such as how they were created using software and equipment. 

While providing the formal specification for RO-Crate, this document also aims to be a practical guide for software authors to create tools for generating and consuming research data packages, with explanation by examples. 


### Terminology

_RO-Crate_: A directory structure that contains a dataset, which is described in an _RO-Crate Metadata File_.

_RO-Crate Root_: The top-level directory of the _RO-Crate_, indicated by the presence of the _RO-Crate Metadata File_ `ro-crate-metadata.jsonld`

_RO-Crate Metadata File_: A JSON-LD file stored as `ro-crate-metadata.jsonld` in the _RO-Crate Root_. The metadata file describes the _RO-Crate_ with structured data in form of _RO-Crate JSON-LD_.

_RO-Crate Website_: Human-readable HTML pages which describe the RO-Crate (i.e. the _Root Data Entity_, its _Data Entities_ and _Context Entities_), with a home-page at `ro-crate-preview.html` (any additional files reside in `ro-crate-preview_files/`)

_Data Entity_: A JSON-LD representation, in the _RO-Crate Metadata File_,_ of a directory, file or other resource contained or described by the RO-Crate.

_Root Data Entity_: A _Data Entity_ of type [Dataset], representing the RO-Crate as a whole.  

_RO-Crate Metadata File Descriptor_: A _Contextual Entity_ of type [CreativeWork], which describes the _RO-Crate Metadata File_ and links it to the _Root Data Entity_.

_JSON-LD_: A JSON-based file format for storing _Linked Data_. This document assumes [JSON-LD 1.0](http://www.w3.org/TR/2014/REC-json-ld-20140116/). JSON-LD use a _context_ to map from JSON keys to _URIs_.

_JSON_: The _JavaScript Object Notation (JSON) Data Interchange Format_ as defined by [RFC7159](https://tools.ietf.org/html/rfc7159); a structured text file format that can be programmatically consumed and generated in a wide range of programming languages.

_Context Entity_: A JSON-LD representation of an entity associated with a _Data Entity_, needed to adequately describe that _Data Entity_._ _For example, a  [Person](http://schema.org/Person), [Organization](http://schema.org/Organization) (including research projects), item of equipment ([IndividualProduct](http://schema.org/IndividualProduct)), [license](http://schema.org/license) or any other _thing_ or _event_ that forms part of the metadata for a _Data Entity_ or supporting information.

_Linked Data_: A data structure where properties, types and resources are identified with _URIs_, which if retrieved over the Web, further describe or provide the identified property/type/resource.

URI: A _Uniform Resource Identifier_ as defined in [RFC3986](https://tools.ietf.org/html/rfc3986), for example `http://example.com/path/file.html` - commonly known as _URL_. In this document the term _URI_ includes _IRI_, which also permit international Unicode characters.

_URI Path_: The relative _path_ element of an _URI_ as defined in [RFC3986 section 3.3](https://tools.ietf.org/html/rfc3986#section-3.3), e.g. `path/file.html`

_RO-Crate JSON-LD Context_: A JSON-LD [context](https://www.w3.org/TR/json-ld/#the-context) that provides Linked Data mapping for RO-Crate metadata to vocabularies like [schema.org](http://schema.org/). 

_RO-Crate JSON-LD_: JSON-LD using the _RO-Crate JSON-LD Context_ containing RO-Crate metadata, which has been [flattened](http://www.w3.org/TR/2014/REC-json-ld-20140116/#flattened-document-form) and then [compacted](http://www.w3.org/TR/2014/REC-json-ld-20140116/#compacted-document-form) according to the rules in JSON-LD 1.0. The _RO-Crate JSON-LD_  for an _RO-Crate_ is stored in the _RO-Crate Metadata File_.

### Linked data conventions

Throughout this specification, RDF terms are referred to using the keys defined in RO-Crate JSON-LD Context.

Following [schema.org](http://schema.org) practice, `property` names start with lowercase letters and `Class` names start with uppercase letters.

In `ro-crate-metadata.jsonld` RDF terms use their RO-Crate JSON-LD names as defined in the RO-Crate JSON-LD Context, which is available at [https://w3id.org/ro/crate/0.2/context](https://w3id.org/ro/crate/0.2/context)


## RO-Crate Structure

The structure an _RO-Crate_ MUST follow is:

```
<RO-Crate root directory>/
|   ro-crate-metadata.jsonld  # _RO-Crate Metadata File_ MUST be present
|   ro-crate-preview.html     # _RO-Crate Website_ homepage MAY be present
|   ro-crate-preview_files/   # MAY be present
|    | [_RO-Crate Website_ files]
|   [payload files and directories]  # 1 or more SHOULD be present
```

The name of the _RO-Crate root_ directory is not defined. For instance, if an _RO-Crate_  is archived in a ZIP-file, the _RO-Crate root_ directory will correspond to the ZIP root directory.


### _RO-Crate Metadata File_ (`ro-crate-metadata.jsonld`)

*  The _RO-Crate Metadata File_ MUST be named `ro-crate-metadata.jsonld` and appear in the _RO-Crate Root_
* `ro-crate-metadata.jsonld` MUST be a JSON-LD document which has been flattened and then compacted according to the rules in JSON-LD 1.1


### _RO-Crate Website_ (`ro-crate-preview.html` and `ro-crate-preview_files/`)

In addition to the machine-oriented _RO-Crate Metadata File_, the RO-Crate MAY include a human-readable HTML rendering of the same information, known as the _RO-Crate Website_.

If present, `ro-crate-preview.html` MUST:

  *   Be a valid [HTML 5](https://www.w3.org/TR/html52/) document 
  *   Contain at least a human readable summary of metadata relating to the _Root Data Entity_
  *   Contain a copy of the _RO-Crate JSON-LD_ in a `script` element of the `head` element of the HTML, for example:
  ```html
    <script type="application/ld+json">
    {
        "@context": "https://w3id.org/ro/crate/0.2/context",
        "@graph": [ ...]
    }
    </script>
  ```

`ro-crate-preview.html` SHOULD:
*   Contain at least the same information as the _RO-Crate JSON-LD_, with the exception that files which have no description, author or similar metadata MAY not be listed in the website.
*   Display at least the metadata relating to the _Root Data Enity_ as static HTML without the need for scripting. It MAY contain extra features enabled by JavaScript.
*   When a _Data Entity_ or _Context Entity_ is referenced by its ID:
  *   If it has a [name](http://schema.org/name) property, provide a link to its HTML version.
  *   If it does not have a name (e.g. a [GeoCoordinates](http://schema.org/GeoCoordinates) location), show it embedded in the HTML for the entity.
*   For keys that resolve in the `RO-Crate JSON-LD Context` to a URI, indicate this (the simplest way is to link the key to its definition.
*   For external URI values, provide a link.
*   If there is sufficient metadata, contain a prominent _“Cite-as”_ text with a natural language data citation (see for example the [FORCE11 Data Citation Principles](https://www.force11.org/group/joint-declaration-data-citation-principles-final)).
*   If there are additional resources necessary to render the preview (e.g. CSS, JSON, HTML), link to them in a subdirectory `ro-crate-preview-files/`

### Payload files and directories

These are the actual files and directories that make up the dataset being described. 

The base RO-Crate specification makes no assumptions about the presence of any specific files or folders beyond the reserved RO-Crate files described above. Payload files may appear directly in the _RO-Crate Root_ alongside the _RO-Crate Metadata File_, and/or appear in sub-directories of the RO-Crate Root._ Each file and directory MAY be represented as Data Entities in the _RO-Crate Metadata File_.


### RO-Crates SHOULD be self-describing and self-contained

A minimal RO-Crate is a directory containing a single _RO-Crate Metadata File_. 

At the basic level, an RO-Crate is a collection of files represented as a schema.org _[Dataset](https://schema.org/Dataset)_, that together form a meaningful unit for the purposes of communication, citation, distribution, preservation, etc.  The _RO-Crate Metadata File_ describes the RO-Crate, and MUST be stored in the _RO-Crate Root_. Self-containment is a core principle of RO-Crate, i.e. that all Dataset files and relevant metadata SHOULD, as far as possible, be contained by the RO-Crate, rather than referring to external resources. However the RO-Crate MAY also reference external resources which are stored or accessed separately, via URIs, e.g. because these cannot be included for practical or legal reasons. 

It is important to note that the _RO-Crate Metadata File_ is not an exhaustive manifest or inventory, that is, it does not necessarily list or describe all files in the package.  Rather it is focused on providing sufficient amount of metadata to understand and use the content and is designed to be compatible with existing and future approaches that _do_ have full inventories / manifest and integrity checks, e.g. by using checksums, such as [BagIt] and Oxford Common File Layout [OCFL] [Objects][OCFL Object].

The intention is that RO-Crates can work well with a variety of archive file formats, e.g. tar, zip, etc., and approaches to capturing file manifests and file fixity, such as [BagIt] and [OCFL], [git].


## RO-Crate Metadata


### RO-Crate uses linked data principles

**TODO** RO-Crate uses Linked Data principles [TODO - ref] - using URIs as names for things.


### Base metadata standard for RO-Crate: Schema.org

[Schema.org](http://schema.org) is the base metadata standard for RO-Crate. Schema.org was chosen because it is widely used on the World Wide Web and supported by search engines, on the assumption that discovery is likely to be maximized if search engines index the content. NOTE: As far as we know there is no alternative, well-maintained linked-data schema for research data with the coverage needed for this project - i.e. a single standard for expressing all the examples presented in this specification.

RO-Crate relies heavily on [schema.org](http://schema.org) using a constrained subset of  [JSON-LD](https://json-ld.org/), and this document gives opinionated recommendations on how to represent the metadata using existing linked data best practices

Generally, the standard keys for [schema.org](http://schema.org) should be used. However, RO-Crate uses variant names for some elements, specifically:

*   `File` is mapped to <http://schema.org/MediaObject> which was chosen as a compromise as it has many of the properties that are needed to describe a generic file. Future versions of schema.org or a research data extension may re-define `File`.
*   `Journal` is mapped to <http://schema.org/Periodical>.


### Additional metadata standards

The following terms from the from the [Research Object ontologies](https://w3id.org/ro/2016-01-28/) are used:

- `Workflow` for a workflow definition, mapped to [http://purl.org/wf4ever/wfdesc#Workflow](https://w3id.org/ro/2016-01-28/wfdesc#Workflow)
- `WorkflowScript` for a script, mapped to [http://purl.org/wf4ever/wf4ever#Script](https://w3id.org/ro/2016-01-28/wf4ever#Script)
- `WorkflowSketch` for an image depicting a workflow, mapped to [http://purl.org/wf4ever/roterms#Sketch](https://w3id.org/ro/2016-01-28/roterms#Sketch).

RO-Crate also uses the _Portland Common Data Model_ ([PCDM](https://github.com/duraspace/pcdm/wiki)) and imports these terms:
 
- `RepositoryObject` mapped to <https://pcdm.org/2016/04/18/models#Object>
- `RepositoryCollection` mapped to <https://pcdm.org/2016/04/18/models#Collection>
- `RepositoryFile` mapped to <https://pcdm.org/2016/04/18/models#File>
- `hasMember` mapped to <https://pcdm.org/2016/04/18/models#hasMember>
- `hasFile` mapped to <https://pcdm.org/2016/04/18/models#hasFile>

The keys `RepositoryObject` and `RepositoryCollection` were chosen to avoid collision between the terms Collection and Object with other vocabularies.


### Summary of Coverage

RO-Crate is simply a way to make metadata assertions about a set of files and folders that make up a _Dataset_. These assertions can be made at three levels:

*   Assertions at the RO-Crate/_Dataset _level: for an RO-Crate to be useful, some metadata should be provided about the dataset as a whole (see minimum requirements for different use-cases below). In the _RO-Crate Metadata File_, we distinguish the _Root Data Entity_ which represents the RO-Crate as a whole, from other _Data Entities_ (files and folders contained in the RO-Crate) and _Context Entities_, e.g. a person, organisation, place related to an RO-Crate _Data Entity_
*   Assertions about files and folders contained in the RO-Crate: in addition to providing metadata about the RO-Crate as a whole, RO-Crate allows metadata assertions to be made about any other _Data Entity_
*   Variable-level assertions: In some cases, e.g. for tabular data, additional metadata may be provided about the structure and variables within a given file. 

This document has guidelines for ways to represent common requirements for describing data in a research context, e.g.:

*   Contact information for a data set.
*   Descriptive information for a dataset and the files within it and their contexts such as an abstract, spatial and temporal coverage.
*   Associated Publications.
*   Funding relationships.
*   Provenance information of various kinds; who (people and organizations) and what (instruments and computer programs) created or contributed to the data set and individual files within it.
* Workflows that operate on the data using standard workflow descriptions including ‘single step workflows’; executable files or environments such as singularity containers or Jupyter notebooks.

However, as RO-Crate uses _Linked Data_ principles, adopters of RO-Crate are free to supplement RO-Crate using [schema.org](https://schema.org/) metadata and/or assertions using other _Linked Data_ vocabularies.


### Recommended Identifiers

_RO-Crate JSON-LD_ SHOULD use the following IDs where possible: 

*   For a _Root Data Entity_, an `identfier` which SHOULD be a DOI URL. 
*   For People participating in the research process: [ORCID](https://orcid.org) identifiers.
*   For [Organization](http://schema.org/Organization)s including [funder](http://schema.org/funder)s,  Research Organization Registry URIs. [https://ror.org/](https://ror.org/)
*   For items of type [Place], a geonames URL.
*   For file formats, a [Pronom] URL, for example <https://www.nationalarchives.gov.uk/PRONOM/fmt/831>.

In the absence of the above, RO-Crates SHOULD contain stable persistent URIs to identify all entities wherever possible.


### Core Metadata for the _Root Data Entity_ 

The _RO-Crate JSON-LD_ MUST contain a _Root Data Entity_, identified by a
_RO-Crate Metadata File Descriptor_ of type [CreativeWork] which describes it, with an [about]
property referencing the _Root Data Entity_ the _Root Data Entity_ MUST have an `@id` of `./`.

```json
{
    "@type": "CreativeWork",
    "@id": "ro-crate-metadata.jsonld",
    "identifier": "ro-crate-metadata.jsonld",
    "about": {"@id": "./"}
},

{
  "@id": "./",
  "@type": "Dataset",
  ...
}

```

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

schema property | constraints | Valid RO-Crate | Citation Use-case (DataCite) | Institutional data repository (JISC RDSS) | Data discovery (Google Dataset Search) 
--------------- | ----------- | -------------- | ---------------------------- | ----------------------------------------- | --------------------------------------
`@type` | Must be a schema:Dataset | M | M | M | M
`@id` | Must be a a string of ‘./’ | M | M | M | M
`name` |  | M | M | M | M
`datePublished` |  | M | M | M |
`author` | Must appear at least once |  referencing a Contextual Entity of `@type: Person` or `Organization` | ? | M | M |
`license` |  | M | M | M |
`identifier` |  | ? | M | M |
`distribution` |  |  |  |  | ?
`contactPoint` | Must appear at least once |  referencing a Contextual Entity of `@type ContactPoint` |  |  |  |
`publisher` |  | ? | M |  |
`description` |  | ? |  |  | M
`url` | Must be a valid _URI_ or _URI Path_ |  | M |  |
`hasPart` | Must appear for each additional Data Entity described in the RO-Crate JSON-LD which is a direct child of the Root Data Entity |  |  |  |

### Contextual Entity: Person

_(required since `author `is required)_

schema property | constraints | Valid RO-Crate | Citation Use-case (DataCite) | JISC RDSS | Data discovery (Google Dataset Search)
--------------- | ----------- | -------------- | ---------------------------- | --------- | --------------------------------------
`@type` |  | Y | M |  |
`@id` |  | Y | M | M |
`name` |  | Y | M |  |
`familyName` |  |  | O | M |
`givenName` |  |  | O | M |
`identifier` |  | ? | O | O |
`sameAs` |  |  |  |  | R

#### Contextual Entity: Organization

_(required since `author` is required)_

schema property | constraints | Valid RO-Crate | Citation Use-case (DataCite) | JISC RDSS | Data discovery (Google Dataset Search)
--------------- | ----------- | -------------- | ---------------------------- | --------- | --------------------------------------
`@type` |  | Y |  | Y |
`@id` |  | Y |  | Y |
`name` |  | Y |  | Y |

#### Contextual Entity: Contact Point

_(required if `contactPoint` is required)_

schema property | constraints | Valid RO-Crate | Citation Use-case (DataCite) | JISC RDSS | Data discovery (Google Dataset Search)
--------------- | ----------- | -------------- | ---------------------------- | --------- | --------------------------------------
`@type` |  | ? |  |  | ?
`@id` |  | ? |  |  | ?
`name` |  | ? |  |  | ?
`email` |  | ? |  |  | ?




The following _RO-Crate Metadata File_ represents a minimal description of an _RO-Crate_. Note that for brevity the _[RO-Crate JSON-LD Context](https://w3id.org/ro/crate/0.2/context)_ is here shown by reference rather than inline.

```json
{ "@context": "https://w3id.org/ro/crate/0.2/context", 
  "@graph": [

 {
    "@id": "./",
    "identifier": "https://doi.org/10.4225/59/59672c09f4a4b",
    "@type": "Dataset",
    "datePublished": "2017",
    "name": "Data files associated with the manuscript:Effects of facilitated family case conferencing for advanced dementia: A cluster randomised clinical trial",
    "distribution": { "@id": "https://data.research.uts.edu.au/examples/v1.0/timluckett.zip"
        },
"contactPoint": {
        "@id": "tim.luckett@uts.edu.au"
      }
 },
  
 {
    "@id": "https://data.research.uts.edu.au/examples/v1.0/timluckett.zip",
    "contentUrl": "https://data.research.uts.edu.au/examples/v1.0/timluckett.zip",
    "@type": "DataDownload",
    "encodingFormat": "application/zip"
 },

 {
      "@id": "tim.luckett@uts.edu.au",
      "@type": "ContactPoint",
      "contactType": "customer service",
      "email": "tim.luckett@uts.edu.au",
      "identifier": "tim.luckett@uts.edu.au",
      "url": "https://orcid.org/0000-0001-6121-5409"
  }

 ]
}
```

### Examples of referencing _Data Entities_ (files and folders) from the _Root Data Entity_

Where files and folders are represented as _Data Entities_ in the RO-Crate JSON-LD, these MUST be linked to, either directly or indriectly, from the Root Data Entity using the [hasPart] property. Directory hierarchies MAY be represented with nested Dataset _Data Entities_, or the Root Dataset MAY refer to files anywhere in the hierarchy using [hasPart].

_Data Entities_ representing files MUST be of `@type: File`, which is an RO-Crate alias for <http://schema.org/MediaObject>

_Data Entities_ representing directories MUST be of `@type: Dataset`.

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
{ "@context": "https://w3id.org/ro/crate/0.2/context",
  "@graph": [
  {
    "@id": "./",
    "@type": [
      "Dataset"
    ],
    "hasPart": [
      {
        "@id": "./cp7glop.ai"
      },
      {
        "@id": "./lots_of_little_files"
      },
      ],
   },
  {
    "@id": "./cp7glop.ai",
    "@type": "File",
    "contentSize": "383766",
    "description": "Illustrator file for Glop Pot",
    "encodingFormat": "application/pdf"
  },
  {
      "@id": "./lots_of_little_files",
      "@type": "Dataset",
      "description": "This directory contains many small files, that we're not going to describe in detail.",
      "name": "Too many files",

  }
]
```

#### Adding detailed descriptions of encodings

The above example provides a mime-type for the file `./cp7glop.ai` - which is
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

If there is not PRONOM identifier, then a contextual entity with a URL as an `@id` MAY be used:

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

If there is no web-accessible decription for a file format it SHOULD be described locally in the dataset, for example in a file:

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
  "encodingFormat": "text/plain",
  "name": "Description of some_extension file format",
  "@type": ["File", "CreativeWork"]
  }
```



### Core Metadata for _Data Entities_

The table below outlines the properties that Data Entities, when present, MUST have to be minimally valid .

 #### File Data Entity

schema property | constraints | Valid RO-Crate | Citation Use-case (DataCite) | JISC RDSS | Data discovery (Google Dataset Search)
--------------- | ----------- | -------------- | ---------------------------- | --------- | --------------------------------------
`@type` | MUST  be  a  File  (alias  of  MediaObject) | Y | | Y |
`@id` | MUST  be a _URI Path_ relative to the _RO Crate root_ | Y || Y |
`name` || Y || Y |
`contentSize` || ? || Y |
`dateModified` || ? || Y |
`fileFormat` || ? |||
`encodingFormat` || ? |||



#### Directory File Entity

schema property | constraints | Valid RO-Crate | Citation Use-case (DataCite) | JISC RDSS | Data discovery (Google Dataset Search)
--------------- | ----------- | -------------- | ---------------------------- | --------- | --------------------------------------
`@type` | MUST be `Dataset` |  | |  |


## Representing _Context Entities_
The _RO-Crate JSON-LD_ `@graph` SHOULD contain additional information about _Context Entities_ for the use of both humans (in `ro-crate-preview.html`) and machines (in `ro-crate-metadata.jsonld`). This also helps to maximise the extent to which an _RO-Crate_ is self-contained and self-describing, in that it reduces the need for the consumer of an RO-Crate to refer to external information which may change or become unavailable over time.

### People

A core principle of Linked data is to use URIs to identify things such as people. The following is the minimum recommended way of representing a [author](http://schema.org/author) in a RO-Crate. This property MAY be applied in the context of a directory ([Dataset](http://schema.org/Dataset)) or to a [File](http://schema.org/MediaObject).

```json
{
      "@type": "Dataset",
      "@id": "some_id",
      "author": {"@id": "https://orcid.org/0000-0002-8367-6908"}

}
{
    "@id": "https://orcid.org/0000-0002-8367-6908",
    "@type": "Person",
    "affiliation": "University of Technology Sydney",
    "name": "J. Xuan"
}
```

This uses an [ORCID](https://orcid.org/) to unambiguously identify an author, with a _Contextual Entity_ of type [Person]((http://schema.org/Person)).

Note the string-value of the organizational affiliation. This SHOULD be improved by also providing a _Context Entity_ for the organization (see example below).


### Organizations as values

An [Organization](http://schema.org/Organization) SHOULD be the value for the [publisher](http://schema.org/publisher) property of a [Dataset](http://schema.org/Dataset) or [ScholarlyArticle](http://schema.org/ScholarlyArticle) or [affiliation](http://schema.org/affiliation) property of a [Person](http://schema.org/Person).


```json
{
  "@type": "Dataset",
  "@id": "some_id",
  "publisher": {"@id": "https://ror.org/03f0f6041"}
}

{
  "@id": "https://ror.org/03f0f6041",
  "@type": "Organization",
  "name": "University of Technology Sydney",
  "url": "https://ror.org/03f0f6041"
}
```

An [Organization](http://schema.org/Organization) SHOULD also be used for a [Person](http://schema.org/Person)'s affiliation.

```json
{
  "@type": "Dataset",
  "@id": "some_id",
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

Sometimes researchers want to affiliate with a sub-part of an institution, such as institute, faculty department, or research group.

Here's a (real, but abridged) example of a researcher who has four institutional affiliations for a published article and data set:


```json
{
  "@id": "./",
  "identifier": "https://doi.org/10.4225/59/59672c09f4a4b",
  "@type": "Dataset",
  "author": {"@id": "https://orcid.org/0000-0002-6756-6119"}
},
{
  "@id": "https://orcid.org/0000-0002-6756-6119",
  "@type": "Person",
  "affiliation": [
    {
      "@id": "1"
    },
    {
      "@id": "2"
    },
    {
      "@id": "3"
    },
    {
      "@id": "4"
    }
  ],
  "name": "Meera Agar"
},
```

The first affiliation is a Faculty of a university. The Faculty is associated with the university via [memberOf](http://schema.org/memberOf).


```json
{
  "@id": "1",
  "@type": "Organization",
  "memberOf": {
    "@id": "https://ror.org/03f0f6041"
  },
  "name": "Faculty of Health, University of Technology Sydney"
},

{
  "@id": "https://ror.org/03f0f6041",
  "@type": "Organization",
  "name": "University of Technology Sydney"
},
```


Thus _RO-Crate JSON-LD_ MAY express chained affiliations with more precision than by using string-literals as values for [affiliation](http://schema.org/affiliation). 

[See an example of a Person with four affiliations.](https://data.research.uts.edu.au/examples/v1.0/luckett/CATALOG_files/pairtree_root/ht/tp/+=/=o/rc/id/,o/rg/=0/00/0-/00/02/-6/75/6-/61/19/index.html)


### More detail on ContactPoint

A RO-Crate SHOULD have contact information, using a [contactPoint](http://schema.org/contactPoint) property with a value of [ContactPoint](http://schema.org/contactPoint). Note that [Dataset](http://schema.org/Dataset) does not (yet) have a contactPoint property, so strictly this would have to be on a Person or Organization which is related to the Dataset via a [author](http://schema.org/author) or [contributor](http://schema.org/contributor) property.

NOTE: This usage follows that of Google Dataset search.

IMPLEMENTATION NOTE: The Google structured Data tool gives an error if `mailto:` URLs are used in the "url" property.

```json
{
      "@id": "https://orcid.org/0000-0001-6121-5409",
      "@type": "Person",
      "affiliation": {
        "@id": "1"
      },
      "contactPoint": {
        "@id": "tim.luckett@uts.edu.au"
      },
      "familyName": "Luckett",
      "givenName": "Tim",
      "identifier": "https://orcid.org/0000-0001-6121-5409",
      "name": "Tim Luckett"
    },


  {
      "@id": "tim.luckett@uts.edu.au",
      "@type": "ContactPoint",
      "contactType": "customer service",
      "email": "tim.luckett@uts.edu.au",
      "identifier": "tim.luckett@uts.edu.au",
      "url": "https://orcid.org/0000-0001-6121-5409"
    },
```


This is not ideal, as there is no direct semantic relationship between the contactPoint property and the Dataset, so the same [contactPoint](http://schema.org/contactPoint) should be added to theRoot Data Entity, in anticipation of this being added to Schema.org, even though this is not strictly supported at the moment.


```json
{
  "@id": "./",
  "identifier": "https://doi.org/10.4225/59/59672c09f4a4b",
  "@type": "Dataset",
  "contactPoint": {
        "@id": "tim.luckett@uts.edu.au"
      },
}
```


[See an example of an item of @type ContactPoint, which is linked to a Dataset and to an Organization via a contactPoint property.](https://data.research.uts.edu.au/examples/v1.0/luckett/CATALOG_files/pairtree_root/ht/tp/+=/=o/rc/id/,o/rg/=0/00/0-/00/01/-6/12/1-/54/09/index.html)


### Publications

To associate a publication with a dataset the _RO-Crate JSON-LD_ MUST include a URL (for example a DOI URL) as the `@id` of a publication using the [citation] property.

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


[See an example of a journal article.](https://data.research.uts.edu.au/examples/v1.0/GTM/CATALOG_files/pairtree_root/ht/tp/+=/=d/x,/do/i,/or/g=/10/,1/10/9=/TC/YB/,2/01/4,/23/86/28/2/index.html)


### Publisher

The _Root Data Entity_ SHOULD have a [publisher](http://schema.org/publisher) property. This SHOULD be an [Organization](http://schema.org/Organization) though it MAY be a [Person](http://schema.org/Person), a string-literal, or a URI.


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


[See an example of an Organization which is linked to the publisher property of a Dataset.](https://data.research.uts.edu.au/examples/v1.0/sample/CATALOG_files/pairtree_root/ht/tp/+=/=u/ts/,e/du/,a/u/index.html)


### Funding and grants

To associate a research project with a [Dataset](http://schema.org/Dataset), the _RO-Crate JSON-LD_ SHOULD contain an entity for the project using type "Organization", referenced by a [funder](http://schema.org/funder) property. The project organization SHOULD in turn reference any external [funder](http://schema.org/funder), either by using its URL as an `@id` or via a _Context Entity_ describing the funder.

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


[See an example of a Dataset which has three listed funders](https://data.research.uts.edu.au/examples/v1.0/sample/CATALOG.html) in a chained relationship, [for example this Organization is linked as a funder and in turn links to another funder.](https://data.research.uts.edu.au/examples/v1.0/sample/CATALOG_files/pairtree_root/ht/tp/s+/==/gi/th/ub/,c/om/=U/TS/-e/Re/se/ar/ch/=p/ro/je/ct/s=/da/ta/cr/at/e/index.html)


### Licensing, Access control and copyright

If a _Data Entity_ has a [license] that is different from the license on the _Root Data Entity_, the entity SHOULD have a [license](http://schema.org/license) property referencing a _Context Entity_ with a value of [CreativeWork](http://schema.org/CreativeWork) that describes the license. The ID of the license SHOULD be its URL (e.g. a Creative Commons License URL) and a summary of the license included using the [description] property. If this is not possible a URL MAY be used as the value.

This _Data Entity_ has a copyright holder which is different from its author. There is a reference to an [Organization](http://schema.org/Organization) describing the copyright holder and a [sameAs](http://schema.org/sameAs) relation to a web page.


```json
{
  "@id": "SciDataCon Presentations/AAA_Pilot_Project_Abstract.html",
  "@type": "File",
  "contentSize": "17085",
  "copyrightHolder": {
    "@id": "IDRC"
  },
  "author": {
    "@id": "https://orcid.org/0000-0002-0068-716X"
  },
  "description": "Abstract for the Pilot Project initial findings",
  "encodingFormat": "text/HTML",
  "license": {
    "@id": "https://creativecommons.org/licenses/by/4.0/"
  },
  "sameAs": "https://www.scidatacon.org/2016/sessions/56/paper/265/"
},

{
  "@id": "https://orcid.org/0000-0002-0068-716X",
  "@type": "Person",
  "identifier": "https://orcid.org/0000-0002-0068-716X",
  "name": "Cameron Neylon"
},

{
  "@id": "IDRC",
  "@type": "Organization",
  "description": "Canadian Frown Corporation and funder of development research",
  "identifier": "IDRC",
  "name": "International Development Research Center"
},
```


See the example of a an [audio recording with a `copyrightHolder` property](https://data.research.uts.edu.au/examples/v1.0/Data_Package-IDRC_Opportunities_and_Challenges_Open_Research_Strategies/CATALOG_files/pairtree_root/Po/li/cy/%5E2/0a/nd/%5E2/0I/mp/le/me/nt/at/io/n%5E/20/Re/vi/ew/%5E2/0I/nt/er/vi/ew/s=/In/te/rv/ie/w_/Au/di/o=/In/te/rv/ie/w-/25/_0/9_/20/15/-1/3_/43/-J/ua/n_/Bi/ca/rr/eg/ui/,f/la/c/index.html) (which is different from the `author` property) and which is linked to a `license`.


### Equipment

To specify which equipment was used to create or update a _Data Entity_, the _RO-Crate_ JSON-LD SHOULD have a _Context Entity_ for each item of equipment which SHOULD be of `@type` [IndividualProduct](http://schema.org/IndividualProduct). The entity SHOULD have a serial number, manufacturer that identifies it as completely as possible. In this case the equipment is a bespoke machine. The equipment SHOULD be described on a web page, and the address of the description SHOULD be used as its `@id`.


```json
{
  "@id": "https://confluence.csiro.au/display/ASL/Hovermap",
  "@type": "IndividualProduct",
  "description": "The CSIRO bentwing is an unmanned aerial vehicle (UAV, commonly known as a drone) with a LIDAR mounted underneath to capture 3D information on the surroundings.",
  "identifier": "https://confluence.csiro.au/display/ASL/Hovermap",
  "name": "bentwing"
}
```


Uses [CreateAction](http://schema.org/CreateAction) and [UpdateAction](http://schema.org/UpdateAction) class to model the contributions of _Context Entities_ of type [Person](http://schema.org/Person) or [Organization](http://schema.org/Organization) in the creation of files.

In this example the CreateAction has a human [agent](http://schema.org/agent), the object is a Place (a cave) and the Hovermap drone is the [instrument](http://schema.org/instrument) used in the file creation event.


```json
{
      "@id": "DataCapture_wcc02",
      "@type": "CreateAction",
      "agent": {
        "@id": "http://orcid.org/0000-0002-1672-552X"
      },
      "identifier": "DataCapture_wcc02",
      "instrument": {
        "@id": "https://confluence.csiro.au/display/ASL/Hovermap"
      },
      "object": {
        "@id": "victoria_arch"
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
      "@id": "victoria_arch",
      "@type": "Place",
      "address": "Wombeyan Caves, NSW 2580",
      "description": "This is the GDA94 datum, which is for most situations is close to WGS84",
      "geo": {
        "@id": "08563107-deb2-4d3b-a25f-83a09b5b61d4"
      },
      "identifier": "victoria_arch",
      "name": "Victoria Arch"
    },
```


[See an example of a data-capture CreateAction with an Object and two files as results.](https://data.research.uts.edu.au/examples/v1.0/Victoria_Arch_pub/CATALOG_files/pairtree_root/Da/ta/Ca/pt/ur/e_/wc/c0/2/index.html)


### Software 

To specify which software was used to create or update a file the software application SHOULD be represented with an entity of type [SoftwareApplication](http://schema.org/SoftwareApplication), with a [version] property. For example:

```json
{
      "@id": "https://www.imagemagick.org/",
      "@type": [
        "SoftwareApplication"
      ],
      "url": "https://www.imagemagick.org/",
      "identifier": "https://www.imagemagick.org/",
      "name": "ImageMagick",
      "version": " ImageMagick 7.0.8-2 Q16 x86_64 2018-06-19"
}
```


The software SHOULD be associated with the [File](http://schema.org/MediaObject) it created using a CreateAction with the [File](http://schema.org/MediaObject) referenced by a [result](http://schema.org/result) property. Any input files SHOULD be referenced by the [object](http://schema.org/object) property.

In the below example, an image with the `@id` of `pics/2017-06-11 12.56.14.jpg` was transformed into an new image `pics/sepia_fence.jpg` using the `ImageMagick` software application. Actions MAY have human-readable names, which MAY be machine generated for use at scale.

```json
{
      "@id": "Photo_Capture_1",
      "@type": "CreateAction",
      "agent": {
        "@id": "https://orcid.org/0000-0002-3545-944X"
      },
      "description": "Photo snapped on a photo walk on a misty day",
      "identifier": "Photo1",
      "endTime": "2017:06:11T12:56:14+10:00",
      "instrument": [
        {
          "@id": "EPL1"
        },
        {
          "@id": "Panny20mm"
        }
      ],
      "result": {
        "@id": "pics/2017-06-11 12.56.14.jpg"
      }
    },
    {
      "@id": "SepiaConversion_1",
      "@type": "CreateAction",
      "name": "Convert dog image to sepia",
      "description": "convert -sepia-tone 80% test_data/sample/pics/2017-06-11\\ 12.56.14.jpg test_data/sample/pics/sepia_fence.jpg",
      "identifier": "SepiaConversion",
      "endTime": "2018:09:19T17:01:07+10:00",
      "instrument": {
        "@id": "https://www.imagemagick.org/"
      },
      "object": {
        "@id": "pics/2017-06-11 12.56.14.jpg"
      },
      "result": {
        "@id": "pics/sepia_fence.jpg"
      }
    },
```


[See an example](https://data.research.uts.edu.au/examples/v1.0/sample/CATALOG_files/pairtree_root/Ph/ot/o1/index.html) of a [CreateAction](http://schema.org/CreateAction), with a result which is a [File](http://schema.org/MediaObject) and an [object](http://schema.org/object), which is a place.


### Workflows and scripts

Scientific workflows and scripts that can be or were used to analyze or generate files contained in an the RO-Crate MAY be embedded in an RO-Crate. Workflows and scripts are described using the type SoftwareSourceCode instead of `SoftwareApplication` above.  

The distinction is fluid, and comes down to availability and understandability. For instance, office spreadsheet applications are generally available and do not need further explanation; while a Python script that is customized for a particular data analysis might be important to understand further and should be included as source code in the RO-Crate dataset:

```json
       {
            "@id": "workflow/retropath.knime",  
            "@type": "SoftwareSourceCode",
            "additionalType": {"@id": "Workflow"},
            "name": "RetroPath Knime workflow",
            "description": "KNIME implementation of RetroPath2.0 workflow",
            "author": {"@id": "#thomas"},
            "programmingLanguage": {"@id": "#knime"},
            "license": "https://spdx.org/licenses/BSD-2-Clause.html",
            "potentialAction": {
                "@type": "ActivateAction",
                "instrument": {"@id": "#knime"}
            }
        }
```

Workflows and scripts are saved on disk using a language and generally need a runtime, in RO-Crate this SHOULD be indicated using a liberal interpretation of `programmingLanguage` and `potentialAction`. Note that the language and its runtime might differ, e.g. there are multiple potential runtimes of a JavaScript, although in the base-case they are the same, and as a shortcut can be described in one go as both a `ComputerLanguage` and `SoftwareApplication`:

```json
       {
            "@id": "#knime",
            "@type": [
                "ComputerLanguage",
                "SoftwareApplication"
            ],
            "name": "KNIME Analytics Platform",
            "alternateName": "KNIME",
            "url": {"@id": "https://www.knime.com/knime-software/knime-analytics-platform"},
            "version": "3.6"
        }
```

A data entity representing a runtime application or language MUST have a [name], [url] and [version], which should indicate a known version the workflow/script was developed or tested with. [alternateName] MAY be provided if there is a shorter colloquial name, for instance “R” instead of “The R Project for Statistical Computing”.

To indicate that a `SoftwareSourceCode` is in the form of a script (e.g. sequential batch/shell script), use:

```json
            "additionalType": {"@id": "WorkflowScript"}
```

If the `SoftwareSourceCode` is in the form of a workflow (e.g. a pipeline of steps with data flow), use:

```json
            "additionalType": {"@id": "Workflow"}
```

#### Workflow diagram/sketch

It can be beneficial to show a diagram or sketch to explain the script/workflow. This may have been generated from the workflow management system or drawn manually as a diagram. It should be included as an `ImageObject` which is `about` the `SoftwareSourceCode`:

```json
{
            "@id": "workflow/workflow.svg",
            "@type": "ImageObject",
            "additionalType": "WorkflowSketch",
            "encodingFormat":  "image/svg+xml",
            "description": "Diagram of RetroPath2.0 workflow",
            "about": {"@id": "workflow/workflow.knime"}
}
```


The image file format SHOULD be indicated with [encodingFormat] via Mime - eg  "image/svg+xml".

Additionally a PRONOM identifier MAY be used, via a reference to a _ContextualEntity_ {"@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/92"}

```json
{
            "@id": "workflow/workflow.svg",
            "@type": "ImageObject",
            "additionalType": "WorkflowSketch",
            "encodingFormat":  ["image/svg+xml", {"@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/92"}],
            "description": "Diagram of RetroPath2.0 workflow",
            "about": {"@id": "workflow/workflow.knime"}
}
 { 
   "@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/92", "@type": "URL",
   "name": "Portable Network Graphics", 
   "Description": "Portable Network Graphics (PNG) ... " 
  }
```

A _Sketch_ may still be provided even if there is no programmatic `SoftwareSourceCode` that can be executed (e.g. because the workflow was done by hand). In this case the sketch should have an `about` referring to the _RO-Crate dataset_ as a whole:

```json
"about": {"@id": "./"}
```

### Representing Provenance: changes to an object 

To record an action which changes the DataSet's metadata, or changes its state in a publication or other workflow, a [CreateAction](http://schema.org/CreateAction) or [UpdateAction](http://schema.org/UpdateAction) SHOULD be associated with a _Data Entity_.

A curation Action MUST have at least one [object](http://schema.org/object) which associates it with either the DataSet or one of its components.

An Action which creates new _Data entities_ - for example, the creation of a new metadata file - SHOULD have these as [result](http://schema.org/result)s.

An Action SHOULD have a [name](http://schema.org/name) and MAY have a [description](http://schema.org/description).

An Action SHOULD have an [endTime], which MUST be in ISO 8601 date format and SHOULD be specified to at least the precision of a day. An Action MAY have a [startTime] meeting the same specifications.

An Action SHOULD have a human [agent](http://schema.org/agent) who was responsible for authorizing the action, and MAY have an [instrument](http://schema.org/instrument) which associates the action with a particular piece of software (for example, the content management system or data catalogue through which an update was approved) which SHOULD be of `@type` SoftwareApplication.

An Action's status MAY be recorded in an [actionStatus] property. The status must be one of the values enumerated by [ActionStatusType]: ActiveActionStatus, CompletedActionStatus, FailedActionStatus or PotentialActionStatus.

An Action which has failed MAY record any error information in an [error](http://schema.org/error) property.

[UpdateAction](http://schema.org/UpdateAction) SHOULD only be used for actions which affect the DataSet as a whole, such as movement through a workflow.

To record curation actions which modify a [File](http://schema.org/MediaObject) within a DataSet - for example, by correcting or enhancing metadata - the old version of the [File](http://schema.org/MediaObject) SHOULD be retained, and a [CreateAction](http://schema.org/CreateAction) added which has the original version as its [object](http://schema.org/object) and the new version as its [result](http://schema.org/result).

```json
{
    "@id": "history-01",
    "@type": "CreateAction",
    "object": { "@id": "https://doi.org/10.5281/zenodo.1009240" },
    "name": "RO-Crate created",
    "endTime": "2018-08-31",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus": "CompletedActionStatus"
},

{
    "@id": "history-02",
    "@type": "UpdateAction",
    "object": { "@id": "https://doi.org/10.5281/zenodo.1009240" },
    "name": "RO-Crate published",
    "endTime": "2018-09-10",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus": "CompletedActionStatus"
},

{ 
    "@id": "history-03",
    "@type": "CreateAction",
    "object": { "@id": "./metadata.xml.v0.1" },
    "result": { "@id": "./metadata.xml" },
    "name": "metadata update",
    "endTime": "2018-09-12",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus": "CompletedActionStatus"
},

{
    "@id": "history-04",
    "@type": "UpdateAction",
    "object": { "@id": "https://doi.org/10.5281/zenodo.1009240" },
    "name": "RO-Crate published",
    "endTime": "2018-09-13",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus": "FailedActionStatus",
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



### Extra metadata such as Exif

Schema.org has a generic extension mechanism for encoding adding arbitrary properties and values which are not available as Schema.org properties. An example of of this is the Schema.org [recommended way (see example 2)](http://schema.org/ImageObject) of including [Exif](https://en.wikipedia.org/wiki/Exif) technical image metadata.

To include EXIF, or other data which can be encoded as property/value pairs, add an array of references to _Anonymous Entities_ which encode each property. This example shows one property of several hundred.

```json
{
      "@id": "pics/2017-06-11 12.56.14.jpg",
      "@type": "ImageObject",
      "contentSize": "5114778",
      "author": {
        "@id": "https://orcid.org/0000-0002-3545-944X"
      },
      "description": "Depicts a fence at a disused motor racing venue with the front part of a slightly out of focus black dog in the foreground.",
      "encodingFormat": "Exchangeable Image File Format (Compressed)",
      "exifData": [
        {
          "@id": "_:b0"
        },
        {
          "@id": "_:b312"
        },
      ]

{
      "@id": "_:b312",
      "@type": "PropertyValue",
      "name": "InternalSerialNumber",
      "value": "4102011002108002               "
    },
```


[See an example of Exif data displayed in HTML.](https://data.research.uts.edu.au/examples/v1.0/sample/CATALOG_files/pairtree_root/pi/cs/=2/01/7-/06/-1/1%5E/20/12/,5/6,/14/,j/pg/index.html)


### Places

To associate a _Data Entity_ with a _Context Entity_ representing a _geographical location or region_ the entity SHOULD have a property of [contentLocation](http://schema.org/contentLocation) with a value of type [Place](http://schema.org/Place).

This example shows how to define a place, using a [geonames](https://www.geonames.org) ID:


```json
{
  "@id": "https://www.geonames.org/8152662/catalina-park.html",
  "@type": "Place",
  "description": "Catalina Park is a disused motor racing venue, located at Katoomba ...",
  "geo": {
    "@id": "b4168a98-8534-4c6d-a568-64a55157b656"
  },
  "identifier": "https://www.geonames.org/8152662/catalina-park.html",
  "name": "Catalina Park"
},
```


The place has a [geo](http://schema.org/geo) property, referencing an _Context Entity_ of `@type` [GeoCoordinates](http://schema.org/GeoCoordinates):


```json
{
  "@id": "b4168a98-8534-4c6d-a568-64a55157b656",
  "@type": "GeoCoordinates",
  "latitude": "-33.7152",
  "longitude": "150.30119",
  "name": "Latitude: -33.7152 Longitude: 150.30119"
},
```


The [GeoCoordinates](http://schema.org/GeoCoordinates) item SHOULD have a human readable [name](http://schema.org/name), which is used in  generating the `ro-crate-preview.html` file.

And the place is referenced from the [contentLocation](http://schema.org/contentLocation) property of the dataset.


```json
{
  "@id": "https://doi.org/10.5281/zenodo.1009240",
  "@type": "Dataset",
  "outputOf": "RO-Crate",
  "contact": {
    "@id": "https://orcid.org/0000-0002-3545-944X"
  },
  "contentLocation": {
    "@id": "https://www.geonames.org/8152662/catalina-park.html"
  },
```


[Place](http://schema.org/Place) MAY use any of the [resources available in Schema.org](http://schema.org/geo) to describe places. Future profiles of RO-Crate may mandate the use of a subset of these. Any directory or file or _Context Entity_ may be geo-located. For example this file:


```json
{
  "@id": "pics/19093074_10155469333581584_5707039334816454031_o.jpg",
  "@type": "File",
  "contentLocation": {
    "@id": "https://www.geonames.org/8152662/catalina-park.html"
  },
  "contentSize": "132765",
  "author": {
    "@id": "https://orcid.org/0000-0002-3545-944X"
  },
```


[See an example of a place in HTML.](https://data.research.uts.edu.au/examples/v1.0/sample/CATALOG_files/pairtree_root/ht/tp/+=/=w/ww/,g/eo/na/me/s,/or/g=/81/52/66/2=/ca/ta/li/na/-p/ar/k,/ht/ml/index.html)


### Time

To describe the time period which a RO-Crate Data Entity is _about_, use [temporalCoverage].


### Subjects & keywords

Subject properties (equivalent to a Dublin Core Subject) on RO-Crate MUST use the [about](http://schema.org/about) property.

Keyword properties MUST use [keyword](http://schema.org/keywords). Note that by schema.org convention keywords are given as a single JSON string, with individual keywords separated by commas. 

```json
{
  "keyword": "Gibraltar, Spain, British Overseas Territory, city, map",
  "about": { "@id": "http://dbpedia.org/resource/Gibraltar" },
}
```

### Digital Library and Repository content

To describe an export from a Digital Library or repository system, RO-Crate uses the _Portland Common Data Model_ ([PCDM](https://github.com/duraspace/pcdm/wiki)). A _Context Entity_ from a repository, representing an abstract entity such as a person, or a work, or a place SHOULD have a`@type` of [RepositoryObject](https://pcdm.org/2016/04/18/models#Object), in addition to any other types. Objects MAY be grouped together in [RepositoryCollection](https://pcdm.org/2016/04/18/models#Collection)s with [hasMember] pointing to the the [RepositoryObject](https://pcdm.org/2016/04/18/models#Object). The keys RepositoryObject and RepositoryCollection were chosen to avoid collision between the terms Collection and Object with other vocabularies.

NOTE: [PCDM](https://github.com/duraspace/pcdm/wiki) specifies that Files should have only technical metadata, not descriptive metadata, which is _not_ a restriction in RO-Crate. If the RO-Crate is to be imported into a strict [PCDM](https://github.com/duraspace/pcdm/wiki) repository, modeling of object/file relationships will be necessary.

For example, this data is exported from an [Omeka](https://omeka.org) repository:


```json
{
   "@id": "https://omeka.uws.edu.au/farmstofreeways/api/collections/6",
   "@type": [
      "RepositoryCollection"
   ],
   "title": [
      "Project Materials"
   ],
   "description": [
      "Materials associated with the project, including fliers seeking participants, lists of sources and question outline.   "
   ],
   "publisher": [
      "University of Western Sydney"
   ],
   "rights": [
      "Copyright University of Western Sydney 2015"
   ],
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
   "@type": [
      "RepositoryObject",
      "Text"
   ],
   "title": [
      "Western Sydney Women's Oral History Project: Flier (illustrated)"
   ],
   "description": [
      "Flier (illustrated) seeking participants for the project."
   ],
   "publisher": [
      "University of Western Sydney"
   ],
   "rights": [
      "Copyright University of Western Sydney 2015"
   ],
   "originalFormat": [
      "Paper"
   ],
   "identifier": [
      "FTF_flier_illust"
   ],
   "rightsHolder": [
      "Western Sydney University"
   ],
   "license": [
      "Content in the Western Sydney Women's Oral History Project: From farms to freeways collection is licensed under a Creative Commons CC BY 3.0 AU licence (https://creativecommons.org/licenses/by/3.0/au/)."
   ],
   "hasFile": [
      {
         "@id": "./content/166/original_eece70f73bf8979c0bcfb97065948531.pdf"
      },
     ...
   ]
},
{
   "@type": "File",
   "@id": "./content/166/original_eece70f73bf8979c0bcfb97065948531.pdf"
},
```


[See an example of a repository exported to a RO-Crate.](https://data.research.uts.edu.au/examples/v1.0/farms_to_freeways/)


### Thumbnails

A [File](http://schema.org/MediaObject) or any other item MAY have a [thumbnail](http://schema.org/thumbnail) property which references another file.

For example, the below [RepositoryObject](https://pcdm.org/2016/04/18/models#Object) is related to four files which are all versions of the same image (via [hasFile](https://pcdm.org/2016/04/18/models#hasFile)) one of which is a thumbnail. The thumbnail MUST be included in the RO-Crate.

If [thumbnail](http://schema.org/thumbnail)s are incidental to the data set, they need not be referenced by [hasPart](http://schema.org/hasPart) or [hasFile](https://pcdm.org/2016/04/18/models#hasFile) relationships. but must be in the BagIt manifest if in a _Bagged RO-Crate_.


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
    {
      "@id": "https://westernsydney.edu.au",
    }
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

[See an example of a thumbnail.](https://data.research.uts.edu.au/examples/v1.0/sample/CATALOG_files/pairtree_root/pi/cs/=2/01/7-/06/-1/1%5E/20/12/,5/6,/14/,j/pg/index.html)


## Extending RO-Crate

To extend RO-Crate implementers SHOULD try to use valid schema.org properties and classes and MAY use terms from other vocabularies and ontologies when this is not possible.

The terms (properties and classes) used SHOULD be added as keys to the `@context` in the _RO-Crate JSON-LD_. URIs in the `@context` SHOULD resolve to a useful human readable page. Where this is not possible - for example if the URI resolves to an RDF ontology file a human-readable URI SHOULD be provided using SameAs.

For example. This URI from the [BIBO](http://purl.org/ontology/bibo/interviewee) ontology resolves to an ontology file, which is not useful for humans, but [this page](http://neologism.ecs.soton.ac.uk/bibo.html#interviewee) is human-readable:


```json
{
  "@context": [ "https://w3id.org/ro/crate/0.2/context"
    {"interviewee": "http://purl.org/ontology/bibo/interviewee"},
  ],
  "@graph": [

  {
      "@id": "http://purl.org/ontology/bibo/interviewee",
      "sameAs": "http://neologism.ecs.soton.ac.uk/bibo.html#interviewee",
      "@type": "URL"
  }
 ]
}
```


When generating the _RO-Crate Website_ from _RO-Crate JSON-LD_, the code MUST use a `sameAs` URI (if present) as a target for an explanatory link for the term instead of the Linked Data URI supplied in the `@context`.

[See an example of the key "interviewee" resolving to a human-readable page.](https://data.research.uts.edu.au/examples/v1.0/Data_Package-IDRC_Opportunities_and_Challenges_Open_Research_Strategies/CATALOG_files/pairtree_root/Po/li/cy/%5E2/0a/nd/%5E2/0I/mp/le/me/nt/at/io/n%5E/20/Re/vi/ew/%5E2/0I/nt/er/vi/ew/s=/In/te/rv/ie/w_/Au/di/o=/In/te/rv/ie/w-/25/_0/9_/20/15/-1/4_/02/-S/im/on/_H/od/so/n,/fl/ac/index.html) and download the [RO-Crate JSON-LD](https://data.research.uts.edu.au/examples/v1.0/Data_Package-IDRC_Opportunities_and_Challenges_Open_Research_Strategies/CATALOG.json)

Where there is no RDF ontology available, then implementors SHOULD attempt to provide context by creating stable web-accessible URIs to document properties and classes, for example, by linking to page describing an XML element or attribute from an XML schema, pending the publication of a formal ontology.




[JSON-LD]:(https://json-ld.org/spec/latest/json-ld/)
[JSON-LD 1.1]:(https://json-ld.org/spec/latest/json-ld/)
[BagIt]: https://en.wikipedia.org/wiki/BagIt
[samples]: ./samples
[DataCite Schema v4.0]: https://schema.datacite.org/meta/kernel-4.0/metadata.xsd
[BagIt profile]: https://github.com/ruebot/bagit-profiles
[CURIE]: https://www.w3.org/TR/curie/
[keyword]: http://schema.org/keywords
[about]: http://schema.org/about
[name]: http://schema.org/name
[author]: http://schema.org/author
[Person]: http://schema.org/Person
[schema:Collection]: http://schema.org/Collection
[identifier]: http://schema.org/identifier
[funder]: http://schema.org/funder
[relatedItem]: http://schema.org/relatedItem
[Organization]: http://schema.org/Organization
[Dataset]: http://schema.org/Dataset
[File]: http://schema.org/MediaObject
[schema:contentUrl]: http://schema.org/contentUrl
[schema:MediaObject]: http://schema.org/MediaObject
[ScholarlyArticle]: http://schema.org/ScholarlyArticle
[CreativeWork]: http://schema.org/CreativeWork
[SoftwareApplication]: http://schema.org/SoftwareApplication
[hasPart]: http://schema.org/hasPart
[memberOf]: http://schema.org/memberOf
[funder]: http://schema.org/funder
[encodingFormat]: http://schema.org/encodingFormat
[accountablePerson]: http://schema.org/accountablePerson
[datePublished]: http://schema.org/datePublished
[license]: http://schema.org/license
[contact]: http://schema.org/accountablePerson
[citation]: http://schema.org/citation
[alternateName]: http://schema.org/alternateName
[temporalCoverage]: http://schema.org/temporalCoverage
[contributor]: http://schema.org/contributor
[contentLocation]: http://schema.org/contentLocation
[copyrightHolder]: http://schema.org/copyrightHolder
[Place]: http://schema.org/Place
[description]: http://schema.org/description
[geo]: http://schema.org/geo
[agent]: http://schema.org/agent
[instrument]: http://schema.org/instrument
[sameAs]: http://schema.org/sameAs
[GeoCoordinates]: http://schema.org/GeoCoordinates
[email]: http://schema.org/email
[phone]: http://schema.org/phone
[affiliation]: http://schema.org/affiliation
[givenName]: http://schema.org/givenName
[familyName]: http://schema.org/familyName
[publisher]: http://schema.org/publisher
[translator]: http://schema.org/translator
[thumbnail]: http://schema.org/thumbnail
[translationOf]: http://schema.org/translationOf
[Product]: http://schema.org/Product
[contactPoint]: http://schema.org/contactPoint
[contactType]: http://schema.org/contactType
[CreateAction]: http://schema.org/CreateAction
[result]: http://schema.org/result
[event]: http://schema.org/event
[object]: http://schema.org/object
[error]: http://schema.org/error
[UpdateAction]: http://schema.org/UpdateAction
[Action]: http://schema.org/Action
[IndividualProduct]: http://schema.org/IndividualProduct
[distribution]: http://schema.org/distribution
[DataDownload]: http://schema.org/DataDownload
[Exif]: https://en.wikipedia.org/wiki/Exif
[WorkflowSketch]: http://wf4ever.github.io/ro/2016-01-28/roterms/#Sketch
[Journal]: http://schema.org/Periodical
[url]: http://schema.org/url
[version]: http://schema.org/version
[endTime]: http://schema.org/endTime
[startTime]: http://schema.org/startTime
[actionStatus]: http://schema.org/actionStatus
[ActionStatusType]: http://schema.org/ActionStatusType

[DataCrate BagIt Profile]: https://raw.githubusercontent.com/UTS-eResearch/datacrate/master/spec/1.0/profile-datacrate-v1.0.json
[DataCrate JSON-LD Context]: ./context.json
[JSON-LD Framing 1.1]: https://json-ld.org/spec/latest/json-ld-framing/
[DataCrate JSON-LD frame]: ./frame.json
[geonames]: https://www.geonames.org
[RDFa]: https://en.wikipedia.org/wiki/RDFa
[schema.org]: http://schema.org
[DCAT]: https://www.w3.org/TR/vocab-dcat/
[DataCite]: https://www.datacite.org/
[SPAR]: https://www.sparontologies.net/
[FRAPO]: https://www.sparontologies.net/ontologies/frapo
[PCDM]: https://github.com/duraspace/pcdm/wiki
[hasFile]: https://pcdm.org/2016/04/18/models#hasFile
[hasMember]: https://pcdm.org/2016/04/18/models#hasMember
[RepositoryCollection]: https://pcdm.org/2016/04/18/models#Collection
[RepositoryObject]: https://pcdm.org/2016/04/18/models#Object

[isOutputOf]: https://sparontologies.github.io/frapo/current/frapo.html#d4e526
[ResearchObject]: https://www.researchobject.org/
[Flattened Document Form]: https://json-ld.org/spec/latest/json-ld/#flattened-document-form
[Pairtree]: https://confluence.ucop.edu/display/Curation/PairTree
[Pairtree specification]: https://confluence.ucop.edu/display/Curation/PairTree?preview=/14254128/16973838/PairtreeSpec.pdf
[linked data]: https://en.wikipedia.org/wiki/Linked_data
[ORCID]: https://orcid.org
[JSON Object]: https://w3c.github.io/json-ld-syntax/#terminology
[BIBO]: http://purl.org/ontology/bibo/interviewee
[OCFL]: https://ocfl.io/
[OCFL Object]: https://ocfl.io/0.3/spec/#object-spec
[Pronom]: https://www.nationalarchives.gov.uk/PRONOM/Default.aspx
