---
page_id: MATE 
title: M@TE (Model Atlas of the Earth)
description: By adopting the RO-Crate standard, M@TE packages numerical Earth system models with comprehensive metadata describing code, inputs, outputs, provenance, and authorship. This makes models machine-actionable, reproducible, and citable, supporting open science and bridging the gap between traditional geology and numerical geosciences.
url: https://mate.science
image: MATE.png
domains: [earth_science]
tasks: [conduct_research, curation, data_handling, software_development, education]
roles: [researcher, software_developer, educator, data_steward]
---

# M@TE (Model Atlas of the Earth)

<img src="assets/img/MATE.png" alt="M@TE logo" width="20%">

The **Model Atlas of the Earth (M@TE)** is a digital platform that provides access to a wide range of computational models and their outputs, focused on Earth’s evolution from the Geosphere to the Hydrosphere.
M@TE encapsulates the entire model development process — from setup to output and analysis — enabling discovery, data preservation, reproducibility and reuse, offering flexibility for users with varying levels of expertise.

Purpose-built to meet the specific needs of the geoscience community, M@TE is a lasting, sustainable, and scalable resource that supports and leverages research infrastructure. It offers flexible tools for managing, sharing, and preserving numerical models, with built-in DOI creation to ensure persistent, citable access to results. Similar in spirit to Zenodo, but bigger and better for geoscientific modeling.

M@TE is designed to meet geoscientists where they are: from educators and students using visualizations in the classroom to researchers developing and benchmarking new numerical models. It lowers the learning curve of numerical models and bridges the gap between traditional geology and numerical geosciences.

M@TE encapsulates the full model life cycle — from code and input data to outputs, documentation, and publications — ensuring models are **machine-readable, reproducible, and reusable**.

To achieve this, M@TE packages models with the RO-Crate standard. Each model is accompanied by structured metadata and references to its components (inputs, outputs, figures, animations, code, authorship). This makes it possible to discover, cite, and reuse computational Earth models at scale.

![M@TE diagram. An RO-Crate is built from contextual entities, model outputs, scripts, and input data. The RO-Crate is hosted on GitHub and published via NCI Australia and given a DOI.](assets/img/MATE-diagram.png)

## Examples of M@TE RO-Crates

An example RO-Crate can be found in the [M@TE GitHub repository](https://github.com/ModelAtlasofTheEarth/polanco-2024-deltas/blob/main/ro-crate-metadata.json), which packages simulation code, input datasets, and output datasets with metadata for citation and reuse.

Each crate includes:
- **Inputs**: code and configuration for simulations
- **Outputs**: model results (e.g. HDF5 datasets, XDMF time series)
- **Documentation and metadata**: descriptions, provenance, cross-links to publications, and persistent identifiers (DOIs)
- **Website materials**: figures and animations for educational and outreach use

## Resources

* [M@TE Homepage](https://mate.science)  
* [M@TE GitHub Organization](https://github.com/ModelAtlasofTheEarth)  

## Publications

Polanco, S., Sandiford, D., Alfonso, C. P., Ilano, L., Qin, X., Giordani, J., Rodríguez Corcho, A. F., & Mather, B. (2024):  
**Model Atlas of the Earth (M@TE): enhancing the usability of integrated numerical models**.  
_AGU Fall Meeting Abstracts 2024_, DI31B-2935  
TODO doi:10.1029/2024AGUFMDI31B2935P

Polanco, S., Sandiford, D., Qin, X., Rodríguez Corcho, A. F., Ilano, L., Alfonso, C. P., Giordani, J., Mather, B., Rees, N., & Farrington, R. (2024):  
**Model Atlas of the Earth (M@TE): advancing the interoperability of digital twins**.  
_EGU General Assembly 2024_, EGU24-12690  
<https://doi.org/10.5194/egusphere-egu24-12690>  

Farrington, R., Wyborn, L., Croucher, J., Devaraju, A., Hunt, A., Hollmann, H., Klump, J., Nixon, A., Prent, A., Polanco, S., Rees, N., & Rawling, T. (2025):  
**AuScope’s Research Data Systems: Operationalising FAIR place-based research through collaboration**.  
_EGU General Assembly 2025_, EGU25-21367  
<https://doi.org/10.5194/egusphere-egu25-21367>
