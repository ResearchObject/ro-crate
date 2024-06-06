---
page_id: wfexs
redirect_from:
    - /in-use/wfexs
title: Workflow Execution Service (WfExS)
description: WfExS-backend is a high-level workflow execution command line program that consumes and creates RO-Crates, focusing on the interconnection of content-sensitive research infrastructures for handling sensitive human data analysis scenarios
url: https://github.com/inab/WfExS-backend
image: wfexs.svg
domains: [biology, biomedical_science, medicine]
tasks: [compliance, conduct_research, data_handling]
roles: [compliance_officer, data_analyst, managerial, researcher]
---
<!--
   Copyright 2019-2024 RO-Crate contributors
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
#Workflow Execution Service (WfExS)
Workflow Execution Service Backend (WfExS-backend) is a high-level orchestrator to run scientific workflows reproducibly. It acquires workflows, containers and inputs  from a distributed scenario in order to prepare their local execution, interfacing with workflow engines to instantiate them. It supports cwltool and Nextflow workflow engines with current efforts to incorporate snakemake and Galaxy. WfExS-backend was initially developed in EOSC-Life as a demonstrator on sensitive data analysis and is now part of the Service Delivery plan of INB/ELIXIR-ES.

RO-Crate is a community-driven digital objects semantic metadata specification used in scenarios like the description of research datasets in several milestones of their lifecycle. It enables the creation of self-contained representations of the metadata, which can be easily shared and reused, even when the annotated digital objects are publicly identified but under controlled access.

WfExS-backend can consume and produce RO-Crates describing scientific workflows (where the workflow and its resources are available) and workflow executions (description of inputs, containers, etc...). The ideal scenario is where the generated RO-Crates describing workflow instantiations have all the shareable gathered details needed to reproduce them.

Generated WfExS-backend RO-Crates come from previously staged execution scenarios and the gathered, associated metadata (both prospective and retrospective). These RO-Crates should follow the different Workflow Run RO-Crate profiles, taking into account the limitations of the WfExS-backend by gathering all the details from the different workflow engines, their instantiations and the computing environment. These details can ensure that properly documented workflow instantiations are more reproducible, reusable, and easily understood by the scientific community.
