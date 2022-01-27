---
title: RO-Crate Structure
nav_order: 3
parent: RO-Crate 1.2-DRAFT
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

<div id="structure"></div>

# RO-Crate Structure
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

## Types of RO-Crate

There are two classes of RO-Crate detailed below:

**Regular RO-Crate**
: A crate that has a well-defined _RO-Crate Root directory_ and can carry an **explicit payload** of local [data entities](data-entities.md) as regular files (combined with [Web-based Data Entities](data-entities.html#web-based-data-entities) where needed). This type of RO-Crate can be suitable for long-term preservation, transfer and publishing, as the _RO-Crate Metadata File_ is stored alongside the crate's payload. 

**Detached RO-Crate**
: A crate without a defined payload directory. In this kind of crate, all data references are absolute. This approach may be suitable for use with dynamic web service APIs and repositories that can't preserve file paths. As the data of these crates can only be [Web-based Data Entities](data-entities.html#web-based-data-entities), the **payload is implicit** and must be preserved/transferred/archived independent of the _RO-Crate Metadata File_. 

In both types of crates the metadata is completed with [contextual entities](contextual-entities.md) that further describe the relationships and context of the data to form a _Research Object_. 

## Regular RO-Crate

A **Regular RO-Crate** is used to contain and describe a _payload_ of files and directories, among with their contextual information.

A _Regular RO-Crate_ can be stored and published in multiple ways depending on its use:
* On a typical hierarchical _file system_ (e.g. `/files/shared/crates/my-crate-01/`)
* Exposed as a _Web resource_ within a folder structure (e.g. <https://www.researchobject.org/2021-packaging-research-artefacts-with-ro-crate/>)
* [_Packaged_](appendix/implementation-notes.md#combining-with-other-packaging-schemes) within a ZIP file, BagIt archive or OCFL structure
* _Archived_ as a set of named files in other ways (e.g. Zenodo deposit)

A valuable feature of the _Regular RO-Crate_ approach is that the metadata is preserved when a crate is transferred between these types of storage/publication systems.

The file path structure a _Regular RO-Crate_ MUST follow is:

```
<RO-Crate root directory>/
|   ro-crate-metadata.json    # RO-Crate Metadata File MUST be present 
|   ro-crate-preview.html     # RO-Crate Website homepage MAY be present
|   ro-crate-preview_files/   # MAY be present
|    | [other RO-Crate Website files]
|   [payload files and directories]  # 0 or more
```
The name of the _RO-Crate root_ directory is not defined, but a root directory is identifiable by the presence of the _RO-Crate Metadata File_, `ro-crate-metadata.json`. For instance, if an _RO-Crate_ is archived in a ZIP-file, the ZIP root directory is an _RO-Crate root_ directory if it contains `ro-crate-metadata.json`.

The payload directory (and its child directory) contains files and directories that SHOULD be described within the _RO-Crate Metadata File_ as [Data Entities](data-entities.md). Additional [Web-based Data Entities](data-entities.html#web-based-data-entities) MAY also be described, but are not considered part of the payload.


## Detached RO-Crate

A _Detached RO-Crate_ is an RO-Crate without a defined root directory, where the _RO-Crate Metadata File_ and/or _RO-Crate Website_ content is accessed independently (e.g. as part of a programmatic API).

These crates cannot carry their own data _payload_, but may reference data deposited separately, or purely reference [contextual entities](contextual-entities.md). 

Any [data entities](data-entities.md) in a _Detached RO-Crate_ MUST be [Web-based Data Entities](data-entities.html#web-based-data-entities). 

{: .warning }
> Using relative URI references like `example/data.txt` in a _Detached RO-Crate_ is NOT RECOMMENDED as this is considered ambigious and fragile. 

A _Detached RO-Crate_ can be identified by the [root data entity](root-data-entity.md) having an `@id` different from `./` in the JSON.

{: .note }
> [Finding the Root Data Entity](root-data-entity.md#finding-the-root-data-entity) can be harder for consumers of detached crates, particularly if the platform serving the _RO-Crate Metadata File_ is unable to ensure the URI path ends with `…/ro-crate-metadata.json`. 


## RO-Crate Metadata File (`ro-crate-metadata.json`)

* In a _Regular RO-Crate_ the _RO-Crate Metadata File_ MUST be named `ro-crate-metadata.json` and appear in the _RO-Crate Root_
  - If an RO-Crate conforming to version 1.0 or earlier contains a file named `ro-crate-metadata.jsonld` but not `ro-crate-metadata.json`, then processing software should treat this as the _RO-Crate Metadata File_. If the crate is updated, the file SHOULD be renamed to `ro-crate-metadata.json` and the _RO-Crate Metadata File Descriptor_ SHOULD be updated to reference it, with an up to date [conformsTo] property naming an appropriate version of this specification. 
* The _RO-Crate Metadata File_ MUST contain _RO-Crate JSON-LD_; a valid [JSON-LD 1.0] document in [flattened]  and [compacted] form
* The _RO-Crate JSON-LD_ SHOULD use the _RO-Crate JSON-LD Context_ <https://w3id.org/ro/crate/1.2-DRAFT/context> by reference.


[JSON-LD](https://json-ld.org/) is a structured form of [JSON] that can represent a _Linked Data_ graph. 

A valid _RO-Crate JSON-LD_ graph MUST describe:

1. The [RO-Crate Metadata File Descriptor](root-data-entity.md#ro-crate-metadata-file-descriptor)
2. The [Root Data Entity](root-data-entity.md#direct-properties-of-the-root-data-entity)
3. Zero or more [Data Entities](data-entities.md)
4. Zero or more [Contextual Entities](contextual-entities.md)

It is RECOMMENDED that any referenced _contextual entities_ are also described in the _RO-Crate Metadata File_ with the same identifier. Similarly it is RECOMMENDED that any _contextual entity_ in the _RO-Crate Metadata file_ is linked to from at least one of the other entities using the same identifier. 

The appendix [RO-Crate JSON-LD](appendix/jsonld.md) details the general structure of the JSON-LD that is expected in the _RO-Crate Metadata File_. In short, the rest of this specification describe the different types of entities that can be added as `{}` objects to the _RO-Crate JSON-LD_ `@graph` array below:

```json
{ "@context": "https://w3id.org/ro/crate/1.2-DRAFT/context",
  "@graph": [

  ]
}
```


## RO-Crate Website (`ro-crate-preview.html` and `ro-crate-preview_files/`)

In addition to the machine-oriented _RO-Crate Metadata File_, the RO-Crate MAY include a human-readable HTML rendering of the same information, known as the _RO-Crate Website_.

If present in the root directory of a _Regular RO-Crate_ as `ro-crate-preview.html`, (or otherwise served in a _Detached RO-Crate_), the RO-Crate Website MUST:

* Be a valid [HTML 5] document 
* Be useful to users of the RO-Crate - this will vary by community and intended use, but in general the aim to assist users in reusing data by explaining what it is, how it was created how it can be used and how to cite it. One simple approach to this is to expose *all* the metadata in the _RO-Crate Metadata File_.
* Contain a copy of the _RO-Crate JSON-LD_ in a `script` element of the `head` element of the HTML, for example:
  ```html
    <script type="application/ld+json">
    {
        "@context": "https://w3id.org/ro/crate/1.2-DRAFT/context",
        "@graph": [ ...]
    }
    </script>
  ```

`ro-crate-preview.html` SHOULD:

* Display at least the metadata relating to the _Root Data Enity_ as static HTML without the need for scripting. It MAY contain extra features enabled by JavaScript.
* When a _Data Entity_ or _Contextual Entity_ is referenced by its ID:
  - If it has a [name] property, provide a link to its HTML version.
  - If it does not have a name (e.g. a [GeoCoordinates] location), show it embedded in the HTML for the entity.
  - For external URI values, provide a link.
* For keys that resolve in the `RO-Crate JSON-LD Context` to a URI, indicate this (the simplest way is to link the key to its definition).
* If there is sufficient metadata, contain a prominent _“Cite-as”_ text with a natural language data citation (see for example the [FORCE11 Data Citation Principles]).
* If there are additional resources necessary to render the preview (e.g. CSS, JSON, HTML), link to them in a subdirectory `ro-crate-preview-files/`


{: .warning }
> In a _Detached RO-Crate_ it is **undefined** how to find the _RO-Crate Website_ from the _RO-Crate Metadata File_ or vice versa.


## Payload files and directories

These are the actual files and directories that make up the **payload** of the dataset being described in a _Regular RO-Crate_.

The base RO-Crate specification makes no assumptions about the presence of any specific files or folders beyond the reserved RO-Crate files described above. 

Payload files may appear directly in the _RO-Crate Root_ alongside the _RO-Crate Metadata File_, and/or appear in sub-directories of the _RO-Crate Root_. Each file and directory MAY be represented as [Data Entities](data-entities.md) in the _RO-Crate Metadata File_.

A RO-Crate may also contain [Web-based Data Entities](data-entities.html#web-based-data-entities) that are not present as part of the payload and referenced using absolute URIs. These may require additional preservation measures.

{: .tip }
> A RO-Crate [packaged with BagIt](appendix/implementation-notes.md#adding-ro-crate-to-bagit) may be [referencing external files](appendix/implementation-notes.md#referencing-external-files) which are not present in the _RO-Crate Root_ hierarchy until the BagIt has been _completed_. This method can be used for files that are large, require authentication or otherwise inconvenient to transfer with the RO-Crate, but which should nevertheless still be considered part of the _payload_.


## Self-describing and self-contained

RO-Crates SHOULD be self-describing and self-contained.

A minimal RO-Crate is a directory containing a single [RO-Crate Metadata File](root-data-entity.md) `ro-crate-metadata.json`. 

At the basic level, an RO-Crate is a collection of files and resources represented as a Schema.org [Dataset], that together form a meaningful unit for the purposes of communication, citation, distribution, preservation, etc.  The _RO-Crate Metadata File_ describes the RO-Crate, and MUST be stored in the _RO-Crate Root_. 

While RO-Crate is well catered for describing a _Dataset_ as files and relevant metadata that are _contained_ by the RO-Crate in the sense of living within the same root directory, RO-Crates can also reference external resources which are stored or accessed separately, via absolute URIs. This is particularly recommended where some resources cannot be co-hosted for practical or legal reasons, or if the RO-Crate itself is primarily web-based.

It is important to note that the _RO-Crate Metadata File_ is **not an exhaustive manifest** or inventory, that is, it does not necessarily list or describe all files in the package.  Rather it is focused on providing sufficient amount of metadata to understand and use the content, and is designed to be compatible with existing and future approaches that _do_ have full inventories / manifest and integrity checks, e.g. by using checksums, such as [BagIt] and Oxford Common File Layout [OCFL Objects][OCFL Object].

The intention is that RO-Crates can work well with a variety of archive file formats, e.g. tar, zip, etc., and approaches to capturing file manifests and file fixity, such as [BagIt], [OCFL] and [git] (see also appendix [Combining with other packaging schemes](appendix/implementation-notes.md#combining-with-other-packaging-schemes)). An RO-Crate can also be hosted on the web or mainly refer to web resources, although extra care to ensure persistence and consistency should be taken for archiving such RO-Crates.

{% include references.liquid %}
