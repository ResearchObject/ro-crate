---
title: Handling relative URI references
parent: Appendix
grand_parent: RO-Crate 1.2-DRAFT
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

<div id="relative-uris"></div>

# APPENDIX: Handling relative URI references
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

In an _Attached RO-Crate_, the _RO-Crate Metadata File_ use _relative URI references_ 
to identify files and directories
contained within the _RO-Crate Root_ and its children.  As described in section
[Describing entities in JSON-LD](jsonld.md#describing-entities-in-json-ld), 
relative URI references are also frequently used for 
identifying _Contextual entities_.

## Converting from Attached to Detached RO-Crate

An [Attached RO-Crate](../structure.md#attached-ro-crate) can be published on the Web by placing its _RO-Crate Root_ directory on a static file-based Web server (e.g. Nginx, Apache HTTPd, GitHub Pages). The use of relative URI references in the _RO-Crate Metadata File_ ensures identifiers of [data entities](../data-entities.md) work as they should.

Sometimes it is desired to make a [Detached RO-Crate](../structure.md#detached-ro-crate), e.g. for depositing or integrating the RO-Crate Metadata File into a knowledge graph or repository that is unable to preserve data files using their existing pathnames. In this case one needs to:

1. Decide on new Web locations for individual data files and update their absolute URI in `@id`
2. Observe the preservation considerations for [Web-based Data Entities](data-entities.md#web-based-data-entities)
3. Ensure all nested directories not browsable on the Web are represented as `Dataset` with its content listed with `hasPart` or `distribution` (see section [Directories on the web](../data-entities.md#Directories on the web; dataset distributions)). Change their relative `@id` to become absolute, e.g. using [ARCP](#establishing-a-base-uri-inside-a-zip-file).
4. Rewrite the JSON-LD with absolute URIs for data entities

If the RO-Crate is already published on the Web, with directory browsing enabled for nested directories, then these steps can be achieved using JSON-LD tooling.

For example, as the RO-Crate Metadata file <https://about.workflowhub.eu/Workflow-RO-Crate/1.0/ro-crate-metadata.json> along with the RO-Crate Root is published on the Web (using GitHub Pages), we can generate a random UUID (e.g. `d6be5c9b-132a-4a93-9837-3e02e06c08e6`) and use [JSON-LD flattening] 
from this context:

```json
{ "@context": [
   {"@base": "https://about.workflowhub.eu/Workflow-RO-Crate/1.0/ro-crate-metadata.json"},
   "https://w3id.org/ro/crate/1.1/context"
  ]
}

```

to this context:

```json
{ "@context": [
   {"@base": "arcp://uuid,d6be5c9b-132a-4a93-9837-3e02e06c08e6/"},
   "https://w3id.org/ro/crate/1.1/context"
  ]  
}
```

None of the existing resources will have a `@id` starting with this fresh base URI, therefore all URIs will be made absolute. The resulting `{@base: ..}` is harmless, but can be removed from the output JSON-LD.

Example output (abbreviated):

```json
{
  "@context": [
    {"@base": "arcp://uuid,d6be5c9b-132a-4a93-9837-3e02e06c08e6/"},
    "https://w3id.org/ro/crate/1.1/context"
  ],
  "@graph": [
    {
      "@id": "https://about.workflowhub.eu/Workflow-RO-Crate/1.0/ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1"},
      "about": {"@id": "https://about.workflowhub.eu/Workflow-RO-Crate/1.0/"},
      "creator": {"@id": "https://orcid.org/0000-0001-9842-9718"}
    },
    {
      "@id": "https://about.workflowhub.eu/Workflow-RO-Crate/1.0/",
      "@type": "Dataset",
      "hasPart": [
        { "@id": "https://about.workflowhub.eu/Workflow-RO-Crate/1.0/index.html"},
        { "@id": "https://about.workflowhub.eu/Workflow-RO-Crate/1.0/example/"},
      ],
      "name": "Workflow RO-Crate profile"
    }
```

Notice how identifiers like `ro-crate-metadata.json`, `./`, `index.html` and `example/` have been translated to absolute URIs.

The above JSON-LD processing will also expand any `#`-based local identifiers of contextual entities:

```json
  {
      "@id": "https://about.workflowhub.eu/Workflow-RO-Crate/1.0/ro-crate-metadata.json#include-ComputationalWorkflow",
      "@type": "Recommendation",
      "category": "MUST",
      "name": "Include Main Workflow",
      "itemReviewed": {
        "@id": "https://bioschemas.org/ComputationalWorkflow"
      }
    }
```

In this approach, the Detached RO-Crate can be resolved to the corresponding Attached RO-Crate by following the `@id` of the Root Data Set or the Root Metadata File entity.

If the new Detached RO-Crate is not meant as a snapshot of the corresponding Attached RO-Crate, then such contextual entities should be assigned new `@id`, e.g. by generating random UUIDs like `urn:uuid:e47e41d9-f924-4c07-bc90-97e7ed34fe35`. Such tranformations are typically not catered for by traditional JSON-LD tooling and require additional implementation.


## Converting from Detached to Attached RO-Crate

_TODO_


## Handling relative URI references when using JSON-LD/RDF tools

When using JSON-LD tooling and RDF libraries to consume or generate RO-Crates, 
extra care should be taken to ensure these URI references are handled correctly.

For this, a couple of scenarios are sketched below with recommendations for
consistent handling:

## Flattening JSON-LD from nested JSON

If performing [JSON-LD flattening] to generate a valid _RO-Crate Metadata File_ for a _Attached RO-Crate_, add `@base: null` to the input JSON-LD `@context` array to avoid expanding relative URI references. The flattening `@context` SHOULD NOT need `@base: null`.

Example, this JSON-LD is in [compacted form][compacted] which may be beneficial for processing, but is not yet valid _RO-Crate Metadata File_ as it has not been flattened into a `@graph` array.

```json
{ 
  "@context": [
      "https://w3id.org/ro/crate/1.2-DRAFT/context"
  ],
  "@id": "ro-crate-metadata.json",
  "@type": "CreativeWork",
  "description": "RO-Crate Metadata Descriptor (this file)",
  "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"},
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

Performing [JSON-LD flattening] with:

```json
{ "@context": 
     "https://w3id.org/ro/crate/1.2-DRAFT/context"
}
```

Results in a valid _RO-Crate JSON-LD_ (actual order in `@graph` may differ):

```json
{
  "@context": "https://w3id.org/ro/crate/1.2-DRAFT/context",
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.2-DRAFT"
      },
      "about": {
        "@id": "./"
      },
      "description": "RO-Crate Metadata Descriptor (this file)"
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

{: .note }
> The saved _RO-Crate JSON-LD_ SHOULD NOT include `{@base: null}` in its `@context`.


## Expanding/parsing JSON-LD keeping relative referencing

[JSON-LD Expansion] can be used to 
resolve terms from the `@context` to absolute URIs, e.g. `http://schema.org/description`. This may be needed to parse [extended properties](#extending-ro-crate) or for combinations with other Linked Data.

This algorithm would normally also expand `@id` fields based on the current [base URI][JSON-LD base URI] of the _RO-Crate Metadata File_, but this may be a temporary location like `file:///tmp/rocrate54/ro-crate-metadata.json`, meaning `@id`: `subfolder/` becomes `file:///tmp/rocrate54/subfolder/` after JSON-LD expansion.

To avoid absoluting local identifiers, before expanding, augment the JSON-LD `@context` to ensure it is an array that includes `{"@base": null}`.

For example, expanding this JSON-LD:

```json
{
  "@context": [
    "https://w3id.org/ro/crate/1.2-DRAFT/context",
    {"@base": null}
  ],
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.2-DRAFT"
      },
      "about": {
        "@id": "./"
      },
      "description": "RO-Crate Metadata Descriptor (this file)"
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

Results in a [expanded form][JSON-LD expanded form] without `@context`, using absolute URIs for properties and types, but retains relative URI references for entities within the _RO-Crate Root_:

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
        "@id": "https://w3id.org/ro/crate/1.2-DRAFT"
      }
    ],
    "http://schema.org/description": [
      {
        "@value": "RO-Crate Metadata Descriptor (this file)"
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

{: .note }
> `@base: null` will not relativize existing absolute URIs that happen to be contained by the _RO-Crate Root_ (see section [Relativizing absolute URIs within RO-Crate Root](#relativizing-absolute-uris-within-ro-crate-root)).

{: .tip }
> Most RDF parsers supporting JSON-LD will perform this kind of expansion before generating triples, but not all RDF stores or serializations support relative URI references. Consider using an alternative `@base` as detailed in sections below.

## Establishing absolute URI for RO-Crate Root

When loading _RO-Crate JSON-LD_ as RDF, or combining the crate's Linked Data into a larger JSON-LD, it is important to ensure correct
[base URI][JSON-LD base URI]
to resolve URI references that are relative to the _RO-Crate Root_.

{: .note }
> When retrieving an RO-Crate over the web, servers might have performed HTTP redirections so that the base URI is different from what was requested. It is RECOMMENDED to follow section [Establishing a Base URI of RFC3986](http://tools.ietf.org/html/rfc3986#section-5.1) before resolving relative links from the _RO-Crate Metadata File_.

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

Following redirection we see that:

* _Base URI_ of the _RO-Crate Metadata File_ becomes `https://www.researchobject.org/ro-crate/1.0/ro-crate-metadata.jsonld`
* The absolute URI for `index.html` resolves to `https://www.researchobject.org/ro-crate/1.0/index.html` 
  - ..rather than `https://w3id.org/ro/crate/1.0/index.html` which would not redirect correctly

This example also use RO-Crate 1.0, where the _RO-Crate Metadata File_ is called `ro-crate-metadata.jsonld` instead of `ro-crate-metadata.json`. Note that the recommended
[algorithm to find the Root Data Entity](../root-data-entity.md#finding-the-root-data-entity)
is agnostic to the actual filename.

## Finding RO-Crate Root in RDF triple stores

When parsing _RO-Crate JSON-LD_ as RDF, where the RDF framework performs resolution to absolute URIs, it may be difficult to find the _RO-Crate Root_ in the parsed triples.

The algoritm proposed in section [Root Data Entity](../root-data-entity.md#finding-the-root-data-entity) allows finding the RDF resource describing `ro-crate-metadata.json`, independent of its parsed base URI. We can adopt this for RDF triples, thus finding crates conforming to this specification can be queried with [SPARQL]:

```sparql
PREFIX schema:  <http://schema.org/>

SELECT ?crate ?metadatafile
WHERE {
  ?crate        a                  schema:Dataset .
  ?metadatafile schema:about       ?crate .
  filter(contains(str(?metadatafile), "ro-crate-metadata.json"))
}
```


## Parsing as RDF with a different RO-Crate Root

When parsing a _RO-Crate Metadata File_ into [RDF triples], for instance uploading it to a _graph store_ like [Apache Jena]'s [Fuseki], it is important to ensure consistent _base URI_:

* Some RDF stores and RDF formats don't support relative URI references in triples (see [RDF 1.1 note on IRIs])
* The _RO-Crate Root_ may depend on where the _RO-Crate Metadata File_ was parsed from, e.g. `<file:///tmp/ro-crate-metadata.json>` (file) or `<http://localhost:3030/test/ro-crate-metadata.json>` (web upload)
* Parsing multiple RO-Crates into the same RDF graph, using same base URI, may merge them into the same RO-Crate
* `ro-crate-metadata.json` may not be recognized as JSON-LD and must be renamed to `ro-crate-metadata.jsonld`
* Web servers hosting `ro-crate-metadata.json` may not send the [JSON-LD _Content-Type_](#ro-crate-json-ld-media-type)
* If base URI is not correct it may be difficult to find the corresponding file and directory paths from an RDF query returning absolute URIs

{: .tip }
> If the RDF library can parse the _RO-Crate JSON-LD_ directly by retrieving from a `http`/`https` URI of the _RO-Crate Metadata File_ it should calculate the correct base URI as detailed in section [Establishing absolute URI for RO-Crate Root](#establishing-absolute-uri-for-ro-crate-root) and you should **not** need to override the base URI as detailed here.

If a web-based URI for the _RO-Crate root_ is known, then this can be supplied as a _base URI_. Most RDF tools support a `--base` option or similar. If this is not possible, then the `@context` of the `RO-Crate JSON-LD` can be modified by ensuring the `@context` is an array that sets the desired `@base`:

```json
{
  "@context": [
    "https://w3id.org/ro/crate/1.2-DRAFT/context",
    {"@base": "http://example.com/crate255/"}
  ],
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.2-DRAFT"
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

```turtle
<http://example.com/crate255/ro-crate-metadata.json> 
  <http://purl.org/dc/terms/conformsTo> 
  <https://w3id.org/ro/crate/1.2-DRAFT> .

<http://example.com/crate255/ro-crate-metadata.json> 
  <http://schema.org/about> 
  <http://example.com/crate255/> .

<http://example.com/crate255/> 
  <http://schema.org/name> 
  "Example RO-Crate" .

<http://example.com/crate255/>
  <http://schema.org/hasPart>
  <http://example.com/crate255/data1.txt> .

<http://example.com/crate255/>
  <http://schema.org/hasPart>
  <http://example.com/crate255/subfolder/> .

<http://example.com/crate255/data1.txt>
 <http://schema.org/description> 
 "One of hopefully many Data Entities" .
```

Generating a _RO-Crate JSON-LD_ from such triples can be done by first [finding the RO-Crate Root](#finding-ro-crate-root-in-rdf-triple-stores) and then use it as base URI to [relativize absolute URIs within RO-Crate Root](#relativizing-absolute-uris-within-ro-crate-root).


## Establishing a base URI inside a ZIP file

An RO-Crate may have been packaged as a ZIP file or similar archive. RO-Crates may exist in a temporary file path which should not determine its identifiers.

When parsing such crates it is recommended to use the
[Archive and Package (arcp) URI scheme][ARCP]
to establish a temporary/location-based UUID or hash-based (SHA256) _base URI_. 

For instance, given a randomly generated UUID `b7749d0b-0e47-5fc4-999d-f154abe68065` we can use `arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/` as the `@base`:


```json
{
  "@context": [
    "https://w3id.org/ro/crate/1.2-DRAFT/context",
    {"@base": "arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/"}
  ],
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.2-DRAFT"
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
<arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/ro-crate-metadata.json> 
  <http://schema.org/about> 
  <arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/> .

<arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/> 
  <http://schema.org/hasPart> 
  <arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/data1.txt> .
```

Here consumers can assume `/` is the _RO-Crate Root_ and generating relative URIs can safely be achieved by  search-replace as the arcp URI is unique. Saving _RO-Crate JSON-LD_ from the triples can be done by using the arcp URI to [relativize absolute URIs within RO-Crate Root](#relativizing-absolute-uris-within-ro-crate-root).

{: .tip }
> **Bagit**: The arcp specification suggests how [BagIt identifiers][ARCP BagIt] can be used to calculate the base URI. See also section [Combining with other packaging schemes](#combining-with-other-packaging-schemes) - note that in this approach the _RO-Crate Root_ will be the payload folder `/data/` under the calculated arcp base URI.

## Relativizing absolute URIs within RO-Crate Root

Some applications may prefer working with absolute URIs, e.g. in a joint graph store or web-based repository, but should relativize URIs within the _RO-Crate Root_ before generating the _RO-Crate Metadata File_.

Assuming a repository at `example.com` has JSON-LD with absolute URIs:

```json
{
  "@context": "https://w3id.org/ro/crate/1.2-DRAFT",
  "@graph": [
    {
      "@id": "http://example.com/crate415/ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.2-DRAFT"
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

Then performing [JSON-LD flattening] with this `@context`:

```json
{ "@context": [
    {"@base": "http://example.com/crate415/"},
     "https://w3id.org/ro/crate/1.2-DRAFT"
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
    "https://w3id.org/ro/crate/1.2-DRAFT"
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
        "@id": "https://w3id.org/ro/crate/1.2-DRAFT"
      },
      "about": {
        "@id": "./"
      }
    }
  ]
}
```

{: .warning }
> This method would also relativize URIs outside the _RO-Crate Root_ that are on the same host, e.g. `http://example.com/crate255/other.txt` would become `../create255/other.txt` - this can particularly be a challenge with local `file:///` URIs. `

{% include references.liquid %}
