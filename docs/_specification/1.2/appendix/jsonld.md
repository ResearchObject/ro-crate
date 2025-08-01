---
title: RO-Crate JSON-LD
redirect_from:
  - /1.2-DRAFT/appendix/jsonld
  - /specification/1.2-DRAFT/appendix/jsonld
  - /specification/1.2-RC1/appendix/jsonld
parent: Appendix
grand_parent: RO-Crate 1.2
nav_order: 22
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

# APPENDIX: RO-Crate JSON-LD {#jsonld}
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

It is not necessary to use [JSON-LD tooling] to generate or parse the _RO-Crate Metadata Document_, although JSON-LD tools may make it easier to conform to this specification, e.g. handling relative URIs. It is however RECOMMENDED to use [JSON tooling][JSON] to handle [JSON][RFC 7159] syntax and escaping rules.

This appendix shows a brief JSON-LD introduction for complying with the _RO-Crate Metadata Document_ requirements.

The example below shows the overall structure of a flattened, compacted _RO-Crate Metadata Document_ where `@context` refers to the _RO-Crate JSON-LD Context_, while `@graph` is a flat array of the entities that constitute this RO-Crate. 

```json
{ "@context": "https://w3id.org/ro/crate/1.2/context",
  "@graph": [

    {
      "@type": "CreativeWork",
      "@id": "ro-crate-metadata.json",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2"},
      "about": {"@id": "./"},
      "description": "RO-Crate Metadata Descriptor (this file)"
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

**Note**: entities above have been shortened for brevity, see the individual sections for [data entities](../data-entities) and [contextual entities](../contextual-entities).


The order of the `@graph` array is not significant. Above we see that the RO-Crate JSON-LD graph contains the _RO-Crate Metadata Descriptor_, the _Root Data Entity_, any _Data Entities_ and any _Contextual Entities_.


## Describing entities in JSON-LD

Properties of an entity can refer to another URI or entity by using the form `{"@id": "uri-reference"}` as in the example above, where the [author] property in the [File] entity refer to the [Person] entity, identified as `#alice`. 

Identifiers in `@id` SHOULD be either a valid _absolute URI_ like <http://example.com/>, or a _URI path_ relative to the RO-Crate root directory. Although legal in JSON-LD, `@id` paths in RO-Crate SHOULD NOT use `../` to climb out of the _RO-Crate Root_, rather such references SHOULD be translated to absolute URIs. See also section [Core Metadata for Data Entities](../data-entities#core-metadata-for-data-entities).

Care must be taken to express any relative paths using `/` separator and escape special characters like space (`%20`). As JSON-LD supports _IRIs_, international characters in identifiers SHOULD be encoded in UTF-8 rather than `%`-escaped.

Because the _RO-Crate JSON-LD_ is _flattened_, all described entities must be JSON objects as direct children of the `@graph` element rather than being nested under another object or array. Properties referencing entities must use a JSON object with `@id` as the only key, e.g. `"author": {"@id": "https://orcid.org/0000-0002-1825-0097"}`

If no obvious identifier is available for a contextual entity, an identifier local to the _RO-Crate Metadata Document_ can be generated. 

-  If the entity has a `name` such as a `Person` for instance an `@id` starting with `#` SHOULD be used; `{"@id": "#alice"}` or `{"@id": "#ac0bd781-7d91-4cdf-b2ad-7305921c7650"}`. 

-  For un-named entities, such as a [Geometry] entity a _blank node_ identifier (e.g. `_:alice`) SHOULD be used. The use of a _blank node_ identifier SHOULD be taken as hint by RO-Crate presentation software to display the entity in-line, not as a separate entity with its own view, such as a page.

Multiple values and references can be represented using JSON arrays, as exemplified in `hasPart` above; however as the `RO-Crate JSON-LD` is in _compacted form_, any single-element arrays like `"author": [{"@id": "#alice"}]` SHOULD be unpacked to a single value like `"author": {"@id": "#alice"}`.


## RO-Crate JSON-LD Context

The main purpose of the `@context` is to relate JSON property keys and `@type` references to their Linked Data identifiers, which in RO-Crate is based primarily on <http://schema.org/> URIs.

In other uses of JSON-LD the context may perform more automatic or detailed mapping, but the `RO-Crate JSON-LD context` is deliberately flat, listing every property and type.

To find the full description of a particular property or type, follow its URI from the context. For instance, we can find within the context <https://w3id.org/ro/crate/1.2/context> that `author` above is mapped to <http://schema.org/author>:

```json
   "author": "http://schema.org/author",
```

The _RO-Crate JSON-LD Context_ may either be set by reference to <https://w3id.org/ro/crate/1.2/context> or by value (merging the two documents).

Consider the below (simplified) example of _by reference_ using a versioned permalink:

```json
{ "@context": "https://w3id.org/ro/crate/1.2/context",
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "description": "RO-Crate Metadata Descriptor (this file)",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2"},
      "about": {"@id": "./"}
    }
  ]
}
```

The above is equivalent to the following JSON-LD using an embedded context, by adding the subset of corresponding keys from the external `@context`:

```json
{ "@context": {
      "CreativeWork": "http://schema.org/CreativeWork",
      "description": "http://schema.org/description",
      "conformsTo": "http://purl.org/dc/terms/conformsTo",
      "about": "http://schema.org/about"
  },
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "description": "RO-Crate Metadata Descriptor (this file)",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2"},
      "about": {"@id": "./"}
    }
  ]
}
```

Note that `conformsTo` is retained to indicate which version of RO-Crate specification the [root data entity](../root-data-entity) conforms to.

While the second form is more verbose, one advantage is that it is "archivable" as it does not require Internet access for retrieving the `@context` permalink. Tools consuming or archiving RO-Crate MAY replace by-reference `@context` URIs with an embedded context by using version-specific hard-coded contexts. See <https://github.com/ResearchObject/ro-crate/releases> to download the JSON-LD contexts corresponding to each version of this specification.

To check which RO-Crate version is used (in terms of properties and types expected), clients SHOULD check the property `conformsTo` on the _RO-Crate Metadata Descriptor_ rather than the value of `@context`.

RO-Crate consumers SHOULD NOT do the opposite substitution from an embedded context, but MAY use the [JSON-LD flattening] algorithm with _compaction_ to a referenced _RO-Crate JSON-LD context_ (see also notes on [handling relative URI references](relative-uris) below).

{% include callout.html type="tip" content="The [JSON-LD flattening & compaction](https://www.w3.org/TR/json-ld-api/#flattening-algorithm) algorithms can be used to rewrite to a different `@context`, e.g. to `https://schema.org/docs/jsonldcontext.jsonld` or a different version of the _RO-Crate JSON-LD Context_." %}

## RO-Crate JSON-LD Media type

The [media type][RFC 6838] `application/ld+json` for `ro-crate-metadata.json` will, when following this specification, comply
with the [flattened/compacted JSON-LD profiles][JSON-LD media type] as well as `https://w3id.org/ro/crate`, which may be indicated in a [HTTP response][RFC7231 response] as:

```http
HEAD http://example.com/ro-123/ro-crate-metadata.json HTTP/1.1

HTTP/1.1 200 OK
Content-Type: application/ld+json; profile="http://www.w3.org/ns/json-ld#flattened http://www.w3.org/ns/json-ld#compacted https://w3id.org/ro/crate"
```


Note that most web servers will however serve `*.json` as `Content-Type: application/json`. 

Requesting the _RO-Crate Metadata Document_ from a browser may also need permission through CORS header `Access-Control-Allow-Origin` (however extra care should be taken if the RO-Crates require access control).

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

To extend RO-Crate, implementers SHOULD try to use existing <http://schema.org/> properties and classes and MAY use terms from other vocabularies and ontologies when this is not possible. In many cases, a liberal interpretation of an schema.org term can be sufficient, e.g. even if <https://schema.org/HowTo> is explained with an example of changing a tire, `HowTo` could also help explain a Linux shell script as a series of computational steps.

Any additional _terms_ (properties and types) from outside schema.org MUST be added as keys to the `@context` in the _RO-Crate JSON-LD_ (if not present) (or be defined by the JSON-LD context in other ways). To avoid duplicating the _RO-Crate JSON-LD Context_ the `@context: []` array form SHOULD be used as shown below.

URIs in the `@context` SHOULD resolve to a useful human readable page. When this is not possible - for example if the URI resolves to an RDF ontology file, a human-readable URI SHOULD be provided as a [DefinedTerm] using a [sameAs] description.

For example. The `@id` URI <http://purl.org/ontology/bibo/interviewee> from the [BIBO ontology] intends to resolve to an ontology file, which is not useful for humans, however the HTML section <http://neologism.ecs.soton.ac.uk/bibo.html#interviewee> is human-readable. To read more about best practices for content negotiation of vocabularies, we refer the reader to [Best Practice Recipes for Publishing RDF Vocabularies].


```json
{
  "@context": [ 
    "https://w3id.org/ro/crate/1.2/context",
    {"interviewee": "http://purl.org/ontology/bibo/interviewee"},
  ],
  "@graph": [
  {
      "@id": "http://purl.org/ontology/bibo/interviewee",
      "@type": "DefinedTerm",
      "name": "interviewee",
      "sameAs": "http://neologism.ecs.soton.ac.uk/bibo.html#interviewee"
  }
 ]
}
```

When generating the _RO-Crate Website_ from _RO-Crate JSON-LD_, the code MUST use a [sameAs] URI (if present) as a target for an explanatory link for the term instead of the Linked Data URI supplied in the `@context`.

Where there is no RDF ontology available, then implementors SHOULD attempt to provide context by creating stable web-accessible URIs to document properties and classes, for example, by linking to a page describing the term.


## Adding new or ad hoc vocabulary terms

Context terms must ultimately map to HTTP(s) URIs which poses challenges for crate-authors wishing to use their own vocabularies.

RO-Crate provides some strategies to add a new term ([DefinedTerm], `rdfs:Class` or `rdf:Property`) that is not in Schema.org or another published vocabulary, so that there is a stable URI that can be added to the `@context`. 

### Choosing URIs for ad hoc terms

For projects that have their own web-presence, URIs MAY be defined there and SHOULD resolve to useful content. For example, for a project with web page <https://example.com/some-project> the property `myProperty` could have a URI: <https://example.com/some-project/terms#myProperty> which resolves to an HTML page that explains each term using HTML anchors:

```html
<section id="myProperty">
  <h2>Property: myProperty</h2>
  <dl><dt>Permalink:</dt> 
      <dd>https://example.com/some-project/terms#myProperty</dd>
  </dl>
  <p>Description of property ...
  </p>
</section>
```

{% include callout.html type="tip" content="Ensure you have a consistent use of `http` or `https` (preferring https) as well as consistent path `/vocab` vs `/vocab/` vs `/vocab/index.html` (preferring the shortest that is also visible in browser)." %}

For ad hoc terms where the crate author does not have the resources to create and maintain an HTML page, authors may use the RO-Crate public namespace (`https://w3id.org/ro/terms/`) to reserve their terms. For example, an ad-hoc URI MAY be used in the form `https://w3id.org/ro/terms/some-project#myProperty` where `some-project` is acting as a _namespace_ for one or more related terms like `education`. Ad-hoc namespaces under `https://w3id.org/ro/terms/` are available on first-come-first-serve basis; to avoid clashes, namespaces SHOULD be registered by [submitting terms and definitions][ro-terms] to the RO-Crate terms project. 

In both cases, to use an ad-hoc term in an RO-Crate, the URI MUST be included in the local context:

```json
{
  "@context": [ 
    "https://w3id.org/ro/crate/1.2/context",
    {"education": "https://example.com/some-project/terms#education",
     "interests": "https://w3id.org/ro/terms/some-project#interests"},
  ],
  "@graph": [ ... ]
}
```

### Add local definitions of ad hoc terms

Following the conventions used by Schema.org, ad-hoc terms SHOULD also include definitions in the RO-Crate with at minimum:

* `@id` is an absolute URI (see [choosing](#choosing-uris-for-ad-hoc-terms))
* `@type` of [DefinedTerm], `rdf:Property` or `rdfs:Class`. Use `rdf:Property` for terms that can be used as JSON-LD keys (after being mapped by the context), or `rdfs:Class` for terms that can be used with `@type`. Use [DefinedTerm] for any other defined concepts that will be referenced by `@id`, e.g. from [creativeWorkStatus].
* `name` with the human readable version of the term, e.g. `http://example.com/vocab#makesFood` has label `"makes food"`
* `description` documenting and clarifying the meaning of the term. For instance the term `education` meaning _Person's education level, e.g. primary school_ (compared to the meaning _Educational Material_)

```json
{
    "@id": "http://purl.archive.org/textcommons/terms#participant",
    "@type": "DefinedTerm",
    "name": "participant",
    "description": "This role is intended for minor participants such as audience members or other peripherally-involved participants in the event…"
}
```


{% include callout.html type="tip" content="It is **not** a requirement to use English for the terms, labels or comments." %}

More information about the relationship of this term to other terms MAY be provided using [domainIncludes], [rangeIncludes], [rdfs:subClassOf], [rdfs:subPropertyOf], [sameAs] following the conventions used in the [Schema.org schema] -- *"Schema.org style schemas"*. For compatibility with RDFS/OWL tools, `name` and `description` SHOULD be duplicated using the RDFS properties `rdfs:label` and `rdfs:comment`:

```json
 {
      "@id": "http://purl.archive.org/textcommons/terms#participant",
      "@type": "rdf:Property",
      "name":       "participant",
      "rdfs:label": "participant",
      "description":  "This role is intended for minor participants such as audience members or other peripherally-involved participants in the event…",
      "rdfs:comment": "This role is intended for minor participants such as audience members or other peripherally-involved participants in the event…",
      "rdfs:subPropertyOf": {"@id": "http://schema.org/participant"},
      "domainIncludes": {"@id": "http://schema.org/CreativeWork"},
      "rangeIncludes": [
         {"@id": "http://schema.org/Person"},
         {"@id": "http://schema.org/Organization"}
      ],
      "sameAs": "http://www.language-archives.org/REC/role.html#participant",
    }
```

{% include callout.html type="note" content="Schema.org also provides the types [Class] and [Property]. These MAY be used as an additional `@type` corresponding to `rdfs:Class` and `rdf:Property`, but as these are (for some reason) not used in Schema.org style schemas, they are also not required by RO-Crate. Likewise, an ontology defining such terms externally may be declaring properties there with more specific types like `owl:ObjectProperty` which do not need to be reflected in the RO-Crate reference." %}

{% include callout.html type="tip" content="For compatibility with the official schema.org JSON-LD context, make sure any referenced `@id` to schema.org terms starts with `http://` rather than `https://` as shown in the browser." %}

## Grouping extensions as an RO-Crate profile

If several RO-Crates are using the same `@context` extension terms, or define the same additional ad-hoc terms, then it may make sense to specify these within an [RO-Crate profile](../profiles) that the crates can then explicitly declare conformance to.   

The `@id` of the extension terms should after the move be made absolute URIs that resolve to the profile crate -- if these were made using <https://w3id.org/ro/terms/> then a request to set up such redirects can be made. 

For terms it is RECOMMENDED to change the `@id` of the terms after moving to be based on the profile's permalink, e.g. the profile with `@id` <https://w3id.org/cpm/ro-crate> defines the term <https://w3id.org/cpm/ro-crate#CPMProvenanceFile>. 

See sections on [profile extension terms](../profiles#extension-terms) and [Profile JSON-LD context](../profiles#json-ld-context).  [Custom file formats](../data-entities#adding-detailed-descriptions-of-file-encodings) and common [contextual entities](../contextual-entities) may also be moved to the profile, ensuring their `@id` are absolute URI and resolve to the profile JSON-LD.

This can reduce repetition in their JSON-LD, but means additional measures must be taken to ensure the resulting RO-Crates remain functional over time, e.g. not to remove terms as the profile evolves over time.

Example:

```json
{ "@context": [
    "https://w3id.org/ro/crate/1.1/context",
    "https://w3id.org/cpm/ro-crate/0.1"
  ],
  "@graph": [

 {
    "@type": "CreativeWork",
    "@id": "ro-crate-metadata.json",
    "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1"},
    "about": {"@id": "./"}
 },
 {
    "@id": "./",
    "@type": "Dataset",
    "conformsTo": {"@id": "https://w3id.org/cpm/crate/0.1"},
    "hasPart": [
        { "@id": "CPM_COMPLIANT_PROVENANCE" }
    ],
    "…" : ""
 },
 {
   "@id": "CPM_COMPLIANT_PROVENANCE",
   "@type": ["File", "CPMProvenanceFile"],
   "encodingFormat": [
      "text/provenance-notation",
      { "@id": "http://www.w3.org/TR/2013/REC-prov-n-20130430/"}
   ],
   "name": "Provenance file"
 }
]
}
```

In the example above, the type `CPMProvenanceFile` is resolved to <https://w3id.org/cpm/ro-crate#CPMProvenanceFile> by the matching key in the second `@context` when content-negotiating for `application/ld+json` (browsers may see the human-readable documentations).

The contextual entity `http://www.w3.org/TR/2013/REC-prov-n-20130430/` for `encodingFormat` is defined within the profile rather than in this specific crate, however in this example that `@id` resolves to the textual specification at W3C rather than back to the Profile Crate. 

{% include references.liquid %}
