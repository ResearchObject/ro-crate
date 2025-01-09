---
title: RO-Crate Structure
redirect_from:
  - /1.2-DRAFT/structure
nav_order: 3
parent: RO-Crate 1.2-DRAFT
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2023 The University of Manchester UK 
   Copyright 2019-2023 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# RO-Crate Structure {#structure}
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

## Note on Version 1.2 of the RO-Crate Specification

This version of the RO-Crate comes after a significant amount of implementation experience has been gathered from users of previous versions, dealing with use cases which were not anticipate or well catered for in the original specification. The result is that the specification has had multiple patches applied and is starting to become unwieldy. Work has commenced as of the beginning of 2025 on a backwards-compatible new modularized version of the RO-Crate Specification and related documents where we anticipate the hard syntactic requirements (the things an RO-Crate parser needs) will be separated from metadata profiles (the things RO-Crate Validators need) and other guidance about implementation (which implementers need) will be separated from each other, instead of interleaved as in the current document.

Version 1.2 is anticipating some of these coming changes, by introducing a clearer specification of RO-Crate compliance at a series of levels than in previous versions, where compliance was open to interpretation.

## Types of RO-Crate

RO-Crate specifies two broad levels of conformance for a text-string, known as the _RO-Crate Metadata Document_. Level one is structural and syntactic compliance - can it be parsed and does it have the right type of linked data? Level 2 is  conformance with the core metadata standard that makes an RO-Crate a useful, distributable dataset, which may be completely abstract, such as a a collection of Class and Property definitions. Within level 2, a distinction is made between data collections where the data is available via a file system (which was the default assumption when the RO-Crate specification was first conceived) and data collections which are aggregations of web resources and there is a mechanism specified for RO-Crates to indicate conformances with these types of packaging, and advice about how software should handle earlier versions of RO-Crate where packaging was an implicit assumption.

1. _Valid RO-Crate Metadata Object_: The _RO-Crate Metadata Document_ string can be parsed into an object which has structural conformance with this specification. (It is JSON, it is valid JSON-LD with a `@graph` and `@context` key which meet certain constraints).
  
   _Valid RO-Crate Metadata Objects_ are the basis of RO-Crate packaging, but can be used for non-packaging purposes as well.

   An RO-Crate Metadata Document (whether or not is is a valid package) may have rich contextual information about the data, how it was collected  and by whom, with details of funding, related information, equipment and facilities, or about abstract entities.  
  
   The details of this contextual information are the domain of _RO-Crate Profiles_ which are concerned with semantics. Profiles are guides with optional validation services that describe how to use RO Crate Metadata for a particular purpose, such as; interchanging workflow software, describing vocabularies/schemas, or structuring archival repositories.

2. _Valid RO-Crate Dataset_: The _Valid RO-Crate Metadata Object_ has sufficient metadata to be considered a _Research Object_ which can be distributed

    - The _Root Entity_:
      
       - Meets all the metadata requirements set out in [Root Data Entity](./root-data-entity.html) incuding:
          - Has [Dataset] as one of its `@type` values
          - Has a "conformsTo" property with a value of  `{"@id": "https://w3id.org/ro/crate/1.2-DRAFT#ro-crate-dataset"}`
       
       NOTE: When processing RO-Crates of versions <= 1.1 conformance with the requirements in [Root Data Entity](./root-data-entity.html) is assumed. In RO-Crate version >= 1.2 conformance with these requirements needs to be explicitly stated, which allows for RO-Crate conventions to be used in non-packaging contexts.
     - There are two types of _RO-Crate Package_:
       -  An _Attached  RO-Crate Package_ has the following constraints:
          - It is defined within a file-system-like service as a directory (known as the _RO-Crate Root_) with the RO-Crate Metadata Document saved in a file-like entity with a file name of `ro-crate-metadata.json`.
          - References to files and directories in the RO-Crate Metadata Document are present in the RO-Crate.
          - The _Root Entity_ MUST have a conformsTo property which has a value of {"@id": "https://w3id.org/ro/crate/1.2-DRAFT#LocalPackage"} 
       -  A _Detached RO-Crate Package_:
            - Is defined by a stand alone RO-Crate metadata document which may be stored in a file or distributed via an API.
            - If stored in a file, the filename SHOULD be `${slug}-ro-crate-metadata.json` where the variable `$slug` is a human readable version of the dataset's ID or name.
            - The _Root Entity_ MUST have a conformsTo property which has a value of {"@id": "https://w3id.org/ro/crate/1.2-DRAFT#DetatchedPackage"}, 
      
    NOTE that for backwards compatibility with RO-Crate 1.1 -- client software may provide modes which force a particular packaging mode to be assumed - for example if the software is passed a directory then it would assume that is processing an _Attached  RO-Crate Package_, while being passed a path to a file, or a string or pre-parsed JSON object the package would be considered a _Detached RO-Crate Package_.



{.note}
> The algorithm for downloading a _Detached RO-Crate Pacakge_ to an _Attached  RO-Crate Package_ is described in the section on [Data Entities](data-entities.html#data-entities)



In all three types of crates the metadata is completed with [contextual entities](contextual-entities) that further describe the relationships and context of the data to form a _Research Object_. 

## RO-Crate Metadata Document (`ro-crate-metadata.json`)

[JSON-LD](https://json-ld.org/) is a structured form of [JSON] that can represent a _Linked Data_ graph. 


* The _RO-Crate Metadata Document_ MUST contain _RO-Crate JSON-LD_; a valid [JSON-LD 1.0] document in [flattened]  and [compacted] form
* The _RO-Crate JSON-LD_ MUST use the _RO-Crate JSON-LD Context_ <https://w3id.org/ro/crate/1.2-DRAFT/context> by reference.


The graph in a _Valid RO-Crate Object_ MUST describe:

1. The [RO-Crate Metadata Descriptor](root-data-entity#ro-crate-metadata-descriptor)
2. The [Root Data Entity](root-data-entity#direct-properties-of-the-root-data-entity)
3. Zero or more [Data Entities](data-entities)
4. Zero or more [Contextual Entities](contextual-entities)

Any referenced _contextual entities_ SHOULD also described in the _RO-Crate Metadata Document_ with the same identifier. Similarly any _contextual entity_ in the _RO-Crate Metadata Document_ SHOULD be linked to from at least one of the other entities using the same identifier. 

The appendix [RO-Crate JSON-LD](appendix/jsonld) details the general structure of the JSON-LD that is expected in the _RO-Crate Metadata Document_. In short, the rest of this specification describe the different types of entities that can be added as `{}` objects to the _RO-Crate JSON-LD_ `@graph` array below:

```json
{ "@context": "https://w3id.org/ro/crate/1.2-DRAFT/context",
  "@graph": [

  ]
}
```


## Attached  RO-Crate Package

An **Attached  RO-Crate Package** is used to contain and describe a _payload_ of files and directories, among with their contextual information.

* In an _Attached  RO-Crate Package_ the _RO-Crate Metadata Document_ MUST be present, named `ro-crate-metadata.json` and appear in the _RO-Crate Root_
  - If an RO-Crate conforming to version 1.0 or earlier contains a file named `ro-crate-metadata.jsonld` but not `ro-crate-metadata.json`, then processing software should treat this as the _RO-Crate Metadata File_. If the crate is updated, the file SHOULD be renamed to `ro-crate-metadata.json` and the _RO-Crate Metadata Descriptor_ SHOULD be updated to reference it, with an up to date [conformsTo] property naming an appropriate version of this specification. 

An _Attached  RO-Crate Package_ can be stored and published in multiple ways depending on its use:
* On a typical hierarchical _file system_ (e.g. `/files/shared/crates/my-crate-01/`)
* Exposed as a _Web resource_ within a folder structure (e.g. <https://www.researchobject.org/2021-packaging-research-artefacts-with-ro-crate/>)
* [_Packaged_](appendix/implementation-notes#combining-with-other-packaging-schemes) within a ZIP file, BagIt archive or OCFL structure
* _Archived_ as a set of named files in other ways (e.g. Zenodo deposit)

A valuable feature of the _Attached  RO-Crate Package_ approach is that the metadata is preserved when a crate is transferred between these types of storage/publication systems.

The file path structure an _Attached  RO-Crate Package_ MUST follow is:

```
<RO-Crate root directory>/
|   ro-crate-metadata.json    # RO-Crate Metadata File containing the RO-Crate Metadata Document MUST be present 
|   ro-crate-preview.html     # RO-Crate Website homepage MAY be present
|   ro-crate-preview_files/   # MAY be present
|    | [other RO-Crate Website files]
|   [payload files and directories]  # 0 or more
```
The name of the _RO-Crate root_ directory is not defined, but a root directory is identifiable by the presence of the _RO-Crate Metadata File_, `ro-crate-metadata.json`. For instance, if an _RO-Crate_ is archived in a ZIP-file, the ZIP root directory is an _RO-Crate root_ directory if it contains `ro-crate-metadata.json`.

The payload directory (and its child directory) contains files and directories that SHOULD be described within the _RO-Crate Metadata File_ as [Data Entities](data-entities). Additional [Web-based Data Entities](data-entities.html#web-based-data-entities) MAY also be described, but are not considered part of the payload.

The `@id` of a an _Attached  RO-Crate Package_ MUST be either `./` or be a URI, such as a DOI URL or other persistent URL which is considered to be the main identifier of the Attached  RO-Crate Package.

{: .note }
> Earlier versions of RO-Crate mandated an `@id` of `./` as a convention for identifying the _Root Data Entity_, but the use of the _RO-Crate Metadata Descriptor_ means that this is no longer required, freeing-up the _Root Data Entity_ `@id` to be used to indicate what should be considered the canonical URI for an RO_Crate Package. Other mechanisms for specifying the 'main identifier' involve multiple JSON-LD entities and may be ambiguous.

## Detached RO-Crate Package

A _Detached RO-Crate Package_ is an RO-Crate without a defined root directory, where the _RO-Crate Metadata Document_ and/or _RO-Crate Website_ content is accessed independently (e.g. as part of a programmatic API).

* In a _Detached RO-Crate Package_ the _RO-Crate Metadata Document_ is a JSON-LD document served over an API or loaded via other means.


Unlike an  _Attached  RO-Crate Package_ a _Detached RO-Crate Package_ is not processed in a file-system context and thus does not carry a data _payload_ in the same sense, but may reference data deposited separately, or purely reference [contextual entities](contextual-entities). 

In a _Detached RO-Crate Package_ the [root data entity](root-data-entity) SHOULD have an `@id` which is a URL that resolves to the _RO-Crate Metadata Document_.

Any [data entities](data-entities) in a _Detached RO-Crate Package Package_ MUST be [Web-based Data Entities](data-entities.html#web-based-data-entities). 


Note that a Detached RO-Crate Package may still use `#`-based local identifiers for [contextual entities](contextual-entities).





## RO-Crate Website (`ro-crate-preview.html` and `ro-crate-preview_files/`) for Packages

In addition to the machine-oriented _RO-Crate Metadata Document_ _Attached  RO-Crate Packages_ and _Detached RO-Crate Packages_ MAY include a human-readable HTML rendering of the same information, known as the _RO-Crate Website_. If present, the _RO-Crate Website_ MUST be a file named `ro-crate-preview.html` in the root directory, which MAY serve as the entry point to other web-resources, which MUST be in `ro-crate-preview_files/` in the root directory.

If present in the root directory of an _Attached  RO-Crate Package_ as `ro-crate-preview.html`, (or otherwise served in a _Detached RO-Crate Package_), the RO-Crate Website MUST:

* Be a valid [HTML 5] document
* Be useful to users of the RO-Crate - this will vary by community and intended use, but in general the aim to assist users in reusing data by explaining what it is, how it was created how it can be used and how to cite it. One simple approach to this is to expose *all* the metadata in the _RO-Crate Metadata Document_.

`ro-crate-preview.html` SHOULD:

* Display at least the metadata relating to the _Root Data Entity_ as static HTML without the need for scripting. It MAY contain extra features enabled by JavaScript.
* When a _Data Entity_ or _Contextual Entity_ is referenced by its ID:
  - If it has a [name] property, provide a link to its HTML version.
  - If it does not have a name (e.g. a [GeoCoordinates] location), show it embedded in the HTML for the entity.
  - For external URI values, provide a link.
* For keys that resolve in the `RO-Crate JSON-LD Context` to a URI, indicate this (the simplest way is to link the key to its definition).
* If there are additional resources necessary to render the preview (e.g. CSS, JSON, HTML), link to them in a subdirectory `ro-crate-preview_files/`

{.note}
> Previous versions of the Specification recommended that the _RO-Crate Website_ should contain a redundant copy of the RO-Crate Metadata Document but there is no evidence that this has been useful and is no longer recommended.


The _RO-Crate Website_ is not considered a part of the RO-Crate payload in an _Attached RO-Crate Package_, but serves as a way to make metadata available in a user-appropriate format. The `ro-crate-preview.html` file and the `ro-crate-preview-files/` directory and any contents SHOULD NOT be included in the `hasPart` property of the _Root Dataset_ or any other `Dataset` entity within an RO-Crate.

Metadata about parts of the _RO-Crate Website_ MAY be included in an RO-Crate as in the following example. Metadata such as an `author` property, `dateCreated` or other provenance can be included, including details about the software that created them, as described in [Software used to create files](./provenance.html#software-used-to-create-files)).

```
{
      "@id": "ro-crate-preview.html",
      "@type": "CreativeWork",
      "about": {"@id": "./"}
}

{
      "@id": "https://www.npmjs.com/package/ro-crate-html-js",
      "@type": "SoftwareApplication",
      "url": "https://www.npmjs.com/package/ro-crate-html-js",
      "name": "ro-crate-html-js",
      "version": "1.4.19"
}

{
      "@id": "#ro-crate-preview-generation",
      "@type": "CreateAction",
      "name": "Create HTML summary",
      "endTime": "2022-10-019T17:01:07+10:00",
      "instrument": {
        "@id": "https://www.npmjs.com/package/ro-crate-html-js"
      },
      "object": {
        "@id": "ro-crate-metadata.json"
      },
      "result": {
        "@id": "ro-crate-preview.html"
      }
}
```




## Payload files and directories (_Attached  RO-Crate Packages_)

These are the actual files and directories that make up the **payload** of the dataset being described in an _Attached  RO-Crate Package_.

The base RO-Crate specification makes no assumptions about the presence of any specific files or folders beyond the reserved RO-Crate files described above. 

Payload files may appear directly in the _RO-Crate Root_ alongside the _RO-Crate Metadata File_, and/or appear in sub-directories of the _RO-Crate Root_. Each file and directory MAY be represented as [Data Entities](data-entities) in the _RO-Crate Metadata File_.

An RO-Crate may also contain [Web-based Data Entities](data-entities.html#web-based-data-entities) that are not present as part of the payload and referenced using absolute URIs. These may require additional preservation measures.

{% include callout.html type="tip" content="An RO-Crate [packaged with BagIt](appendix/implementation-notes#adding-ro-crate-to-bagit) may be [referencing external files](appendix/implementation-notes#referencing-external-files) which are not present in the _RO-Crate Root_ hierarchy until the BagIt has been _completed_. This method can be used for files that are large, require authentication or otherwise inconvenient to transfer with the RO-Crate, but which should nevertheless still be considered part of the _payload_." %}


## Self-describing and self-contained Attached  RO-Crate Packages

_RO-Crates Packages_ SHOULD be self-describing and self-contained.

A minimal _Attached  RO-Crate Package_ is a directory containing a single _RO-Crate Metadata Document_ stored as an [RO-Crate Metadata File](root-data-entity) `ro-crate-metadata.json`. 

At the basic level, an Attached  RO-Crate Package is a collection of files and resources represented as a Schema.org [Dataset], that together form a meaningful unit for the purposes of communication, citation, distribution, preservation, etc.  The _RO-Crate Metadata Document_ describes the RO-Crate, and MUST be stored in the _RO-Crate Root_. 

While RO-Crate is well catered for describing a _Dataset_ as files and relevant metadata that are _contained_ by the RO-Crate in the sense of living within the same root directory, RO-Crates can also reference external resources which are stored or accessed separately, via absolute URIs. This is particularly recommended where some resources cannot be co-hosted for practical or legal reasons, or if the RO-Crate itself is primarily web-based.

It is important to note that the _RO-Crate Metadata Document_ is **not necessarily an exhaustive manifest** or inventory, that is, it is not required to list or describe all files in the package.  Rather it is focused on providing sufficient amount of metadata to understand and use the content, and is designed to be compatible with existing and future approaches that _do_ have full inventories / manifest and integrity checks, e.g. by using checksums, such as [BagIt] and Oxford Common File Layout [OCFL Objects][OCFL Object].

The intention is that RO-Crates can work well with a variety of archive file formats, e.g. tar, zip, etc., and approaches to capturing file manifests and file fixity, such as [BagIt], [OCFL] and [git] (see also appendix [Combining with other packaging schemes](appendix/implementation-notes#combining-with-other-packaging-schemes)). An RO-Crate can also be hosted on the web or mainly refer to web resources, although extra care to ensure persistence and consistency should be taken for archiving such RO-Crates.

{% include references.liquid %}
