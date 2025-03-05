# RO-Crate Specification Quick Reference

This document collates all the explicit requirements of the specification, while omitting all of the guidance, examples and notes. It is primarily intended for developers of tools which ingest/export/validate RO-Crates, though it may also be useful as a general resource. It should NOT be treated as a replacement for the spec itself!

If you have questions, your first port of call should be the full specification page for the item you have questions about.

Requirements are grouped according to the part(s) of RO-Crate structure or the type(s) of entity they apply to. This means they are not necessarily in order in which they appear in the specification. Each table has a "primary source" listed at the top which links to the specification section containing the bulk of the requirements and guidance about that subject. Requirements which come from other sections have their source listed in the table itself.

## RO-Crate Structure

[Structure - Full specification](structure)

### Metadata Document

[RO-Crate Metadata Document - full reference](structure#ro-crate-metadata-document-ro-crate-metadatajson)

| Property/Target | Severity | Description | Eli attention |
| ------ | ------ | ------- | ------ |
| RO-Crate Metadata Document | MUST | Must be valid [JSON-LD 1.0] |  |
| RO-Crate Metadata Document | MUST | The JSON-LD must be [flattened] |  |
| RO-Crate Metadata Document | MUST | The JSON-LD must be [compacted] |  |
| RO-Crate Metadata Document | MUST | The JSON-LD must use the _RO-Crate JSON-LD Context_ <https://w3id.org/ro/crate/1.2-DRAFT/context> by reference |  |
| `@graph` | MUST | Must describe the [RO-Crate Metadata Descriptor](root-data-entity#ro-crate-metadata-descriptor) | |
| `@graph` | MUST | Must describe the [Root Data Entity](root-data-entity#direct-properties-of-the-root-data-entity) | |
| `@graph` | MUST | Must describe zero or more [Data Entities](data-entities) | |
| `@graph` | MUST | Must describe zero or more [Contextual Entities](contextual-entities) | |
| `@graph` | SHOULD | Any contextual entity in the `@graph` SHOULD be linked to from at least one of the other entities using its `@id`. 
| `@graph` | SHOULD | Any contextual entity referenced by entities in the `@graph` SHOULD be described in the same `@graph`.

### Attached RO-Crate

[Attached RO-Crate - full reference](structure#attached-ro-crate-package)

| Property/Target | Severity | Description | Eli attention |
| ------ | ------ | ------- | ------ |
| Whole RO-Crate | SHOULD | Should be self-describing and self-contained | |
| RO-Crate Metadata Document | MUST | Must be present as a file in the RO-Crate Root |  |
| RO-Crate Metadata Document | MUST | Must be named `ro-crate-metadata.json` |  |
| RO-Crate Root | MUST | Must contain `ro-crate-metadata.json` | |
| RO-Crate Root | MAY | May contain `ro-crate-preview.html`, a human-readable HTML rendering of the same information contained in the RO-Crate Metadata Document (see [RO-Crate Website requirements](#ro-crate-website)) | |
| RO-Crate Root | MAY | May contain subdirectory `ro-crate-preview_files/` with other RO-Crate website files | |
| RO-Crate Root | MUST | Must contain 0 or more payload files and directories | |
| `@graph` | MAY | Each payload file and directory in the RO-Crate Root MAY be represented as a [Data Entity](data-entities) in the `@graph`.
| `@graph` | MAY | May include [Web-based Data Entities](data-entities.html#web-based-data-entities) which are not part of the payload | | 
| `@graph` | SHOULD NOT | Should NOT include `ro-crate-preview.html` or `ro-crate-preview-files/` in the `hasPart` property of the _Root Data Entity_ or any other `Dataset` entity, even if they are present in the _RO-Crate Root_ | |
| `@graph` | MAY | May include metadata about parts of the _RO-Crate Website_, such as `author`, `dateCreated` or other provenance | |
| Root Data Entity `@id` | MUST | Must be either `./` or be a URI which is considered to be the main identifier of the RO-Crate | |

### Detached RO-Crate

[Detached RO-Crate - full reference](structure#detached-ro-crate-package)

| Property/Target | Severity | Description | Eli attention |
| ------ | ------ | ------- | ------ |
| RO-Crate Metadata Document | SHOULD | If stored in a file, SHOULD be named `${prefix}-ro-crate-metadata.json`, where the variable `${prefix}` is a human readable version of the dataset's ID or name | [source](structure#types-of-ro-crate) |
| Root Data Entity `@id` | SHOULD | If the crate is available online, should be an absolute URL | |
| Root Data Entity `@id` | MAY | If the crate is not yet or will never be available online, may be any valid URI, including `./` | |
| `@graph` | MUST | All [data entities](data-entities) in `@graph` must be [Web-based Data Entities](data-entities.html#web-based-data-entities) | |


### RO-Crate Website

[RO-Crate Website - full reference](structure#ro-crate-website-ro-crate-previewhtml-and-ro-crate-preview_files-for-packages)

| Property/Target | Severity | Description | Eli attention |
| ------ | ------ | ------- | ------ |
| RO-Crate Website | MUST | If website is present, it must be a file named `ro-crate-preview.html` in the root directory | |
| RO-Crate Website | MAY | May serve as the entry point to additional web resources | |
| RO-Crate Website Additional Resources | MUST | Must be in `ro-crate-preview_files/` in the root directory | |
| `ro-crate-preview.html` | MUST | Must be a valid [HTML 5] document | |
| RO-Crate Website | MUST | Must be useful to users of the RO-Crate | |
| RO-Crate Website | SHOULD | Should display at least the metadata relating to the _Root Data Entity_ as static HTML without the need for scripting | |
| RO-Crate Website | MAY | May contain extra features enabled by JavaScript. | |
| RO-Crate Website - Entity | SHOULD | When entity A references entity B, if B's `@id` is an external URI, A should provide a link to that URI | |
| RO-Crate Website - Entity | SHOULD | When entity A references entity B, if B's `@id` is not an external URI, and B has a [name] property, A should provide a link to B's HTML version | |
| RO-Crate Website - Entity | SHOULD | When entity A references entity B, if B's `@id` is not an external URI, and B does not have a [name] property, A should show B embedded in A's HTML | |
| RO-Crate Website - Key | SHOULD | For keys that resolve in the `RO-Crate JSON-LD Context` to a URI, website should indicate this | |


## Metadata

[Metadata - Full specification](metadata)

### All Entities

[All entities - full reference](metadata#common-principles-for-ro-crate-entities)

Unless otherwise specified, all properties are optional. Constraints on properties apply only if the property is present.

Unless otherwise specified, all entities MAY have additional properties not included in the specification. This includes [custom properties](https://www.researchobject.org/ro-crate/specification/1.2-DRAFT/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms).

1. The entity MUST have an `@id`.
1. The entity `@id` must be unique in the `@graph` (i.e. no two entities may share the same `@id`). [[source](contextual-entities.md#contextual-vs-data-entities)]
2. The entity MUST have a `@type`, which MAY be an array. 
3. The `@type` SHOULD include at least one [Schema.org] type that accurately describe the entity.
3. If a data entity is also a contextual entity (or vice versa):
    1. it MUST be described as a single JSON-LD object in the RO-Crate Metadata JSON-LD `@graph` 
    1. it SHOULD list both relevant data and contextual types in its `@type` array
5. The entity SHOULD have a human-readable `name`.
6. The properties used on the entity SHOULD be applicable to the `@type` (or superclass) according to their definitions.
7. Property references to other entities MUST use the `{ "@id": "..."}` object form.
8. The entity SHOULD be ultimately referenceable from the root data entity (possibly through another reachable [data entity](data-entities) or [contextual entity](contextual-entities)).


| Property/Target | Severity | Description | Eli attention |
| ------| ------ | ------- | ------ |
| `@id` | MUST | Must be present |
| `@id` | MUST | Must be unique in the `@graph` (no two entities may share an `@id`) | [source](contextual-entities.md#contextual-vs-data-entities)
| `@id` | MUST | If the entity is both a data entity and a contextual entity, it must be described as a single object (i.e. with a single `@id`) in `@graph` | [source](contextual-entities.md#contextual-vs-data-entities)
| `@type` | MUST | Must be present |
| `@type` | SHOULD | Should include at least one [Schema.org] type that accurately describes the entity |
| `@type` | MAY | May be an array |
| `@type` | SHOULD | If the entity is both a data entity and a contextual entity, should list both relevant data and contextual types | [source](contextual-entities.md#contextual-vs-data-entities)
| [name] | SHOULD | Should be present |
| [name] | SHOULD | Should be human-readable | hard to machine-test
| additional properties | SHOULD | Should be applicable to the `@type` (or superclass) according to their definitions |
| additional properties | MAY | May be present, including [custom properties](https://www.researchobject.org/ro-crate/specification/1.2-DRAFT/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms) | non-closed shapes
| property references to other entities | MUST | Must use the `{ "@id": "..."}` object form | 
| the entity itself | SHOULD | Should be ultimately referenceable from the root data entity (possibly through another reachable [data entity](data-entities) or [contextual entity](contextual-entities)) |
| nested entities | SHOULD | Should not be present - instead describe these as separate contextual entities in the flat `@graph` list | MUST? |
| `citation` | SHOULD | Should reference a [ScholarlyArticle] or [CreativeWork] entity | [source](contextual-entities#publications-via-citation-property) - CHECK THESE REQS they're weird
| `thumbnail` | MAY | May be present | applies mainly to [File] entities. [source](contextual-entities#thumbnails)
| `thumbnail` | MUST | If present, must reference a [File] data entity within the RO-Crate | [source](contextual-entities#thumbnails)

### CreativeWork entities

| Property/Target | Severity | Description | Eli attention |
| ------| ------ | ------- | ------ |
| `author` | SHOULD | If present, should reference one or more [Person] entities | [source](contextual-entities#people)
| `creditText` | MAY | For `CreativeWork` entities, may be present to provide a textual citation for the entity | [source](root-data-entity#resolvable-persistent-identifiers-and-citation-text)
| `publisher` | SHOULD | For a [Dataset] or [ScholarlyArticle], should reference an [Organization] entity | [source](contextual-entities#organizations-as-values)


### Recommended Identifiers

[Recommended Identifiers - full reference](metadata#recommended-identifiers)

_RO-Crate JSON-LD_ SHOULD use the following IDs where possible:

* For a _Root Data Entity_, an `identifier` which is RECOMMENDED to be a  <https://doi.org/> URI. 
* For a [Person]: [ORCID] identifiers, e.g. <https://orcid.org/0000-0002-1825-0097>
* For [Organization]s including [funder]s,  [Research Organization Registry URIs], e.g. <https://ror.org/0384j8v12>
* For entities of type [Place], a [geonames] URL, e.g. <http://sws.geonames.org/8152662/>
* For file formats, a [Pronom] URL, for example <https://www.nationalarchives.gov.uk/PRONOM/fmt/831>.

In the absence of the above, RO-Crates SHOULD contain stable persistent URIs to identify all entities wherever possible.

## Root Data Entity

[Root Data Entity – full specification](root-data-entity)

### RO-Crate Metadata Descriptor

1. The _RO-Crate Metadata Document_ MUST contain a self-describing **RO-Crate Metadata Descriptor** with the `@id` value `ro-crate-metadata.json` and `@type` [CreativeWork].
2. The _RO-Crate Metadata Descriptor_ MUST have an [about] property referencing the _Root Data Entity_'s `@id`.
3. The [conformsTo] of the _RO-Crate Metadata Descriptor_ SHOULD be a versioned permalink URI of the RO-Crate specification that the _RO-Crate JSON-LD_ conforms to. 
    1. This URI SHOULD start with `https://w3id.org/ro/crate/`. 
    2. The `conformsTo` property MAY be an array, to additionally indicate specializing [RO-Crate profiles](profiles).

| Property/Target | Severity | Description | Eli attention |
| ------| ------ | ------- | ------- |
| `@id` | MUST | Must be `ro-crate-metadata.json` |
| `@type` | MUST | Must be [CreativeWork] |
| [about] | MUST | Must be present |
| [about] | MUST | Must reference the _Root Data Entity_'s `@id` |
| [conformsTo] | MUST | Must be present | NOT ACTUALLY STATED?
| [conformsTo] | SHOULD | Should be a versioned permalink URI of the RO-Crate specification that the _RO-Crate JSON-LD_ conforms to |
| [conformsTo] | SHOULD | URI should start with `https://w3id.org/ro/crate/` if referencing the base RO-Crate specification |
| [conformsTo] | MAY | MAY be an array, to additionally indicate specializing [RO-Crate profiles](profiles) | Is this changing? |

### Root Data Entity

The _Root Data Entity_ MUST have the following properties:

*  `@type`: MUST be [Dataset] or an array that contains `Dataset`
*  `@id`:  SHOULD be the string `./` or an absolute URI (see [below](#root-data-entity-identifier))
*  `name`: SHOULD identify the dataset to humans well enough to disambiguate it from other RO-Crates
*  `description`: SHOULD further elaborate on the name to provide a summary of the context in which the dataset is important.
*  `datePublished`: MUST be a single string value in [ISO 8601 date format][DateTime], SHOULD be specified to at least the precision of a day, and MAY be a timestamp down to the millisecond. 
*  `license`: SHOULD link to a _Contextual Entity_ or _Data Entity_ in the _RO-Crate Metadata Document_ with a name and description (see section on [licensing](contextual-entities#licensing-access-control-and-copyright)). MAY, if necessary, be a textual description of how the RO-Crate may be used. 

* RO-Crates that have been assigned a _persistent identifier_ (e.g. a DOI) SHOULD indicate this using [identifier] on the Root Data Entity using the approach set out in the [Science On Schema.org guides], that is, through a `PropertyValue`. 
    * Clients SHOULD be permissive of `identifier` being a string (which MAY be a URI), or a `@id` reference
    * if an `@id`: which SHOULD be represented as an `PropertyValue` entity which MUST have a human readable `value`, and SHOULD have a `url` if the identifier is Web-resolvable. A citable representation of this persistent identifier MAY be given as a `description` of the `PropertyValue`
    * It is RECOMMENDED that resolving the `identifier` programmatically returns the _RO-Crate Metadata Document_ or an archive (e.g. ZIP) that contains the _RO-Crate Metadata File_, using [content negotiation](data-entities#retrieving-an-ro-crate) and/or [Signposting].

* With an RO-Crate identifier that is persistent and resolvable in this way from a URI, the root data entity SHOULD indicate this using the `cite-as` property according to [RFC8574]. Likewise, an HTTP/HTTPS server of the resolved RO-Crate Metadata Document or archive (possibly after redirection) SHOULD indicate that persistent identifier in its [Signposting] headers using `Link rel="cite-as"`. 
    * `cite-as` MAY go to a repository landing page, and MAY require authentication, but MUST ultimately have the RO-Crate as a downloadable item, which SHOULD be programmatically accessible through content negotiation or [Signposting] (`Link rel="describedby"` for a _RO-Crate Metadata Document_, or `Link rel="item"` for an archive).

Any entity which is a subclass of [CreativeWork], including [Dataset]s like the _Root Data Entity_, MAY have a `creditText` property which provides a textual citation for the entity.

Additional properties of _schema.org_ types [Dataset] and [CreativeWork] MAY be added to further describe the RO-Crate as a whole, e.g. [author], [abstract], [publisher]. See sections [contextual entities](contextual-entities) and [provenance](provenance) for further details.

| Property/Target | Severity | Description | Eli attention |
| ------| ------ | ------- | ------- |
| `@id` | SHOULD | Should be the string `./` or an absolute URI |
| `@type` | MUST | Must be [Dataset] or an array that contains `Dataset` |
| [name] | MUST | Must be present |
| [name] | SHOULD | Should identify the dataset to humans well enough to disambiguate it from other RO-Crates | not MA
| [description] | MUST | Must be present |
| [description] | SHOULD | Should elaborate on the name to provide a summary of the context in which the dataset is important | not MA
| [datePublished] | MUST | Must be present |
| [datePublished] | MUST | Must be a single string value in [ISO 8601 date format][DateTime] |
| [datePublished] | SHOULD | Should be specified to at least the precision of a day |
| [datePublished] | MAY | May be a timestamp down to the millisecond |
| [license] | MUST| Must be present |
| [license] | SHOULD | Should link to a _Contextual Entity_ or _Data Entity_ in the _RO-Crate Metadata Document_ with a name and description |
| [license] | MAY | May be a textual description of how the RO-Crate may be used, if necessary | 
| [identifier] | SHOULD | Should be used to indicate the _persistent identifier_ (e.g. a DOI) for the crate, if one exists
| [identifier] | SHOULD | Should use the approach set out in the [Science On Schema.org guides] to create an [identifier entity](#identifier-entity)
| [identifier] | MAY | Be a string
| [identifier] | RECOMMENDED | Recommended that resolving the `identifier` programmatically returns the _RO-Crate Metadata Document_ or an archive (e.g. ZIP) that contains the _RO-Crate Metadata File_, using [content negotiation](data-entities#retrieving-an-ro-crate) and/or [Signposting]
| [cite-as] | MUST | If present, must ultimately have the RO-Crate as a downloadable item
| [cite-as] | SHOULD | If the RO-Crate identifier is persistent and resolvable from a URI, this should be indicated using the `cite-as` property according to [RFC8574]
| [cite-as] | SHOULD | The RO-Crate download should be programmatically accessible through content negotiation or [Signposting]
| [cite-as] | MAY | May go to a repository landing page
| [cite-as] | MAY | May require authentication
| HTTP/HTTPS server of the resolved RO-Crate Metadata Document or archive | SHOULD | Should indicate the persistent identifier in its [Signposting] headers using `Link rel="cite-as"`  | this segment is quite tangential...
| `publisher` | SHOULD | Should be present | [source](contextual-entities#publisher)
| `publisher` | SHOULD | Should reference an [Organization] | [source](contextual-entities#publisher)
| `publisher` | MAY | May reference a [Person] | [source](contextual-entities#publisher)
| `funder` | SHOULD | Should reference all funders directly, including those that are also referenced by entities included in `hasPart`. | [source](contextual-entities#funding-and-grants)
| `hasPart` | MUST | Must directly or indirectly (via nested `hasPart`) reference all _Data Entities_ in the RO-Crate JSON-LD | [source](data-entities#referencing-files-and-folders-from-the-root-data-entity) | 
| `hasPart` | MAY | May refer to files anywhere within the folder hierarchy within the _RO-Crate Root_ | |

### Identifier entity

Used to indicate a _persistent identifier_ (e.g. a DOI). Should use the approach set out in the [Science On Schema.org guides].

| Property/Target | Severity | Description | Eli attention |
| ------| ------ | ------- | ------- |
| `@type` | SHOULD | Should be [PropertyValue] |
| `value` | MUST | Must be present |
| `value` | MUST | Must be human-readable |
| `url` | SHOULD | Should be present if the identifier is Web-resolvable |
| `description` | MAY | May include a citable representation of this persistent identifier |

## Data Entities

Type of data entity | Property/Target | Severity | Description | Eli attention |
| ------- | ------| ------ | ------- | ------- |
| All | `@id` | MUST | If the entity represents a file or directory present in the _RO-Crate Root_, `@id` must be a relative URI | |
| All | `@id` | MUST | If `@id` is a relative URI, the file or directory represented by the entity must be present in the _RO-Crate Root_ at that relative path | |
| All | `@id` | MUST | If in a [Detached RO-Crate](structure#detached-ro-crate-package), `@id` must be an absolute URI | |
| All | `@id` | SHOULD | International characters in identifiers should be written using native UTF-8 characters | |
| All | `@id` | MAY | May include traditional URL encoding of Unicode characters with `%`  | |
| All | `@type` | MAY | May be an array | |
| All | `name` | SHOULD | Should be present | |
| All | `description` | SHOULD | Should be present | |
| All | `license` | SHOULD | If different to the `license` on the _Root Data Entity_, should reference a [CreativeWork] entity | [source](contextual-entities#licensing-access-control-and-copyright)
| All | `contentLocation` / `spatialCoverage` | SHOULD | One of these properties should be present if the entity is associated with a geographical location or region | [source](contextual-entities#places)
| All | `contentLocation` / `spatialCoverage` | SHOULD | If present, should reference a [Place] entity | [source](contextual-entities#places)
| All | `about` | MUST | Subject properties (equivalent to a [Dublin Core Subject](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/terms/subject/)) must use the [about] property | I don't understand this one... [source](contextual-entities#subjects--keywords)
| All | `keywords` | MUST | Keyword properties must use the [keywords] property | [source](contextual-entities#subjects--keywords)
| All | `temporalCoverage` | SHOULD | Should be present if the entity is associated with a time period | implicit!! [source](contextual-entities#time)
| All | `citation` | MUST | If associating a publication with a dataset, `citation` must include a URL (for example a DOI URL) as the `@id` of a publication | this feels a weird requirement... [source](contextual-entities#publications-via-citation-property)
| All | `identifier` | MAY | May be a published DOI that primarily captures that file or dataset | [source](contextual-entities#publications-via-citation-property)
| File | `@id` | MUST | Must be a relative or absolute URI | |
| File | `@type` | MUST | Must be `File`, or an array where `File` is one of the values | |
| File | `contentURL` | MAY | May be present | |
| File | `contentURL` | SHOULD | If present, following the link (allowing for HTTP redirects) should directly download the file represented by the entity | |
| File | `encodingFormat` | SHOULD | Should be present | |
| File | `encodingFormat` | SHOULD | Should be an IANA [media type] as a string and/or a reference to a [file format](data-entities#adding-detailed-descriptions-of-file-encodings) contextual entity | |
| File | `conformsTo` | SHOULD | Should be present if the file follows a particular profile of the encoding format | |
| File | `conformsTo` | SHOULD | If present, should reference a contextual entity of type [Profile] | |
| File | `contentSize` | SHOULD | Should be present | |
| File | `contentSize` | SHOULD | Should be the size of the file in bytes | |
| File | `identifier`, `url`, `subjectOf`, `mainEntityOfPage` | MAY | May link to a relevant web presence for the entity | see [source](data-entities#web-based-data-entities) for further guidance |
| File | `identifier`, `url`, `subjectOf`, `mainEntityOfPage` | SHOULD | If the entity is both in the _RO-Crate Root_ and on the web, one of these properties should be used to link to the relevant web presence | see [source](data-entities#web-based-data-entities) for further guidance |
| Thumbnail (File) | (usage) | MUST | Must be present in the BagIt manifest if in a [_Bagged RO-Crate_](appendix/implementation-notes#adding-ro-crate-to-bagit) | this is a weird one too... actually more structural. [source](contextual-entities#thumbnails)
| Dataset | `@id` | MUST | Must be a relative URI, an absolute URI, or a local identifier beginning with `#` | |
| Dataset | `@type` | MUST | Must be `Dataset` or an array where `Dataset` is one of the values | |
| Dataset | `@id` | SHOULD | If `@id` is a relative URI, it should end with `/` | |
| Dataset | `@id` | SHOULD | If `@id` is an absolute URI, it should resolve to a programmatic listing of the content of the "directory" | |
| Dataset | `hasPart` | SHOULD | Should be present | is this needed? |
| Dataset | `hasPart` | SHOULD | Should list any directly contained data entities | can it be empty? | 
| Dataset | `hasPart` | MAY | May include other Datasets to represent a nested folder hierarchy | 
| Dataset | `distribution` | SHOULD | Should be present if the `@id` is a web URI |  |
| Dataset | `hasPart` | SHOULD | If the `@id` is a web URI, either `hasPart` should contain a complete listing of the dataset's content, or the dataset should be an RO-Crate | |
| Dataset | `distribution` | MAY | If the dataset represented by the entity is an RO-Crate, `distribution` may be present | |
| Dataset | `distribution` | MAY | If the dataset represented by the entity is an RO-Crate, `distribution` should be the URI of an archive that contains the _RO-Crate Metadata Document_ | |
| Dataset | `funder` | SHOULD | Should be present if a research project is associated with the dataset | [source](contextual-entities#funding-and-grants)
| Dataset | `funder` | SHOULD | Should reference an [Organization] entity | [source](contextual-entities#funding-and-grants)
| Web-based File or Dataset | `@id` | SHOULD NOT | Should not reference intermediate resources such as splash-pages, search services or web-based viewer applications
| Web-based File or Dataset | `sdDatePublished` | SHOULD | Should be present
| Web-based File or Dataset | `sdDatePublished` | SHOULD | Should indicate when the `@id` was accessed
| Web-based File or Dataset | `localPath` | MAY | May indicate a destination path that can be used when downloading the data | |
| Web-based File or Dataset | `encodingFormat` | SHOULD | Should link to a _Contextual Entity_ representing the format | see [contextual entities for encoding formats](TODO) | 
| Web-based File or Dataset | `encodingFormat` | MAY | May be a local description of the format if there is no web-accessible description | | 


### Referenced RO-Crates

This section describes how an RO-Crate A may reference another RO-Crate B. Properties in the "Property/Target" column are properties of the data entity within A that represents B.

| Property/Target | Severity | Description | Eli attention |
| ------- | ------| ------ | ------- |
| All | MUST | Must follow all requirements for [Directory Data Entities](#data-entities)  | |
| `@id` | SHOULD | If B's RDE has an `identifier` declared, `@id` should be that identifier | |
| `@id` | SHOULD | If A is [attached](structure#attached-ro-crate-package) and B is a nested folder within A, `@id` should be the relative path to B from A's _RO-Crate Root_. | |
| `@id` | SHOULD | If the conditions above do not apply, and B's RDE `@id` is an absolute URI or can be converted to one (see [source](data-entities#determining-entity-identifier-for-a-referenced-ro-crate) for guidance), and that URI resolves according to [Retrieving an RO-Crate](data-entities#retrieving-an-ro-crate), `@id` should be that absolute URI | |
| `sdDatePublished` | SHOULD | If the condition above applies, but the absolute URI does not have [Signposting] declared for a `Link:` with `rel=cite-as`, `sdDatePublished` should be present | |
| `sdDatePublished` | SHOULD | If present, should indicate when the URI in the `@id` was accessed | |
| `@id` | MAY | If B is not on the Web, and does not have a persistent identifier, then a non-resolvable identifier may be used. | |
| `@id` | MAY | If B's metadata document is on the Web, but the above conditions fail to determine `@id`, then a non-resolvable identifier may be used. | |
| `subjectOf` | SHOULD | If the condition above applies, should be present | |
| `subjectOf` | SHOULD | If present, should reference a contextual entity representing B's metadata descriptor | See [contextual entity for referenced RO-Crate metadata descriptor](#TODO) |
| `conformsTo` | SHOULD | Should include the versionless RO-Crate base profile `https://w3id.org/ro/crate` | |
| `conformsTo` | MUST NOT | Must NOT include a specific version of the RO-Crate base profile (such as `https://w3id.org/ro/crate/1.1`) | |
| `conformsTo` | MAY | May reference contextual entities representing [RO-Crate profiles](profiles) (specific versions are permitted) | |


* Consumers that find a reference to a `Dataset` with the generic RO-Crate profile indicated MAY attempt to resolve the persistent identifier, but SHOULD NOT assume that the `@id` directly resolves to an RO-Crate Metadata Document. 

##### All (data entities)

* a directory containing a set of files _MAY_ be described using a `Dataset` _Data Entity_ that encapsulates the files with a `description` property that explains the contents.
* care must be taken to express any relative paths using `/` separator, correct casing, and escape special characters like space (`%20`) and percent (`%25`)
* the _RO-Crate Metadata Document_ is always UTF-8
* If `contentUrl` has more than one value, then a checker service SHOULD try each provided value until one resolves and returns a correct [contentSize].
* Additional care SHOULD be taken to improve persistence and long-term preservation of web resources included 
in an RO-Crate, as they can be more difficult to archive or move along with the _RO-Crate Root_, and
may change intentionally or unintentionally, leaving the RO-Crate with incomplete or outdated information.
* File Data Entries with an `@id` URI outside the _RO-Crate Root_ SHOULD at the time of RO-Crate creation be directly downloadable by a simple non-interactive retrieval (e.g. HTTP GET) of a single data stream, permitting redirections and HTTP/HTTPS authentication


## Contextual Entities

The RO-Crate SHOULD contain additional information about _Contextual Entities_ for the use of both humans (in `ro-crate-preview.html`) and machines (in `ro-crate-metadata.json`).

### Contextual Entities 2

If an existing permalink or other absolute URI is reasonably unique for that entity, that URI SHOULD be used as identifier for the contextual entity in preference of an identifier local to the RO-Crate (e.g. `#josiah` or `#0fa587c6-4580-4ece-a5df-69af3c5590e3`).




#### Person

Guidelines only!!

The following is the minimum recommended way of representing an [author] of an RO-Crate. The [author] property MAY also be applied to a directory ([Dataset]), a [File] or other [CreativeWork] entities.

[name, affiliation, `@id`, `@type`]


#### Organization

An [Organization] SHOULD be the value for the [publisher] property of a [Dataset] or [ScholarlyArticle].

An [Organization] SHOULD also be used for a [Person]'s [affiliation] property.

#### Misc

An RO-Crate SHOULD have contact information, using a contextual entity of type [ContactPoint].
Note that in Schema.org [Dataset] does not currently have the corresponding [contactPoint] property, so the contact point would need to be given through a [Person] or [Organization] contextual entity which are related to the Dataset via a [author] or [publisher] property.

To associate a publication with a dataset the _RO-Crate JSON-LD_ MUST include a URL (for example a DOI URL) as the `@id` of a publication using the [citation] property.
The publication SHOULD be described further 
as an additional contextual entity of
type [ScholarlyArticle] or [CreativeWork].

[citation] MAY also be used with other data and contextual entities:

A [data entity](data-entities) MAY provide a published DOI [identifier] that primarily captures that file or dataset. A citation MAY also be provided:

The [Root Data Entity](root-data-entity) SHOULD have a [publisher] property. This SHOULD be an [Organization] though it MAY be a [Person].

To associate a research project with a [Dataset], the _RO-Crate JSON-LD_ SHOULD contain an entity for the project using type [Organization], referenced by a [funder] property. The project `Organization` SHOULD in turn reference any external [funder], either by using its URL as an `@id` or via a _Contextual Entity_ describing the funder.

{% include callout.html type="tip" content="To make it very clear where funding is coming from, the _Root Data Entity_ SHOULD also reference funders directly, as well as via a chain of references." %}

If a [Data Entity](data-entities) has a [license] that is different from the license on the _Root Data Entity_, the entity SHOULD have a [license] property referencing a _Contextual Entity_ with a type [CreativeWork] to describe the license. The `@id` of the license SHOULD be its URL (e.g. a Creative Commons License URL) and, when possible, a summary of the license included using the [description] property.

#### Places

To associate a [Data Entity](data-entities) with a _Contextual Entity_ representing a geographical location or region, the entity SHOULD have a property of [contentLocation] or [spatialCoverage] with a value of type [Place].

To express point or shape geometry it is recommended that a `geo` property on a [Place] entity SHOULD link to a [Geometry] entity, with an [asWKT] property that expresses the point or shape in [Well Known Text (WKT)](https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry) format.  This example is a point, `POINT ($longitude, $latitude)`, but other asWKT primitives, `LINESTRING` & `POLYGON` SHOULD be used as required.

#### Misc more

Subject properties (equivalent to a [Dublin Core Subject](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/terms/subject/)) on the [root data entity](root-data-entity) or a [data entity](data-entities) MUST use the [about] property.

Keyword properties MUST use [keywords]. Note that by Schema.org convention, keywords are given as a single JSON string, with individual keywords separated by commas.

To describe the _time period_ which an RO-Crate [Data Entity](data-entities) (or the [root data entity](root-data-entity)) is _about_, use [temporalCoverage]:

A [File] or any other entity MAY have a [thumbnail] property which references another file.

For example, the below [RepositoryObject] is related to four files which are all versions of the same image (via [hasFile]), one of which is a thumbnail. The thumbnail MUST be included in the RO-Crate.

If [thumbnail]s are incidental to the data set, they need not be referenced by [hasPart]  or [hasFile] relationships, but they must be in the BagIt manifest if in a [_Bagged RO-Crate_](appendix/implementation-notes#adding-ro-crate-to-bagit).

### Table

The RO-Crate SHOULD contain additional information about _Contextual Entities_ for the use of both humans (in `ro-crate-preview.html`) and machines (in `ro-crate-metadata.json`).


Type of contextual entity | Property/Target | Severity | Description | Eli attention |
| ------- | ------| ------ | ------- | ------- |
| Any | `@id` | SHOULD | If an existing permalink or other absolute URI is reasonably unique for that entity, that URI should be used as `@id` |
| Any | `@type` | SHOULD | If the entity is from a repository, should include [RepositoryObject] in addition to any other types | [source](provenance#recording-changes-to-ro-crates) |
| Person | `name` | SHOULD | Should be present | implicit! |
| Person | `affiliation` | SHOULD | Should be present | implicit! |
| Person | `affiliation` | SHOULD | Should reference an [Organization] entity | [source](contextual-entities#organizations-as-values) |
| Person / Organization | `contactPoint` | SHOULD | Should be present in at least one of the entities that is referenced as [author] or [publisher] from the _Root Data Entity_ |
| Person / Organization | `contactPoint` | SHOULD | Should reference a [ContactPoint] entity |
| Organization | `funder` | SHOULD | If relevant, should reference any external [funder], either by using its URL as an `@id` or via a _Contextual Entity_ describing the funder. |
| License | `@id` | SHOULD | Should be the URL of the license |
| License | `@type` | SHOULD | Should be [CreativeWork] |
| License | `name` | SHOULD | Should be present | [source](root-data-entity#direct-properties-of-the-root-data-entity) |
| License | `description` | SHOULD | Should be present | [source](root-data-entity#direct-properties-of-the-root-data-entity) |
| License | `description` | SHOULD | Should contain a summary of the license |
| Place | `geo` | SHOULD | Should reference a [Geometry] entity |
| Geometry | `asWKT` | SHOULD | Should express the point or shape in [Well Known Text (WKT)](https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry) format |
| Item of physical equipment | `@id` | SHOULD | Should be a URL to a web page describing the equipment | [source](provenance#equipment-used-to-create-files) |
| Item of physical equipment | `@type` | SHOULD | Should be [IndividualProduct] | [source](provenance#equipment-used-to-create-files) |
| Item of physical equipment | `description` | SHOULD | Should include serial number and manufacturer that identify the equipment as completely as possible | implicit - the SHOULD is present but doesn't say which property to use. [source](provenance#equipment-used-to-create-files) |
| Software application | `@type` | SHOULD | Should be [SoftwareApplication] | [source](provenance#software-used-to-create-files)
| Software application | `version` | SHOULD | Should be present | [source](provenance#software-used-to-create-files)
| RepositoryCollection | usage | MAY | May be used to group [RepositoryObject] entities | [source](provenance#recording-changes-to-ro-crates) |
| RepositoryCollection | `hasMember` | MAY | May reference [RepositoryObject] entities | [source](provenance#recording-changes-to-ro-crates) |
| Encoding format | `@id` | SHOULD | Should be a [PRONOM] identifier if one exists for the format | [source](data-entities#adding-detailed-descriptions-of-file-encodings) |
| Encoding format | `@id` | MAY | May be a URL that is not a PRONOM identifier | [source](data-entities#adding-detailed-descriptions-of-file-encodings) |
| Encoding format | `@type` | SHOULD | Should contain [WebPage] | [source](data-entities#adding-detailed-descriptions-of-file-encodings) |
| Encoding format | `@type` | SHOULD | Should contain `Standard` if the `@id` link sufficiently documents the format | [source](data-entities#adding-detailed-descriptions-of-file-encodings) |
| Encoding format | `@type` | SHOULD NOT | Should NOT contain `Standard` if the `@id` link does not sufficiently document the format | [source](data-entities#adding-detailed-descriptions-of-file-encodings) |
| Encoding format | `@type` | MAY | May include [WebPageElement] if the `@id` links to a section of a webpage | [source](data-entities#adding-detailed-descriptions-of-file-encodings) |
| Metadata descriptor for a referenced RO-Crate | `encodingFormat` | SHOULD | Should be `"application/ld+json"` or an equivalent representation of JSON-LD | [source](data-entities#referencing-another-metadata-document) |
| Metadata descriptor for a referenced RO-Crate | `conformsTo` | SHOULD NOT | Should NOT be present | [source](data-entities#referencing-another-metadata-document) |
| Metadata descriptor for a referenced RO-Crate | `about` | SHOULD NOT | Should NOT be present | [source](data-entities#referencing-another-metadata-document) |


## Focus of an RO-Crate

Whole page seems to be guidelines, not requirements

## Provenance of entities

A software application or item of equipment SHOULD be associated with the [File]\(s) (or other [data entities](data-entities)) it created as an [instrument] of a [CreateAction], with the [File] referenced by a [result] property. Any input files SHOULD be referenced by the [object] property.

Type of entity | Property/Target | Severity | Description | Eli attention |
| ------- | ------| ------ | ------- | ------- |
| All Actions | `instrument` | MAY be present |
| All Actions | `instrument` | SHOULD reference an entity of type [IndividualProduct] (equipment) or [SoftwareApplication] (software), except if multiple [SoftwareApplication]s were used together | singleton? implicit in the writing |
| CreateAction | `instrument` | If multiple [SoftwareApplication]s were used together, SHOULD reference a [SoftwareSourceCode] entity representing the whole [workflow](workflows) |
| CreateAction | `result` | SHOULD reference one or more entities representing the outputs of the action | implicit, actually only stated for [File]s |
| CreateAction | `object` | SHOULD reference one or more entities representing the inputs of the action | implicit, actually only stated for [File]s |
| CreateAction | `name` | MAY | May be human-readable |
| CreateAction | `name` | MAY | May be machine-generated |
| CreateAction / UpdateAction | usage | SHOULD | To record an action which changes an entity's metadata, or changes its state in a publication or other workflow, a [CreateAction] or [UpdateAction] SHOULD be associated with a [Data Entity](data-entities) or, for the RO-Crate itself, with the [root data entity](root-data-entity). | can't tell if this is its own req, or if it is elaborated on by successive reqs |
| Curation action | `object` | MUST | Must be present |
| Curation action | `object` | MUST | Must reference the _Root Data Entity_ or one of the entities in its `hasPart` | what is a curation action...? |
| Action which creates data entities | `result` | SHOULD | Should reference the data entities that were created |
| All Actions | `name` | SHOULD | Should be present |
| All Actions | `description` | MAY | May be present |
| All Actions | `endTime` | SHOULD | Should be present |
| All Actions | `endTime` | MUST | Must be in [ISO 8601 date format][DateTime] |
| All Actions | `endTime` | SHOULD | Should be specified to at least the precision of a day |
| All Actions | `startTime` | MAY | MAY be present |
| All Actions | `startTime` | MUST | Must be in [ISO 8601 date format][DateTime] |
| All Actions | `startTime` | SHOULD | Should be specified to at least the precision of a day |
| All Actions | `agent` | SHOULD | Should be present |
| All Actions | `agent` | SHOULD | Should reference a [Person] entity who was responsible for authorizing the action | implicit... just says a "human [agent] |
| All Actions | `actionStatus` | MAY | May be present |
| All Actions | `actionStatus` | MUST | MUST be must be one of the values enumerated by [ActionStatusType]: [ActiveActionStatus], [CompletedActionStatus], [FailedActionStatus] or [PotentialActionStatus] |
| All Actions | `error` | MAY | If the Action failed, may include error information |
| UpdateAction | usage | SHOULD | Should only be used for actions which affect the Dataset as a whole, such as movement through a workflow | Crate as a whole?
| CreateAction | usage | SHOULD | Should be used for actions which modify a [File] within a Dataset |
| File | usage | SHOULD | If a [CreateAction] modifies a file within a dataset, the old version should be retained and a [CreateAction] added which has the original version as its [object] and the new version as its [result] |

so far: 211 reqs...
