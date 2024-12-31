---
page_id: dataplant
redirect_from:
    - /in-use/dataplant
title: Data Plant
description: DataPLANT`s mission is to provide a sustainable and well annotated data management platform for plant sciences.
url: https://nfdi4plants.org/content/learn-more/annotated-research-context.html
domains: [biology, omics]
tasks: [manage_data]
roles: [information_architect]
---

# DataPlant

[DataPlant](https://nfdi4plants.org/) is implementing [Annotated Research Context (ARC)](https://nfdi4plants.org/content/learn-more/annotated-research-context.html), an RO-Crate profile that combines the Investigation Study Assay model ([ISA](https://isa-specs.readthedocs.io/en/latest/isamodel.html)) and the Common Workflow Language ([CWL](https://www.commonwl.org/)) to capture a range from single experimental setups to complex experimental designs. 

In ARC, files are managed in a git repository with a fixed structure following the ISA model, in addition to metadata in an Excel spreadsheet. The [arcCommander](https://github.com/nfdi4plants/arcCommander) tool can help with managing this structure, while the tool [arc--to-roc](https://github.com/nfdi4plants/arc-to-roc) can inspect the structure to generate an RO-Crate metadata file.
The [ARC specification](https://github.com/nfdi4plants/ARC-specification/blob/main/ARC%20specification.md#appendix-conversion-of-arcs-to-ro-crates) allows augmentation by adding an explicit `ro-crate-metadata.json` to the ARC.

DataPlant has provided [detailed guides to creating ARCs](https://www.nfdi4plants.de/nfdi4plants.knowledgebase/docs/guides/index.html) and introduce further tooling.
