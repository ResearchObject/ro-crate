---
title:  "Announcing RO-Crate 1.3"
author: ["Eli Chadwick"]
date: 2026-06-23
---

[RO-Crate 1.3]({{baseurl}}{% link _specification/1.3/index.md %}) has just been released!

This release is extremely similar to 1.2 and upgrading will be trivial for most use cases. The changes primarily affect those describing computational workflows with RO-Crate, either using the [Workflows and Scripts](../workflows) chapter or the [Workflow RO-Crate](https://w3id.org/workflowhub/workflow-ro-crate/) profile and its derivatives.

The [RO-Crate 1.2 Specification Quick Reference]({{baseurl}}{% link pages/resources/quick-reference.md %}) remains entirely valid for 1.3.

## Updates to Bioschemas URIs in the RO-Crate JSON-LD context

The [RO-Crate JSON-LD context]({{baseurl}}{% link _specification/1.3/context.jsonld %}) includes a small number of terms from the Bioschemas vocabulary that are used to describe computational workflows: `ComputationalWorkflow`, `FormalParameter`, `input`, and `output`. The Bioschemas project has now established canonical, resolvable URIs for all of these terms, and RO-Crate 1.3 updates the context accordingly.

The table below shows the URIs for these terms in the last three minor versions of RO-Crate.

| Term | RO-Crate 1.3 context | RO-Crate 1.2 context | RO-Crate 1.1 context |
| --- | --- | --- | --- |
| ComputationalWorkflow | <https://bioschemas.org/terms/ComputationalWorkflow> | https://bioschemas.org/ComputationalWorkflow | https://bioschemas.org/ComputationalWorkflow |
| FormalParameter | <https://bioschemas.org/terms/FormalParameter> | https://bioschemas.org/FormalParameter | https://bioschemas.org/FormalParameter |
| input | <https://bioschemas.org/terms/input> | https://bioschemas.org/properties/input | https://bioschemas.org/ComputationalWorkflow#input |
| output | <https://bioschemas.org/terms/output> | https://bioschemas.org/properties/output | https://bioschemas.org/ComputationalWorkflow#output |

Note that `ComputationalWorkflow` and `FormalParameter` did not have URI changes between 1.1 and 1.2, whereas `input` and `output` had URI changes between all three versions.

The [Workflow RO-Crate](https://about.workflowhub.eu/Workflow-RO-Crate/) and [Workflow Run RO-Crate](https://www.researchobject.org/workflow-run-crate/) profiles will be updated to incorporate these changes in the coming weeks.

## Schema.org version update

The version of Schema.org on which the RO-Crate context is based has been updated to [v30.0](https://schema.org/docs/releases.html#v30.0) for RO-Crate 1.3. This update adds many new terms and does not remove any, so it is entirely backward compatible. 

None of the new terms are used in the 1.3 specification. Some of them may however be of interest to [profile]({{baseurl}}{% link pages/resources/profiles.md %}) creators, including:
* [AuthenticateAction](http://schema.org/AuthenticateAction)
* [Certification](http://schema.org/Certification)
* [Credential](https://schema.org/Credential)
* [Error](http://schema.org/Error)
* [InstantaneousEvent](http://schema.org/InstantaneousEvent)
* [LoginAction](http://schema.org/LoginAction)
* [OperatingSystem](http://schema.org/OperatingSystem)
* [RuntimePlatform](https://schema.org/RuntimePlatform) 
* [pronouns](http://schema.org/pronouns)
* [various types of source for digital objects](https://schema.org/IPTCDigitalSourceEnumeration) to be used with [digitalSourceType](http://schema.org/digitalSourceType)
* other properties associated with the classes above. 

## Upgrading from 1.2 to 1.3

A crate that conforms to RO-Crate 1.2 can be updated to 1.3 by simply updating the `conformsTo` and `@context`. No other changes are required to the JSON-LD metadata.

RO-Crate consumers/implementers who utilize the RDF representation of crates should take note of the changes to Bioschemas term URIs and be prepared to handle the previous URIs when reading older crates.
