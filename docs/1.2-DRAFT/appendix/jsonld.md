---
title: RO-Crate JSON-LD
parent: Appendix
grand_parent: RO-Crate 1.2-DRAFT
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2022 The University of Manchester UK 
   Copyright 2019-2022 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

<div id="jsonld"></div>

# APPENDIX: RO-Crate JSON-LD
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

It is not necessary to use [JSON-LD tooling] to generate or parse the _RO-Crate Metadata File_, although JSON-LD tools may make it easier to conform to this specification, e.g. handling relative URIs. It is however RECOMMENDED to use [JSON tooling][JSON] to handle [JSON][RFC 7159] syntax and escaping rules.

This appendix shows a brief JSON-LD introduction for complying with the _RO-Crate Metadata File_ requirements.

The example below shows the overall structure of a flattened, compacted _RO-Crate Metadata File_ where `@context` refers to the _RO-Crate JSON-LD Context_, while `@graph` is a flat array of the entities that constitute this RO-Crate. 

```json
{ "@context": "https://w3id.org/ro/crate/1.2-DRAFT/context",
  "@graph": [

    {
      "@type": "CreativeWork",
      "@id": "ro-crate-metadata.json",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"},
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

**Note**: entities above have been shortened for brevity, see the individual sections for [data entities](../data-entities.md) and [contextual entities](../contextual-entities.md).


The order of the `@graph` array is not significant. Above we see that the RO-Crate JSON-LD graph contains the _RO-Crate Metadata File Descriptor_, the _Root Data Entity_, any _Data Entities_ and any _Contextual Entities_.



## Describing entities in JSON-LD

Properties of an entity can refer to another URL or entity by using the form `{"@id": "uri-reference"}` as in the example above, where the [author] property in the [File] entity refer to the [Person] entity, identified as `#alice`. 

Identifiers in `@id` SHOULD be either a valid _absolute URI_ like <http://example.com/>, or a _URI path_ relative to the RO-Crate root directory. Although legal in JSON-LD, `@id` paths in RO-Crate SHOULD NOT use `../` to climb out of the _RO-Crate Root_, rather such references SHOULD be translated to absolute URIs. See also section [Core Metadata for Data Entities](../data-entities.md#core-metadata-for-data-entities).

Care must be taken to express any relative paths using `/` separator and escape special characters like space (`%20`). As JSON-LD supports _IRIs_, international characters in identifiers SHOULD be encoded in UTF-8 rather than `%`-escaped.

Because the _RO-Crate JSON-LD_ is _flattened_, all described entities must be JSON objects as direct children of the `@graph` element rather than being nested under another object or array. Properties referencing entities must use a JSON object with `@id` as the only key, e.g. `"author": {"@id": "https://orcid.org/0000-0002-1825-0097"}`

If no obvious identifier is available for a contextual entity, an identifier local to the _RO-Crate Metadata File_ can be generated, for instance `{"@id": "#alice"}` or `{"@id": "#ac0bd781-7d91-4cdf-b2ad-7305921c7650"}`. Although it is RECOMMENDED to use `#`-based local identifiers, identifiers in `@id` MAY alternatively be a _blank node_ identifier (e.g. `_:alice`).

Multiple values and references can be represented using JSON arrays, as exemplified in `hasPart` above; however as the `RO-Crate JSON-LD` is in _compacted form_, any single-element arrays like `"author": [{"@id": "#alice"}]` SHOULD be unpacked to a single value like `"author": {"@id": "#alice"}`.


## RO-Crate JSON-LD Context

The main purpose of the `@context` is to relate JSON property keys and `@type` references to their Linked Data identifiers, which in RO-Crate is based primarily on <http://schema.org/> URIs.

In other uses of JSON-LD the context may perform more automatic or detailed mapping, but the `RO-Crate JSON-LD context` is deliberately flat, listing every property and type.

To find the full description of a particular property or type, follow its URI from the context. For instance, we can find within the context <https://w3id.org/ro/crate/1.2-DRAFT/context> that `author` above is mapped to <http://schema.org/author>:

```json
   "author": "http://schema.org/author",
```

The _RO-Crate JSON-LD Context_ may either be set by reference to <https://w3id.org/ro/crate/1.2-DRAFT/context> or by value (merging the two documents).

Consider the below (simplified) example of _by reference_ using a versioned permalink:

```json
{ "@context": "https://w3id.org/ro/crate/1.2-DRAFT/context",
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "description": "RO-Crate Metadata File Descriptor (this file)",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"},
      "about": {"@id": "./"}
    }
  ]
}
```

The above is equivalent to the following JSON-LD using an embedded context, by adding the subset of corresponding keys from the external `@context`:

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
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"},
      "about": {"@id": "./"}
    }
  ]
}
```

Note that `conformsTo` is retained to indicate which version of RO-Crate specification the [root data entity](../root-data-entity.md) conforms to.

While the second form is more verbose, one advantage is that it is "archivable" as it does not require Internet access for retrieving the `@context` permalink. Tools consuming or archiving RO-Crate MAY replace by-reference `@context` URIs with an embedded context by using version-specific hard-coded contexts. See <https://github.com/ResearchObject/ro-crate/releases> to download the JSON-LD contexts corresponding to each version of this specification.

To check which RO-Crate version is used (in terms of properties and types expected), clients SHOULD check the property `conformsTo` on the _RO-Crate Metadata File Descriptor_ rather than the value of `@context`.

RO-Crate consumers SHOULD NOT do the opposite substitution from an embedded context, but MAY use the [JSON-LD flattening] algorithm with _compaction_ to a referenced _RO-Crate JSON-LD context_ (see also notes on [handling relative URI references](relative-uris.md) below).

{: .tip }
> The [JSON-LD flattening & compaction](https://www.w3.org/TR/json-ld-api/#flattening-algorithm) algorithms can be used to rewrite to a different `@context`, e.g. to `https://schema.org/docs/jsonldcontext.jsonld` or a different version of the _RO-Crate JSON-LD Context_.

## RO-Crate JSON-LD Media type

The [media type][RFC 6838] `application/ld+json` for `ro-crate-metadata.json` will, when following this specification, comply
with the [flattened/compacted JSON-LD profiles][JSON-LD media type] as well as `https://w3id.org/ro/crate`, which may be indicated in a [HTTP response][RFC7231 response] as:

```http
HEAD http://example.com/ro-123/ro-crate-metadata.json HTTP/1.1

HTTP/1.1 200 OK
Content-Type: application/ld+json; profile="http://www.w3.org/ns/json-ld#flattened http://www.w3.org/ns/json-ld#compacted https://w3id.org/ro/crate"
```


Note that most web servers will however serve `*.json` as `Content-Type: application/json`. 

Requesting the RO-Crate metadata file from a browser may also need permission through CORS header `Access-Control-Allow-Origin` (however extra care should be taken if the RO-Crates require access control).

To change the configuration of **Apache HTTPD 2**, add the following to `.htaccess` or equivalent config file:

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

## Extending RO-Crate

To extend RO-Crate, implementers SHOULD try to use existing <http://schema.org/> properties and classes and MAY use terms from other vocabularies and ontologies when this is not possible.

The _terms_ (properties and types) used SHOULD be added as keys to the `@context` in the _RO-Crate JSON-LD_ (if not present). To avoid duplicating the _RO-Crate JSON-LD Context_ the `@context: []` array form SHOULD be used as shown below.

URIs in the `@context` SHOULD resolve to a useful human readable page. When this is not possible - for example if the URI resolves to an RDF ontology file, a human-readable URI SHOULD be provided using a [sameAs] description.

For example. The `@id` URI <http://purl.org/ontology/bibo/interviewee> from the [BIBO ontology] intends to resolve to an ontology file, which is not useful for humans, however the HTML section <http://neologism.ecs.soton.ac.uk/bibo.html#interviewee> is human-readable. To read more about best practices for content negotiation of vocabularies, we refer the reader to [Best Practice Recipes for Publishing RDF Vocabularies].


```json
{
  "@context": [ 
    "https://w3id.org/ro/crate/1.2-DRAFT/context",
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

Where there is no RDF ontology available, then implementors SHOULD attempt to provide context by creating stable web-accessible URIs to document properties and classes, for example, by linking to a page describing an XML element or an attribute from an XML schema, pending the publication of a formal ontology.


## Adding new or ad hoc vocabulary terms

Context terms must ultimately map to HTTP(s) URIs which poses challenges for crate-authors wishing to use their own vocabularies.

RO-Crate provides some strategies to add a new term (a [Class] or [Property]) that is not in Schema.org or another published vocabulary, so that there is a stable URI that can be added to the @context. 

### Choosing URLs for ad hoc terms

For projects that have their own web-presence, URLs MAY be defined there and SHOULD resolve to useful content. For example for a project with web page <https://criminalcharacters.com/> the property `education` could have a URL: <https://criminalcharacters.com/vocab#education> which resolves to an HTML page that explains the term using HTML anchors:

```html
<div id="education">
  <h1>Property: education</h1>
  <p>Literacy of prisoner. Prison authorities would record the prisoner’s statement as to whether they could read and write …
  </p>
</div>
```

{: .tip }
> Ensure you have a consistent use of `http` or `https` (preferring https) as well as consistent path `/vocab` vs `/vocab/` vs `/vocab/index.html` (preferring the shortest that is also visible in browser).

For ad hoc terms where the crate author does not have the resources to create and maintain an HTML page, authors may use the RO-Crate public namespace (`https://w3id.org/ro/terms/`) to reserve their terms. For example, an ad-hoc URL MAY be used in the form `https://w3id.org/ro/terms/criminalcharacters#education` where `criminalcharacters` is acting as a _namespace_ for one or more related terms like `education`. Ad-hoc namespaces under `https://w3id.org/ro/terms/` are available on first-come-first-serve basis; to avoid clashes, namespaces SHOULD be registered by [submitting terms and definitions][ro-terms] to the RO-Crate terms project. 

In both cases, to use an ad-hoc term in an RO-Crate, the URI MUST be included in the local context:

```json
{
  "@context": [ 
    "https://w3id.org/ro/crate/1.2-DRAFT/context",
    {"education": "https://criminalcharacters.com/vocab#education",
     "interests": "https://w3id.org/ro/terms/criminalcharacters#interests"},
  ],
  "@graph": [ ... ]
}
```


### Add local definitions of ad hoc terms

Following the conventions used by Schema.org, ad-hoc terms SHOULD also include definitions in the RO-Crate with at minimum:

* `@type` of either `Class` (contextual entity type) or `Property` (attribute of an contextual entity)
* `rdfs:label` with the human readable version of the term, e.g. `makesFood` has label `makes food`
* `rdf:comment` documenting and clarifying the meaning of the term. For instance the term `sentence` in a prisoner vocabulary will have a different explanation than `sentence` in a linguistic vocabulary.

```json
{
    "@id": "https://criminalcharacters.com/vocab#education",
    "@type": "rdf:Property",
    "rdfs:label": "education",
    "rdf:comment": "Literacy of prisoner. ..."
}
```

{: .tip }
> It is **not** a requirement to use English for the terms, labels or comments.

More information about the relationship of this term to other terms MAY be provided using [domainIncludes], [rangeIncludes], [rdfs:subClassOf] following the conventions used in the [Schema.org schema].

{% include references.liquid %}
