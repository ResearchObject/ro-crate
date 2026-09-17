---
page_id: eln
title: Electronic Lab Notebook
description: The ELN file format has been defined as an archive format to capture Electronic Laboratory Notebooks (ELN). The format is based on RO-Crate and is supported by a number of ELN softwares.
url: https://guides.dataverse.org/en/6.4/installation/advanced.html#inventory-of-external-exporters
domains: [chemistry, biomedical_science]
tasks: [data_handling, manage_data]
roles: [data_steward, repository_manager, researcher]
---

# Electronic Lab Notebook

The [ELN file format](https://the.elnconsortium.org/specification/) has been defined as an archive format to capture Electronic Laboratory Notebooks (ELN).  

An ELN archive is a ZIP file with the `.eln` extension (media type [`application/vnd.eln+zip`](https://www.iana.org/assignments/media-types/application/vnd.eln+zip)), containing a single root folder, which is an RO-Crate. 

The [ELN specification](https://github.com/TheELNConsortium/TheELNFileFormat/blob/master/SPECIFICATION.md) is based on the RO-Crate specification and is exported by Lab notebook software, including [eLabFTW](https://www.elabftw.net/).


ELN archives can be created on the desktop with [ELNPack](https://athemis.github.io/ELNPack), [previewed in Dataverse](https://github.com/gdcc/dataverse-previewers/pull/21), and [validated](https://check-eln.streamlit.app/). The [ELN Metadata Diff Viewer](https://codeberg.org/achimw/eln-metadata-diff) compares differences in ELN's RO-Crate metadata. A series of [ELN templates](https://github.com/sfb1638/elabftw-templates/blob/main/TEMPLATES.md) are available. 



## ELN implementations and examples


| Implementation                                            | .eln import | .eln export | Example and specialisation                                                                                   |
| --------------------------------------------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------ |
| [datalab](https://github.com/datalab-org)                 |             | ✅          | [datalab](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/datalab)                 |
| [eLabFTW](https://www.elabftw.net)                        | ✅          | ✅          | [elabftw](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/elabftw)                 |
| [ELN Metadata Diff Viewer](https://codeberg.org/achimw/eln-metadata-diff) | ✅ |      |                                                                                                              |
| [ELNPack](https://athemis.github.io/ELNPack/)             |             | ✅          |                                                                                                              |
| [Kadi4Mat](https://kadi.iam.kit.edu/)                     | ✅          | ✅          | [kadi4mat](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/kadi4mat)               |
| [LinkAhead](https://getlinkahead.com/)                    | ✅          |             |                                                                                                              |
| [NOMAD](https://nomad-lab.eu)                             | ✅          |             |                                                                                                              |
| [OpenSemanticLab](https://github.com/OpenSemanticLab)     | ✅          | ✅          | [OpenSemanticLab](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/OpenSemanticLab) |
| [Pasta](https://github.com/PASTA-ELN/pasta-eln)           | ✅          | ✅          | [PASTA](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/PASTA)                     |
| [Rspace](https://www.researchspace.com/)                  | ✅          | ✅          | [RSpace](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/RSpace)                   |
| [SampleDB](https://github.com/sciapp/sampledb)            | ✅          | ✅          | [SampleDB](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/SampleDB)               |
| [SciLog](https://github.com/paulscherrerinstitute/scilog) | ✅          | ✅          | [SciLog](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/SciLog)                   |


_Table adapted from [TheELNConsortium/TheELNFileFormat](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master?tab=readme-ov-file#known-implementations)_

## Related publications

Max Schröder, Susanne Staehlke, Paul Groth, J. Barbara Nebe, Sascha Spors, Frank Krüger (2022):  
**Structure-based knowledge acquisition from electronic lab notebooks for research data provenance documentation**.  
_Journal of Biomedical Semantics_ **13**(4)  
<https://doi.org/10.1186/s13326-021-00257-x>

Hanna Tsybenko, Sarath Menon, Fei Chen, Abril Azocar Guzman, Katharina Grünwald, Steffen Brinckmann, Tilmann Hickel, Tim Dahmen, Volker Hofmann, Stefan Sandfeld, Ruth Schwaiger (2025):  
**Digital Transformation in Materials Science**: A User Journey of Nanoindentation, Image Analysis and Simulations.  
_Data Science Journal_ **24**:23  
<https://doi.org/10.5334/dsj-2025-033>

Steffen Brinckmann, Georg Winkens, Ruth Schwaiger (2026):  
**PASTA-ELN: Simplifying Research Data Management for Experimental Materials Science**.  
_Advanced Engineering Materials_ e202503181
<https://doi.org/10.1002/adem.202503181>

Rory Macneil, Daniel Turner (2025):  
**Implementing RO-Crate in Research Space**.  
_Zenodo_  
<https://doi.org/10.5281/zenodo.16986906>

