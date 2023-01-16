---
title: Profiles
excerpt: |
  Profiles of RO-Crates and their entities can be used to specialize and recommend
  further which metadata types and properties are expected.
nav_order: 9
parent: RO-Crate 1.2-DRAFT
---

# RO-Crate profiles
    
While RO-Crates can be considered general-purpose containers of arbitrary data and open-ended metadata, in practical use within a particular domain, application or framework, it will be beneficial to further constrain RO-Crate to a specific **profile**: a set of conventions, types and properties that one minimally can require and expect to be present in that subset of RO-Crates.

Defining and conforming to such a profile enables reliable programmatic consumption of an RO-Crate’s content, as well as consistent creation, e.g. a form in a user interface form firmly suggest the required types and properties, and likewise a rendering of an RO-Crate can easier make rich UI components if it can reliably assume for instance that the [`Person`](contextual-entities.md#people) always has an `affiliation` to a [`Organization`](contextual-entities.md#organizations-as-values) which has a `url` - a restriction that may not be appropriate for all types of RO-Crates.

As such RO-Crate Profiles can be considered a _duck typing_ mechanism for RO-Crates, but also as a classifier to indicate the crate's purpose, expectations and focus.

## Publishing an RO-Crate profile

An _RO-Crate profile_ is identified with a **Profile URI**.

Recommendations:
* The profile URI MUST resolve to a human-readable _profile description_ (e.g. a HTML web page)
  - The profile URI MAY have a corresponding machine-readable [_Profile Crate_](#profile-crate)
* The profile URI SHOULD be a _permalink_ (persistent identifier)
  - e.g. starting with <https://w3id.org/> <http://purl.org/> or <https://www.doi.org/>
* The profile URI SHOULD be _versioned_ with [`MAJOR.MINOR`][semver], e.g. `http://example.com/image-profile-2.4`
* The profile description SHOULD use key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL as described in [RFC2119].

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

* MUST have `Profile` listed amongst its `@type`, wwhich SHOULD be an array and SHOULD include `CreativeWork`.
* SHOULD have an absolute URI as `@id`
* SHOULD have a descriptive [name]
* MAY declare [version], preferably according to [Semantic Versioning][semver]

RO-Crates conforming to (or intending to conform to) such a profile declare this using `conformsTo` on the [root data entity](root-data-entity.md):

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

While the Profile URI `@id` must resolve to a human-readable _profile description_, it can additionally be made to [resolve](#how-to-retrieve-a-profile-crate) to a _Profile Crate_.

A **Profile Crate** is a type of RO-Crate that gathers resources which further define the profile. This allows formalizing alternative profile description for machine-readability, for instance for validation, but also additional resources like examples.


### How to retrieve a Profile Crate

To resolve a Profile URI to a machine-readable _Profile Crate_, two approaches are recommended to retrieve its [RO-Crate metadata file](root-data-entity.md#ro-crate-metadata-file-descriptor):

1. [HTTP Content-negotiation](https://httpd.apache.org/docs/2.4/content-negotiation.html) for the [RO-Crate media type](appendix/jsonld.md#ro-crate-json-ld-media-type), for example:  
  Requesting `https://w3id.org/ro/wfrun/process/0.1` with HTTP header  
  `Accept: application/ld+json;profile=https://w3id.org/ro/crate` redirects to the _RO-Crate Metadata file_
  `https://www.researchobject.org/workflow-run-crate/profiles/0.1/process_run_crate/ro-crate-metadata.json`
2. The above approach may fail (or returns a HTML page), e.g. for content-delivery networks that do not support content-negotiation. The fallback is to try resolving the path `./ro-crate-metadata.json` from the _resolved_ URI (after permalink redirects). For example:  
If permalink `https://w3id.org/workflowhub/workflow-ro-crate/1.0` redirects to `https://about.workflowhub.eu/Workflow-RO-Crate/1.0/index.html` (a HTML page), then
try retrieving `https://about.workflowhub.eu/Workflow-RO-Crate/1.0/ro-crate-metadata.json`
3. If none of these approaches worked, then this profile probably does not have a corresponding Profile Crate. For humans, display a hyperlink to its `@id` described by its `name`.

<!-- TODO Make both examples above actually work! -->

### What is included in the Profile Crate?

Below follows the suggested [data entities](data-entities.md) to include in a Profile Crate using `hasPart`:

#### Profile description entity

A Profile Crate MUST declare a human-readable _profile description_, which is [about] this Profile Crate and SHOULD have `encodingFormat` as `text/html`:

```json
{
    "@id": "index.html",
    "@type": "File",
    "name": "Workflow RO-Crate profile description",
    "encodingFormat": "text/html",
    "about": "./",
}
```

The _profile description_ MAY be equivalent to the
[RO-Crate Website](structure.md#ro-crate-website-ro-crate-previewhtml-and-ro-crate-preview_files)
`ro-crate-preview.html` (promoted to become a data entity):

```json
{
    "@id": "ro-crate-preview.html",
    "@type": "CreativeWork",
    "name": "RO-Crate preview of the Process Run Crate",
    "encodingFormat": "text/html",
    "about": "./",
}
```


#### Profile Schema entity


An optional machine-readable _schema_ of the profile, for instance a [Describo](https://arkisto-platform.github.io/describo/) [JSON profile](https://github.com/UTS-eResearch/describo/wiki/dsp-index):

```json
{
    "@id": "https://raw.githubusercontent.com/UTS-eResearch/describo/v0.13.0/src/components/profiles/paradisec.describo.profile.json",
    "@type": "File",
    "name": "PARADISEC profile for Describo",
    "encodingFormat": [
        "application/json", 
        {"@id": "https://github.com/UTS-eResearch/describo/wiki/dsp-index"}
    ]
},
{
    "@id": "https://github.com/UTS-eResearch/describo/wiki/dsp-index",
    "@type": "WebPage",
    "name": "Describo JSON profile"
}
```

A schema may formalize restrictions on the 
[RO-Crate metadata file](root-data-entity.md#ro-crate-metadata-file-descriptor) on 
a graph-level (e.g. what types/properties) as well as serialization level
(e.g. use of JSON arrays).

Below are known schema types and their suggested
[encodingFormat](data-entities.md#adding-detailed-descriptions-of-encodings) identifiers:

| Name          | Media Type                | URI                        |
| ------------- | ------------------------- | -------------------------- | 
| JSON Schema   | `application/schema+json` | <https://json-schema.org/draft/2020-12/schema> |
| Describo      | `application/json`        | <https://github.com/UTS-eResearch/describo/wiki/dsp-index> |
| CheckMyCrate  | `application/json`        | <https://github.com/KockataEPich/CheckMyCrate#profiles> |
| SHACL         | `text/turtle`             | <https://www.w3.org/TR/shacl/> |
| ShEx          | `text/shex`               | <http://shex.io/shex-semantics/> |
| BagIt Profile | `application/json`        | <https://bagit-profiles.github.io/bagit-profiles-specification/> |


{: .tip }
Some of the above schema languages are based on general data structure syntaxes 
like `application/json` and `text/turtle`, and therefore have a 
generic  _Media Type_ accompanied by a specialized  _URI_.


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
   "@type": "WebPage",
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
}
```

The `@id` of the vocabulary SHOULD be the _namespace_, 
while `url` SHOULD go to a human-readable description of the vocabulary.

#### Extension terms

A profile that [extends RO-Crate](appendix/jsonld.md#extending-ro-crate) MAY indicate particular terms
directly as [DefinedTerm] instances:

```json
{
    "@id": "https://w3id.org/ro/terms/test#runsOn",
    "@type": "DefinedTerm",
    "termCode": "runsOn",
    "name": "Runs on",
    "description": "Service where the test instance is executed",
    "url": "https://lifemonitor.eu/workflow_testing_ro_crate#test-instance",
}
```

The `termCode` SHOULD be valid as a key in JSON-LD `@context` of conforming RO-Crates.


#### JSON-LD Context

A profile that have a corresponding JSON-LD `@context` (e.g. to map its extensions terms,
or to suggest a version of RO-Crate's official context) SHOULD indicate the 
context in the Profile Crate:

```json
{
    "@id": "https://w3id.org/ro/crate/1.2-DRAFT/context",
    "@type": "CreativeWork",
    "name": "RO-Crate JSON-LD Context",
    "encodingFormat": [
        "application/ld+json",
        {"@id": "http://www.w3.org/ns/json-ld#Context"}
    ],
    "version": "1.1.1",
},
{
    "@id": "http://www.w3.org/ns/json-ld#Context",
    "@type": "Thing",
    "name": "JSON-LD Context",
    "url": "https://www.w3.org/TR/json-ld/"
}
```

The JSON-LD Context:

* SHOULD have a _permalink_ (persistent identifier) as `@id`
  - e.g. starting with <https://w3id.org/> <http://purl.org/>
* SHOULD use `https` rather than `http` with a certificate commonly accepted by browsers
* SHOULD have a `@id` URI that is _versioned_ with [`MAJOR.MINOR`][semver], e.g. `https://example.com/image-profile-2.4`
* SHOULD have a descriptive [name]
* SHOULD have a `encodingFormat` to the contextual entity `http://www.w3.org/ns/json-ld#Context`
* MAY declare [version] according to [Semantic Versioning][semver]

Note that the referenced context URI does _not_ have to match the `@context` of the Profile Crate itself.

{: .tip }
The `@context` MAY be the Profile Crate's Metadata JSON-LD file if 
it is [resolvable](appendix/jsonld.md#ro-crate-json-ld-media-type)
as media type `application/ld+json` over HTTP.

{% include references.liquid %}
