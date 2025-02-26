# Human changelog 1.2

## New chapter: [Introduction](introduction)

An introduction has been added with an overview of RO-Crate and an example. It is aimed at new users and can safely be ignored by experienced users, as it does not contain any requirements that are not represented elsewhere in the specification.

## New chapter: [The focus of an RO-Crate](crate-focus)

This section includes _guidance_ (no hard requirements) on how to indicate the main entity or entities within an RO-Crate. This is useful in the case of crates which contain many entities but have a few entities which are the most important or provide context for the rest.

## New chapter: [Provenance of entities](provenance)

This section adds requirements around describing [Action]s which created or updated entities or the crate metadata itself. In particular, requirements at the SHOULD level have been added around describing the software and/or equipment used to create data entities.

## New chapter: [Profiles](profiles)

... write a summary

Profile conformance SHOULD be declared on the _Root Data Entity_ rather than on the _RO-Crate 
Metadata Descriptor_ where conformance to the base RO-Crate specification is declared. 
This is because the profile applies to the whole RO-Crate, and may cover aspects beyond 
the crate's metadata file (e.g. identifiers, packaging, purpose).

(include an example)

profiles#declaring-conformance-of-an-ro-crate-profile

Metadata descriptor [about] now has **a single value** (previously unconstrained).
> This descriptor MUST have an [about]
property with a single value referencing the _Root Data Entity_'s `@id`.

## New chapter: [Workflows and Scripts](workflows)

... write a summary

## Other sections

Removed requirement for the RO-Crate JSON-LD to be included in the HTML header of the RO-Crate Website - as "there is no evidence that this has been useful".

### Structure

Earlier versions of RO-Crate mandated an `@id` of `./` as a convention for identifying the _Root Data Entity_, but the use of the _RO-Crate Metadata Descriptor_ means that this is no longer required, freeing-up the _Root Data Entity_ `@id` to be used to indicate what should be considered the canonical URI for an RO-Crate Package. Other mechanisms for specifying the 'main identifier' involve multiple JSON-LD entities and may be ambiguous.

Previous versions of the Specification recommended that the _RO-Crate Website_ should contain a redundant copy of the RO-Crate Metadata Document, but there is no evidence that this has been useful and it is no longer recommended.
