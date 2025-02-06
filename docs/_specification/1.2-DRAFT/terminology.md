---
title: Terminology
redirect_from:
  - /1.2-DRAFT/terminology
nav_order: 2
parent: RO-Crate 1.2-DRAFT
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2023 The University of Manchester UK 
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

# Terminology {#terminology}


_RO-Crate_: A dataset, which is described in a JSON-LD _RO-Crate Metadata Document_. 

_RO-Crate Metadata Document_: A JSON-LD document that describes the _RO-Crate_ with structured data in form of _RO-Crate JSON-LD_. This may be stored in a file-system as an _RO-Crate Metadata File_, served via web site or via an API. 

_RO-Crate Metadata File_: An _RO-Crate Metadata Document_ stored in a file named  `ro-crate-metadata.json` in the _RO-Crate Root_ of an _Attached RO-Crate Package_. See section [RO-Crate Metadata Document](structure#ro-crate-metadata-document-ro-crate-metadatajson). 

_Attached RO-Crate Package_: A file system directory, indicated by the presence of the _RO-Crate Metadata File_ which functions as a packaged dataset. A _Local RO-Crate Package_ carries a payload of zero or more files. See section [Types of RO-Crate](structure#types-of-ro-crate).

_Detached RO-Crate Package_: A stand alone _RO-Crate Metadata Document_ which defines a virtual data package by referencing online materials. A  _Detached RO-Crate Package_ does not have a payload See section [Types of RO-Crate](structure#types-of-ro-crate).


_Detached RO-Crate Metadata File_: An _RO-Crate Metadata Document_ stored in a file named  `${prefix}-ro-crate-metadata.json` or `ro-crate-metadata.json` where  `$prefix`, if present is a file-system safe version identifier or name for the RO-Crate.


_RO-Crate Root_: The top-level directory of an _RO-Crate Package_. See section [RO-Crate structure](structure)

_RO-Crate Metadata Descriptor_: A _Contextual Entity_ of type [CreativeWork], which describes the _RO-Crate Metadata Document_ and links it to the _Root Data Entity_. See section [RO-Crate Metadata Descriptor](root-data-entity#ro-crate-metadata-descriptor)

_RO-Crate Website_: Human-readable HTML pages which describe the RO-Crate (i.e. the _Root Data Entity_, its _Data Entities_ and _Context Entities_), with a home-page at `ro-crate-preview.html`. See section [RO-Crate Website](structure#ro-crate-website-ro-crate-previewhtml-and-ro-crate-preview_files).

_Type_: A classification of objects or their descriptions. The type (or "class") is given as a short-hand _key_, mapped by the _RO-Crate JSON-LD Context_ to a _URI_ that has the type definition. See appendix [RO-Crate JSON-LD](appendix/jsonld).

_Data Entity_: A JSON-LD representation (in the _RO-Crate Metadata Document_) of a directory, file, or other Web resource which is considered _contained_ by the _RO-Crate_. See section [Data entities](data-entities).

_Property_: A relationship from one _entity_ to another entity, or to a _value_. The type of relationship is identified by a _URI_, mapped to a _key_ by _JSON-LD_. See appendix [RO-Crate JSON-LD](appendix/jsonld).

_Root Data Entity_: A _Data Entity_ of _type_ [Dataset], representing the RO-Crate as a whole.  See section [Root Data Entity](root-data-entity).

_JSON-LD_: A JSON-based file format for storing _Linked Data_. This document assumes [JSON-LD 1.0]. JSON-LD use a _context_ to map from JSON keys to _URIs_. See appendix [RO-Crate JSON-LD](appendix/jsonld).

_JSON_: The _JavaScript Object Notation (JSON) Data Interchange Format_ as defined by [RFC 7159]; a structured text file format that can be programmatically consumed and generated in a wide range of programming languages. The main JSON structures are _objects_ (`{}`) indexed by _keys_, sequential _arrays_ (`[]`) and literal _values_ (`""`).

_Contextual Entity_: A JSON-LD representation of an entity associated with another _Entity_, in order to adequately describe it. For example, a [Person], [Organization] (including research projects), item of equipment ([IndividualProduct]), [license] or any other _thing_ or _event_ that forms part of the metadata for a _Data Entity_. _Properties_ of contextual entities may refer to further entities. See section [Contextual Entities](contextual-entities).

_Linked Data_: A data structure where properties, types and resources are identified with _URIs_, which if retrieved over the Web, further describe or provide the identified property/type/resource.

_URI_: A _Uniform Resource Identifier_ as defined in [RFC 3986], for example `http://example.com/path/file.html` - commonly known as _URL_. In this document the term _URI_ includes _IRI_, which also permit international Unicode characters. The URI identifies a downloadable resource (e.g. an image) or a concept (e.g. a _type_ definition).

_URI Path_: The relative _path_ element of an _URI_ as defined in [RFC3986 section 3.3], e.g. `path/file.html`

_RO-Crate JSON-LD Context_: A JSON-LD [context][JSON-LD context] that provides Linked Data mapping for RO-Crate metadata to vocabularies like [Schema.org]. This mapping assigns meaning to the JSON keys, see appendix [RO-Crate JSON-LD](appendix/jsonld).

_RO-Crate JSON-LD_: JSON-LD that use the _RO-Crate JSON-LD Context_ and contain RO-Crate metadata, written as if [flattened] and then [compacted] according to the rules in JSON-LD 1.0. The _RO-Crate JSON-LD_ for an _RO-Crate_ is stored or transmitted in the _RO-Crate Metadata Document.



## Linked Data conventions

Throughout this specification, RDF terms (_properties_, _types_) are referred to using the _keys_ defined in the _RO-Crate JSON-LD Context_.

Following [Schema.org] practice, `property` names start with lowercase letters and `Type` names start with uppercase letters.

In the _RO-Crate Metadata Document_ the RDF terms use their RO-Crate JSON-LD names as defined in the _RO-Crate JSON-LD Context_, which is available at <https://w3id.org/ro/crate/1.2-DRAFT/context>

{% include references.liquid %}
