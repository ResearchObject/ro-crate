---
layout: default
title: Contextual Entities
excerpt: |
  The RO-Crate contain additional information about Contextual Entities for the
  use of both humans and machines. This also helps to maximize the extent to
  which an RO-Crate is self-contained and self-describing, in that it reduces the
  need for the consumer of an RO-Crate to refer to external information which may
  change or become unavailable over time.
sort: 8
jekyll-mentions: false
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


# Representing Contextual Entities

The _RO-Crate JSON-LD_ `@graph` SHOULD contain additional information about _Contextual Entities_ for the use of both humans (in `ro-crate-preview.html`) and machines (in `ro-crate-metadata.json`). This also helps to maximize the extent to which an _RO-Crate_ is self-contained and self-describing, in that it reduces the need for the consumer of an RO-Crate to refer to external information which may change or become unavailable over time.

## Contextual vs Data entities

<!-- https://github.com/ResearchObject/ro-crate/pull/94/ START -->

RO-Crate distinguishes between _Contextual entities_ and _Data entities_. 

**[Data entities](data-entities.md)** primarily exist in their own right as a file or directory (which may be in the _RO-Crate Root_ directory or downloadable by URL). 

**Contextual entities** however primarily exist outside the digital sphere (e.g. [People](#people), [Places](#places)) or are  conceptual descriptions that primarily exists as metadata, like [GeoCoordinates] and [ContactPoint](#contact-information).

Some contextual entities can also be considered data entities - for instance the [license](#licensing-access-control-and-copyright) property refers to a [CreativeWork] that can reasonably be downloaded, however a license document is not usually considered as part of research outputs and would therefore typically not be included in [hasPart] on the [root data entity](root-data-entity.md). 

Likewise, some data entities may also be described as contextual entities, for instance a `File` that is also a [ScholarlyArticle]. In such cases the _Contextual Data Entity_ SHOULD be described a single JSON object in the `@graph` with both types listed in a `@type` array. Consumers of an RO-Crate encountering two entities with the same `@id` SHOULD interpret them as a single entity.

<!-- https://github.com/ResearchObject/ro-crate/pull/94/ END -->

## Identifiers for contextual entities

A challenge can be how to assign [identifiers for contextual entities](appendix/jsonld.html#describing-entities-in-json-ld), that is deciding on their `@id` value.

RO-Crate recommend that if an existing permalink (e.g. `https://orcid.org/0000-0002-1825-0097`) or other absolute URI (e.g. `https://en.wikipedia.org/wiki/Josiah_S._Carberry`) is reasonably unique for that entity, that URI should be used as identifier for the contextual entity in preference of an identifier local to the RO-Crate (e.g. `#josiah` or `#0fa587c6-4580-4ece-a5df-69af3c5590e3`). 

Care should be taken to not describe two conceptually different contextual entities with the same identifier - e.g. if `https://en.wikipedia.org/wiki/Josiah_S._Carberry` is a `Person` it should not also be a [CreativeWork] (although this example is a fictional person!).

Where a related URL exist that may not be unique enough to serve as identifier, it can instead be added to a contextual entity using [url].


See the [appendix on JSON-LD identifiers](appendix/jsonld.html#describing-entities-in-json-ld) for details.

## People

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



## Publications via citation property

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





## Publisher

The [Root Data Entity](root-data-entity.md) SHOULD have a [publisher](http://schema.org/publisher) property. This SHOULD be an [Organization](http://schema.org/Organization) though it MAY be a [Person](http://schema.org/Person).


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

```tip
To make it very clear where funding is coming from, the _Root Data Entity_ SHOULD also reference funders directly, as well as via a chain of references.
```


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

In some cases the license of the [RO-Crate metadata](root-data-entity.md) (the JSON-LD statements in the _RO-Crate Metadata File Descriptor_) is different from the license on the [Root Data Entity](root-data-entity.md) and its content (_data entities_ indicated by [hasPart]). 

For instance, a common pattern for repositories is to license metadata as [CC0 Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/), while data is licensed as [CC-BY](https://creativecommons.org/licenses/by/4.0/) or similar.  This pattern allow metadata to be combined freely (e.g. the DataCite knowledge graph), while redistribution of data files would require explicit attribution and statement of their license.

To express the metadata license is different from the _Root Data Entity_, expand the _RO-Crate Metadata File Descriptor_  to include `license`:

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

If no explicit `license` is expressed on the _RO-Crate Metadata File Descriptor_, the `license` expressed on the _Root Data Entity_ apply also on the RO-Crate metadata.

<!-- TODO: This got a bit to complicated, commented out for 1.0

## License of contextual entity metadata

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

In the above (abridged) example, there is no explicit license on the _RO-Crate Metadata File Description_, so the _Root Data Entity_ license [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0) would apply to RO-Crate JSON-LD statements, except for the statements on the imported <http://sws.geonames.org/8152662/>,  which metadata is re-distributed under license <https://creativecommons.org/licenses/by/4.0/>. 

In this example the CC-BY license requires retaining "a notice that refers to this Public License" and "identification of the creator(s) of the Licensed Material", here respected using `sdLicense` and `sdPublisher`.  

As the RO-Crate uses _flattened_ JSON-LD, `sdLicense` should be expressed directly on each data/contextual entities where required. 

**Tip**: If metadata is imported from a source licensed as [CC0 Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/), no `sdLicense` statement is required.

-->


## Extra metadata such as Exif

Schema.org has a generic extension mechanism for encoding arbitrary properties and values which are not available as Schema.org properties. An example of of this is the Schema.org [recommended way (see example 2)](http://schema.org/ImageObject) of including [Exif](https://en.wikipedia.org/wiki/Exif) technical image metadata.

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


## Places

To associate a [Data Entity](data-entities.md) with a _Contextual Entity_ representing a _geographical location or region_ the entity SHOULD have a property of [contentLocation] with a value of type [Place].

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

**Tip**: To find the `@id` and `identifier` corresponding to a GeoNames HTML page like <https://www.geonames.org/8152662/catalina-park.html> click its `.rdf` button to find the identifier <http://sws.geonames.org/8152662/> referred from <https://sws.geonames.org/8152662/about.rdf>:

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

## Subjects & keywords

Subject properties (equivalent to a Dublin Core Subject) on the [root data entity](root-data-entity.md) or a [data entity](data-entities.md) MUST use the [about] property.

Keyword properties MUST use [keywords]. Note that by schema.org convention, keywords are given as a single JSON string, with individual keywords separated by commas.

```json
{
  "keywords": "Gibraltar, Spain, British Overseas Territory, city, map",
  "about": { "@id": "http://dbpedia.org/resource/Gibraltar" },
}
```

## Time

To describe the _time period_ which a RO-Crate [Data Entity](date-entities.md) (or the [root data entity](root-data-entity.md)) is _about_, use [temporalCoverage]:

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

A [File] or any other item MAY have a [thumbnail] property which references another file.

For example, the below [RepositoryObject](https://pcdm.org/2016/04/18/models#Object) is related to four files which are all versions of the same image (via [hasFile](https://pcdm.org/2016/04/18/models#hasFile)) one of which is a thumbnail. The thumbnail MUST be included in the RO-Crate.

If [thumbnail]s are incidental to the data set, they need not be referenced by [hasPart](http://schema.org/hasPart) or [hasFile](https://pcdm.org/2016/04/18/models#hasFile) relationships. but must be in the BagIt manifest if in a _Bagged RO-Crate_.


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
[OCFL Object]: https://ocfl.io/1.0/spec/#object-spec
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
[additionalType]: http://schema.org/additionalType
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
[creator]: http://schema.org/creator
[dateCreated]: http://schema.org/dateCreated
[datePublished]: http://schema.org/datePublished
[defaultValue]: http://schema.org/defaultValue
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
[valueRequired]: http://schema.org/valueRequired
[version]: http://schema.org/version

[RFC 2119]: https://tools.ietf.org/html/rfc2119
[RFC 3986]: https://tools.ietf.org/html/rfc3986
[RFC 6838]: https://tools.ietf.org/html/rfc6838
[RFC 7159]: https://tools.ietf.org/html/rfc7159
[RFC 8493]: https://tools.ietf.org/html/rfc8493
