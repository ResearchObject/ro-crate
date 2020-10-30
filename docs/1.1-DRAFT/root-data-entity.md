---
layout: default
title: Root Data Entity
excerpt: |
  ..
sort: 6
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

# Root Data Entity

The **Root Data Entity** is a [Dataset] that represent the RO-Crate as a whole;
a _Research Object_ that includes the _Data Entities_ and the related
_Contextual Entities_.

As explained in section [RO-Crate structure](structure.md), the RO-Crate description 
is stored as _JSON-LD_ in the _RO-Crate Metadata File_ `ro-crate-metadata.json` in 
the _RO-Crate root_ directory. 

## RO-Crate Metadata File Descriptor

The _RO-Crate JSON-LD_ MUST contain a self-describing
**RO-Crate Metadata File Descriptor** with
the `@id` value `ro-crate-metadata.json` (or `ro-crate-metadata.jsonld` in legacy
crates) and `@type` [CreativeWork]. This descriptor MUST have an [about]
property referencing the _Root Data Entity_, which SHOULD have an `@id` of `./`.

```json

{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context", 
  "@graph": [
    {
        "@type": "CreativeWork",
        "@id": "ro-crate-metadata.json",
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

### Finding the Root Data Entity

Consumers processing the RO-Crate as an JSON-LD graph can thus reliably find
the _Root Data Entity_ by following this algorithm:

1. For each entity in `@graph` array
2. ..if the `conformsTo` property is a URI that starts with `https://w3id.org/ro/crate/`
3. ....from this entity's `about` object keep the `@id` URI as variable _root_
4. For each entity in `@graph` array
5. .. if the entity has an `@id` URI that matches _root_ return it

See also the appendix on
[finding RO-Crate Root in RDF triple stores](appendix/relative-uris.md#finding-ro-crate-root-in-rdf-triple-stores).

### Purpose of Metadata File

To ensure a base-line interoperability between RO-Crates, and for an RO-Crate to
be considered a _Valid RO-Crate_, a minimum set of metadata is required for the
_Root Data Entity_. As [stated earlier](structure.md#self-describing-and-self-contained)
the _RO-Crate Metadata File_ is not an
exhaustive manifest or inventory, that is, it does not necessarily list or
describe all files in the package. For this reason, there are no minimum
metadata requirements in terms of describing [Data Entities](data-entities.md) (files and folders)
other than the _Root Data Entity_. Extensions of RO-Crate dealing with specific
types of dataset may put further constraints or requirements of metadata beyond
the Root Data Entity (see the appendix [Extending RO-Crate](appendix/jsonld.md#extending-ro-crate)).

The _RO-Crate Metadata File Descriptor_ MAY contain information such as
licensing for the _RO-Crate Metadata File_ so metadata can be licensed
separately from Data.

The table below outlines the properties that the _Root Data Entity_ MUST have to
be minimally valid and additionally highlights properties required to meet other
common use-cases:

## Direct properties of the Root Data Entity

The _Root Data Entity_ MUST have the following properties:

*  `@type`: MUST be [Dataset]
*  `@id`:  MUST end with `/` and SHOULD be the string `./`
*  `name`: SHOULD identify the dataset to humans well enough to disambiguate it from other RO-Crates
*  `description`: SHOULD further elaborate on the name to provide a summary of the context in which the dataset is important.
*  `datePublished`: MUST be a string in ISO 8601 date format and SHOULD be specified to at least the precision of a day, MAY be a timestamp down to the millisecond. 
*  `license`: SHOULD link to a _Contextual Entity_ in the _RO-Crate Metadata File_ with a name and description. MAY have a URI (eg for Creative Commons or Open Source licenses). MAY, if necessary be a textual description of how the RO-Crate may be used.

```note
These requirements are stricter than those published 
for [Google Dataset Search](https://developers.google.com/search/docs/data-types/dataset) which 
requires a `Dataset` to have a `name` and `description`,
```

```warning
The properties above are not sufficient to generate a [DataCite][DataCite Schema] citation. Advice on integrating with [DataCite] will be provided in a future version of this specification, or as an implementation guide.
```

## Minimal example of RO-Crate

The following _RO-Crate Metadata File_ represents a minimal description of an _RO-Crate_. 

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context", 
  "@graph": [

 {
    "@type": "CreativeWork",
    "@id": "ro-crate-metadata.json",
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

{% include references.liquid %}
