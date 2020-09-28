---
layout: default
title: Handling relative URI references
excerpt: |
  ..
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

# APPENDIX: Handling relative URI references

The _RO-Crate Metadata File_ use _relative URI references_ to identify files and directories
contained within the _RO-Crate Root_ and its children.  As described in section
[Describing entities in JSON-LD](#describing-entities-in-json-ld) above, 
relative URI references are also frequently used for 
identifying _Contextual entities_.

When using JSON-LD tooling and RDF libraries to consume or generate RO-Crates, 
extra care should be taken to ensure these URI references are handled correctly.

For this, a couple of scenarios are sketched below with recommendations for
consistent handling:

## Flattening JSON-LD from nested JSON

If performing
[JSON-LD flattening](https://www.w3.org/TR/json-ld-api/#flattening-algorithm) to generate a valid _RO-Crate Metadata File_ , add `@base: null` to the input JSON-LD `@context` array to avoid expanding relative URI references. The flattening `@context` SHOULD NOT need `@base: null`.

Example, this JSON-LD is in [compacted form](https://www.w3.org/TR/json-ld11/#compacted-document-form) which may be beneficial for processing, but is not yet valid _RO-Crate Metadata File_ as it has not been flattened into a `@graph` array.

```json
{ 
  "@context": [
    {"@base": null},
    "https://w3id.org/ro/crate/1.1-DRAFT/context"
  ],
  "@id": "ro-crate-metadata.json",
  "@type": "CreativeWork",
  "description": "RO-Crate Metadata File Descriptor (this file)",
  "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
  "about": {
    "@id": "./",
    "@type": "Dataset",
    "name": "Example RO-Crate",
    "description": "The RO-Crate Root Data Entity",
    "hasPart": [
      { "@id": "data1.txt",
        "@type": "File",
        "description": "One of hopefully many Data Entities",
      },
      { "@id": "subfolder/",
        "@type": "Dataset"
      }
    ]
  }
}
```

Performing [JSON-LD flattening](https://www.w3.org/TR/json-ld-api/#flattening-algorithm) with:

```json
{ "@context": 
     "https://w3id.org/ro/crate/1.1-DRAFT/context"
}
```

Results in a valid _RO-Crate JSON-LD_ (actual order in `@graph` may differ):

```json
{
  "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "./"
      },
      "description": "RO-Crate Metadata File Descriptor (this file)"
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {
          "@id": "data1.txt"
        },
        {
          "@id": "subfolder/"
        }
      ],
      "name": "Example RO-Crate"
    },
    {
      "@id": "data1.txt",
      "@type": "File",
      "description": "One of hopefully many Data Entities"
    },
    {
      "@id": "subfolder/",
      "@type": "Dataset"
    }
  ]
}
```

```note
The saved _RO-Crate JSON-LD_ SHOULD NOT include `{@base: null}` in its `@context`.
```


## Expanding/parsing JSON-LD keeping relative referencing

[JSON-LD Expansion](https://www.w3.org/TR/json-ld-api/#expansion) can be used to 
resolve terms from the `@context` to absolute URIs, e.g. `http://schema.org/description`. This may be needed to parse [extended properties](#extending-ro-crate) or for combinations with other Linked Data.

This algorithm would normally also expand `@id` fields based on the current [base URI](https://www.w3.org/TR/json-ld11/#base-iri) of the _RO-Crate Metadata File_, but this may be a temporary location like `file:///tmp/rocrate54/ro-crate-metadata.json`, meaning `@id`: `subfolder/` becomes `file:///tmp/rocrate54/subfolder/` after JSON-LD expansion.

To avoid absoluting local identifiers, before expanding, augment the JSON-LD `@context` to ensure it is an array that includes `{"@base": null}`.

For example, expanding this JSON-LD:

```json
{
  "@context": [
    "https://w3id.org/ro/crate/1.1-DRAFT/context",
    {"@base": null}
  ]
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "./"
      },
      "description": "RO-Crate Metadata File Descriptor (this file)"
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {
          "@id": "data1.txt"
        },
        {
          "@id": "subfolder/"
        }
      ],
      "name": "Example RO-Crate"
    }
  ]
}
```

Results in a [expanded form](https://www.w3.org/TR/json-ld11/#expanded-document-form) without `@context`, using absolute URIs for properties and types, but retains relative URI references for entities within the _RO-Crate Root_:

```json
[
  {
    "@id": "ro-crate-metadata.json",
    "@type": [
      "http://schema.org/CreativeWork"
    ],
    "http://schema.org/about": [
      {
        "@id": "./"
      }
    ],
    "http://purl.org/dc/terms/conformsTo": [
      {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      }
    ],
    "http://schema.org/description": [
      {
        "@value": "RO-Crate Metadata File Descriptor (this file)"
      }
    ]
  },
  {
    "@id": "./",
    "@type": [
      "http://schema.org/Dataset"
    ],
    "http://schema.org/description": [
      {
        "@value": "The RO-Crate Root Data Entity"
      }
    ],
    "http://schema.org/hasPart": [
      {
        "@id": "data1.txt"
      },
      {
        "@id": "subfolder/"
      }
    ],
    "http://schema.org/name": [
      {
        "@value": "Example RO-Crate"
      }
    ]
  }
]
```

```note
Note that `@base: null` will not relativize existing absolute URIs that happen to be contained by the _RO-Crate Root_ (see section [Relativizing absolute URIs within RO-Crate Root](#relativizing-absolute-uris-within-ro-crate-root)).
```

```tip
Most RDF parsers supporting JSON-LD will perform this kind of expansion before generating triples, but not all RDF stores or serializations support relative URI references. Consider using an alternative `@base` as detailed in sections below.
```

## Establishing absolute URI for RO-Crate Root

When loading _RO-Crate JSON-LD_ as RDF, or combining the crate's Linked Data into a larger JSON-LD, it is important to ensure correct
[base URI](https://www.w3.org/TR/2014/REC-json-ld-20140116/#base-iri)
to resolve URI references that are relative to the _RO-Crate Root_.

```note
Note that when retrieving an RO-Crate over the web, servers might have performed HTTP redirections so that the base URI is different from what was requested. It is RECOMMENDED to follow section [Establishing a Base URI of RFC3986](http://tools.ietf.org/html/rfc3986#section-5.1) before resolving relative links from the _RO-Crate Metadata File_.
```

For instance, consider this HTTP redirection from a permalink (simplified):

```http
GET https://w3id.org/ro/crate/1.0/crate HTTP/1.1

HTTP/1.1 301 Moved Permanently
Location: https://www.researchobject.org/ro-crate/1.0/ro-crate-metadata.jsonld
```

```http
GET https://www.researchobject.org/ro-crate/1.0/ro-crate-metadata.jsonld HTTP/1.1

HTTP/1.1 200 OK
Content-Type: application/ld+json

{
    "@context": "https://w3id.org/ro/crate/1.0/context",
    "@graph": [
      {
        "@id": "ro-crate-metadata.jsonld",
        "@type": "CreativeWork",
        "conformsTo": {
          "@id": "https://w3id.org/ro/crate/1.0"
        },
        "about": {
          "@id": "./"
        },
        "license": {
          "@id": "https://creativecommons.org/publicdomain/zero/1.0/"
        }
      },
      {
        "@id": "./",
        "@type": "Dataset",
        "hasPart": [
          {
            "@id": "index.html"
          }
      }
    ]
}
```

Following redirection we see that the _base URI_ of the _RO-Crate Metadata File_ becomes `https://www.researchobject.org/ro-crate/1.0/ro-crate-metadata.jsonld`, and therefore the absolute URI for `index.html` is `https://www.researchobject.org/ro-crate/1.0/index.html` rather than `https://w3id.org/ro/crate/1.0/index.html` which would not redirect correctly.

This example also use RO-Crate 1.0, where the _RO-Crate Metadata File_ is called `ro-crate-metadata.jsonld` instead of `ro-crate-metadata.json`. Note that the recommended
[algorithm to find the Root Data Entity](#core-metadata-for-the-root-data-entity)
is agnostic to the actual filename.

## Finding RO-Crate Root in RDF triple stores

When parsing _RO-Crate JSON-LD_ as RDF, where the RDF framework performs resolution to absolute URIs, it may be difficult to find the _RO-Crate Root_ in the parsed triples.

The algoritm proposed in section [Core Metadata for the Root Data Entity](#core-metadata-for-the-root-data-entity) allows finding the RDF resource describing `ro-crate-metadata.json`, independent of its parsed base URI. We can adopt this for RDF triples, thus finding crates conforming to this specification can be queried with [SPARQL](https://www.w3.org/TR/sparql11-query/):

```sparql
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX schema:  <http://schema.org/>

SELECT ?crate ?metadatafile
WHERE {
  ?crate        a                  schema:Dataset .
  ?metadatafile schema:about       ?crate .
  ?metadatafile dcterms:conformsTo <https://w3id.org/ro/crate/1.1-DRAFT> .
}
```

..or (less efficient) for any RO-Crate version:

```sparql
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX schema:  <http://schema.org/>

SELECT ?crate ?metadatafile ?spec
WHERE {
  ?crate        a                  schema:Dataset .
  ?metadatafile schema:about       ?crate .
  ?metadatafile dcterms:conformsTo ?spec .

  FILTER STRSTARTS(str(?spec), "https://w3id.org/ro/crate/")
}
```


## Parsing as RDF with a different RO-Crate Root

When parsing a _RO-Crate Metadata File_ into [RDF triples](https://www.w3.org/TR/rdf11-concepts/), for instance uploading it to a _graph store_ like [Apache Jena](https://jena.apache.org/)'s [Fuseki](https://jena.apache.org/documentation/fuseki2/), it is important to ensure consistent _base URI_:

* Some RDF stores and RDF formats don't support relative URI references in triples (see [RDF 1.1 concepts](https://www.w3.org/TR/rdf11-concepts/#note-iris))
* The _RO-Crate Root_ may depend on where the _RO-Crate Metadata File_ was parsed from, e.g. `<file:///tmp/ro-crate-metadata.json>` (file) or `<http://localhost:3030/test/ro-crate-metadata.json>` (web upload)
* Parsing multiple RO-Crates into the same RDF graph, using same base URI, may merge them into the same RO-Crate
* `ro-crate-metadata.json` may not be recognized as JSON-LD and must be renamed to `ro-crate-metadata.jsonld`
* Web servers hosting `ro-crate-metadata.json` may not send the [JSON-LD _Content-Type_](#ro-crate-json-ld-media-type)
* If base URI is not correct it may be difficult to find the corresponding file and directory paths from an RDF query returning absolute URIs

```tip
If the RDF library can parse the _RO-Crate JSON-LD_ directly by retrieving from a `http`/`https` URI of the _RO-Crate Metadata File_ it should calculate the correct base URI as detailed in section [Establishing absolute URI for RO-Crate Root](#establishing-absolute-uri-for-ro-crate-root) and you should **not** need to override the base URI as detailed here.
```

If a web-based URI for the _RO-Crate root_ is known, then this can be supplied as a _base URI_. Most RDF tools support a `--base` option or similar. If this is not possible, then the `@context` of the `RO-Crate JSON-LD` can be modified by ensuring the `@context` is an array that sets the desired `@base`:

```json
{
  "@context": [
    "https://w3id.org/ro/crate/1.1-DRAFT/context",
    {"@base": "http://example.com/crate255/"}
  ],
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "./"
      }
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "name": "Example RO-Crate"
    },
    {
      "@id": "data1.txt",
      "@type": "File",
      "description": "One of hopefully many Data Entities"
    },
    {
      "@id": "subfolder/",
      "@type": "Dataset"
    }
  ]
}
```

Parsing this will generate triples like below using `http://example.com/crate255/` as the _RO-Crate Root_ (shortened):

```
<http://example.com/crate255/ro-crate-metadata.json> <http://purl.org/dc/terms/conformsTo> <https://w3id.org/ro/crate/1.1-DRAFT> .

<http://example.com/crate255/ro-crate-metadata.json> <http://schema.org/about> <http://example.com/crate255/> .

<http://example.com/crate255/> <http://schema.org/name> "Example RO-Crate" .

<http://example.com/crate255/> <http://schema.org/hasPart> <http://example.com/crate255/data1.txt> .

<http://example.com/crate255/> <http://schema.org/hasPart> <http://example.com/crate255/subfolder/> .

<http://example.com/crate255/data1.txt> <http://schema.org/description> "One of hopefully many Data Entities" .

```

Generating a _RO-Crate JSON-LD_ from such triples can be done by first [finding the RO-Crate Root](#finding-ro-crate-root-in-rdf-triple-stores) and then use it as base URI to [relativize absolute URIs within RO-Crate Root](#relativizing-absolute-uris-within-ro-crate-root).


## Establishing a base URI inside a ZIP file

An RO-Crate may have been packaged as a ZIP file or similar archive. RO-Crates may exist in a temporary file path which should not determine its identifiers.

When parsing such crates it is recommended to use the
[Archive and Package (arcp) URI scheme](https://tools.ietf.org/id/draft-soilandreyes-arcp-03.html)
to establish a temporary/location-based UUID or hash-based (SHA256) _base URI_. 

For instance, given a randomly generated UUID `029bcde1-dfa3-43cf-b7d9-a4fb75ccd4eb` we can use `arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/` as the `@base`:


```json
{
  "@context": [
    "https://w3id.org/ro/crate/1.1-DRAFT/context",
    {"@base": "arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/"}
  ],
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "./"
      }
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {
          "@id": "data1.txt"
        },
        {
          "@id": "subfolder/"
        }
      ],
      "name": "Example RO-Crate"
    },
    {
      "@id": "data1.txt",
      "@type": "File",
      "description": "One of hopefully many Data Entities"
    },
    {
      "@id": "subfolder/",
      "@type": "Dataset"
    }
  ]
}
```

Parsing this as RDF will generate triples including:

```turtle
<arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/ro-crate-metadata.json> <http://schema.org/about> <arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/> .

<arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/> <http://schema.org/hasPart> <arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/data1.txt> .
```

Here consumers can assume `/` is the _RO-Crate Root_ and generating relative URIs can safely be achieved by  search-replace as the arcp URI is unique. Saving _RO-Crate JSON-LD_ from the triples can be done by using the arcp URI to [relativize absolute URIs within RO-Crate Root](#relativizing-absolute-uris-within-ro-crate-root).

```tip
**Bagit**: The arcp specification suggests how [BagIt identifiers](https://tools.ietf.org/html/draft-soilandreyes-arcp-03#appendix-A.4) can be used to calculate the base URI. See also section [Combining with other packaging schemes](#combining-with-other-packaging-schemes) - note that in this approach the _RO-Crate Root_ will be the payload folder `/data/` under the calculated arcp base URI.
```

## Relativizing absolute URIs within RO-Crate Root

Some applications may prefer working with absolute URIs, e.g. in a joint graph store or web-based repository, but should relativize URIs within the _RO-Crate Root_ before generating the _RO-Crate Metadata File_.

Assuming a repository at `example.com` has JSON-LD with absolute URIs:

```json
{
  "@context": "https://w3id.org/ro/crate/1.1-DRAFT",
  "@graph": [
    {
      "@id": "http://example.com/crate415/ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "http://example.com/crate415/"
      },
    },
    {
      "@id": "http://example.com/crate415/",
      "@type": "Dataset",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {
          "@id": "http://example.com/crate415/data1.txt"
        },
        {
          "@id": "http://example.com/crate415/subfolder/"
        }
      ],
      "name": "Example RO-Crate"
    }
  ]
}
```

Then performing [JSON-LD flattening](https://www.w3.org/TR/json-ld-api/#flattening-algorithm)
with this `@context`:

```json
{ "@context": [
    {"@base": "http://example.com/crate415/"},
     "https://w3id.org/ro/crate/1.1-DRAFT"
  ]
}
```

Will output _RO-Crate JSON-LD_ with relative URIs:

```json
{
  "@context": [
    {
      "@base": "http://example.com/crate415/"
    },
    "https://w3id.org/ro/crate/1.1-DRAFT"
  ],
  "@graph": [
    {
      "@id": "./",
      "@type": "Dataset",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {
          "@id": "data1.txt"
        },
        {
          "@id": "subfolder/"
        }
      ],
      "name": "Example RO-Crate"
    },
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.1-DRAFT"
      },
      "about": {
        "@id": "./"
      }
    }
  ]
}
```

```warning
This method would also relativize URIs outside the _RO-Crate Root_ that are on the same host, e.g. `http://example.com/crate255/other.txt` would become `../create255/other.txt` - this can particularly be a challenge with local `file:///` URIs. 
````



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
