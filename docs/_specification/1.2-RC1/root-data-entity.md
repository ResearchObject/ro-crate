---
title: Root Data Entity
redirect_from:
  - /1.2/root-data-entity
nav_order: 5
parent: RO-Crate 1.2 
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

# Root Data Entity  {#root-data-entity}
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

The **Root Data Entity** is a [Dataset] that represents the RO-Crate as a whole;
a _Research Object_ that includes the _Data Entities_ and the related
_Contextual Entities_.

## RO-Crate Metadata Descriptor

The _RO-Crate Metadata Document_ MUST contain a self-describing
**RO-Crate Metadata Descriptor** with
the `@id` value `ro-crate-metadata.json` (or `ro-crate-metadata.jsonld` in legacy
crates for RO-Crate 1.0 or older) and `@type` [CreativeWork]. This descriptor MUST have an [about] property referencing the _Root Data Entity_'s `@id`.

```json

{ "@context": "https://w3id.org/ro/crate/1.2/context", 
  "@graph": [
    {
        "@type": "CreativeWork",
        "@id": "ro-crate-metadata.json",
        "about": {"@id": "./"},
        "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2"}
    },
    
    {
      "@id": "./",
      "@type": "Dataset",
      ...
    }
  ]
}
```

{% include callout.html type="note" content="Even in [Detached RO-Crate Packages](structure#detached-ro-crate-package), where the _RO-Crate Metadata File_ may be absent or named with a [prefix](structure#types-of-ro-crate), the identifier `ro-crate-metadata.json` MUST be used within the _RO-Crate JSON-LD_." %}

The [conformsTo] of the _RO-Crate Metadata Descriptor_ SHOULD have a single value which 
is a versioned permalink URI of the RO-Crate specification
that the _RO-Crate JSON-LD_ conforms to. The URI SHOULD 
start with `https://w3id.org/ro/crate/`. 

{% include callout.html type="note" content="In RO-Crates conforming to version 1.1 and earlier, `conformsTo` MAY be an array and can include [RO-Crate profiles](profiles) in addition to the base specification. In version 1.2, it is now recommended that profile declarations are included on the _Root Data Entity_ instead (see [Direct Properties of the Root Data Entity](#direct-properties-of-the-root-data-entity))." %}

### Finding the Root Data Entity

Consumers processing the RO-Crate as a JSON-LD graph can
find the _Root Data Entity_ by following this algorithm:

1. For each entity in `@graph` array
2. .. if the `@id` is `ro-crate-metadata.json`
3. .... from this entity's `about` object, keep the `@id` URI as variable _root_
4. .. if the `@id` is `ro-crate-metadata.jsonld`
5. .... from this entity's `about` object, keep the `@id` URI as variable _legacyroot_
6. For each entity in `@graph` array
7. .. if the entity has an `@id` URI that matches a non-null _root_ return it
8. For each entity in `@graph` array
9. .. if the entity has an `@id` URI that matches a non-null _legacyroot_ return it
10. Fail with unknown root data entity.

Note that the above can be implemented efficiently by first building a map (`entity_map`) of
all entities using their `@id` as keys (which is typically also helpful for
further processing) and then performing a series of lookups. 
Ignoring the legacy case for now, this lookup code could be:

```javascript
metadata_entity = entity_map["ro-crate-metadata.json"]
root_entity = entity_map[metadata_entity["about"]["@id"]]
```

See also the appendix on
[finding RO-Crate Root in RDF triple stores](appendix/relative-uris#finding-ro-crate-root-in-rdf-triple-stores).

### Purpose of Metadata Document

To ensure a base-line interoperability between RO-Crates, a minimum set of metadata is required for the
_Root Data Entity_. As [stated earlier](structure#self-describing-and-self-contained)
the _RO-Crate Metadata Document_ is not an
exhaustive manifest or inventory, that is, it does not necessarily list or
describe all files in the package. For this reason, there are no minimum
metadata requirements in terms of describing [Data Entities](data-entities) (files and folders)
other than the _Root Data Entity_. Extensions of RO-Crate dealing with specific
types of dataset may apply further constraints or requirements of metadata beyond
the Root Data Entity (see the appendix [Extending RO-Crate](appendix/jsonld#extending-ro-crate)).

The _RO-Crate Metadata Descriptor_ MAY contain information such as
licensing for the _RO-Crate Metadata Document_ if metadata is licensed
separately from the crate's Data entities.

The section below outlines the properties that the _Root Data Entity_ MUST have.

## Direct properties of the Root Data Entity

The _Root Data Entity_ MUST have all of the properties listed below. Each property also has requirements that apply to its value:

*  `@type`: MUST be [Dataset] or an array that contains `Dataset`
*  `@id`:  SHOULD be the string `./` or an absolute URI (see [below](#root-data-entity-identifier))
*  `name`: SHOULD identify the dataset to humans well enough to disambiguate it from other RO-Crates
*  `description`: SHOULD further elaborate on the name to provide a summary of the context in which the dataset is important.
*  `datePublished`: MUST be a single string value in [ISO 8601 date format][DateTime], SHOULD be specified to at least the precision of a day, and MAY be a timestamp down to the millisecond. 
*  `license`: SHOULD link to a _Contextual Entity_ or _Data Entity_ in the _RO-Crate Metadata Document_ with a name and description (see section on [licensing](contextual-entities#licensing-access-control-and-copyright)). MAY, if necessary, be a textual description of how the RO-Crate may be used. 


{% include callout.html type="note" content="These requirements are stricter than those published 
for [Google Dataset Search](https://developers.google.com/search/docs/data-types/dataset) which 
requires a `Dataset` to have a `name` and `description`." %}

{% include callout.html type="warning" content="The properties above are not sufficient to generate a [DataCite] citation. Advice on integrating with [DataCite] will be provided in a future version of this specification, or as an implementation guide." %}

Additional properties of _schema.org_ types [Dataset] and [CreativeWork] MAY be added to further describe the RO-Crate as a whole, e.g. [author], [abstract], [publisher]. See sections [contextual entities](contextual-entities) and [provenance](provenance) for further details.

If the RO-Crate conforms to one or more [profiles](profiles), this should be described following the guidance in the section [Declaring conformance of an RO-Crate profile](profiles#declaring-conformance-of-an-ro-crate-profile).

### Root Data Entity identifier

The _Root Data Entity_'s `@id` SHOULD be either `./` (indicating the directory of `ro-crate-metadata.json` is the [RO-Crate Root](structure)), or an absolute URI.


{% include callout.html type="note" content="RO-Crates that have been assigned a _persistent identifier_ (e.g. a DOI) MAY indicate this using [identifier] on the _Root Data Entity_ using the approach set out in the [Science On Schema.org guides], that is through a `PropertyValue` or MAY use a full persistent URL as the `@id` for the _Root Data Entity_." %}

{% include callout.html type="note" content="RO-Crate 1.1 and earlier recommended `identifier` to be plain string URIs. Clients SHOULD be permissive of an RO-Crate `identifier` being a string (which MAY be a URI), or a `@id` reference, which SHOULD be represented as a `PropertyValue` entity which MUST have a human readable `value`, and SHOULD have a `url` if the identifier is Web-resolvable. A citable representation of this persistent identifier MAY be given as a `description` of the `PropertyValue`, but as there are more than 10.000 known [citation styles], no attempt should be made to parse this string."
%}

#### Resolvable persistent identifiers and citation text

It is RECOMMENDED that resolving the `identifier` programmatically returns the _RO-Crate Metadata Document_ or an archive (e.g. ZIP) that contains the _RO-Crate Metadata File_, using [content negotiation](data-entities#retrieving-an-ro-crate) and/or [Signposting]. With an RO-Crate identifier that is persistent and resolvable in this way from a URI, the _Root Data Entity_ SHOULD indicate this using the `cite-as` property according to [RFC8574]. Likewise, an HTTP/HTTPS server of the resolved RO-Crate Metadata Document or archive (possibly after redirection) SHOULD indicate that persistent identifier in its [Signposting] headers using `Link rel="cite-as"`. 

{% include callout.html type="tip" content="The above `cite-as` MAY go to a repository landing page, and MAY require authentication, but MUST ultimately have the RO-Crate as a downloadable item, which SHOULD be programmatically accessible through content negotiation or [Signposting] (`Link rel=\"describedby\"` for an _RO-Crate Metadata Document_, or `Link rel=\"item\"` for an archive). To rather associate a textual scholarly citation for a crate (e.g. journal article), indicate instead a [publication via `citation` property](contextual-entities#publications-via-citation-property)."
%}

Any entity which is a subclass of [CreativeWork], including [Dataset]s like the _Root Data Entity_, MAY have a `creditText` property which provides a textual citation for the entity.

## Minimal example of RO-Crate

The following _RO-Crate Metadata Document_ represents a minimal description of an _RO-Crate_ that also follows the identifier recommendations above for use in an _Attached RO-Crate Package_. 

```json
{ "@context": "https://w3id.org/ro/crate/1.2/context", 
  "@graph": [

 {
    "@id": "ro-crate-metadata.json",
    "@type": "CreativeWork",
    "about": {"@id": "./"},
    "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2"}
 },  
 {
    "@id": "./",
    "@type": "Dataset",
    "identifier": {"@id": "https://doi.org/10.4225/59/59672c09f4a4b"},
    "cite-as": "https://doi.org/10.4225/59/59672c09f4a4b",
    "datePublished": "2017",
    "name": "Data files associated with the manuscript:Effects of facilitated family case conferencing for ...",
    "description": "Palliative care planning for nursing home residents with advanced dementia ...",
    "license": {"@id": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/"},
    "creditText": "Agar, M. et al., 2017. Data supporting \"Effects of facilitated family case conferencing for advanced dementia: A cluster randomised clinical trial\". https://doi.org/10.4225/59/59672c09f4a4b"
 },
 {
    "@id": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/",
    "@type": "CreativeWork",
    "description": "This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/au/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.",
    "identifier": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/",
    "name": "Attribution-NonCommercial-ShareAlike 3.0 Australia (CC BY-NC-SA 3.0 AU)"
 },
 {
    "@id": "https://doi.org/10.4225/59/59672c09f4a4b",
    "@type": "PropertyValue",
    "propertyID": "https://registry.identifiers.org/registry/doi",
    "value": "doi:10.4225/59/59672c09f4a4b",
    "url": "https://doi.org/10.4225/59/59672c09f4a4b"
  }
 ]
}
```

Alternatively the following is also valid, this time using the DOI as the `@id` of the _Root Data Entity_:

```json
 {
    "@id": "ro-crate-metadata.json",
    "@type": "CreativeWork",
    "about": {"@id": "https://doi.org/10.4225/59/59672c09f4a4b"},
    "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2"}
 },  
{
    "@id": "https://doi.org/10.4225/59/59672c09f4a4b",
    "@type": "Dataset",
    "cite-as": "https://doi.org/10.4225/59/59672c09f4a4b",
    "datePublished": "2017",
    "name": "Data files associated with the manuscript:Effects of facilitated family case conferencing for ...",
    "description": "Palliative care planning for nursing home residents with advanced dementia ...",
    "license": {"@id": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/"},
    "creditText": "Agar, M. et al., 2017. Data supporting \"Effects of facilitated family case conferencing for advanced dementia: A cluster randomised clinical trial\". https://doi.org/10.4225/59/59672c09f4a4b"
 }
```
{% include references.liquid %}
