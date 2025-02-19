---
page_id: eln
title: Electronic Lab Notebook
description: 
url: https://guides.dataverse.org/en/6.4/installation/advanced.html#inventory-of-external-exporters
domains: [chemistry, biomedical_science]
tasks: [data_handling, manage_data]
roles: [data_steward, repository_manager, researcher]
---

# Electronic Lab Notebook

The [ELN file format](https://github.com/TheELNConsortium/TheELNFileFormat) has been defined as an archive format to capture Electronic Laboratory Notebooks (ELN).  

An ELN archive is a ZIP file with the `.eln` extension, containing a single root folder which is an RO-Crate. 

The [ELN specification](https://github.com/TheELNConsortium/TheELNFileFormat/blob/master/SPECIFICATION.md) is based on the RO-Crate specification and is exported by Lab notebook software including [eLabFTW](https://www.elabftw.net/)

ELN archives can be [previewed in Dataverse](https://github.com/gdcc/dataverse-previewers/pull/21).



## ELN implementations and examples

| Implementation                                    | .eln import | .eln export  | Example |
| ------------------------------------------------- | ----------- | ------------ | ------------ |
| [eLabFTW](https://www.elabftw.net)                | ✅ | ✅ | [elabftw](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/elabftw)   |
| [Kadi4Mat](https://kadi.iam.kit.edu/)             | ✅ | ✅ | [kadi4mat](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/kadi4mat) |
| [Pasta](https://github.com/PASTA-ELN/pasta-eln)   | ✅ | ✅ | [PASTA](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/PASTA)       |
| [SampleDB](https://github.com/sciapp/sampledb)    | ✅ | ✅ | [SampleDB](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/SampleDB) |
| [Rspace](https://www.researchspace.com/)          | ✅ | ✅ | [RSpace](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master/examples/RSpace)     |
| [NOMAD](https://nomad-lab.eu)                     | ✅ |    | |

_Table adapted from [TheELNConsortium/TheELNFileFormat](https://github.com/TheELNConsortium/TheELNFileFormat/tree/master?tab=readme-ov-file#known-implementations)_
