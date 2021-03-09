---
title: Terminology
sort: 3
excerpt: |
  ...
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

# Terminology

_RO-Crate_: A directory structure that contains a dataset, which is described in an _RO-Crate Metadata File_.

_RO-Crate Root_: The top-level directory of the _RO-Crate_, indicated by the presence of the _RO-Crate Metadata File_ `ro-crate-metadata.json` (or `ro-crate-metadata.jsonld` for crates that comply with versions before v1.1 of this specification)

_RO-Crate Metadata File_: A JSON-LD file stored as `ro-crate-metadata.json` in the _RO-Crate Root_. The metadata file describes the _RO-Crate_ with structured data in form of _RO-Crate JSON-LD_. (In version 1.0 this file was named `ro-crate-metadata.jsonld` but has been renamed to improve the usability of crates.)

_RO-Crate Website_: Human-readable HTML pages which describe the RO-Crate (i.e. the _Root Data Entity_, its _Data Entities_ and _Context Entities_), with a home-page at `ro-crate-preview.html` (any additional files reside in `ro-crate-preview_files/`)

_Entity_: An identified object, which have a given _type_ and may be described using a set of _properties_.

_Type_: A classification of objects or their descriptions. The type (or _class_) is identified by a _URI_, mapped to a _key_ by _JSON-LD_.

_Property_: A relationship from one _entity_ to another entity, or to a _value_. The type of relationship is identified by a _URI_, mapped to a _key_ by _JSON-LD_.

_Data Entity_: A JSON-LD representation, in the _RO-Crate Metadata File_, of a directory, file or other resource contained or described by the RO-Crate.

_Root Data Entity_: A _Data Entity_ of _type_ [Dataset], representing the RO-Crate as a whole.  

_RO-Crate Metadata File Descriptor_: A _Contextual Entity_ of type [CreativeWork], which describes the _RO-Crate Metadata File_ and links it to the _Root Data Entity_.

_JSON-LD_: A JSON-based file format for storing _Linked Data_. This document assumes [JSON-LD 1.0]. JSON-LD use a _context_ to map from JSON keys to _URIs_.

_JSON_: The _JavaScript Object Notation (JSON) Data Interchange Format_ as defined by [RFC 7159]; a structured text file format that can be programmatically consumed and generated in a wide range of programming languages. The main JSON structures are _objects_ (`{}`) indexed by _keys_, sequential _arrays_ (`[]`) and literal _values_ (`""`).

_Contextual Entity_: A JSON-LD representation of an entity associated with a _Data Entity_, needed to adequately describe that _Data Entity_. For example, a [Person], [Organization] (including research projects), item of equipment ([IndividualProduct]), [license] or any other _thing_ or _event_ that forms part of the metadata for a _Data Entity_ or supporting information.

_Linked Data_: A data structure where properties, types and resources are identified with _URIs_, which if retrieved over the Web, further describe or provide the identified property/type/resource.

_URI_: A _Uniform Resource Identifier_ as defined in [RFC 3986], for example `http://example.com/path/file.html` - commonly known as _URL_. In this document the term _URI_ includes _IRI_, which also permit international Unicode characters.

_URI Path_: The relative _path_ element of an _URI_ as defined in [RFC3986 section 3.3], e.g. `path/file.html`

_RO-Crate JSON-LD Context_: A JSON-LD [context][JSON-LD context] that provides Linked Data mapping for RO-Crate metadata to vocabularies like [Schema.org].

_RO-Crate JSON-LD_: JSON-LD structure using the _RO-Crate JSON-LD Context_ and containing RO-Crate metadata, written as if [flattened]  and then [compacted] according to the rules in JSON-LD 1.0. The _RO-Crate JSON-LD_ for an _RO-Crate_ is stored in the _RO-Crate Metadata File_.

## Linked Data conventions

Throughout this specification, RDF terms (_properties_, _types_) are referred to using the _keys_ defined in the _RO-Crate JSON-LD Context_.

Following [Schema.org] practice, `property` names start with lowercase letters and `Type` names start with uppercase letters.

In the _RO-Crate Metadata File_ the RDF terms use their RO-Crate JSON-LD names as defined in the _RO-Crate JSON-LD Context_, which is available at <https://w3id.org/ro/crate/1.2-DRAFT/context>

{% include references.liquid %}
