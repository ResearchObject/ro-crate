---
page_id: COMPSs
title: COMPSs
description: The COMPSs programming model is able to record Workflow Provenance in RO-Crate format, for governance and reproducibility of computational experiments
url: https://compss.bsc.es/
image: COMPSs.png
domains: [informatics] # should match item(s) in pages/domains
tasks: [conduct_research, curation, data_handling, software_development] # should match item(s) in pages/tasks
roles: [information_architect, researcher, software_developer] # should match item(s) in pages/roles
---
<!--
   Copyright 2019-2022 RO-Crate contributors
   <https://github.com/ResearchObject/ro-crate/graphs/contributors>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

# COMPSs

[![COMPSs logo](assets/img/COMPSs.png)](https://compss.bsc.es/)

COMP Superscalar ([COMPSs](https://compss.bsc.es/)) is a task-based programming model which aims to ease the development of applications for distributed infrastructures, such as large High-Performance Clusters (HPC), Clouds and Container managed clusters. PyCOMPSs is the Python binding of COMPSs.

COMPSs provides a programming interface for the development of applications in Python/Java/C/C++/R, a runtime system that exploits the inherent parallelism of applications at execution time, and a rich ecosystem for the operation, monitoring, performance evaluation and integration with Jupyter/Jupyterlab.

The COMPSs runtime includes the capacity of automatically recording details of the application’s execution as metadata, also known as [Workflow Provenance](https://compss-doc.readthedocs.io/en/stable/Sections/04_Ecosystem/05_Workflow_Provenance.html). The metadata is recorded in RO-Crate format, following [Workflow RO-Crate](https://w3id.org/workflowhub/workflow-ro-crate/1.0) and [Workflow Run RO-Crate](https://www.researchobject.org/workflow-run-crate/) profile collection. With workflow provenance, you are able to share not only your workflow application (i.e. the source code) but also your workflow run (i.e. the datasets used as inputs, the outputs generated as results, and rich information about every single task executed). 

Provenance information can be useful for a number of things, including Governance, Reproducibility, Replicability, Traceability, or Knowledge Extraction, among others. Workflow Provenance enables users to publish research results obtained with COMPSs as artifacts that can be cited in scientific publications with their corresponding DOI, by using [WorkflowHub](https://workflowhub.eu/) or [Zenodo](https://zenodo.org/) using the [RO-Crate InvenioRDM Deposit library](https://github.com/ResearchObject/ro-crate-inveniordm). Both workflow provenance metadata and its publication in WorkflowHub/Zenodo enable the reproducibility of the workflows.

We have also developed a 'inspect' option in the [PyCOMPSs CLI](https://pypi.org/project/pycompss-cli/) that allows to visualise in a friendly way not only COMPSs generated crates but also the ones generated from different WMSs that follow the Workflow related RO-Crate profiles. This means 'pycompss inspect' is interoperable at least with crates generated with: CWL, nextflow, Galaxy, Autosubmit, WfExS, Streamflow, Snakemake and Sapporo.

![COMPSs with RO-Crate](assets/img/COMPSs-screenshot.png)

## Examples of COMPSs RO-Crates

Plenty of examples of COMPSs Workflows with enabled provenance recording can be found at [WorkflowHub](https://workflowhub.eu/workflows?filter%5Bworkflow_type%5D=pycompss) (filtering the browsing by 'COMPSs' workflow type).

In addition, the COMPSs User Manual has a dedicated section on [how to generate Workflow Provenance with COMPSs](https://compss-doc.readthedocs.io/en/stable/Sections/04_Ecosystem/05_Workflow_Provenance.html).

## Resources

* [COMPSs Homepage](https://compss.bsc.es/)
* [COMPSs documentation](https://compss-doc.readthedocs.io/en/stable/)
* [Workflow Provenance Slides Quick Overview](https://zenodo.org/records/11057731)
* [Workflow Provenance Detailed Slides](https://zenodo.org/records/10046567)
* [RO-Crate InvenioRDM Deposit library](https://github.com/ResearchObject/ro-crate-inveniordm)
* [PyCOMPSs CLI](https://pypi.org/project/pycompss-cli/)

## Publications

Panna Lukács, Rosa M. Badia, Raül Sirvent:
**Explaining AI Applications through Workflow Provenance**.
_Master Thesis, Universitat Politècnica de Catalunya, 2025_
<https://hdl.handle.net/2117/449230>

Leo, S., Crusoe, M. R., Rodríguez-Navas, L., Sirvent, R., Kanitz, A., De Geest, P., ... & Soiland-Reyes, S.:
**Recording provenance of workflow runs with RO-Crate**.
_PLoS ONE 19(9): e0309210. 2024_
<https://doi.org/10.1371/journal.pone.0309210>  

Raül Sirvent, Javier Conejero, Francesc Lordan, Jorge Ejarque, Laura Rodríguez-Navas, José M Fernández, Salvador Capella-Gutiérrez, Rosa M Badia:  
**Automatic, Efficient and Scalable Provenance Registration for FAIR HPC Workflows**.  
_IEEE/ACM Workshop on Workflows in Support of Large-Scale Science (WORKS) 2022_ (1-9)
<https://doi.org/10.1109/WORKS56498.2022.00006>  
[[preprint](https://upcommons.upc.edu/handle/2117/384589)]

