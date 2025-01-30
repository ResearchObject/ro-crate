# RO-Crate Specification Quick Reference

This document collates all the explicit requirements of the specification, while omitting all of the guidance, examples and notes. It is primarily intended for developers of tools which ingest/export/validate RO-Crates, though it may also be useful as a general resource. 

If you have questions, your first port of call should be the full specification page for the item you have questions about.

In rare cases, requirements are listed in a different section from their original source, to be closer to related requirements. In those cases, the original source section is linked from the requirement.

## RO-Crate Structure

[Structure - Full specification](structure)

(wait as this is changing...)

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

(skip for now...)


## Contextual Entities

The RO-Crate SHOULD contain additional information about _Contextual Entities_ for the use of both humans (in `ro-crate-preview.html`) and machines (in `ro-crate-metadata.json`).

### Contextual Entities 

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















### All...

Type of entity | Property/Target | Severity | Description | Eli attention |
| ------- | ------| ------ | ------- | ------- |
| Any | `@id` | SHOULD | If an existing permalink or other absolute URI is reasonably unique for that entity, that URI should be used as `@id`. |
| Person | `name` | SHOULD | Should be present | implicit!
| Person | `affiliation` | SHOULD | Should be present | implicit!
| Person | `affiliation` | SHOULD | Should reference an [Organization] entity | [source](contextual-entities#organizations-as-values)
| Person / Organization | `contactPoint` | SHOULD | Should be present in at least one of the entities that is referenced as [author] or [publisher] from the _Root Data Entity_
| Person / Organization | `contactPoint` | SHOULD | Should reference a [ContactPoint] entity

##### All (data entities)

Type of entity | Property/Target | Severity | Description | Eli attention |
| ------- | ------| ------ | ------- | ------- |
| All | `citation` | MUST | If associating a publication with a dataset, `citation` must include a URL (for example a DOI URL) as the `@id` of a publication | this feels a weird requirement... [source](contextual-entities#publications-via-citation-property)
| All | `identifier` | MAY | May be a published DOI that primarily captures that file or dataset

The RO-Crate SHOULD contain additional information about _Contextual Entities_ for the use of both humans (in `ro-crate-preview.html`) and machines (in `ro-crate-metadata.json`).

#### Misc

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
