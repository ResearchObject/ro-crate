---
title: Quick reference
sidebar: resources
---


# RO-Crate Specification Quick Reference

## How to use this document

This document collates all the explicit requirements of the specification, while omitting all of the guidance, examples and notes. It is primarily intended for developers of tools which ingest/export/validate RO-Crates, though it may also be useful as a general resource. It should NOT be treated as a replacement for the spec itself!.

Requirements are grouped according to the part(s) of RO-Crate structure or the type(s) of entity they apply to. This means they are not necessarily in order in which they appear in the specification. Each table has a "primary source" listed at the top which links to the specification section containing the bulk of the requirements and guidance about that subject. Requirements which come from other sections have their source listed in the table itself.

If you have a question about a requirement, it may already be answered on the full specification page for that requirement, so check there first.

## RO-Crate Structure

[Structure - full specification](../structure)

### Metadata Document

[RO-Crate Metadata Document - full specification](../structure#ro-crate-metadata-document-ro-crate-metadatajson)

| Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------ | ------ | ------- | ------ | --- |
| RO-Crate Metadata Document | MUST | Must be UTF-8 | [source](../data-entities.md#encoding-file-paths-in-ids)  |  |
| RO-Crate Metadata Document | MUST | Must be valid [JSON-LD 1.0] |  |  |
| RO-Crate Metadata Document | MUST | The JSON-LD must be [flattened] |  |  |
| RO-Crate Metadata Document | MUST | The JSON-LD must be [compacted] |  |  |
| RO-Crate Metadata Document | MUST | The JSON-LD must use the _RO-Crate JSON-LD Context_ <https://w3id.org/ro/crate/1.2-DRAFT/context> by reference |  | updated version, upgraded to MUST |
| `@graph` | MUST | Must describe the [RO-Crate Metadata Descriptor](../root-data-entity#ro-crate-metadata-descriptor) | |  |
| `@graph` | MUST | Must describe the [Root Data Entity](../root-data-entity#direct-properties-of-the-root-data-entity) | |  |
| `@graph` | MUST | Must describe zero or more [Data Entities](../data-entities) | |  |
| `@graph` | MUST | Must describe zero or more [Contextual Entities](../contextual-entities) | |  |
| `@graph` | SHOULD | Any contextual entity in the `@graph` SHOULD be linked to from at least one of the other entities using its `@id`.   |
| `@graph` | SHOULD | Any contextual entity referenced by entities in the `@graph` SHOULD be described in the same `@graph`.  |

### Attached RO-Crate

Though the concept of attached RO-Crates is new in version 1.2, most of the requirements in this section were present in the 1.1 specification. The difference is that there is now a second type of RO-Crate - the [Detached RO-Crate](#detached-ro-crate) - to which these requirements do not apply. Put another way, the requirements listed in this section that applied to all RO-Crates in version 1.1 now only apply to Attached RO-Crates.

[Attached RO-Crate - full specification](../structure#attached-ro-crate-package)

| Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------ | ------ | ------- | ------ | --- |
| Whole RO-Crate | SHOULD | Should be self-describing and self-contained | | |
| RO-Crate Metadata Document | MUST | Must be present as a file in the RO-Crate Root |  | |
| RO-Crate Metadata Document | MUST | In crates conforming to version 1.1+, must be named `ro-crate-metadata.json` |  | |
| RO-Crate Metadata Document | MAY | In crates conforming to version 1.0 and earlier, may be named `ro-crate-metadata.jsonld` |  | |
| RO-Crate Root | MUST | Must contain `ro-crate-metadata.json` | | |
| RO-Crate Root | MAY | May contain `ro-crate-preview.html`, a human-readable HTML rendering of the same information contained in the RO-Crate Metadata Document (see [RO-Crate Website requirements](#ro-crate-website)) | | |
| RO-Crate Root | MAY | May contain subdirectory `ro-crate-preview_files/` with other RO-Crate website files | | |
| RO-Crate Root | MUST | Must contain 0 or more payload files and directories | | |
| `@graph` | MAY | Each payload file and directory in the RO-Crate Root MAY be represented as a [Data Entity](../data-entities) in the `@graph`. | | |
| `@graph` | MAY | May include [Web-based Data Entities](../data-entities.html#web-based-data-entities) which are not part of the payload | |  |
| `@graph` | SHOULD NOT | Should NOT include `ro-crate-preview.html` or `ro-crate-preview_files/` in the `hasPart` property of the _Root Data Entity_ or any other `Dataset` entity, even if they are present in the _RO-Crate Root_ | Exception: `ro-crate-preview.html` may be included in `hasPart` if it is **also** the profile description within a Profile Crate (see [Profile Crate](#profile-crate) section) | New |
| `@graph` | MAY | May include metadata about parts of the _RO-Crate Website_, such as `author`, `dateCreated` or other provenance | | New |
| `@graph` | MAY | May include scientific workflows and scripts that were used (or can be used) to analyze or generate files contained in the RO-Crate | [source](../workflows) | |
| Root Data Entity `@id` | MUST | Must be either `./` or be a URI which is considered to be the main identifier of the RO-Crate | | Updated - previously SHOULD be `./` but now both options are equally acceptable |

### Detached RO-Crate

[Detached RO-Crate - full specification](../structure#detached-ro-crate-package)

| Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------ | ------ | ------- | ------ | --- |
| RO-Crate Metadata Document | SHOULD | If stored in a file, SHOULD be named `${prefix}-ro-crate-metadata.json`, where the variable `${prefix}` is a human readable version of the dataset's ID or name | [source](../structure#types-of-ro-crate) | New |
| Root Data Entity `@id` | SHOULD | If the crate is available online, should be an absolute URL | | New |
| Root Data Entity `@id` | MAY | If the crate is not yet or will never be available online, may be any valid URI, including `./` | | New |
| `@graph` | MUST | All [data entities](../data-entities) in `@graph` must be [Web-based Data Entities](../data-entities.html#web-based-data-entities) | | New |


### RO-Crate Website

[RO-Crate Website - full specification](../structure#ro-crate-website-ro-crate-previewhtml-and-ro-crate-preview_files-for-packages)

| Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------ | ------ | ------- | ------ | --- |
| RO-Crate Website | MUST | If website is present, it must be a file named `ro-crate-preview.html` in the root directory | | New (implied in 1.1) |
| RO-Crate Website | MAY | May serve as the entry point to additional web resources | | New (implied in 1.1) |
| RO-Crate Website Additional Resources | MUST | Must be in `ro-crate-preview_files/` in the root directory | | New (implied in 1.1) |
| `ro-crate-preview.html` | MUST | Must be a valid [HTML 5] document | | |
| RO-Crate Website | MUST | Must be useful to users of the RO-Crate | | |
| RO-Crate Website | SHOULD | Should display at least the metadata relating to the _Root Data Entity_ as static HTML without the need for scripting | | |
| RO-Crate Website | MAY | May contain extra features enabled by JavaScript. | | |
| RO-Crate Website - Entity | SHOULD | When entity A references entity B, if B's `@id` is an external URI, A should provide a link to that URI | | |
| RO-Crate Website - Entity | SHOULD | When entity A references entity B, if B's `@id` is not an external URI, and B has a [name] property, A should provide a link to B's HTML version | | |
| RO-Crate Website - Entity | SHOULD | When entity A references entity B, if B's `@id` is not an external URI, and B does not have a [name] property, A should show B embedded in A's HTML | | |
| RO-Crate Website - Key | SHOULD | For keys that resolve in the `RO-Crate JSON-LD Context` to a URI, website should indicate this | | |

Removed 1.1 -> 1.2: 
* RO-Crate Website MUST: Contain a copy of the RO-Crate JSON-LD in a script element of the head element of the HTML
* RO-Crate Website SHOULD: If there is sufficient metadata, contain a prominent “Cite-as” text with a natural language data citation

## Metadata

[Metadata - Full specification](../metadata)

### All Entities

[All entities - full specification](../metadata#common-principles-for-ro-crate-entities)

Unless otherwise specified, all properties are optional. Constraints on properties apply only if the property is present.

Most of the "new" requirements here are not truly new, but were implied in 1.1 and have now been made explicit.

| Property/Target | Severity | Description | Notes | Changed in 1.2 | 
| ------| ------ | ------- | ------ | --- | 
| `@id` | MUST | Must be present | | New |
| `@id` | MUST | Must be unique in the `@graph` (no two entities may share an `@id`) | [source](../contextual-entities#contextual-vs-data-entities) |  |
| `@id` | MUST | If the entity is both a data entity and a contextual entity, it must be described as a single object (i.e. with a single `@id`) in `@graph` | [source](../contextual-entities#contextual-vs-data-entities) | |
| `@type` | MUST | Must be present | | New |
| `@type` | SHOULD | Should include at least one [Schema.org] type that accurately describes the entity | | New |
| `@type` | MAY | May be an array | | |
| `@type` | SHOULD | If the entity is both a data entity and a contextual entity, should list both relevant data and contextual types | [source](../contextual-entities#contextual-vs-data-entities) | |
| [name] | SHOULD | Should be present | | New |
| [name] | SHOULD | Should be human-readable | | New |
| additional properties | SHOULD | Should be applicable to the `@type` (or superclass) according to their definitions | | New |
| additional properties | MAY | May be present, including [custom properties](https://www.researchobject.org/ro-crate/specification/1.2-DRAFT/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms) | If validating RO-Crates with RDF shape constraints, this means you must not use closed shapes | |
| additional properties | MAY | If the RO-Crate conforms to a profile, it may use [custom properties](https://www.researchobject.org/ro-crate/specification/1.2-DRAFT/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms) defined in that profile's [Profile Crate](../profiles#profile-crate) without making any additional contextual entities | using and copying terms are both valid, see below. [source](../profiles#how-to-retrieve-a-profile-crate) | New |
| additional properties | MUST | If the RO-Crate uses a [custom property or class](https://www.researchobject.org/ro-crate/specification/1.2-DRAFT/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms) from a [Profile Crate](../profiles#profile-crate) without making additional contextual entities, it must use the full URI corresponding to the `@id` of that property/class within the Profile Crate, or be mapped to that URIs from the RO-Crate's JSON-LD `@context` | This can usually be achieved by importing whatever additional `@context` the profile recommends. [source](../profiles#how-to-retrieve-a-profile-crate) | New |
| additional properties | MAY | If the RO-Crate conforms to a profile, it may copy across entities from that profile's [Profile Crate](../profiles#profile-crate) that define [custom properties](https://www.researchobject.org/ro-crate/specification/1.2-DRAFT/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms) | using and copying terms are both valid, see line above. This way is useful for archiving. [source](../profiles#how-to-retrieve-a-profile-crate) | New |
| additional properties `@id` | SHOULD | If the RO-Crate conforms to a profile and copies entities from that profile's [Profile Crate](../profiles#profile-crate) which define [custom properties](https://www.researchobject.org/ro-crate/specification/1.2-DRAFT/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms), the shared entities should have absolute URIs as `@id` |  [source](../profiles#how-to-retrieve-a-profile-crate) | New |
| property references to other entities | MUST | Must use the `{ "@id": "..."}` object form |  | New |
| the entity itself | SHOULD | Should be ultimately referenceable from the root data entity (possibly through another reachable [data entity](../data-entities) or [contextual entity](../contextual-entities)) | | New |
| nested entities | MUST NOT | Must NOT be present - instead describe these as separate contextual entities in the flat `@graph` list | as the JSON-LD must be [flattened] | |
| `citation` | SHOULD | If present, should reference a [ScholarlyArticle] or [CreativeWork] entity | [source](../contextual-entities#publications-via-citation-property) | |
| `thumbnail` | MAY | May be present | applies mainly to [File] entities. [source](../contextual-entities#thumbnails) | |
| `thumbnail` | MUST | If present, must reference a [File] data entity within the RO-Crate | [source](../contextual-entities#thumbnails) | |

## Root Data Entity

[Root Data Entity – full specification](../root-data-entity)

### RO-Crate Metadata Descriptor

[RO-Crate Metadata Descriptor – full specification](../root-data-entity#ro-crate-metadata-descriptor)

| Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------| ------ | ------- | ------- | --- |
| `@id` | MUST | Must be `ro-crate-metadata.json` | | |
| `@type` | MUST | Must be [CreativeWork] | | |
| [about] | MUST | Must be present | | |
| [about] | MUST | Must reference the _Root Data Entity_'s `@id` | | |
| [conformsTo] | SHOULD | Should be present | | |
| [conformsTo] | SHOULD | Should have a single value | In 1.2+, any additional profile declarations should be included on the Root Data Entity instead of the Metadata Descriptor | New |
| [conformsTo] | SHOULD | Should be a versioned permalink URI of the RO-Crate specification that the _RO-Crate JSON-LD_ conforms to | | |
| [conformsTo] | SHOULD | URI should start with `https://w3id.org/ro/crate/` if referencing the base RO-Crate specification | | |
| [conformsTo] | MAY | In RO-Crates conforming to version 1.1 and earlier, [conformsTo] may be an array, to additionally indicate [RO-Crate profiles](../profiles) | Introduced to support existing community usage of `conformsTo` which wasn't in the 1.1 spec | New |

### Root Data Entity

[RO-Crate Metadata Descriptor – full specification](../root-data-entity#direct-properties-of-the-root-data-entity)

| Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------| ------ | ------- | ------- | --- |
| `@id` | SHOULD | Should be the string `./` or an absolute URI | | Updated - no longer needs to end with `/` and absolute URIs are now acceptable |
| `@type` | MUST | Must be [Dataset] or an array that contains `Dataset` | | | |
| [name] | MUST | Must be present | | |
| [name] | SHOULD | Should identify the dataset to humans well enough to disambiguate it from other RO-Crates | | |
| [description] | MUST | Must be present | | |
| [description] | SHOULD | Should elaborate on the name to provide a summary of the context in which the dataset is important | | |
| [datePublished] | MUST | Must be present | | |
| [datePublished] | MUST | Must be a single string value in [ISO 8601 date format][DateTime] | | Updated - added "single" |
| [datePublished] | SHOULD | Should be specified to at least the precision of a day | | |
| [datePublished] | MAY | May be a timestamp down to the millisecond | | |
| [license] | MUST| Must be present | | |
| [license] | SHOULD | Should reference a _Contextual Entity_ or _Data Entity_ in the _RO-Crate Metadata Document_ | see [contextual entities for licenses](#TODO) | Updated - added "or _Data Entity_" |
| [license] | MAY | May be a textual description of how the RO-Crate may be used | | |
| [identifier] | SHOULD | If the RO-Crate has a persistent identifier, should be present | | |
| [identifier] | SHOULD | If present, should use the approach set out in the [Science On Schema.org guides] to reference a contextual entity for the identifier | see [contextual entities for identifiers](#TODO) | New |
| [identifier] | SHOULD | Should be a DOI (including referencing an entity whose `@id` is a DOI), if possible | [source](../metadata#recommended-identifiers) | | |
| [identifier] | SHOULD | Resolving the `identifier` programmatically should return the _RO-Crate Metadata Document_ or an archive (e.g. ZIP) that contains the _RO-Crate Metadata File_, using [content negotiation](../data-entities#retrieving-an-ro-crate) and/or [Signposting] | | New |
| [identifier] | MAY | Be a string | | Updated - downgraded from SHOULD |
| `cite-as` | MUST | If present, must ultimately have the RO-Crate as a downloadable item | | New |
| `cite-as` | SHOULD | If the RO-Crate identifier is persistent and resolvable from a URI, this should be indicated using the `cite-as` property according to [RFC8574] | | New |
| `cite-as` | SHOULD | The RO-Crate download should be programmatically accessible through content negotiation or [Signposting] | | New |
| `cite-as` | MAY | May go to a repository landing page | | New |
| `cite-as` | MAY | May require authentication | | New |
| HTTP/HTTPS server of the resolved RO-Crate Metadata Document or archive | SHOULD | Should indicate the persistent identifier in its [Signposting] headers using `Link rel="cite-as"`  | | New |
| `publisher` | SHOULD | Should be present | [source](../contextual-entities#publisher) | |
| `publisher` | SHOULD | Should reference an [Organization] | [source](../contextual-entities#publisher) | |
| `publisher` | MAY | May reference a [Person] | [source](../contextual-entities#publisher) | |
| `funder` | SHOULD | Should reference all funders directly, including those that are also referenced by entities included in `hasPart`. | [source](../contextual-entities#funding-and-grants) | |
| `hasPart` | MUST | Must directly or indirectly (via nested `hasPart`) reference all _Data Entities_ in the RO-Crate JSON-LD | [source](../data-entities#referencing-files-and-folders-from-the-root-data-entity) | |
| `hasPart` | MAY | May refer to files anywhere within the folder hierarchy within the _RO-Crate Root_ | [source](../data-entities#referencing-files-and-folders-from-the-root-data-entity) | |
| `hasPart` | MAY | May reference additional entities, such as `File`s and `Dataset`s with local identifiers | i.e. does not need to exclusively reference the data entities. [source](../data-entities#referencing-files-and-folders-from-the-root-data-entity) | |
| `distribution` | MAY | May be present | [source](../data-entities.md#downloadable-dataset) |
| `distribution` | MAY | If present, should be the URI of an archive that contains the _RO-Crate Metadata Document_ | [source](../data-entities.md#downloadable-dataset) |
| `conformsTo` | SHOULD | Should be present if the RO-Crate conforms to additional [RO-Crate profiles](../profiles.md) beyond the base specification | [source](../profiles.md#declaring-conformance-of-an-ro-crate-profile) | New |
| `conformsTo` | MUST | If present, each value must reference a contextual entity of type [Profile] representing a profile the RO-Crate conforms to | [source](../profiles.md#declaring-conformance-of-an-ro-crate-profile) | New |


Removed 1.1 -> 1.2:
`license` MAY: MAY have a URI (eg for Creative Commons or Open Source licenses).

## Data Entities

[Data Entities - full specification](../data-entities)

A data entity is an entity which fulfils both of the following criteria:
* its `@type` includes `File` or `Dataset`.
* its `@id` is an absolute URI or a relative URI.

A `File` or `Dataset` entity may have an `@id` which is a local identifier beginning with a `#`, in which case it is **not** considered to be a `Data Entity` and the rules below do not apply (though they can be used as best practices).

| Type of data entity | Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------- | ------| ------ | ------- | ------ | ----- |
| Any | `@id` | MUST | Must be a valid URI reference. This includes using `/` separator for relative paths, and escaping special characters | | |
| Any | `@id` | MUST | If the entity represents a file or directory present in the _RO-Crate Root_, `@id` must be a relative URI | | New |
| Any | `@id` | MUST | If `@id` is a relative URI, the file or directory represented by the entity must be present in the _RO-Crate Root_ at that relative path | | New |
| Any | `@id` | MUST | If in a [Detached RO-Crate](../structure#detached-ro-crate-package), `@id` must be an absolute URI | | New |
| Any | `@id` | SHOULD | International characters in identifiers should be written using native UTF-8 characters | | |
| Any | `@id` | MAY | May include traditional URL encoding of Unicode characters with `%`  | | |
| Any | `@type` | MAY | May be an array | | |
| Any | `name` | SHOULD | Should be present | | New |
| Any | `description` | SHOULD | Should be present | | New |
| Any | `license` | SHOULD | If the license of the data is different to the `license` on the _Root Data Entity_, `license` should be present | [source](../contextual-entities#licensing-access-control-and-copyright) | |
| Any | `license` | SHOULD | Should reference a [CreativeWork] entity | [source](../contextual-entities#licensing-access-control-and-copyright) | |
| Any | `contentLocation` / `spatialCoverage` | SHOULD | One of these properties should be present if the entity is associated with a geographical location or region | [source](../contextual-entities#places) | Updated - now allows `spatialCoverage` to be used |
| Any | `contentLocation` / `spatialCoverage` | SHOULD | If present, should reference a [Place] entity | [source](../contextual-entities#places) | |
| Any | `about` | MUST | Subject properties (equivalent to a [Dublin Core Subject](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/terms/subject/)) must use the [about] property | [source](../contextual-entities#subjects--keywords) | |
| Any | `keywords` | MUST | Keyword properties must use the [keywords] property | [source](../contextual-entities#subjects--keywords) | |
| Any | `temporalCoverage` | implicit | Should be present if the entity is associated with a time period | implicit due to phrasing, treated as a recommendation. [source](../contextual-entities#time) | |
| Any | `citation` | MUST | If associating a publication with a dataset, `citation` must include a URL (for example a DOI URL) as the `@id` of a publication | See example in [source](../contextual-entities#publications-via-citation-property) | |
| Any | `citation` | SHOULD | If present, should reference a [ScholarlyArticle] or [CreativeWork] entity | [source](../contextual-entities#publications-via-citation-property) | |
| Any | `identifier` | MAY | May be a published DOI that primarily captures that file or dataset | [source](../contextual-entities#publications-via-citation-property) | |
| Any | `encodingFormat` | SHOULD | If the data entity is a subresource of an RO-Crate Profile Crate, `encodingFormat` should be present | [source](../profiles#what-is-included-in-the-profile-crate) | New |
| CreativeWork (including File and Dataset) | `author` | SHOULD | If present, should reference one or more [Person] entities | [source](../contextual-entities#people) | |
| CreativeWork (including File and Dataset) | `creditText` | MAY | For `CreativeWork` entities, may be present to provide a textual citation for the entity | [source](../root-data-entity#resolvable-persistent-identifiers-and-citation-text) | New |
| File | `@id` | MUST | Must be a relative or absolute URI | |
| File | `@id` | MUST | If `@id` is a URI outside the _RO-Crate Root_, then at the time of the RO-Crate's creation, the data should be directly downloadable from that URI by a simple non-interactive retrieval of a single data stream, permitting redirections and HTTP/HTTPS authentication | see examples in [source](../data-entities.md#web-based-data-entities) |
| File | `@type` | MUST | Must be `File`, or an array where `File` is one of the values | |
| File | `contentURL` | MAY | May be present | |
| File | `contentURL` | SHOULD | If present, following the link (allowing for HTTP redirects) should directly download the file represented by the entity | | New |
| File | `encodingFormat` | SHOULD | Should be present | | New |
| File | `encodingFormat` | SHOULD | Should be an IANA [media type] as a string and/or a reference to a [file format](../data-entities#adding-detailed-descriptions-of-file-encodings) contextual entity | see [contextual entities for file formats](#TODO) | Updated - added string option |
| File | `encodingFormat` | MAY | May be a local description of the format if there is no web-accessible description | | |
| File | `conformsTo` | SHOULD | Should be present if the file follows a particular profile of the encoding format | | New |
| File | `conformsTo` | SHOULD | If present, should reference a contextual entity of type [Profile] | | New |
| File | `contentSize` | SHOULD | Should be present | | New |
| File | `contentSize` | SHOULD | Should be the size of the file in bytes | | New |
| File | `identifier`, `url`, `subjectOf`, `mainEntityOfPage` | MAY | May reference a relevant web presence for the entity | see [source](../data-entities#data-entities-in-an-attached-ro-crate-that-are-also-on-the-web) for further guidance |
| File | `identifier`, `url`, `subjectOf`, `mainEntityOfPage` | SHOULD | If the entity is both in the _RO-Crate Root_ and on the web, one of these properties should be used to link to the relevant web presence | see [source](../data-entities#data-entities-in-an-attached-ro-crate-that-are-also-on-the-web) for further guidance |
| Thumbnail (File) | usage | MUST | Must be present in the BagIt manifest if in a [_Bagged RO-Crate_](appendix/implementation-notes#adding-ro-crate-to-bagit) | [source](../contextual-entities#thumbnails)
| Dataset | usage | MAY | May encapsulate a set of files without describing them individually as File data entities | | New |
| Dataset | `@id` | MUST | Must be a relative URI, an absolute URI, or a local identifier beginning with `#` | |
| Dataset | `@id` | SHOULD | If `@id` is a relative URI, it should end with `/` | | Updated - added "If `@id` is a relative URI" |
| Dataset | `@id` | SHOULD | If `@id` is an absolute URI, it should resolve to a programmatic listing of the content of the "directory" | | |
| Dataset | `@type` | MUST | Must be `Dataset` or an array where `Dataset` is one of the values | |
| Dataset | `hasPart` | SHOULD | Should be present | | New |
| Dataset | `hasPart` | SHOULD | Should list any directly contained data entities | | New |
| Dataset | `hasPart` | MAY | May include other Datasets to represent a nested folder hierarchy | 
| Dataset | `hasPart` | SHOULD | If the `@id` is a web URI, either `hasPart` should contain a complete listing of the dataset's content, or the dataset should be an RO-Crate | | Updated - added RO-Crate option |
| Dataset | `distribution` | SHOULD | Should be present if the `@id` is a web URI | | New |
| Dataset | `distribution` | MAY | If the dataset represented by the entity is an RO-Crate, `distribution` may be present | | New |
| Dataset | `distribution` | MAY | If the dataset represented by the entity is an RO-Crate, `distribution` should be the URI of an archive that contains the _RO-Crate Metadata Document_ | | New |
| Dataset | `funder` | SHOULD | Should be present if a research project is associated with the dataset | [source](../contextual-entities#funding-and-grants)
| Dataset | `funder` | SHOULD | Should reference an [Organization] entity | [source](../contextual-entities#funding-and-grants)
| Dataset or ScholarlyArticle | `publisher` | SHOULD | Should reference an [Organization] entity | [source](../contextual-entities#organizations-as-values) | |
| Web-based File or Dataset | `@id` | SHOULD NOT | Should not reference intermediate resources such as splash-pages, search services or web-based viewer applications | | New |
| Web-based File or Dataset | `@id` | SHOULD | RO-Crate creators should improve the persistence and long-term preservation of web resources included in an RO-Crate | | |
| Web-based File or Dataset | `sdDatePublished` | SHOULD | Should be present
| Web-based File or Dataset | `sdDatePublished` | SHOULD | Should indicate when the `@id` was accessed
| Web-based File or Dataset | `localPath` | MAY | May indicate a destination path that can be used when downloading the data | | New |

* A `File` entity MAY have an `@id` that is a local identifier beginning with `#`, in which case it is **not** considered to be a Data Entity.
    * though it MAY still be linked to the _Root Data Entity_ via [hasPart].
* If `contentUrl` has more than one value, then a checker service SHOULD try each provided value until one resolves and returns a correct [contentSize].

### Referenced RO-Crates

[Referenced RO-Crates – full specification](../data-entities#referencing-other-ro-crates)

This section describes how an RO-Crate A may reference another RO-Crate B. Properties in the "Property/Target" column are properties of **the data entity within A that represents B**.

| Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------- | ------| ------ | ------- | --- |
| All | MUST | Must follow requirements for [Directory Data Entities](#data-entities)  | | New |
| `@id` | SHOULD | If B's RDE has an `identifier` declared, `@id` should be that identifier | | New |
| `@id` | SHOULD | If A is [attached](../structure#attached-ro-crate-package) and B is a nested folder within A, `@id` should be the relative path to B from A's _RO-Crate Root_. | | New |
| `@id` | SHOULD | If the conditions above do not apply, and B's RDE `@id` is an absolute URI or can be converted to one (see [source](../data-entities#determining-entity-identifier-for-a-referenced-ro-crate) for guidance), and that URI resolves according to [Retrieving an RO-Crate](../data-entities#retrieving-an-ro-crate), `@id` should be that absolute URI | | New |
| `sdDatePublished` | SHOULD | If the condition above applies, but the absolute URI does not have [Signposting] declared for a `Link:` with `rel=cite-as`, `sdDatePublished` should be present | | New |
| `sdDatePublished` | SHOULD | If present, should indicate when the URI in the `@id` was accessed | | New |
| `@id` | MAY | If B is not on the Web, and does not have a persistent identifier, then a non-resolvable identifier may be used. | | New |
| `@id` | MAY | If B's metadata document is on the Web, but the above conditions fail to determine `@id`, then a non-resolvable identifier may be used. | | New |
| `subjectOf` | SHOULD | If the condition above applies, should be present | | New |
| `subjectOf` | SHOULD | If present, should reference a contextual entity representing B's metadata descriptor | See [contextual entity for referenced RO-Crate metadata descriptor](#TODO) | New |
| `conformsTo` | SHOULD | Should include the versionless RO-Crate base profile `https://w3id.org/ro/crate` | | New |
| `conformsTo` | MUST NOT | Must NOT include a specific version of the RO-Crate base profile (such as `https://w3id.org/ro/crate/1.1`) | | New |
| `conformsTo` | MAY | May reference contextual entities representing [RO-Crate profiles](../profiles) (specific versions are permitted) | | New |

* Consumers that find a reference to a `Dataset` with the generic RO-Crate profile indicated MAY attempt to resolve the persistent identifier, but SHOULD NOT assume that the `@id` directly resolves to an RO-Crate Metadata Document. 
* It is NOT RECOMMENDED to resolve a relative root identifier if the metadata document was retrieved from a URI that does not end with `/ro-crate-metadata.json`, `/*-ro-crate-metadata.json` or `/ro-crate-metadata.jsonld` -- these are not part of a valid [Attached](structure.html#attached-ro-crate-package) or [Detached](structure.html#detached-ro-crate-package) RO-Crate Package.

## Contextual Entities

[Contextual Entities – full specification](../contextual-entities)

The RO-Crate SHOULD contain additional information about _Contextual Entities_ for the use of both humans (in `ro-crate-preview.html`) and machines (in `ro-crate-metadata.json`).

| Type of contextual entity | Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------- | ------| ------ | ------- | ------- | ----- |
| Any | `@id` | SHOULD | If an existing permalink or other absolute URI is reasonably unique for that entity, that URI should be used as `@id` |
| Any | `@type` | SHOULD | If the entity is from a repository, should include [RepositoryObject] in addition to any other types | [source](../provenance#recording-changes-to-ro-crates) |
| Person | `@id` | SHOULD | Should be an ORCID identifier, if possible | [source](../metadata#recommended-identifiers) | 
| Person | `name` | implicit | Should be present | Shown in a best practice example |
| Person | `affiliation` | implicit | Should be present | Shown in a best practice example |
| Person | `affiliation` | SHOULD | Should reference an [Organization] entity | [source](../contextual-entities#organizations-as-values) |
| Person / Organization | `contactPoint` | SHOULD | Should be present in at least one of the entities that is referenced as [author] or [publisher] from the _Root Data Entity_ |
| Person / Organization | `contactPoint` | SHOULD | Should reference a [ContactPoint] contextual entity |
| Organization | `@id` | SHOULD | Should be an ROR identifier, if possible | [source](../metadata#recommended-identifiers)
| Organization | `funder` | SHOULD | If relevant, should reference any external [funder], either by using its URL as an `@id` or via a _Contextual Entity_ describing the funder. |
| License | `@id` | SHOULD | Should be the URL of the license |
| License | `@type` | SHOULD | Should be [CreativeWork] |
| License | `name` | SHOULD | Should be present | [source](../root-data-entity#direct-properties-of-the-root-data-entity) |
| License | `description` | SHOULD | Should be present | [source](../root-data-entity#direct-properties-of-the-root-data-entity) |
| License | `description` | SHOULD | Should contain a summary of the license |
| Place | `@id` | SHOULD | Should be a [geonames] ID, e.g. `http://sws.geonames.org/8152662/` | [source](../metadata#recommended-identifiers) | 
| Place | `geo` | SHOULD | If the entity includes point or shape geometry, `geo` should be present | | New |
| Place | `geo` | SHOULD | Should reference a [Geometry] entity | | New |
| Geometry | `asWKT` | SHOULD | Should express the point or shape in [Well Known Text (WKT)](https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry) format |
| Item of physical equipment | `@id` | SHOULD | Should be a URL to a web page describing the equipment | [source](../provenance#equipment-used-to-create-files) |
| Item of physical equipment | `@type` | SHOULD | Should be [IndividualProduct] | [source](../provenance#equipment-used-to-create-files) |
| Item of physical equipment | `description` | implicit | Should include serial number and manufacturer that identify the equipment as completely as possible | the SHOULD is present but doesn't say which property to use, so `description` is assumed. [source](../provenance#equipment-used-to-create-files) |
| Software application | `@type` | SHOULD | Should be [SoftwareApplication] | [source](../provenance#software-used-to-create-files)
| Software application | `version` | SHOULD | Should be present | [source](../provenance#software-used-to-create-files)
| RepositoryCollection | usage | MAY | May be used to group [RepositoryObject] entities | [source](../provenance#recording-changes-to-ro-crates) |
| RepositoryCollection | `hasMember` | MAY | May reference [RepositoryObject] entities | [source](../provenance#recording-changes-to-ro-crates) |
| Encoding format | `@id` | SHOULD | Should be a [PRONOM] identifier if one exists for the format | [source](../data-entities#adding-detailed-descriptions-of-file-encodings) |
| Encoding format | `@id` | MAY | May be a URL that is not a PRONOM identifier | [source](../data-entities#adding-detailed-descriptions-of-file-encodings) |
| Encoding format | `@type` | SHOULD | Should contain [WebPage] | [source](../data-entities#adding-detailed-descriptions-of-file-encodings) | Updated - changed from [WebSite] to [WebPage]|
| Encoding format | `@type` | SHOULD | Should contain `Standard` if the `@id` link sufficiently documents the format | [source](../data-entities#adding-detailed-descriptions-of-file-encodings) | New |
| Encoding format | `@type` | SHOULD NOT | Should NOT contain `Standard` if the `@id` link does not sufficiently document the format | [source](../data-entities#adding-detailed-descriptions-of-file-encodings) | New |
| Encoding format | `@type` | MAY | May include [WebPageElement] if the `@id` links to a section of a webpage | [source](../data-entities#adding-detailed-descriptions-of-file-encodings) | New |
| Metadata descriptor for a referenced RO-Crate | `encodingFormat` | SHOULD | Should be `"application/ld+json"` or an equivalent representation of JSON-LD | [source](../data-entities#referencing-another-metadata-document) | New |
| Metadata descriptor for a referenced RO-Crate | `conformsTo` | SHOULD NOT | Should NOT be present | [source](../data-entities#referencing-another-metadata-document) | New |
| Metadata descriptor for a referenced RO-Crate | `about` | SHOULD NOT | Should NOT be present | [source](../data-entities#referencing-another-metadata-document) | New |
| Persistent identifier | `@type` | SHOULD | Should be [PropertyValue] | [source](../root-data-entity#root-data-entity-identifier) | New |
| Persistent identifier | `value` | MUST | Must be present | [source](../root-data-entity#root-data-entity-identifier) | New |
| Persistent identifier | `value` | MUST | Must be human-readable | [source](../root-data-entity#root-data-entity-identifier) | New |
| Persistent identifier | `url` | SHOULD | Should be present if the identifier is Web-resolvable | [source](../root-data-entity#root-data-entity-identifier) | New |
| Persistent identifier | `description` | MAY | May include a citable representation of this persistent identifier | [source](../root-data-entity#root-data-entity-identifier) | New |
| RO-Crate profile | `@id` | SHOULD | Should be an absolute URI | [source](../profiles#declaring-conformance-of-an-ro-crate-profile) | New |
| RO-Crate profile | `@type` | MUST | Must include [Profile] | [source](../profiles#declaring-conformance-of-an-ro-crate-profile) | New |
| RO-Crate profile | `@type` | SHOULD | Should be an array | [source](../profiles#declaring-conformance-of-an-ro-crate-profile) | New |
| RO-Crate profile | `@type` | SHOULD | Should include [CreativeWork] if the profile is a web page | [source](../profiles#declaring-conformance-of-an-ro-crate-profile) | New |
| RO-Crate profile | `@type` | SHOULD | Should include [Dataset] if the profile is a Profile Crate | [source](../profiles#declaring-conformance-of-an-ro-crate-profile) | New |
| RO-Crate profile | `name` | SHOULD | Should be present | [source](../profiles#declaring-conformance-of-an-ro-crate-profile) | New |
| RO-Crate profile | `name` | SHOULD | Should be descriptive | [source](../profiles#declaring-conformance-of-an-ro-crate-profile) | New |
| RO-Crate profile | `version` | MAY | May be present | [Semantic Versioning][semver] preferred. [source](../profiles#declaring-conformance-of-an-ro-crate-profile) | New |
| RO-Crate profile | `distribution` | MAY | May link to a snapshot copy of the Profile Crate | Follow guidance for [dataset distributions](data-entities#directories-on-the-web-dataset-distributions). Useful for archiving. [source](../profiles#archiving-profile-crates) | New |
| Programming language | `@type` | implicit | Should include `ComputerLanguage` | "`programmingLanguage`, implied to be a `ComputerLanguage`". [source](../workflows#workflow-runtime-and-programming-language) | |
| Programming language | `@type` | MAY | May include `SoftwareApplication` if the runtime of the language is essentially the same as the language itself | e.g. for Python and R [source](../workflows#workflow-runtime-and-programming-language) | |
| `ComputerLanguage` or `SoftwareApplication` | `name` | MUST | Must be present |[source](../workflows#workflow-runtime-and-programming-language) | |
| `ComputerLanguage` or `SoftwareApplication` | `url` | MUST | Must be present |[source](../workflows#workflow-runtime-and-programming-language) | |
| `ComputerLanguage` or `SoftwareApplication` | `version` | MUST | Must be present |[source](../workflows#workflow-runtime-and-programming-language) | |
| `ComputerLanguage` or `SoftwareApplication` | `version` | SHOULD | Should indicate a known version that linked workflows/scripts were developed/tested with |[source](../workflows#workflow-runtime-and-programming-language) | |
| `ComputerLanguage` or `SoftwareApplication` | `alternateName` | MAY | May be present if there is a shorter colloquial name for the language/software | [source](../workflows#workflow-runtime-and-programming-language) | |

## Focus of an RO-Crate

[Focus of an RO-Crate - full specification](../crate-focus)

Whole page seems to be guidelines, not requirements

## Provenance of entities

[Provenance of entities - full specification](../provenance)

This section is unchanged from version 1.1 to version 1.2.

A software application or item of equipment SHOULD be associated with the [File]\(s) (or other [data entities](../data-entities)) it created as an [instrument] of a [CreateAction], with the [File] referenced by a [result] property. Any input files SHOULD be referenced by the [object] property.

| Type of entity | Property/Target | Severity | Description | Notes |
| ------- | ------| ------ | ------- | ------- |
| All Actions | `instrument` | MAY | May be present |
| All Actions | `instrument` | SHOULD | Should reference an entity of type [IndividualProduct] (equipment) or [SoftwareApplication] (software), except if multiple [SoftwareApplication]s were used together | phrasing implies that this might be expected to be a single value |
| All Actions | `name` | SHOULD | Should be present |
| All Actions | `description` | MAY | May be present |
| All Actions | `endTime` | SHOULD | Should be present |
| All Actions | `endTime` | MUST | Must be in [ISO 8601 date format][DateTime] |
| All Actions | `endTime` | SHOULD | Should be specified to at least the precision of a day |
| All Actions | `startTime` | MAY | MAY be present |
| All Actions | `startTime` | MUST | Must be in [ISO 8601 date format][DateTime] |
| All Actions | `startTime` | SHOULD | Should be specified to at least the precision of a day |
| All Actions | `agent` | SHOULD | Should be present |
| All Actions | `agent` | implicit | Should reference a [Person] entity who was responsible for authorizing the action | says a "human [agent]" should be referenced |
| All Actions | `actionStatus` | MAY | May be present |
| All Actions | `actionStatus` | MUST | MUST be must be one of the values enumerated by [ActionStatusType]: [ActiveActionStatus], [CompletedActionStatus], [FailedActionStatus] or [PotentialActionStatus] |
| All Actions | `error` | MAY | If the Action failed, may include error information |
| CreateAction | `instrument` | SHOULD | If multiple [SoftwareApplication]s were used together, should reference a [SoftwareSourceCode] entity representing the whole [workflow](../workflows) |
| CreateAction | `result` | implicit | Should reference one or more entities representing the outputs of the action | only formally stated for [File]s |
| CreateAction | `object` | implicit | Should reference one or more entities representing the inputs of the action | only formally stated for [File]s |
| CreateAction | `name` | MAY | May be human-readable |
| CreateAction | `name` | MAY | May be machine-generated |
| CreateAction / UpdateAction | usage | SHOULD | To record an action which changes an entity's metadata, or changes its state in a publication or other workflow, a [CreateAction] or [UpdateAction] SHOULD be associated with a [Data Entity](../data-entities) or, for the RO-Crate itself, with the [root data entity](../root-data-entity). | not clear if this requirement stands alone or if the following requirements elaborate upon it |
| CreateAction | usage | SHOULD | Should be used for actions which modify a [File] within a Dataset |
| Action which creates data entities | `result` | SHOULD | Should reference the data entities that were created |
| UpdateAction | usage | SHOULD | Should only be used for actions which affect the Dataset as a whole, such as movement through a workflow | |
| Curation action | `object` | MUST | Must be present |
| Curation action | `object` | MUST | Must reference the _Root Data Entity_ or one of the entities in its `hasPart` |
| File | usage | SHOULD | If a [CreateAction] modifies a file within a dataset, the old version should be retained and a [CreateAction] added which has the original version as its [object] and the new version as its [result] |

## RO-Crate Profiles

[RO-Crate profiles - full specification](../profiles)

### All Profiles

These requirements apply to all profiles, regardless of where or how they are published.

| Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------ | ------ | ------- | ------ | --- |
| URI | MUST | Must resolve to a human-readable _profile description_ (e.g. a HTML web page) | | New |
| URI | SHOULD | Should be a permalink/persistent identifier | | New |
| URI | SHOULD | Should be versioned with [`MAJOR.MINOR`][semver] | | New |
| URI | MAY | May have a corresponding machine-readable [_Profile Crate_](#profile-crate) | | New |
| URI | MAY | May resolve to a [_Profile Crate_](#profile-crate) **in addition to** the human-readable profile description | | New |
| Profile description | SHOULD | Should use key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL as described in [RFC 2119] | | New |
| Profile description | MAY | May require/suggest which `@type` of [data entities](data-entities) and/or [contextual entities](contextual-entities) are expected | | New |
| Profile description | MAY | May require/suggest _properties_ expected per type of entity | e.g. _"Each [CreativeWork] MUST declare a [license]"_ | New |
| Profile description | MAY | May require/suggest a particular [version of RO-Crate](https://www.researchobject.org/ro-crate/specification.html) | | New |
| Profile description | MAY | May recommend [RO-Crate extensions](appendix/jsonld#extending-ro-crate) with domain-specific terms and vocabularies | | New |
| Profile description | MAY | May require/suggest a particular [JSON-LD context](appendix/jsonld?highlight=@context#ro-crate-json-ld-context) | | New |
| Profile description | MAY | May require/suggest a particular RO-Crate publishing method or [packaging](appendix/implementation-notes#combining-with-other-packaging-schemes) like .zip or BagIt | | New |
| Profile description | MAY | May provide further recommendations or requirements for how any related RO-Crate profiles are to be used | [source](../profiles#multiple-profiles) | New |


### Profile Crate 

[Profile Crate - full specification](../profiles#profile-crate)

These requirements apply **in addition to** the requirements in [All Profiles](#all-profiles) above.

Entities with a (D) are data entities; entities with a (C) are contextual entities.

| Type of Entity | Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------ | ------ | ------ | ------- | ------ | ----- |
| Whole crate | `@context` / recommended context | SHOULD | Should include a mapping to any absolute URIs used to define [custom properties or classes](../appendix/jsonld#adding-new-or-ad-hoc-vocabulary-terms) | See [Extending RO-Crate](appendix/jsonld#extending-ro-crate) | New |
| Whole crate | `@context` / recommended context | SHOULD | Updates to the context should NOT remove terms already published and potentially used by consumers of the profile | | New |
| Whole crate | `@context` / recommended context | SHOULD | Updates to the context should NOT replace URIs terms map to -- except for typos. | | New |
| Whole crate | `@context` / recommended context | MAY | Updates MAY add new terms or patch fixes (with corresponding `version` change in the RO-Crate metadata) | | New |
| Whole crate | `@context` | MAY | May be the crate's metadata JSON-LD file itself, if the file is resolvable as media type `application/ld+json` over HTTP | | New |
| Root Data Entity (D) | `@id` | SHOULD | Should be an absolute URI | | New |
| Root Data Entity (D) | `@type` | MUST | Must include [Profile] | | New |
| Root Data Entity (D) | `identifier` | SHOULD | If the `@id` is a permanent URI, `identifier` should be the same URI | | New |
| Root Data Entity (D) | `name` | SHOULD | Should be descriptive | | New |
| Root Data Entity (D) | `hasPart` | MUST | Must reference the human-readable _profile description_ as a data entity | | New |
| Root Data Entity (D) | `hasPart` | SHOULD | Should list related data entities | | New |
| Root Data Entity (D) | `hasPart` | MAY | If the _profile description_ is equivalent to the _RO-Crate website_ entity, that entity may be listed in `hasPart` (contrary to the [usual recommendations](#ro-crate-website)) | | New |
| Root Data Entity (D) | `hasPart` | implicit | May _suggest_ other RO-Crate profiles which are interoperable with this one | text uses "can" rather than "may". [source](../profiles#multiple-profiles) |  |
| Root Data Entity (D) | `hasResource` | MAY | May list descriptors of profile resources | | New |
| Root Data Entity (D) | `hasResource` | SHOULD | If the profile [extends RO-Crate](../appendix/jsonld#extending-ro-crate), should reference a `ResourceDescriptor` for the vocabulary/ontology used | | New |
| Root Data Entity (D) | `version` | MAY | May be present | [Semantic Versioning][semver] preferred | New |
| Root Data Entity (D) | `isProfileOf` | SHOULD | Should be present | | New |
| Root Data Entity (D) | `isProfileOf` | SHOULD | Should reference the minimally expected RO-Crate specification | | New |
| Root Data Entity (D) | `isProfileOf` | MAY | May reference a contextual entity for the specification | | New |
| Any resource (D) | `encodingFormat` | SHOULD | If the resource is referenced from `hasArtifact` on a `ResourceDescriptor`, `encodingFormat` should be present | | New |
| Profile description resource (D) | `about` | MUST | Must reference the _Root Data Entity_ | | New |
| Profile description resource (D) | `encodingFormat` | SHOULD | Should be `text/htmlNew `
| Profile description resource (D) | entity | MAY | May be equivalent to the [_RO-Crate Website_ entity](#ro-crate-website) New |
| Resource descriptor (C) | `@type` | SHOULD | Should include `ResourceDescriptor` | [source](../profiles#what-is-included-in-the-profile-crate) | New |
| Resource descriptor (C) | `hasRole` | implicit | Should reference the role of the resource | See [common roles in the Profiles Vocabulary](Profiles Vocabulary). Implicit from the example in the [source](../profiles#what-is-included-in-the-profile-crate) | New |
| Resource descriptor (C) | `hasRole` | SHOULD | If describing the _profile description_ resource, should be `http://www.w3.org/ns/dx/prof/role/specification` or `http://www.w3.org/ns/dx/prof/role/guidance` | New |
| Resource descriptor (C) | `hasRole` | implicit | If describing an external vocabulary, should be `http://www.w3.org/ns/dx/prof/role/vocabulary` | Implicit from example | New |
| Resource descriptor (C) | `hasRole` | MAY | If describing another RO-Crate profile that is interoperable with this one, may be `http://purl.org/dc/terms/conformsTo` | text uses "can" rather than "may". [source](../profiles#multiple-profiles) | New |
| Resource descriptor (C) | `hasArtifact` | SHOULD | Should reference a data entity representing the subresource itself | [source](../profiles#what-is-included-in-the-profile-crate) | New |
| Resource descriptor (C) | `dct:format` | MAY | May be present | [source](../profiles#what-is-included-in-the-profile-crate) | New |
| Resource descriptor (C) | `dct:conformsTo` | MAY | May be present | [source](../profiles#what-is-included-in-the-profile-crate) | New |
| External vocabulary (D) | `@id` | SHOULD | Should be the namespace of the vocabulary | | New |
| External vocabulary (D) | `@type` | SHOULD | Should be [DefinedTermSet] | | New |
| External vocabulary (D) | `url` | SHOULD | Should link to a human-readable description of the vocabulary | | New |
| Custom vocabulary (D) | entity | MAY | May be present | | New |
| Custom vocabulary (D) | `@type` | MAY | May include `DefinedTermSet` | | New |
| Custom vocabulary (D) | `hasDefinedTerm` | MAY | May list custom terms defined by the profile | | New |
| Custom term (D) | entity | MAY | May be present with or without a parent `DefinedTermSet` | | New |
| Custom term (D) | `@type` | MAY | May include `DefinedTerm`, `rdfs:Class` and/or `rdf:Property` | | New |
| Custom term (D) | `termCode` | SHOULD | Should be valid as a key in JSON-LD `@context` of conforming RO-Crates | | New |
| JSON-LD context (C) | entity | SHOULD | Should be present if the profile has a corresponding JSON-LD `@context` | | New |
| JSON-LD context (C) | `@id` | MUST | Must be an absolute URI | | New |
| JSON-LD context (C) | `@id` | MUST | Must be retrievable as JSON-LD directly or with content-negotiation and/or HTTP redirects | | New |
| JSON-LD context (C) | `@id` | SHOULD | Should be a permalink / persistent identifier | | New |
| JSON-LD context (C) | `@id` | SHOULD | Should be versioned with [`MAJOR.MINOR`][semver] | | New |
| JSON-LD context (C) | `@id` | SHOULD | Should use `https` rather than `http` with a certificate commonly accepted by browsers | | New |
| JSON-LD context (C) | `encodingFormat` | MUST | Must be `application/ld+json` | | New |
| JSON-LD context (C) | `encodingFormat` | MUST | Must be `application/ld+json` | | New |
| JSON-LD context (C) | `name` | SHOULD | Should be present | | New |
| JSON-LD context (C) | `name` | SHOULD | Should be descriptive | | New |
| JSON-LD context (C) | `conformsTo` | SHOULD | Should be present | | New |
| JSON-LD context (C) | `conformsTo` | SHOULD | Should reference the contextual entity `http://www.w3.org/ns/json-ld#Context` | | New |
| JSON-LD context (C) | `version` | MAY | May declare [version] according to [Semantic Versioning][semver] | | New |
| `http://www.w3.org/ns/json-ld#Context` (C) | entity | MAY | May be present | Not required, even if the JSON-LD context `conformsTo` references it | New |
| `http://www.w3.org/ns/json-ld#Context` (C) | `@type` | implicit | Should be `DefinedTerm` | Implicit from example and phrasing | New |
| Interoperable RO-Crate profile (C) | entity | MAY | May be present | | New |
| Interoperable RO-Crate profile sub-elements (C) | entity | SHOULD NOT | Should not be present | | New |


## Workflows and Scripts

[Workflows and scripts - full specification](../workflows)

| Type of Entity | Property/Target | Severity | Description | Notes | Changed in 1.2 |
| ------ | ------ | ------ | ------- | ------ | --- |
| Script | `@type` | MUST | Must include both `File` and `SoftwareSourceCode` | | |
| Script | `@id` | MUST | Must be a URI linking to the executable script | | |
| Script | `name` | MUST | Must be present | | |
| Script | `name` | MUST | Must be human-readable | | |
| Workflow | `@type` | MUST | Must include all of `File`, `SoftwareSourceCode`, and `ComputationalWorkflow` | | |
| Workflow | `@id` | MUST | Must be a URI linking to the workflow entry-point | | |
| Workflow | `name` | MUST | Must be present | | |
| Workflow | `name` | MUST | Must be human-readable | | |
| Workflow | entity | SHOULD | Should conform to the Bioschemas [ComputationalWorkflow][ComputationalWorkflow profile 1.0] profile | To conform, properties listed under "Marginality: Minimum" MUST be present, and properties listed under "Marginality: Recommended" SHOULD be present | Updated suggested target version from 0.5-DRAFT to 1.0 |
| Workflow | `conformsTo` | SHOULD | If conforming to the Bioschemas [ComputationalWorkflow][ComputationalWorkflow profile 1.0] profile, `conformsTo` should include the versioned URI for that profile | | |
| Script or Workflow | `programmingLanguage` | SHOULD | Should be present | | |
| Script or Workflow | `programmingLanguage` | SHOULD | Should reference a `ComputerLanguage` representing the runtime of the workflow | Often the language and runtime are the essentially the same, but they may differ | |
| Script or Workflow | `hasPart` | implicit | May reference `SoftwareApplication` or `SoftwareSourceCode` entities representing steps of the script/workflow | text uses "it is possible to" rather than "may" | |
| Script or Workflow | `image` | implicit | Should reference an `ImageObject` data entity representing a diagram/sketch which explains the script/workflow | Implicit in phrasing | |
| Script or Workflow | `input` | implicit | May reference `FormalParameter` contextual entities representing inputs | text uses "can" rather than "may" | |
| Script or Workflow | `output` | implicit | May reference `FormalParameter` contextual entities representing outputs | text uses "can" rather than "may" | |
| Script or Workflow related `ImageObject` | `encodingFormat` | SHOULD | Should be present | |
| Script or Workflow related `ImageObject` | `encodingFormat` | SHOULD | Should include an IANA [media type] as a string | see [contextual entities for file formats](#TODO) | | |
| Script or Workflow related `ImageObject` | `encodingFormat` | SHOULD | Should include the [Pronom] identifier for the format, which may be a reference to a [file format](../data-entities#adding-detailed-descriptions-of-file-encodings) contextual entity | see [contextual entities for file formats](#TODO) | | |
| Script or Workflow related `ImageObject` | `about` | SHOULD | Should reference the script/workflow that the image explains | Implicit in phrasing | |
| Script or Workflow related `ImageObject` | `about` | SHOULD | If there is no programmatic `SoftwareSourceCode` that can be executed, `about` should reference the datasets that the workflow created | | |
| `FormalParameter` | entity | MAY | May conform to the Bioschemas [FormalParameter][FormalParameter profile 1.0] profile | To conform, properties listed under "Marginality: Minimum" MUST be present, abnd properties listed under "Marginality: Recommended" SHOULD be present. Implicit | Updated suggested target version from 0.1-DRAFT to 1.0 |
| `FormalParameter` | `conformsTo` | SHOULD | If conforming to the Bioschemas [FormalParameter][FormalParameter profile 1.0] profile, `conformsTo` should include the versioned URI for that profile | | |

{% include references.liquid %}
