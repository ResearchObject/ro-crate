---
title: Human changelog
redirect_from:
  - /1.2-DRAFT/appendix/human-changelog
parent: Appendix
grand_parent: RO-Crate 1.2-DRAFT
nav_order: 35
---

# Human changelog 1.2

This document is designed to be a widely understandable summary of the changes introduced in version 1.2 of the RO-Crate specification. Changes are broken down by chapter, and some guidance is included on how to upgrade crates from version 1.1 to 1.2. 

Not every change is described in detail. For developers and implementers that require further detail, you can see the exact changes to requirements by searching for "New" in the [specification quick reference](quick-reference). 

## New chapter: [Introduction](introduction)

An introduction has been added with an overview of RO-Crate and an example. It is aimed at new users and can safely be ignored by experienced users, as it does not contain any requirements that are not represented elsewhere in the specification.

## RO-Crate Structure

The JSON-LD must (upgraded from should) use the RO-Crate JSON-LD Context https://w3id.org/ro/crate/1.2/context (updated version) by reference. Most (if not all) RO-Crates conforming to 1.1 already include the context by reference, so we do not expect this to be a disruptive change.

#### Attached and Detached RO-Crate Packages

The requirement in 1.1 for a RO-Crate to always be a directory has proven to be limiting in some cases. For example, in some applications it is beneficial to serve RO-Crate metadata over an API separately from the data it describes. However, separating the metadata in this way requires some changes to how you handle cross-references and finding the Root Data Entity. Therefore, 1.2 introduces a distinction between Attached and Detached RO-Crate Packages:

* [Attached RO-Crate Package](../structure#attached-ro-crate-package) has a defined root directory containing a payload of files and directories as well as the RO-Crate metadata (i.e. it is _attached to_ a file system). All RO-Crates conforming to version 1.1 are of this type.
* [Detached RO-Crate Package](../structure#detached-ro-crate-package) has no defined root directory, and the RO-Crate metadata is accessed independently of the entities it describes (i.e. it is _detached from_ a file system). This type is new in 1.2 and comes with a few new requirements not detailed here.

It is recommended that RO-Crate tool developers read the full specification for these sections to fully understand the requirements for these different types of crate.

#### RO-Crate Website

Some requirements were tightened around the _RO-Crate Website_.

Previous versions of the specification recommended that the _RO-Crate Website_ should contain a redundant copy of the RO-Crate Metadata Document, but there is no evidence that this has been useful and it is no longer recommended. 1.2 also removed the suggestion that the RO-Crate Website should include “Cite-as” text.

If the RO-Crate website is present, it must be a file named `ro-crate-preview.html` in the root directory. If there are additional website resources (e.g. JavaScript files), they must be in `ro-crate-preview_files/` in the root directory. These requirements are implied in version 1.1, so we expect most RO-Crates already follow them.

The RO-Crate website and supporting files `ro-crate-preview.html` and `ro-crate-preview_files/` should not be included in the `hasPart` of any `Dataset` (except in the special case where `ro-crate-preview.html` is also the profile description within a [Profile Crate](../profiles#profile-crate)). Again, this was already discouraged in version 1.1.

#### To update crates from 1.1

* Note that all RO-Crates conforming to version 1.1 follow the Attached RO-Crate style by default in 1.2; no change to the metadata is needed to achieve this.
* Ensure the RO-Crate JSON-LD Context https://w3id.org/ro/crate/1.2/context is used by reference in `@context`
* If the RO-Crate website is present, ensure it is a file named `ro-crate-preview.html` in the root directory. If there are additional resources, ensure they are in `ro-crate-preview_files/` in the root directory.
* If `ro-crate-preview.html` and `ro-crate-preview_files/` are included in the `hasPart` of any `Dataset`, remove them.
  * Exception: `ro-crate-preview.html` may be included in `hasPart` if it is also the profile description within a Profile Crate (see Profile Crate section)

### Metadata

The “new” requirements in this section are not truly new, but were implied in 1.1 and have now been made explicit.

This includes clarifying that all entities must have `@id` and `@type` properties, and stating how the entities in the `@graph` should be properly connected together.

#### To update crates from 1.1

* Ensure that all entities have `@id`, `@type`, and ideally a human-readable `name`.
* Ensure that all entities are directly or indirectly reachable from the Root Data Entity.
* Ensure cross-references use the `{ "@id": "..."}` form.

## Root Data Entity {#chapter-root-data-entity}

The primary update to this chapter is to formally support declarating conformance to one or more [RO-Crate profiles](../profiles).

#### Metadata Descriptor

The Metadata Descriptor `conformsTo` should be a single value referencing a version of RO-Crate. Additional profiles should be listed on the Root Data Entity.

{% include callout.html type="note" content="As the RO-Crate profile concept was developed, community usage of `conformsTo` expanded to include an array of profiles. Over time, it was agreed to move profile declarations to the Root Data Entity and away from the Metadata Descriptor. This is because the profile applies to the whole RO-Crate, and may cover aspects beyond 
the crate's metadata file (e.g. identifiers, packaging, purpose). For compatibility reasons, 1.2 supports both options, but discourages including profiles in the Metadata Descriptor in new crates." %}

#### Root Data Entity

Profile declarations should be included in `conformsTo` on the Root Data Entity. Each value must reference a contextual entity of type [Profile] representing a profile the RO-Crate conforms to.

Earlier versions of RO-Crate mandated an `@id` of `./` as a convention for identifying the _Root Data Entity_, but the use of the _RO-Crate Metadata Descriptor_ means that this is no longer required. It is now equally acceptable for the _Root Data Entity_ `@id` to be a URI (as long as that URI is considered the main identifier of the RO-Crate). The `@id` no longer needs to end with `/`.

Minor updates to some properties:
* `datePublished` now must have a _single_ value
* `license` may now reference a data entity
* additional guidance on how to declare `identifier` and `cite-as` (see [Root Data Entity identifier](../root-data-entity#root-data-entity-identifier))

#### To update crates from 1.1

* ensure `datePublished` has a single value
* check that `identifier` and `cite-as` follow the recommended approaches (see [Root Data Entity identifier](../root-data-entity#root-data-entity-identifier))
* if profiles are declared in `conformsTo` on the Metadata Descriptor, migrate these to `conformsTo` on the Root Data Entity
* ensure a contextual entity is present for each profile listed in `conformsTo` on the Root Data Entity

### Data Entities

This release includes some clarifications about what and is and is not a data entity, and more carefully ensures that relative URIs correspond to files in the _RO-Crate Root_ (and vice versa).

Detailed guidance was also added on [how an RO-Crate can reference other RO-Crates](../data-entities#referencing-other-ro-crates). Referenced RO-Crates may be nested, web-based, Attached or Detached, and so on - the specification aims to account for all common scenarios.

#### All data entities

If the entity represents a file or directory present in the _RO-Crate Root_, `@id` must be a relative URI

If `@id` is a relative URI, the file or directory represented by the entity must be present in the _RO-Crate Root_ at that relative path.

If in a Detached RO-Crate, `@id` must be an absolute URI.

Numerous minor changes to properties:
* `name` and `description` should be present
* `spatialCoverage` may now be used as an alternative to `contentLocation`
* for web-based data entities, `@id` should not reference intermediate resources such as splash-pages, search services or web-based viewer applications
* for web-based data entities, the new property `localPath` may be used to indicate a destination path that can be used when downloading the data

#### File

Numerous minor changes to properties:
* Following the `contentUrl` link (if present) should directly download the file represented by the entity (allowing for HTTP redirects)
* `encodingFormat` may now be an IANA media type as a string
* `conformsTo` should be present if the file follows a particular profile of the encoding format, and reference a [Profile] entity
* `contentSize` should be present and state the size of the file in bytes

#### Dataset 

A [Dataset] may encapsulate a set of files without describing them individually as File data entities.

Numerous minor changes to properties:
* `hasPart` should be present
* `distribution` should be present if the @id is a web URI

#### To update crates from 1.1

* If a data entity represents a file or directory present in the _RO-Crate Root_, ensure its `@id` is a relative URI
* If a data entity's `@id` is a relative URI, ensure the file or directory represented by the entity is present in the _RO-Crate Root_ at that relative path
* (optional) ensure `name` and `description` are present
* (optional) if the data entity is web-based, ensure its `@id` does not reference intermediate resources such as splash-pages, search services or web-based viewer applications
* (optional) review new "should" rules for `File` and `Dataset` entities
* (optional) if the crate references another RO-Crate, check that it follows the [new guidance](../data-entities#referencing-other-ro-crates) on this

### Contextual Entities

Updated guidance on describing [places](../contextual-entities#places). 

Other sections added new guidance on describing [encoding formats](../data-entities#adding-detailed-descriptions-of-file-encodings), [referenced RO-Crate metadata documents](../data-entities.md#referencing-another-metadata-document), [persistent identifiers](../root-data-entity#root-data-entity-identifier), and [RO-Crate profiles](../profiles.md#declaring-conformance-of-an-ro-crate-profile)

#### To update crates from 1.1

* (optional) ensure descriptions of [places](../contextual-entities#places), [encoding formats](../data-entities#adding-detailed-descriptions-of-file-encodings), and [persistent identifiers](../root-data-entity#root-data-entity-identifier) follow updated guidance

## New chapter: [The focus of an RO-Crate](crate-focus)

This section includes _guidance_ (no hard requirements) on how to indicate the main entity or entities within an RO-Crate. This is useful in the case of crates which contain many entities but have a few entities which are the most important or provide context for the rest.

This section formalizes existing community conventions around declaration of main entities, including the convention used in the [Workflow RO-Crate](https://about.workflowhub.eu/Workflow-RO-Crate/) profile.

### Provenance of entities

No changes.

## New chapter: [Profiles](profiles)

Profiles define a set of conventions, types and properties that one can minimally require and expect to be present in RO-Crates used within a particular domain, application or framework.

Defining and conforming to such a profile enables reliable programmatic consumption of an RO-Crate’s content, as well as consistent creation, e.g. via a form in a user interface containing the required types and properties. Likewise, a rendering of an RO-Crate can more easily make rich UI components if it can reliably assume, for instance, that a Person always has an affiliation to a Organization which has a url - a restriction that may not be appropriate for all types of RO-Crates.

As such, RO-Crate profiles can be considered a _duck typing_ mechanism for RO-Crates, but also as a classifier to indicate the crate’s purpose, expectations, and focus.

This chapter defines:
* how to publish a profile
* how to declare conformance to a profile (see also [root data entity](#chapter-root-data-entity))
* how to define a _Profile Crate_ (a type of RO-Crate that represents an RO-Crate profile)

## Workflows and Scripts

The only change in this chapter is an update to the suggested versions of the Bioschemas profiles [ComputationalWorkflow] and [FormalParameter].

## Appendix

Not checked thoroughly.
