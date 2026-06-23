---
title: What's changed in RO-Crate 1.3
sidebar: resources
---

# What's changed in RO-Crate 1.3

### JSON-LD context

If using the terms `ComputationalWorkflow`, `FormalParameter`, `input`, or `output` (as in [Workflows and Scripts](../../_specification/1.3/workflows)), be aware that their mapping in the JSON-LD context has changed.

| Term | RO-Crate 1.3 context | RO-Crate 1.2 context | RO-Crate 1.1 context |
| --- | --- | --- | --- |
| ComputationalWorkflow | <https://bioschemas.org/terms/ComputationalWorkflow> | https://bioschemas.org/ComputationalWorkflow | https://bioschemas.org/ComputationalWorkflow |
| FormalParameter | <https://bioschemas.org/terms/FormalParameter> | https://bioschemas.org/FormalParameter | https://bioschemas.org/FormalParameter |
| input | <https://bioschemas.org/terms/input> | https://bioschemas.org/properties/input | https://bioschemas.org/ComputationalWorkflow#input |
| output | <https://bioschemas.org/terms/output> | https://bioschemas.org/properties/output | https://bioschemas.org/ComputationalWorkflow#output |

Note that `ComputationalWorkflow` and `FormalParameter` did not have URI changes between 1.1 and 1.2, whereas `input` and `output` had URI changes between all three versions.

### To update crates from 1.2

A crate that conforms to RO-Crate 1.2 can be updated to 1.3 by simply updating the `conformsTo` and `@context`. No other changes are required to the JSON-LD metadata.

RO-Crate consumers/implementers who utilize the RDF representation of crates should take note of the changes to Bioschemas term URIs and be prepared to handle the previous URIs when reading older crates.

### To update crates from 1.1

See [What's changed in RO-Crate 1.2](./whats-changed-in-1-2) and update according to that guidance, then follow the instructions above to update from 1.2 to 1.3.

{% include references.liquid %}
