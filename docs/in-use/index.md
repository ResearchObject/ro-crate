---
title: RO-Crate In Use
has_children: true
redirect_from:
    - /implementations
---
<!--
   Copyright 2019-2020 The University of Manchester and RO-Crate contributors 
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

# RO-Crate in use

These applications use or expose RO-Crates to describe Data, Datasets and Workflows:

## WorkflowHub

[WorkflowHub](https://about.workflowhub.eu/) imports and exports [Workflow RO-Crates](https://about.workflowhub.eu/Workflow-RO-Crate/), using it as an exchange format. They are a specialization of RO-Crate for packaging an executable workflow with all necessary documentation. It is aligned with, and intends to strictly extend, the more general [Bioschemas ComputationalWorkflow profile](https://bioschemas.org/profiles/ComputationalWorkflow/1.0-RELEASE/).


## LifeMonitor

[LifeMonitor](life_monitor) uses RO-Crate as an exchange format for describing test suites associated with workflows. To this end, the LifeMonitor team is developing an extension to the [Workflow RO-Crate specification](https://about.workflowhub.eu/Workflow-RO-Crate/) to support the inclusion of metadata related to the testing of computational workflows stored in the crate.

## Arkisto

[Arkisto uses RO-Crate](https://arkisto-platform.github.io/standards/ro-crate/) for packaging data objects in the 3 uses cases described below.

As part of these use-cases they have been developing or enhancing their tooling to facilitate their use of RO-Crate

  * [OCFL-indexer](https://github.com/CoEDL/modpdsc/) is a NodeJS application that walks the [Oxford Common File Layout](https://ocfl.io/) on the file system, validate RO-Crate Metadata Files and parse into objects registered in Elasticsearch. (~ _alpha_) 
  * [ocfl-tools](https://github.com/CoEDL/ocfl-tools) contains tools for managing RO-Crates in an OCFL repository .
  * [ocfl-viewer](https://hub.docker.com/r/coedl/ocfl-viewer)
  * [ONI indexer](https://github.com/UTS-eResearch/oni-indexer)


**Modern PARADISEC**

[Modern PARADISEC](https://arkisto-platform.github.io/case-studies/paradisec/) demonstrates the use of RO-Crate to describe the collections and items and store those items within an OCFL system. The demonstrator includes an elastic search service and a webserver but the key feature is that the it keeps working with only the filesystem and a webserver.


**UTS Research Data Repository**

The [UTS Data Repository](https://arkisto-platform.github.io/case-studies/uts-repo/) UTS Research Data Repository is a searchable portal for discovering and accessing public datasets by UTS researchers. Datasets are described with RO-Crates and published either through the University’s institutional research data management system or direct import from research storage devices for very large datasets.

**UTS Cultural Datasets**

The [UTS Cultural Datasets](https://arkisto-platform.github.io/case-studies/uts-cultural/) project is collaborating with Humanities and Social Science (HASS) researchers and is re-using existing UTS Data infrastructure to build interactive services that allow people to use the data. They make use of RO-Crate to be able to directly transfer data and mappings to the [Expert Nation database](https://expertnation.org/).

## Workflow Execution Service (WfExS)

[WfExS-backend](https://github.com/inab/WfExS-backend) is a high-level workflow execution command line program that consumes and creates RO-Crates, focusing on
the interconnection of content-sensitive research infrastructures for handling sensitive human data analysis scenarios.
WfExS-backend delegates workflow execution of existing workflow engines, and it is designed to facilitate more secure
and reproducible workflow executions to promote analysis reproducibility and replicability. Secure executions are
achieved using FUSE encrypted directories for non-disclosable inputs, intermediate workflow execution results and output
files.

RO-Crates are, indeed, an element of knowledge transfer between repeated workflow executions. WfExS-backend stores all
the gathered details, output metadata and execution provenance in the output RO-Crate to achieve future reproducible
executions. Final execution results can be encrypted with crypt4gh GA4GH standard using the public keys of the target
researchers or destination, so the results can be safely moved outside the execution environments through unsecured
networks and storages.

## Research Object Composer

[Research Object Composer](https://github.com/researchobject/research-object-composer) is a REST API for gradually building and depositing Research Objects according to a pre-defined profile. It uses JSON as an intermediate format and modified JSON schemas to define a Profile (RO-Crate support _alpha_)
