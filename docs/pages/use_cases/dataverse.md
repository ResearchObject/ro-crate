---
page_id: dataverse
redirect_from:
    - /in-use/dataverse
title: Dataverse
description: Dataverse is open source research data repository software with over 130 installations across research institutions. It has optional support for RO-Crate export, preview and metadata editing.
image: dataverse.png
url: https://guides.dataverse.org/en/6.4/installation/advanced.html#inventory-of-external-exporters
domains: []
tasks: [data_handling, manage_data]
roles: [data_steward, repository_manager]
---

# Dataverse
 
[Dataverse](https://dataverse.org) is open source research data repository software with over 130 [installations](https://dataverse.org/installations) across research institutions. It has support for RO-Crate export, preview and metadata editing.

## Export of RO-Crate

Dataverse has optional support for **exporting** dataset metadata as RO-Crate. This must currently be enabled as an [external exporter](https://guides.dataverse.org/en/latest/installation/advanced.html#external-metadata-exporters).

There are two export methods developed, both return a [detached RO-Crate](specification/1.2/structure#detached-ro-crate-package) as JSON-LD output:

* [KU Leuven](https://www.kuleuven.be/) developed [exporter-ro-crate](https://github.com/gdcc/exporter-ro-crate), with support from [EOSC FAIR-IMPACT](https://fair-impact.eu/support-offer-2-enabling-fair-signposting-and-ro-crate-contentmetadata-discovery-and-consumption). This is a customizable exporter that can be adjusted based on Dataverse's configurable metadata blocks.
* The [Transformer exporter](https://github.com/gdcc/exporter-transformer) supports RO-Crate Metadata JSON export as `arp-ro-crate`, which adds `@context` mapping of typical dataverse metadata fields, e.g. `geographicBoundingBox` or `grantNumberAgency`. A more basic form `basic-ro-crate` mainly describes the dataset. 

Contact the operator of your Dataverse installation to enable RO-Crate export.

## RO-Crate previewer 

To render Dataverse deposits containing a RO-Crate Metadata document (`ro-crate-metadata.json`), a [RO-Crate previewer](https://github.com/gdcc/dataverse-previewers/blob/1.4/5.2curlcommands.md#ro-crate-previewer-beta) can be enabled by the operator of the Dataverse instance. 

## RO-Crate manager

The [AROMA ARP RO-Crate Manager](aroma) customises Dataverse to allow detailed RO-Crate metadata editing and dynamic schema creation as an alternative to the more tabular metadata blocks.


## ELN format

Dataverse renders [ELN Electronic Lab Notebooks](eln), a file format based on RO-Crate, however currently only a ZIP file listing is provided. This can in theory be combined with the RO-Crate previewer.


## Resources

Dieuwertje Bloemen, Özgür Karadeniz (2024):  
[**Creating a Dataverse RO-Crate exporter with FAIR-IMPACT support**](https://doi.org/10.5281/zenodo.12548334).  
_Open Repositories Conference_ ([OR 2024](https://or2024.openrepositories.org/)), Göteborg, Sweden, 2024-06-03/--06  
<https://doi.org/10.5281/zenodo.12548334>

* <https://github.com/gdcc/exporter-ro-crate>
* <https://github.com/gdcc/exporter-transformer/tree/1.0.10/examples/arp-ro-crate>
* <https://github.com/gdcc/exporter-transformer/tree/1.0.10/examples/basic-ro-crate>
* <https://github.com/IQSS/dataverse/pull/10086>
* <https://github.com/IQSS/dataverse/pull/10796>
