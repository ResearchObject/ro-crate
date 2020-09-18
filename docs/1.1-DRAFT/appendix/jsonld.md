---
layout: default
title: Appendix: RO-Crate JSON-LD
excerpt: 
sort: 5
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

# APPENDIX: RO-Crate JSON-LD

It is not necessary to use [JSON-LD tooling](https://json-ld.org/#developers) to generate or parse the _RO-Crate Metadata File_, although they may make it easier to conform to this specification, e.g. handling relative URIs. It is RECOMMENDED to use [JSON tooling](http://json.org/) to handle [JSON](https://tools.ietf.org/html/rfc7159) syntax and escaping rules.

This appendix shows a brief JSON-LD introduction for complying with the _RO-Crate Metadata File_ requirements.

The below example shows the overall structure of a flattened, compacted _RO-Crate Metadata File_ where `@context` refers to the _RO-Crate JSON-LD Context_, while `@graph` is a flat list of the entities that constitute this RO-Crate. 

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [

    {
      "@type": "CreativeWork",
      "@id": "ro-crate-metadata.json",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
      "about": {"@id": "./"},
      "description": "RO-Crate Metadata File Descriptor (this file)"
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "name": "Example RO-Crate",
      "description": "The RO-Crate Root Data Entity",
      "hasPart": [
        {"@id": "data1.txt"},
        {"@id": "data2.txt"}
      ]
    },


    {
      "@id": "data1.txt",
      "@type": "File",
      "description": "One of hopefully many Data Entities",
      "author": {"@id": "#alice"},
      "contentLocation":  {"@id": "http://sws.geonames.org/8152662/"}
    },
    {
      "@id": "data2.txt",
      "@type": "File"
    },

    {
      "@id": "#alice",
      "@type": "Person",
      "name": "Alice",
      "description": "One of hopefully many Contextual Entities"
    },
    {
      "@id": "http://sws.geonames.org/8152662/",
      "@type": "Place",
      "name": "Catalina Park"
    }
 ]
}
```

**Note**: entities above have been shortened for brevity, see their individual sections elsewhere in this specification.

The order of the `@graph` list is not significant. Above we see that the RO-Crate JSON-LD graph contain the _RO-Crate Metadata File Descriptor_, the _Root Data Entity_, any _Data Entities_ and any _Contextual Entities_.


### Describing entities in JSON-LD

Properties of an entity can refer to another URL or entity by using the form `{"@id": "uri-reference"}` as in the example above, where the [author] property in the [File] entity refer to the [Person] entity, identified as `#alice`. 

Identifiers in `@id` SHOULD be either a valid _absolute URIs_ like <http://example.com/>, or an _URI references_ _URI paths_ relative to the RO-Crate root directory. Care must be taken to express any relative paths using `/` separator and escape special characters like space (`%20`). As JSON-LD supports _IRIs_, international characters in identifiers SHOULD be encoded in UTF-8 rather than `%`-escaped.

Because the _RO-Crate JSON-LD_ is _flattened_, all described entities must be direct children of the `@graph` element rather than being nested under another property or list.

If no obvious identifier is available for a contextual entity, an identifier local to the _RO-Crate Metadata File_ can be generated, for instance `{"@id": "#alice"}` or `{"@id": "#ac0bd781-7d91-4cdf-b2ad-7305921c7650"}`. Although it is RECOMMENDED to use `#`-based local identifiers, identifiers in `@id` MAY alternatively be a _blank node_ identifier (e.g. `_:alice`).

Multiple values and references can be represented using JSON arrays, as exemplified in `hasPart` above, however as the `RO-Crate JSON-LD` is in _compacted form_ any single-element arrays like `"author": [{"@id": "#alice"}]` SHOULD be unpacked to a single value like `"author": {"@id": "#alice"}`.


### RO-Crate JSON-LD Context

The main purpose of the `@context` is to relate JSON property keys and `@type` references to their Linked Data identifiers, which in RO-Crate is based primarily on <http://schema.org/> URIs.

In other uses of JSON-LD the context may perform more automatic or detailed mapping, but the `RO-Crate JSON-LD context` is deliberately flat, listing every property and type.

To find the full description of a particular property or type, follow its URI from the context. For instance, we can find within the context <https://w3id.org/ro/crate/1.1-DRAFT/context> that `author` above is mapped to <http://schema.org/author>:

```json
   "author": "http://schema.org/author",
```

The _RO-Crate JSON-LD Context_ may either be set by reference to <https://w3id.org/ro/crate/1.1-DRAFT/context>, or by value (merging the two documents).

Consider the below (simplified) example of _by reference_ using a versioned permalink:

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "description": "RO-Crate Metadata File Descriptor (this file)",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
      "about": {"@id": "./"}
    }
  ]
}
```

The above is equivalent to this JSON-LD using an embedded context, by adding the subset of corresponding keys from the external `@context`:

```json
{ "@context": {
      "CreativeWork": "http://schema.org/CreativeWork",
      "about": "http://schema.org/about",
      "description": "http://schema.org/description",
      "conformsTo": "http://purl.org/dc/terms/conformsTo",
      "about": "http://schema.org/about"
  },
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "description": "RO-Crate Metadata File Descriptor (this file)",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
      "about": {"@id": "./"}
    }
  ]
}
```

While the second form is more verbose, one advantage is that it is "archivable" as it does not require Internet access for retrieving the `@context` permalink. Tools consuming or archiving RO-Crate MAY replace by-reference `@context` URIs with an embedded context by using version-specific hard-coded contexts, see <https://github.com/ResearchObject/ro-crate/releases>

To check which RO-Crate version is used (in terms of properties and types expected), clients SHOULD check the property `conformsTo` on the _RO-Crate Metadata File Descriptor_ rather than the value of `@context`.

RO-Crate consumers SHOULD NOT do the opposite substitution from an embedded context, but MAY use the [JSON-LD flattening](https://www.w3.org/TR/json-ld-api/#flattening-algorithm) algorithm with _compaction_ to a referenced _RO-Crate JSON-LD context_ (but see notes on [handling relative URI references](#handling-relative-uri-references) below).

**Tip**: The [JSON-LD flattening & compaction](https://www.w3.org/TR/json-ld-api/#flattening-algorithm) algorithms can be used to rewrite to a different `@context`, e.g. to <http://schema.org> or a different version of the _RO-Crate JSON-LD Context_.

### RO-Crate JSON-LD Media type

The [media type][RFC 6838] for `ro-crate-metadata.json` will, when following this specification, comply
with the [flattened/compacted JSON-LD profiles](https://www.w3.org/TR/json-ld/#application-ld-json) as well as `https://w3id.org/ro/crate`, which may be indicated in a [HTTP response](https://tools.ietf.org/html/rfc7231#section-3.1.1.5) as:

```http
HEAD http://example.com/ro-123/ro-crate-metadata.json HTTP/1.1

HTTP/1.1 200 OK
Content-Type: application/ld+json; profile="http://www.w3.org/ns/json-ld#flattened http://www.w3.org/ns/json-ld#compacted https://w3id.org/ro/crate"
```


Note that most web servers will serve `ro-crate-metadata.json` with  `Content-Type: application/json`. 

Requesting the RO-Crate metadata file from a browser may also need permission through CORS header `Access-Control-Allow-Origin` (however extra care should be taken if the RO-Crates require access control).

To change configuration of **Apache HTTPD 2**, add to `.htaccess` or equivalent config file:

```conf
<Files "ro-crate-metadata.json">
  ForceType 'application/ld+json;profile="http://www.w3.org/ns/json-ld#flattened http://www.w3.org/ns/json-ld#compacted https://w3id.org/ro/crate"'

  Header set Access-Control-Allow-Origin *
  Header set Access-Control-Expose-Headers "Content-Length,Content-Range,Content-Type"
</Files>
```

For **NGINX**, try:

```nginx
location ~ ro-crate-metadata.json$ {
        types { } default_type 'application/ld+json;profile="http://www.w3.org/ns/json-ld#flattened http://www.w3.org/ns/json-ld#compacted https://w3id.org/ro/crate"';

        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range,Content-Type';
}
```

For **Content-Delivery Networks** (e.g. GitHub pages) a symbolic link to `ro-crate-metadata.jsonld` may help to create an alias that can be served as `application/ld+json`:

```sh
ln -s ro-crate-metadata.json ro-crate-metadata.jsonld
```

### Extending RO-Crate

To extend RO-Crate, implementers SHOULD try to use existing <http://schema.org/> properties and classes and MAY use terms from other vocabularies and ontologies when this is not possible.

The terms (properties and classes) used SHOULD be added as keys to the `@context` in the _RO-Crate JSON-LD_ (if not present). To avoid duplicating the _RO-Crate JSON-LD Context_ the `@context: []` array form SHOULD be used as shown below.

URIs in the `@context` SHOULD resolve to a useful human readable page. Where this is not possible - for example if the URI resolves to an RDF ontology file, a human-readable URI SHOULD be provided using a [sameAs] description.

For example. The `@id` URI <http://purl.org/ontology/bibo/interviewee> from the [BIBO ontology](http://neologism.ecs.soton.ac.uk/bibo.html) ontology itends to resolve to an ontology file, which is not useful for humans, however the HTML section <http://neologism.ecs.soton.ac.uk/bibo.html#interviewee> is human-readable.


```json
{
  "@context": [ 
    "https://w3id.org/ro/crate/1.1-DRAFT/context",
    {"interviewee": "http://purl.org/ontology/bibo/interviewee"},
  ],
  "@graph": [
  {
      "@id": "http://purl.org/ontology/bibo/interviewee",
      "sameAs": "http://neologism.ecs.soton.ac.uk/bibo.html#interviewee",
      "@type": "Thing"
  }
 ]
}
```


When generating the _RO-Crate Website_ from _RO-Crate JSON-LD_, the code MUST use a [sameAs] URI (if present) as a target for an explanatory link for the term instead of the Linked Data URI supplied in the `@context`.

Where there is no RDF ontology available, then implementors SHOULD attempt to provide context by creating stable web-accessible URIs to document properties and classes, for example, by linking to page describing an XML element or attribute from an XML schema, pending the publication of a formal ontology.


### Adding new or ad hoc vocabulary terms

Context terms must ultimately map to HTTP(s) URIs which poses challenges for crate-authors wishing to use their own vocabularies.

RO-Crate provides some strategies To add a new term (a Class or Property) that is not in schema.org or another published vocabulary, so that there is a stable URI that can be added to the @context. 

#### Choosing URLs for ad hoc terms

For projects that have their own web-presence, URLs MAY defined and SHOULD resolve to useful content. For example for a project with web page <https://criminalcharacters.com/> the property `education` could have a URL: https://criminalcharacters.com/vocab/#education which resolves to an HTML page that explains the term.

For ad hoc terms where the crate author does not have the resources to put up an HTML page, an ad-hoc URL MAY be used in the form `https://w3id.org/ro/terms/criminalcharacters/education` where `criminalcharacters` is acting as a _namespace_ for one or more related terms like `education`. Ad-hoc namespaces under `https://w3id.org/ro/terms/` are available on first-come-first-serve basis; to avoid clashes, namespaces SHOULD be registered by [submitting terms and definitions](https://github.com/ResearchObject/ro-terms) to the RO-Crate project. 

In both cases, to use an ad-hoc term in an RO-Crate, the URI MUST be included in the local context:

```json
{
  "@context": [ 
    "https://w3id.org/ro/crate/1.1-DRAFT/context",
    {"education": "https://criminalcharacters.com/vocab/#education",
     "interests": "https://w3id.org/ro/terms/school/interests"},
  ],
  "@graph": [ ... ]
}
```


#### Add local definitions of ad hoc terms

Following the conventions used by Schema.org, ad-hoc terms SHOULD also include definitions in the RO-Crate with at minimum:

* `@type` of either `Class` (contextual entity type) or `Property` (attribute of an contextual entity)
* `rdfs:label` with the human readable version of the term, e.g. `makesFood` has label `makes food`
* `rdf:comment` documenting and clarifying the meaning of the term. For instance the term `sentence` in a prisoner vocabulary will have a different explanation than `sentence` in a linguistic vocabulary.

It is **not** a requirement to use English for the terms, labels or comments.

```
{
    "@id": "https://criminalcharacters.com/vocab/#education",
    "@type": "rdf:Property",
    "rdfs:label": "education",
    "rdf:comment": "Literacy of prisoner. ..."
}
```

More information about the relationship of this term to other terms MAY be provided using [domainIncludes]("http://schema.org/domainIncludes"), [rangeIncludes](http://schema.org/rangeIncludes), [rdfs:subClassOf](https://www.w3.org/TR/rdf-schema/#ch_subclassof) following the conventions used in the [Schema.org schema](https://schema.org/version/latest/schemaorg-current-http.jsonld).

### Handling relative URI references

The _RO-Crate Metadata File_ use _relative URI references_ to identify files and directories
contained within the _RO-Crate Root_ and its children.  As described in section
[Describing entities in JSON-LD](#describing-entities-in-json-ld) above, 
relative URI references are also frequently used for 
identifying _Contextual entities_.

When using JSON-LD tooling and RDF libraries to consume or generate RO-Crates, 
extra care should be taken to ensure these URI references are handled correctly.

For this, a couple of scenarios are sketched below with recommendations for
consistent handling:

#### Flattening JSON-LD from nested JSON

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
    "description": "The RO-Crate Root Data Entity"
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

Note that the saved _RO-Crate JSON-LD_ SHOULD NOT include `{@base: null}` in its `@context`.


#### Expanding/parsing JSON-LD keeping relative referencing

[JSON-LD Expansion](https://www.w3.org/TR/json-ld-api/#expansion) can be used to 
resolve terms from the `@context` to absolute URIs, e.g. `http://schema.org/description`. This may be needed to parse [extended properties](#extending-ro-crate) or for combinations with other Linked Data.

This algorithm would normally also expand `@id` fields based on the current [base URI](https://www.w3.org/TR/json-ld11/#base-iri) of the _RO-Crate Metadata File_, but this may be a temporary location like `file:///tmp/rocrate54/ro-crate-metadata.json`, meaning `@id`: `subfolder/` becomes `file:///tmp/rocrate54/subfolder/` after JSON-LD expansion.

To avoid absoluting local identifiers, before expanding, augment the JSON-LD `@context` to ensure it is an array that includes `{"@base": null}`.

For example, expanding

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

Note that `@base: null` will not relativize existing absolute URIs that happen to be contained by the _RO-Crate Root_ (see section [Relativizing absolute URIs within RO-Crate Root](#relativizing-absolute-uris-within-ro-crate-root)).

**Note**: Most RDF parsers supporting JSON-LD will perform this kind of expansion before generating triples, but not all RDF stores or serializations support relative URI references. Consider using an alternative `@base` as detailed in sections below.

#### Establishing absolute URI for RO-Crate Root

When loading _RO-Crate JSON-LD_ as RDF, or combining the crate's Linked Data into a larger JSON-LD, it is important to ensure correct
[base URI](https://www.w3.org/TR/2014/REC-json-ld-20140116/#base-iri)
to resolve URI references that are relative to the _RO-Crate Root_.

Note that when retrieving an RO-Crate over the web, servers might have performed HTTP redirections so that the base URI is different from what was requested. It is RECOMMENDED to follow section [Establishing a Base URI of RFC3986](http://tools.ietf.org/html/rfc3986#section-5.1) before resolving relative links from the _RO-Crate Metadata File_.

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

##### Finding RO-Crate Root in RDF triple stores

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


##### Parsing as RDF with a different RO-Crate Root

When parsing a _RO-Crate Metadata File_ into [RDF triples](https://www.w3.org/TR/rdf11-concepts/), for instance uploading it to a _graph store_ like [Apache Jena](https://jena.apache.org/)'s [Fuseki](https://jena.apache.org/documentation/fuseki2/), it is important to ensure consistent _base URI_:

* Some RDF stores and RDF formats don't support relative URI references in triples (see [RDF 1.1 concepts](https://www.w3.org/TR/rdf11-concepts/#note-iris))
* The _RO-Crate Root_ may depend on where the _RO-Crate Metadata File_ was parsed from, e.g. `<file:///tmp/ro-crate-metadata.json>` (file) or `<http://localhost:3030/test/ro-crate-metadata.json>` (web upload)
* Parsing multiple RO-Crates into the same RDF graph, using same base URI, may merge them into the same RO-Crate
* `ro-crate-metadata.json` may not be recognized as JSON-LD and must be renamed to `ro-crate-metadata.jsonld`
* Web servers hosting `ro-crate-metadata.json` may not send the [JSON-LD _Content-Type_](#ro-crate-json-ld-media-type)
* If base URI is not correct it may be difficult to find the corresponding file and directory paths from an RDF query returning absolute URIs

**Tip**: If the RDF library can parse the _RO-Crate JSON-LD_ directly by retrieving from a `http`/`https` URI of the _RO-Crate Metadata File_ it should calculate the correct base URI as detailed in section [Establishing absolute URI for RO-Crate Root](#establishing-absolute-uri-for-ro-crate-root) and you should **not** need to override the base URI as detailed here.

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


##### Establishing a base URI inside a ZIP file

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

**Bagit**: The arcp specification suggests how [BagIt identifiers](https://tools.ietf.org/html/draft-soilandreyes-arcp-03#appendix-A.4) can be used to calculate the base URI. See also section [Combining with other packaging schemes](#combining-with-other-packaging-schemes) - note that in this approach the _RO-Crate Root_ will be the payload folder `/data/` under the calculated arcp base URI.

#### Relativizing absolute URIs within RO-Crate Root

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

**Warning**: This method would also relativize URIs outside the _RO-Crate Root_ that are on the same host, e.g. `http://example.com/crate255/other.txt` would become `../create255/other.txt` - this can particularly be a challenge with local `file:///` URIs. 




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
[OCFL Object]: https://ocfl.io/0.3/spec/#object-spec
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
