---
title: Profiles
excerpt: |
  Profiles of RO-Crates and their entities can be used to specialize and recommend
  further which metadata types and properties are expected.
nav_order: 10
parent: RO-Crate 1.2-DRAFT
---
<!--
   Copyright 2021-2024 The University of Manchester UK 
   Copyright 2021-2024 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# RO-Crate profiles
    
While RO-Crates can be considered general-purpose containers of arbitrary data and open-ended metadata, in practical use within a particular domain, application or framework, it will be beneficial to further constrain RO-Crate to a specific **profile**: a set of conventions, types and properties that one minimally can require and expect to be present in that subset of RO-Crates.

Defining and conforming to such a profile enables reliable programmatic consumption of an RO-Crate’s content, as well as consistent creation, e.g. a form in a user interface containing the required types and properties, and likewise a rendering of an RO-Crate can easier make rich UI components if it can reliably assume for instance that the [`Person`](contextual-entities.md#people) always has an `affiliation` to a [`Organization`](contextual-entities.md#organizations-as-values) which has a `url` - a restriction that may not be appropriate for all types of RO-Crates.

As such RO-Crate Profiles can be considered a _duck typing_ mechanism for RO-Crates, but also as a classifier to indicate the crate's purpose, expectations and focus.

## Publishing an RO-Crate profile

An _RO-Crate profile_ is identified with a **Profile URI**.

Recommendations:
* The profile URI MUST resolve to a human-readable _profile description_ (e.g. a HTML web page)
  - The profile URI MAY have a corresponding machine-readable [_Profile Crate_](#profile-crate)
* The profile URI SHOULD be a _permalink_ (persistent identifier)
  - e.g. starting with <https://w3id.org/> <http://purl.org/> or <https://doi.org/> 
* The profile URI SHOULD be _versioned_ with [`MAJOR.MINOR`][semver], e.g. `http://example.com/image-profile-2.4`
* The profile description SHOULD use key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL as described in [RFC 2119].

Suggestions:
* The profile MAY require/suggest which `@type` of [data entities](data-entities.md) and/or [contextual entities](contextual-entities.md) are expected.
* The profile MAY require/suggest _properties_ expected per type of entity (e.g. _"Each [CreativeWork] must declare a [license]"_)
* The profile MAY require/suggest a particular [version of RO-Crate](https://www.researchobject.org/ro-crate/specification.html).
* The profile MAY recommend [RO-Crate extensions](appendix/jsonld.md#extending-ro-crate) with domain-specific terms and vocabularies.
* The profile MAY require/suggest a particular [JSON-LD context](appendix/jsonld.md?highlight=@context#ro-crate-json-ld-context).
* The profile MAY require/suggest a particular RO-Crate publishing method or [packaging](appendix/implementation-notes.md#combining-with-other-packaging-schemes) like .zip or BagIt.


## Declaring conformance of an RO-Crate profile

RO-Crate can describe a profile by adding it as an [contextual entity](contextual-entities.md):

```json
{
    "@id": "https://w3id.org/ro/wfrun/process/0.1",
    "@type": ["CreativeWork", "Profile"],
    "name": "Process Run crate profile",
    "version": "0.1.0"
}
```

The contextual entity for a profile:

* The `@type` SHOULD be an array. The `@type` MUST include [Profile].
* The `'@type` SHOULD include `CreativeWork` (indicating a Web Page) or `Dataset` (indicating a Profile Crate).
* SHOULD have an absolute URI as `@id`
* SHOULD have a descriptive [name]
* MAY declare [version], preferably according to [Semantic Versioning][semver]

RO-Crates that are _conforming to_ (or intending to conform to) such a profile SHOULD declare this using `conformsTo` on the [root data entity](root-data-entity.md):

```json
{
    "@id": "./",
    "@type": "Dataset",
    "conformsTo":
        {"@id": "https://w3id.org/ro/wfrun/process/0.1"}       
}
```

It is valid for a crate to conform to multiple profiles, in which case `conformsTo` is an unordered array.

Note that as profile conformance is declared on the RO-Crate Root (`./` in this example), the profile applies to the whole RO-Crate, and may cover aspects beyond the crate's metadata file (e.g. identifiers, packaging, purpose).



## Profile Crate

While the Profile URI `@id` must resolve to a human-readable _profile description_, it MAY additionally be made to [resolve](#how-to-retrieve-a-profile-crate) to a _Profile Crate_.

A **Profile Crate** is a type of RO-Crate that gathers resources which further define the profile in addition to the _profile description_. This allows formalizing alternative profile description for machine-readability, for instance for validation, but also additional resources like examples. The rest of this subsection declares the content of this Profile Crate.

The Profile Crate `@id` declared within its own RO-Crate Metadata Document SHOULD be an absolute URI, and the corresponding reference from its RO-Crate Metadata Descriptor updated accordingly. 

Within the Profile Crate, its [Root Data entity](root-data-entity) MUST declare `Profile` as an additional `@type`:

```json
{
    "@id": "ro-crate-preview.html",
    "@type": "CreativeWork",
    "about": { "@id": "https://w3id.org/ro/wfrun/process/0.1" }
}
{
    "@id": "https://w3id.org/ro/wfrun/process/0.1",
    "@type": ["Dataset", "Profile"],
    "name": "Process Run crate profile",
    "version": "0.1.0",
    "isProfileOf": [
        {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"},
    ],
    "hasPart": [ 
        { "@id": "index.html" }
    ],
    "hasResource": [ 
        { "@id": "#hasSpecification" }
    ],
    "…": ""
},
{
    "@id": "index.html",
    "@type": "File",
    "name": "Process Run crate profile description",
    "encodingFormat": "text/html",
    "about": "https://w3id.org/ro/wfrun/process/0.1",
},
{ 
    "@id": "#hasSpecification",
    "@type": "ResourceDescriptor",
    "hasRole": { "@id": "http://www.w3.org/ns/dx/prof/role/specification" },
    "hasArtifact": {"@id": "index.html"}
}
```

The rest of the [earlier requirements](#declaring-conformance-of-an-ro-crate-profile) for a Profile entity also apply here, adding:

* MUST reference the human readable _profile description_ as a data entity
* SHOULD have an absolute URI as `@id`
* SHOULD have a descriptive [name]
* MAY declare [version], preferably according to [Semantic Versioning][semver] (e.g. `0.4.0`)
* SHOULD reference the minimally expected RO-Crate specification as `isProfileOf`, which MAY be declared as contextual entity
* SHOULD list related data entities using `hasPart` (see [below](#what-is-included-in-the-profile-crate))
* MAY list profile descriptors using `hasResource` (see [below](#declaring-the-role-within-the-crate))

{: .tip}
> The base RO-Crate specification referenced by `isProfileOf` is a Profile Crate itself, see [ro-crate-metadata.json](ro-crate-metadata.json) or [ro-crate-preview.html](ro-crate-preview.html). 


### How to retrieve a Profile Crate

To resolve a Profile URI to a machine-readable _Profile Crate_, two approaches are recommended to retrieve its [RO-Crate Metadata Document](root-data-entity.md#ro-crate-metadata-file-descriptor):

1. [HTTP Content-negotiation] for the [RO-Crate media type](appendix/jsonld.md#ro-crate-json-ld-media-type), for example:  

Requesting `https://w3id.org/workflowhub/workflow-ro-crate/1.0` with HTTP header

  `Accept: application/ld+json;profile=https://w3id.org/ro/crate` redirects to the _RO-Crate Metadata file_
  `https://about.workflowhub.eu/Workflow-RO-Crate/1.0/ro-crate-metadata.json`

2. The above approach may fail (or returns a HTML page), e.g. for content-delivery networks that do not support content-negotiation. The fallback is to try resolving the path `./ro-crate-metadata.json` from the _resolved_ URI (after permalink redirects). For example:  
If permalink `https://w3id.org/workflowhub/workflow-ro-crate/1.0` redirects to `https://about.workflowhub.eu/Workflow-RO-Crate/1.0/index.html` (a HTML page), then
try retrieving `https://about.workflowhub.eu/Workflow-RO-Crate/1.0/ro-crate-metadata.json`
3. If none of these approaches worked, then this profile probably does not have a corresponding Profile Crate. For humans, display a hyperlink to its `@id` described by its `name`.

<!-- TODO Make both examples above actually work! -->


#### Shared contextual entities from a Profile Crate

If an RO-Crate declares conformance to a given profile crate with `conformsTo` on its root data entity, contextual entities declared in the corresponding Profile Crate do _not_ need to be repeated in the conforming crate. 

For instance, if a Profile Crate adds a `DefinedTerm` entity according to the [ad-hoc definitions](appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms), the term MAY be referenced in the conforming crate without making a contextual entity there. For archival purposes it MAY however still be preferrable to copy such entities across to each conforming crate.

It is RECOMMENDED that `@id` of such shared entities are absolute URIs on both sides to avoid resolving relative paths, and that the profile's recommended [JSON-LD Context](#json-ld-context) used by conforming crates SHOULD have a mapping to the URIs, see section [Extending RO-Crate](appendix/jsonld.md#extending-ro-crate).

#### Archiving Profile Crates

For archival purposes, a crate declaring profile conformance MAY choose to include a snapshot copy of the Profile Crate, indicated using `distribution`, as detailed for [dataset distributions](data-entities.md#directories-on-the-web-dataset-distributions):

```json
{
    "@id": "https://w3id.org/ro/wfrun/process/0.1",
    "@type": ["CreativeWork", "Profile"],
    "name": "Process Run crate profile",
    "version": "0.1.0",
    "distribution": { "@id": "process-profile-0.1.zip" }
},
{ 
    "@id": "process-profile-0.1.zip",
    "@type": "DataDownload",
    "encodingFormat": ["application/zip", {"@id": "https://www.nationalarchives.gov.uk/PRONOM/x-fmt/263"}],
    "conformsTo": { "@id": "https://w3id.org/ro/crate" }
}
```

This is mainly beneficial if the crate relies heavily on the profile, e.g. for definitions of terms.

### What is included in the Profile Crate? 

This section defines the type of resources that should or may be included in the Profile Crate for different purposes (roles).

#### Declaring the role within the crate

In order for programmatic use of the Profile Crate to consume particular subresources, e.g. for validation, the _role_ of each entity SHOULD be declared by including them using `hasResource` to a `ResourceDescriptor` contextual entity that references the subresource using `hasResource`, as defined by the [Profiles Vocabulary]:

```json
{
    "@id": "http://example.com/my-crate-profile/0.1/",
    "@type": ["Dataset", "Profile"],
    "name": "My Crate Profile",
    "version": "0.1.0",
    "hasPart": [
        {"@id": "http://example.com/my-crate-profile/0.1/shape.shex"}
    ],
    "hasResource": [
        {"@id": "#hasShape"}
    ]
}
{ 
    "@id": "#hasShape",
    "@type": "ResourceDescriptor",
    "hasRole": { "@id": "http://www.w3.org/ns/dx/prof/role/constraints" },
    "hasArtifact": {"@id": "http://example.com/my-crate-profile/0.1/shape.shex"}
}
```

The [`ResourceDescriptor`](https://www.w3.org/TR/dx-prof/#Class:ResourceDescriptor) entity MAY also declare `dct:format` or `dct:conformsTo`, however the data entity referenced with `hasArtifact` SHOULD always declare `encodingFormat` (with OPTIONAL `conformsTo`) to specify its [encoding format](data-entities#adding-detailed-descriptions-of-encodings), e.g.:

```json
{
    "@id": "http://example.com/my-crate-profile/0.1/shape.shex",
    "@type": "File",
    "encodingFormat": [
        "text/shex", 
        {"@id": "http://shex.io/shex-semantics/" }
    ]
}
```

The referenced role do not need to be declared as a `DefinedTerm` contextual entity unless it differs from these recommended [predefined roles](https://www.w3.org/TR/dx-prof/#resource-roles-vocab):

```json
{
    "@id": "http://www.w3.org/ns/dx/prof/role/constraints",
    "@type": ["DefinedTerm", "ResourceRole"],
    "name": "Constraints", 
    "description": "Descriptions of obligations, limitations or extensions that the profile defines"
},
{
    "@id": "http://www.w3.org/ns/dx/prof/role/example",
    "@type": ["DefinedTerm", "ResourceRole"],
    "name": "Example", 
    "description": "Sample instance data conforming to the profile"
},
{
    "@id": "http://www.w3.org/ns/dx/prof/role/guidance",
    "@type": ["DefinedTerm", "ResourceRole"],
    "name": "Guidance", 
    "description": "Documents, in human-readable form, how to use the profile"
},
{
    "@id": "http://www.w3.org/ns/dx/prof/role/mapping",
    "@type": ["DefinedTerm", "ResourceRole"],
    "name": "Mapping", 
    "description": "Describes conversions between two specifications"
},
{
    "@id": "http://www.w3.org/ns/dx/prof/role/schema",
    "@type": ["DefinedTerm", "ResourceRole"],
    "name": "Schema", 
    "description": "Machine-readable structural descriptions of data defined by the profile"
},
{
    "@id": "http://www.w3.org/ns/dx/prof/role/specification",
    "@type": ["DefinedTerm", "ResourceRole"],
    "name": "Specification", 
    "description": "Defining the profile in human-readable form"
},
{
    "@id": "http://www.w3.org/ns/dx/prof/role/validation",
    "@type": ["DefinedTerm", "ResourceRole"],
    "name": "Validation", 
    "description": "Supplies instructions about how to verify conformance of data to the profile"
},
{
    "@id": "http://www.w3.org/ns/dx/prof/role/vocabulary",
    "@type": ["DefinedTerm", "ResourceRole"],
    "name": "Vocabulary", 
    "description": "Defines terms used in the profile specification"
},
{
    "@id": "http://purl.org/dc/terms/conformsTo",
    "@type": ["DefinedTerm", "ResourceRole"],
    "name": "Conforms to", 
    "description": "Suggestion of additional profile to conform to"
}
```

The examples in the rest of this document will list the data entities with a corresponding `ResourceDescriptor` entity, but for brevity not repeating the required `hasPart` and `hasResource` references from the root dataset.

Below follows the suggested [data entities](data-entities.md) to include in a Profile Crate using `hasPart` and, if applicable, a corresponding `hasResource` to a `ResourceDescriptor`:

#### Profile description entity

A Profile Crate MUST declare a human-readable _profile description_, which is [about] this Profile Crate and SHOULD have [encodingFormat] as `text/html`. The corresponding `ResourceDescriptor` SHOULD have identifier `http://www.w3.org/ns/dx/prof/role/specification` or `http://www.w3.org/ns/dx/prof/role/guidance` -- for example:

```json
{
    "@id": "index.html",
    "@type": "File",
    "name": "Workflow RO-Crate profile description",
    "encodingFormat": "text/html",
    "about": "https://w3id.org/ro/wfrun/process/0.1",
},
{ 
    "@id": "#hasSpecification",
    "@type": "ResourceDescriptor",
    "hasRole": { "@id": "http://www.w3.org/ns/dx/prof/role/specification" },
    "hasArtifact": {"@id": "index.html"}
}
```

The _profile description_ MAY be equivalent to the
[RO-Crate Website](structure.md#ro-crate-website-ro-crate-previewhtml-and-ro-crate-preview_files) entity
`ro-crate-preview.html` (becoming a data entity by listing it under `hasPart`):

```json
{
    "@id": "ro-crate-preview.html",
    "@type": "CreativeWork",
    "name": "RO-Crate preview of the Process Run Crate",
    "encodingFormat": "text/html",
    "about": "https://w3id.org/ro/wfrun/process/0.1"
}
```


#### Profile Schema entity

An optional machine-readable _schema_ of the profile, for instance a [Describo JSON profile]:

```json
{
    "@id": "https://raw.githubusercontent.com/UTS-eResearch/describo/v0.13.0/src/components/profiles/paradisec.describo.profile.json",
    "@type": "File",
    "name": "PARADISEC profile for Describo",
    "encodingFormat": "application/json",
    "conformsTo": {"@id": "https://github.com/UTS-eResearch/describo/wiki/dsp-index#profile-structure"}
},
{ 
    "@id": "#hasSchema",
    "@type": "ResourceDescriptor",
    "hasRole": { "@id": "http://www.w3.org/ns/dx/prof/role/schema" },
    "hasArtifact": {"@id": "https://raw.githubusercontent.com/UTS-eResearch/describo/v0.13.0/src/components/profiles/paradisec.describo.profile.json"}
},
{
    "@id": "https://github.com/UTS-eResearch/describo/wiki/dsp-index#profile-structure",
    "@type": "Profile",
    "name": "Describo JSON profile"
}
```

A schema may formalize restrictions on the 
[RO-Crate Metadata Document](root-data-entity.md#ro-crate-metadata-file-descriptor) on 
a graph-level (e.g. what types/properties) as well as serialization level
(e.g. use of JSON arrays). 

This interpretation of _schema_ assumes the resource somewhat describes the data structure, e.g. expected types and attributes the RO-Crate's JSON-LD. Use alternatively the role `http://www.w3.org/ns/dx/prof/role/validation` if the schema is primarily a set of constraint for validation purposes, or `http://www.w3.org/ns/dx/prof/role/vocabulary` for ontologies and term listings.



Below are known schema types in their recommended media type, with suggested identifiers for the contextual entities of
[encodingFormat](data-entities.md#adding-detailed-descriptions-of-encodings) with type `Standard` and `conformsTo` with type `Profile`:

| Name           | `encodingFormat` Media Type   | `encodingFormat` URI   | `conformsTo` URI |  role  | 
| -------------- | ------------------------- | -------------------------- | ---------- |
| JSON Schema    | `application/schema+json` | <https://json-schema.org/draft/2020-12/schema> |  |  `schema` | 
| Crate-O        | `application/json`        | <https://www.nationalarchives.gov.uk/PRONOM/fmt/817> |  <https://github.com/Language-Research-Technology/ro-crate-editor-profiles>  | `schema` |
| Describo       | `application/json`        | <https://www.nationalarchives.gov.uk/PRONOM/fmt/817> | <https://github.com/describo/profiles> | `schema` |
| CheckMyCrate   | `application/json`        | <https://www.nationalarchives.gov.uk/PRONOM/fmt/817> | <https://github.com/KockataEPich/CheckMyCrate#profiles> | `validation` |
| SHACL          | `text/turtle`             | <https://www.nationalarchives.gov.uk/PRONOM/fmt/874> |  <https://www.w3.org/TR/shacl/> | `validation` |
| ShExC          | `text/shex`               | <http://shex.io/shex-semantics/#shexc> |  |  `validation`
| ShExJ          | `application/ld+json`     | <https://www.nationalarchives.gov.uk/PRONOM/fmt/880> | <http://shex.io/shex-semantics/#shexj> |  `validation` |
| BagIt Profile  | `application/json`        | <https://www.nationalarchives.gov.uk/PRONOM/fmt/817>  | <https://bagit-profiles.github.io/bagit-profiles-specification/> | `schema`
| SKOS           | `text/turtle`             | <https://www.nationalarchives.gov.uk/PRONOM/fmt/874> | <http://www.w3.org/TR/skos-reference> | `vocabulary`
| OWL 2 (in RDF) | `text/turtle`             | <https://www.nationalarchives.gov.uk/PRONOM/fmt/874> | <http://www.w3.org/TR/owl2-mapping-to-rdf/>  | `vocabulary` |
 

{: .tip }
Some of the above schema languages are based on general data structure syntaxes 
like `application/json` and `text/turtle`, and therefore have a 
generic  `encodingFormat` with a specialized `conformsTo` _URI_, which itself is declared as a `Profile`.



#### Software that works with the profile

[Software](provenance.md#software-used-to-create-files) that may consume/validate/generate RO-Crates following this profile (potentially using the schema):

```json
{
      "@id": "https://arkisto-platform.github.io/describo/",
      "@type": "SoftwareApplication",
      "name": "Describo",
      "version": "0.13.0",
      "url": "https://arkisto-platform.github.io/describo/"
}
```

#### Repositories that expect the profile

A [repository](provenance.md#digital-library-and-repository-content) or collection within a repository that may accept/contain RO-Crates following this profile:

```json
{
   "@id": "https://mod.paradisec.org.au/",
   "@type": "RepositoryCollection",
   "title":  "Modern PARADISEC demonstrator",   
   "description": "PARADISEC curates digital material about small or endangered languages",
   "publisher": {"@id": "https://paradisec.org.au/"}
}
```

#### BagIt packaging

If conforming RO-Crates should be [packaged](appendix/implementation-notes.md#adding-ro-crate-to-bagit) according to a [BagIt profile] (e.g. must be serialized as an `application/zip`):

```json
{
   "@id": "https://w3id.org/ro/bagit/profile/0.3",
   "@type": "Profile",
   "name":  "BagIt profile for RO-Crate in ZIP",
   "encodingFormat": [
        "application/json", 
        {"@id": "https://bagit-profiles.github.io/bagit-profiles-specification/"}
   ]   
}
```

<!-- TODO: Make BagIt profile similar to https://w3id.org/ro/bagit -->

#### Extension vocabularies

A profile that [extends RO-Crate](appendix/jsonld.md#extending-ro-crate) SHOULD indicate
which vocabulary/ontology it uses as a [DefinedTermSet]:

```json
{
    "@id": "https://w3id.org/ro/terms/test#",
    "@type": "DefinedTermSet",
    "name": "Namespace for workflow testing metadata",
    "url": "https://github.com/ResearchObject/ro-terms/tree/master/test",
},
{ 
    "@id": "#hasTestVocabulary",
    "@type": "ResourceDescriptor",
    "hasRole": { "@id": "http://www.w3.org/ns/dx/prof/role/vocabulary" },
    "hasArtifact": {"@id": "https://w3id.org/ro/terms/test#"}
}
```

The `@id` of the vocabulary SHOULD be the _namespace_, 
while `url` SHOULD go to a human-readable description of the vocabulary.

A profile that defines many extensions term MAY define its own `DefinedTermSet` and relate the terms using `hasDefinedTerm`:

```json
 {
    "@id": "https://w3id.org/cpm/ro-crate",
    "@type": "Dataset",
    "identifier": "https://w3id.org/cpm/ro-crate",
    "name": "Common Provenance Model RO-Crate profiles and vocabulary",
    "hasPart": [
      { "@id": "https://w3id.org/cpm/ro-crate#" }
    ],
    "hasResource": [
        { "@id": "#hasCPMVocabulary" }
    ]
  },
  { 
    "@id": "#hasCPMVocabulary",
    "@type": "ResourceDescriptor",
    "hasRole": { "@id": "http://www.w3.org/ns/dx/prof/role/vocabulary" },
    "hasArtifact": {"@id": "https://w3id.org/cpm/ro-crate#"}
  },  
  {
    "@id": "https://w3id.org/cpm/ro-crate#",
    "@type": "DefinedTermSet",
    "name": "Namespace for Common Provenance Model RO-Crate model",
    "hasDefinedTerm": [
      { "@id": "https://w3id.org/cpm/ro-crate#CPMProvenanceFile" },
      { "@id": "https://w3id.org/cpm/ro-crate#CPMMetaProvenanceFile" }
    ]
  },
  { 
    "@id": "https://w3id.org/cpm/ro-crate#CPMProvenanceFile",
    "@type": "DefinedTerm",
    "…" : ""
  }
```


#### Extension terms

A profile that [extends RO-Crate](appendix/jsonld.md#extending-ro-crate) MAY indicate particular terms
directly as [DefinedTerm], `rdfs:Class` and/or `rdf:Property` instances:

```json
{
    "@id": "https://w3id.org/ro/terms/test#runsOn",
    "@type": "DefinedTerm",
    "termCode": "runsOn",
    "name": "Runs on",
    "description": "Service where the test instance is executed",
    "url": "https://lifemonitor.eu/workflow_testing_ro_crate#test-instance"
}
```

The `termCode` SHOULD be valid as a key in JSON-LD `@context` of conforming RO-Crates. The term SHOULD be mapped to the terms' `@id` in the `@context` of this Profile Crate.



#### JSON-LD Context

A profile that have a corresponding JSON-LD `@context` (e.g. to map its extensions terms,
or to suggest a version of RO-Crate's official context) SHOULD indicate the 
context in the Profile Crate:

```json
{
    "@id": "https://w3id.org/ro/crate/1.2-DRAFT/context",
    "@type": "CreativeWork",
    "name": "RO-Crate JSON-LD Context",
    "encodingFormat": "application/ld+json",
    "conformsTo": {"@id": "http://www.w3.org/ns/json-ld#Context"},
    "version": "1.1.1"
},
{
    "@id": "http://www.w3.org/ns/json-ld#Context",
    "@type": "DefinedTerm",
    "name": "JSON-LD Context",
    "url": "https://www.w3.org/TR/json-ld/"
}
```

The JSON-LD Context entity:

* MUST have an `encodingFormat` of `application/ld+json`
* MUST have an absolute URI as `@id`, which MUST be retrievable as JSON-LD directly or with content-negotiation and/or HTTP redirects.
* SHOULD have a _permalink_ (persistent identifier) as `@id`
  - e.g. starting with <https://w3id.org/> <http://purl.org/>
  - MAY embed major.minor version in the PID, e.g. <https://w3id.org/ro/crate/1.2/context>
* SHOULD use `https` rather than `http` with a certificate commonly accepted by browsers
* SHOULD have a `@id` URI that is _versioned_ with [`MAJOR.MINOR`][semver], e.g. `https://example.com/image-profile-2.4`
* SHOULD have a descriptive [name]
* SHOULD have a `encodingFormat` to the contextual entity `http://www.w3.org/ns/json-ld#Context`
* MAY declare [version] according to [Semantic Versioning][semver]
- Updates MAY add new terms or patch fixes (with corresponding `version` change)
* Updates SHOULD NOT remove terms already published and potentially used by consumers of the profile
* Updates SHOULD NOT replace URIs terms map to -- except for typos.
* Including the `DefinedTerm` for JSON-LD is optional.

Note that the referenced context URI does _not_ have to match the `@context` of the Profile Crate itself.

{: .tip }
The `@context` MAY be the Profile Crate's Metadata JSON-LD file itself if 
it is [resolvable](appendix/jsonld.md#ro-crate-json-ld-media-type)
as media type `application/ld+json` over HTTP. Make sure the crate includes the 
defined terms both within its `@context` and ideally as entities in its `@graph`.


#### Multiple profiles

RO-Crate profiles sometimes build on each other. Note that unlike traditional object-oriented programming with strict class hierarchies, profiles are a looser construct of conventions rather than absolute rules. RO-Crate therefore do not enforce any particular "inheritance" across profiles.

A crate conforming to multiple RO-Crate profiles SHOULD explicitly declare `conformsTo` for each profile. Each profile MUST have a corresponding contextual entity for each.

A Profile Crate can _suggest_ interoperable profiles under `hasPart`, and recommend it by using the role `http://purl.org/dc/terms/conformsTo` in a resource descriptor:

```json

{
    "@id": "https://w3id.org/ro/wfrun/process/0.1",
    "@type": ["CreativeWork", "Profile"],
    "name": "Process Run crate profile",
    "version": "0.1.0"
},
{ 
    "@id": "#shouldConformTo",
    "@type": "ResourceDescriptor",
    "hasRole": { "@id": "http://purl.org/dc/terms/conformsTo" },
    "hasArtifact": {"@id": "https://w3id.org/ro/wfrun/process/0.1"}
}
```

Note that this does not enforce any particular hierarchy of profiles, thus listed profiles can be both more general or more specific than the given Profile Crate. A given profile MAY provide further recommendations or requirements for how the related profiles are to be used in its human-readable documentation.

It is NOT RECOMMENDED to include further elements of the referenced profiles, e.g. their `ResourceDescriptor`s, see [How to retrieve a Profile Crate](#how-to-retrieve-a-profile-crate). 


{% include references.liquid %}
