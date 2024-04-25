---
title: Contextual Entities
excerpt: |
  The RO-Crate contain additional information about Contextual Entities for the
  use of both humans and machines. This also helps to maximize the extent to
  which an RO-Crate is self-contained and self-describing, in that it reduces the
  need for the consumer of an RO-Crate to refer to external information which may
  change or become unavailable over time.
nav_order: 7
jekyll-mentions: false
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

<div id="contextual-entities"></div>

# Representing Contextual Entities
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

The RO-Crate SHOULD contain additional information about _Contextual Entities_ for the use of both humans (in `ro-crate-preview.html`) and machines (in `ro-crate-metadata.json`). This also helps to maximize the extent to which an _RO-Crate_ is self-contained and self-describing, in that it reduces the need for the consumer of an RO-Crate to refer to external information which may change or become unavailable over time.

## Contextual vs Data entities

RO-Crate distinguishes between _contextual entities_ and _data entities_.

**[Data entities](data-entities.md)** primarily exist in their own right as a file or directory (which may be in the _RO-Crate Root_ directory or downloadable by URL). 

**Contextual entities** however primarily exist outside the digital sphere (e.g. [People](#people), [Places](#places)) or are  conceptual descriptions that primarily exist as metadata, like [Geometry] and [ContactPoint](#contact-information).

Some contextual entities can also be considered data entities -- for instance the [license](#licensing-access-control-and-copyright) property refers to a [CreativeWork] that can reasonably be downloaded, however a license document is not usually considered as part of research outputs and would therefore typically not be included in [hasPart] on the [root data entity](root-data-entity.md). 

{: .tip }
> Files in the _RO-Crate Root_ are not necessarily data entities -- the [RO-Crate Metadata Descriptor](root-data-entity.md#ro-crate-metadata-file-descriptor) is a file in the _RO-Crate Root_, but is considered a _Contextual Entity_ as it is describing the RO-Crate, rather than being part of it. On the other hand, the [Root Data Entity](root-data-entity.md#root-data-entity) is a data entity within its own metadata file.

Likewise, some data entities may also be described as contextual entities, for instance a `File` that is also a [ScholarlyArticle]. In such cases the _contextual data entity_ MUST be described as a single JSON object in the RO-Crate Metadata JSON `@graph` and SHOULD list both relevant data and contextual types in a `@type` array. 

The RO-Crate Metadata JSON `@graph` MUST NOT list multiple entities with the same `@id`; behaviour of consumers of an RO-Crate encountering multiple entities with the same `@id` is undefined.


## Identifiers for contextual entities

A challenge can be how to assign [identifiers for contextual entities](appendix/jsonld.md#describing-entities-in-json-ld), that is deciding on their `@id` value.

If an existing permalink (e.g. `https://orcid.org/0000-0002-1825-0097`) or other absolute URI (e.g. `https://en.wikipedia.org/wiki/Josiah_S._Carberry`) is reasonably unique for that entity, that URI SHOULD be used as identifier for the contextual entity in preference of an identifier local to the RO-Crate (e.g. `#josiah` or `#0fa587c6-4580-4ece-a5df-69af3c5590e3`). 

Care should be taken to not describe two conceptually different contextual entities with the same identifier - e.g. if `https://en.wikipedia.org/wiki/Josiah_S._Carberry` is a [Person] it SHOULD NOT also be a [CreativeWork] (although this example is a fictional person!).

Where a related URL exists that may not be unique enough to serve as identifier, it can instead be added to a contextual entity using the property [url].


See the [appendix on JSON-LD identifiers](appendix/jsonld.md#describing-entities-in-json-ld) for details.


## People

A core principle of Linked data is to use URIs to identify important entities such as people. The following is the minimum recommended way of representing a [author] of a RO-Crate. The [author] property MAY also be applied to a directory ([Dataset]), a [File] or other [CreativeWork] entities.

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

This uses an [ORCID] to unambiguously identify an author, represented as a _Contextual Entity_ of type [Person].

Note the string _value_ for the organizational affiliation. This SHOULD be improved by also providing a _Contextual Entity_ for the organization (see example below).


## Organizations as values

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




## Contact information

A RO-Crate SHOULD have contact information, using a contextual entity of type [ContactPoint]. Note that in Schema.org [Dataset] does not currently have the corresponding [contactPoint] property, so the contact point would need to be given through a [Person] or [Organization] contextual entity which are related to the Dataset via a [author] or [publisher] property.


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



## Publications via citation property

To associate a publication with a dataset the _RO-Crate JSON-LD_ MUST include a URL (for example a DOI URL) as the `@id` of a publication using the [citation] property.

For example:


```json
{
    "@id": "./",
    "@type": "Dataset",
    "citation": {"@id": "https://doi.org/10.1109/TCYB.2014.2386282"}
}
```

The publication SHOULD be described further 
as an additional contextual entity of
type [ScholarlyArticle] or [CreativeWork].


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
  "datePublished": "2015",
  "creditText": "J. Xuan, J. Lu, G. Zhang and X. Luo, \"Topic Model for Graph Mining,\" in IEEE Transactions on Cybernetics, vol. 45, no. 12, pp. 2792-2803, Dec. 2015, doi: 10.1109/TCYB.2014.2386282. keywords: {Data mining;Chemicals;Hidden Markov models;Inference algorithms;Data models;Vectors;Chemical elements;Graph mining;latent Dirichlet allocation (LDA);topic model;Graph mining;latent Dirichlet allocation (LDA);topic model}"
}
```

[citation] MAY also be used with other data and contextual entities:

```json
{
  "@id": "communities-2018.csv",
  "@type": "File",
  "name": "Snapshot of RO Community efforts",
  "citation": {"@id": "https://doi.org/10.5281/zenodo.1313066"},
  "encodingFormat": "text/csv"
}
```

A [data entity](data-entities.md) MAY provide a published DOI [identifier] that primarily captures that file or dataset. A citation MAY also be provided:

```json
{
  "@id": "figure.png",
  "@type": ["File", "ImageObject"],
  "name": "XXL-CT-scan of an XXL Tyrannosaurus rex skull",
  "identifier": "https://doi.org/10.5281/zenodo.3479743",
  "citation": {"@id": "http://ndt.net/?id=19249"},
  "encodingFormat": "image/png"
},
{
    "@id": "https://doi.org/10.5281/zenodo.3479743",
    "@type": "PropertyValue",
    "propertyID": "https://registry.identifiers.org/registry/doi",
    "value": "doi.org/10.5281/zenodo.3479743",
    "url": "https://doi.org/10.5281/zenodo.3479743"
},
{
  "@id": "http://ndt.net/?id=19249",
  "@type": "ScholarlyArticle",
  "url": "http://ndt.net/?id=19249",
  "name": "An XXL-CT-scan of an XXL Tyrannosaurus rex skull. 19th World Conference on Non-Destructive Testing (WCNDT 2016)",
  "creditText": "Reims, N., Schulp, A., Böhnel, M., & Larson, P. (2016). An XXL-CT-scan of an XXL Tyrannosaurus rex skull. 19th World Conference on Non-Destructive Testing (WCNDT 2016), 13-17 June 2016 in Munich, Germany. e-Journal of Nondestructive Testing Vol. 21(7). https://www.ndt.net/?id=19249"
}


```


## Publisher

The [Root Data Entity](root-data-entity.md) SHOULD have a [publisher] property. This SHOULD be an [Organization] though it MAY be a [Person].


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





## Funding and grants

To associate a research project with a [Dataset], the _RO-Crate JSON-LD_ SHOULD contain an entity for the project using type [Organization], referenced by a [funder] property. The project `Organization` SHOULD in turn reference any external [funder], either by using its URL as an `@id` or via a _Contextual Entity_ describing the funder.

{: .tip }
> To make it very clear where funding is coming from, the _Root Data Entity_ SHOULD also reference funders directly, as well as via a chain of references.


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



## Licensing, Access control and copyright

If a [Data Entity](data-entities.md) has a [license] that is different from the license on the _Root Data Entity_, the entity SHOULD have a [license] property referencing a _Contextual Entity_ with a type [CreativeWork] to describe the license. The `@id` of the license SHOULD be its URL (e.g. a Creative Commons License URL) and, when possible, a summary of the license included using the [description] property.

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


### Metadata license

In some cases the license of the [RO-Crate metadata](root-data-entity.md) (the JSON-LD statements in the _RO-Crate Metadata Descriptor_) is different from the license on the [Root Data Entity](root-data-entity.md) and its content (_data entities_ indicated by [hasPart]). 

For instance, a common pattern for repositories is to license metadata as [CC0 Public Domain Dedication][CC0], while data is licensed as [CC-BY] or similar.  This pattern allow metadata to be combined freely (e.g. the [DataCite] knowledge graph), while redistribution of data files would require explicit attribution and statement of their license.

To express the metadata license is different from the _Root Data Entity_, expand the _RO-Crate Metadata Descriptor_  to include `license`:

```json
{
  "@type": "CreativeWork",
  "@id": "ro-crate-metadata.json",
  "identifier": "ro-crate-metadata.json",
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

If no explicit `license` is expressed on the _RO-Crate Metadata Descriptor_, the `license` expressed on the _Root Data Entity_ apply also on the RO-Crate metadata.


## Extra metadata such as Exif

Schema.org has a generic extension mechanism for encoding arbitrary properties and values which are not available as Schema.org properties. An example of this is the Schema.org [recommended way (see example 2)][ImageObject] of including [Exif] technical image metadata.

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
},
{
      "@id": "#c2521494-9b94-4b23-a713-6b281f540823",
      "@type": "PropertyValue",
      "name": "InternalSerialNumber",
      "value": "4102011002108002"
},
```


## Places

To associate a [Data Entity](data-entities.md) with a _Contextual Entity_ representing a geographical location or region the entity SHOULD have a property of [contentLocation] or [spatialCoverage] with a value of type [Place].


To express point or shape geometry it is recommended that a `geo` property on a [Place] entity SHOULD link to a [Geometry] entity, with an [asWKT] property that expresses the point or shape in [Well Known Text (WKT)](https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry) format.  This example is a point, `POINT ($longitude, $latitude)`, but other asWKT primitives, `LINESTRING` & `POLYGON` SHOULD be used as required.

This example shows how to define a place, using a [geonames] ID:


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
},
{
  "@id": "http://sws.geonames.org/8152662/",
  "@type": "Place",
  "description": "Catalina Park is a disused motor racing venue, located at Katoomba ...",
  "geo": {
    "@id": "_:Geometry-1"
  },
  "identifier": "http://sws.geonames.org/8152662/",
  "uri": "https://www.geonames.org/8152662/catalina-park.html",
  "name": "Catalina Park"
},
{
  "@id": "_:Geometry-1",
  "@type": "Geometry",
  "name": "Geometry-1",
  "asWKT": "<http://www.opengis.net/def/crs/OGC/1.3/CRS84> POINT (150.301195 -33.7152)"
}
```

**Tip**: To find the `@id` and `identifier` corresponding to a GeoNames HTML page like <https://www.geonames.org/8152662/catalina-park.html> click its `.rdf` button to find the identifier <http://sws.geonames.org/8152662/> referred from <https://sws.geonames.org/8152662/about.rdf>:

```xml
<gn:Feature rdf:about="http://sws.geonames.org/8152662/">
<!--... -->
```

**Tip**: Note the use of a JSON-LD blank node identifier here (starting with `_:`) - this indicates to an RO-Crate presentation application that the entity does not stand in its own right, and may be displayed inline (in this case as a map).

**Tip**: It is considered best practice to include the explicit mentioning of the CRS (Coordinate Reference System) identified through its opengis URI at the start of the `asWKT` field.  This provides the essential context to have the numbers is the remainder of the string correctly be plotted on te map.  Note however that many GIS related tooling expects that information to be fed in via a seperate config setting or API call. So handling these strings in any app that interacts with such systems might require some extra processing. 

**NOTE**: Any of the schema.org geographical classes and entities MAY be used on a [Place] element to describe geographical points and shapes, and previous versions of this specification did show examples of using [latitude] and [longitude] properties and entities such as [GeoCoordinates], however this results in very verbose JSON-LD and there is some imprecision in the schema.org specification that makes this approach hard to implement in RO-Crate applications for analysis or presentation of crates. We found that developers were resorting to embedding escaped [GeoJSON](https://en.wikipedia.org/wiki/GeoJSON) as string values in RO-Crate; WKT format is more compact and easier to implement and is recommended for use in RO-Crate as shown above.

## Subjects & keywords

Subject properties (equivalent to a Dublin Core Subject) on the [root data entity](root-data-entity.md) or a [data entity](data-entities.md) MUST use the [about] property.

Keyword properties MUST use [keywords]. Note that by Schema.org convention, keywords are given as a single JSON string, with individual keywords separated by commas.

```json
{
  "keywords": "Gibraltar, Spain, British Overseas Territory, city, map",
  "about": { "@id": "http://dbpedia.org/resource/Gibraltar" },
}
```

## Time

To describe the _time period_ which a RO-Crate [Data Entity](data-entities.md) (or the [root data entity](root-data-entity.md)) is _about_, use [temporalCoverage]:

```json
{
  "@id": "photos/",
  "@type": "Dataset",
  "name": "Photos of Gibraltar from 1950 till 1975",
  "about": {"@id": "http://dbpedia.org/resource/Gibraltar"},
  "temporalCoverage": "1950/1975"
}
```


## Thumbnails

A [File] or any other entity MAY have a [thumbnail] property which references another file.

For example, the below [RepositoryObject] is related to four files which are all versions of the same image (via [hasFile]) one of which is a thumbnail. The thumbnail MUST be included in the RO-Crate.

If [thumbnail]s are incidental to the data set, they need not be referenced by [hasPart]  or [hasFile] relationships. but must be in the BagIt manifest if in a _Bagged RO-Crate_.


```json
{
  "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/383",
  "@type": [
    "RepositoryObject",
    "ImageObject"
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
}
```

{% include references.liquid %}
