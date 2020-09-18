---
layout: default
title: RO-Crate Structure
excerpt: |
  ..
sort: 4
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

# RO-Crate Structure

The structure an _RO-Crate_ MUST follow is:

```
<RO-Crate root directory>/
|   ro-crate-metadata.json  # RO-Crate Metadata File MUST be present 
|   ro-crate-preview.html     # RO-Crate Website homepage MAY be present
|   ro-crate-preview_files/   # MAY be present
|    | [other RO-Crate Website files]
|   [payload files and directories]  # 0 or more
```

The name of the _RO-Crate root_ directory is not defined, but a root directory is identifiable by the presence of the _RO-Crate Metadata File_, `ro-crate-metadata.json`. For instance, if an _RO-Crate_ is archived in a ZIP-file, the ZIP root directory correspond to _RO-Crate root_ directory if it contains `ro-crate-metadata.json`.


[Data Entities](#core-metadata-for-data-entities) in the RO-Crate MUST either be _payload files/directories_ present within the RO-Crate root directory or its subdirectories, or be [Web-based Data Entities](#web-based-data-entities).

<!--
RO-Crates can be _nested_ by including payload directories that themselves contain an _RO-Crate Metadata File_.
-->

## RO-Crate Metadata File (`ro-crate-metadata.json`)

* In new RO-Crates the _RO-Crate Metadata File_ MUST be named `ro-crate-metadata.json` and appear in the _RO-Crate Root_
* The _RO-Crate Metadata File_ MUST contain _RO-Crate JSON-LD_; a valid [JSON-LD 1.0](https://www.w3.org/TR/2014/REC-json-ld-20140116/) document in [flattened](https://www.w3.org/TR/json-ld/#flattened-document-form) and [compacted](https://www.w3.org/TR/json-ld/#compacted-document-form) form
* The _RO-Crate JSON-LD_ SHOULD use the _RO-Crate JSON-LD Context_ <https://w3id.org/ro/crate/1.1-DRAFT/context> by reference.
* If an RO-Crate conforming to version 1.0 or earlier contains a file named `ro-crate-metadata.jsonld` instead of `ro-crate-metadata.json` then processing software should treat this as the _RO-Crate Metadata File_. If the crate is updated then the file should SHOULD be renamed to `ro-crate-metadata.json` and the _RO-Crate Metadata File Descriptor_ SHOULD be updated to to reference it, with an up to date `conformsTo` property naming an appropriate version of this specification. 


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


## RO-Crate Website (`ro-crate-preview.html` and `ro-crate-preview_files/`)

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

## Payload files and directories

These are the actual files and directories that make up the dataset being described.

The base RO-Crate specification makes no assumptions about the presence of any specific files or folders beyond the reserved RO-Crate files described above. Payload files may appear directly in the _RO-Crate Root_ alongside the _RO-Crate Metadata File_, and/or appear in sub-directories of the _RO-Crate Root_. Each file and directory MAY be represented as Data Entities in the _RO-Crate Metadata File_.


## RO-Crates SHOULD be self-describing and self-contained

A minimal RO-Crate is a directory containing a single _RO-Crate Metadata File_. 

At the basic level, an RO-Crate is a collection of files and resources represented as a schema.org [Dataset], that together form a meaningful unit for the purposes of communication, citation, distribution, preservation, etc.  The _RO-Crate Metadata File_ describes the RO-Crate, and MUST be stored in the _RO-Crate Root_. 

While RO-Crate is well catered for describing a _Dataset_ as files and relevant metadata that are _contained_ by the RO-Crate in the sense of living within the same root directory, RO-Crates can also reference external resources which are stored or accessed separately, via absolute URIs. This is particularly recommended where some resources cannot be co-hosted for practical or legal reasons, or if the RO-Crate itself is primarily web-based.

It is important to note that the _RO-Crate Metadata File_ is not an exhaustive manifest or inventory, that is, it does not necessarily list or describe all files in the package.  Rather it is focused on providing sufficient amount of metadata to understand and use the content, and is designed to be compatible with existing and future approaches that _do_ have full inventories / manifest and integrity checks, e.g. by using checksums, such as [BagIt] and Oxford Common File Layout [OCFL Object]s.

The intention is that RO-Crates can work well with a variety of archive file formats, e.g. tar, zip, etc., and approaches to capturing file manifests and file fixity, such as [BagIt], [OCFL] and [git]. An RO-Crate can also be hosted on the web or mainly refer to web resources, although extra care to ensure persistence and consistency should be taken for archiving such RO-Crates.
