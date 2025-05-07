---
page_id: digital-twins
title: Digital Twins
description: RO-Crate is used to describe digital twins in a number of projects studying earth systems and biodiversity. These include DT-GEO, BioDT, EDITO-Infra, and Destination Earth.
domains: [climate_science, ecology] # should match item(s) in pages/domains
tasks: [conduct_research, software_development] # should match item(s) in pages/tasks
roles: [data_analyst, software_developer] # should match item(s) in pages/roles
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

# Digital Twins

RO-Crate is used to describe digital twins in a number of projects studying earth systems and biodiversity. These include [DT-GEO](https://dtgeo.eu/project/), [BioDT](https://biodt.eu), [EDITO-infra](https://edito-infra.eu), and [Destination Earth](https://destination-earth.eu).

## DT-GEO

<img src="assets/img/dt-geo.png" alt="DT-GEO logo" width="30%">

A Digital Twin for GEOphysical extremes ([DT-GEO](https://dtgeo.eu/project/)) is a European project that aims to analyse and forecast the impact of tsunamis, earthquakes, volcanoes, and anthropogenic seismicity.

RO-Crate has two uses in DT-GEO.

The first use is generating the metadata of experiments that are run using [COMPSs](COMPSs). This is directly supported in COMPSs, so the Digital Twin Components (DTCs) that use COMPSs in their implementation are able to automatically generate metadata with RO-Crates following the [Workflow Run Crate](https://www.researchobject.org/workflow-run-crate/profiles/workflow_run_crate/) profile.

The second use will be an integration of RO-Crate in the [EPOS metadata schema](https://www.epos-eu.org) to describe prospective provenance of workflows (i.e. the plan for a workflow execution before it happens), which will also be used by DT-GEO. EPOS mainly uses [DCAT](https://www.w3.org/TR/vocab-dcat-3/) and [CERIF](https://eurocris.org/services/main-features-cerif) metadata formats to describe the digital assets of type datasets and software (code + services), and uses [Common Workflow Language](https://www.commonwl.org) plus RO-Crate for the abstract representation of workflows.

### Resources

* [DT-GEO WorkflowHub team](https://workflowhub.eu/programmes/36)
* [EOSC and the Digital Twins](https://www.youtube.com/watch?v=qhzlEg7bdzo) session at EOSC Symposium 2024
    * DT-GEO slides: [A Digital Twin for GEOphysical Extremes](https://eosc.eu/wp-content/uploads/2024/10/Blanquer_DT-GEO.pdf)



## BioDT

<img src="assets/img/biodt.svg" alt="BioDT logo" width="30%">

The Biodiversity Digital Twin ([BioDT](https://biodt.eu)) project provides advanced models for simulation and prediction of biodiversity dynamics. It provides insights and tools for conservation and restoration efforts.

RO-Crate is used in BioDT to create FAIR exports of workflow executions, as well as describing workflows uploaded to [WorkflowHub](workflowhub). In particular, the prototype digital twin for [Crop Wild Relatives](https://biodt.eu/use-cases/crop-wild-relatives) exports workflow executions to the [Destination Earth Data Lake](https://data.destination-earth.eu).

### Resources

* [BioDT WorkflowHub space](https://workflowhub.eu/programmes/22)
* [Example Workflow Run Crate for Crop Wild Relatives pDT](https://workflow.earth/dataset/cwr/10b84c65d5ca549fe00f) (and corresponding [workflow](https://workflowhub.eu/workflows/1261?version=1))
* [Practical web-based FDOs with RO-Crate and FAIR Signposting](https://zenodo.org/records/10892090):  Training material featuring a demonstration of RO-Crate and FAIR Signposting in biodiversity
* [BioDT - FAIR](https://github.com/BioDT/biodt-fair): Examples, resources, and other materials related to FAIR in BioDT
* [Bridging Data Standards and FAIR Principles in biodiversity digital twinning: Prototyping, Challenges, Lessons Learned, and Future Plans](https://youtu.be/2IJKRQF8H-4?t=2806): talk recording by Sharif Islam
* [DestinE User eXchange Day 1: Agriculture and biodiversity](https://www.youtube.com/watch?v=I4B6l5a1GYo&t=59s): Talk recording by Claus Weiland on BioDT's use of DestinE
* [EOSC and the Digital Twins](https://www.youtube.com/watch?v=qhzlEg7bdzo) session at EOSC Symposium 2024
    * BioDT slides: [Biodiversity Digital Twin for advanced modelling, simulation and prediction capabilities](https://eosc.eu/wp-content/uploads/2024/10/Zuquim_BioDT.pdf)
* [BioDT publications relevant to RO-Crate](#biodt-publications)

## EDITO-Infra

<img src="assets/img/edito-infra.png" alt="EDITO-Infra logo" width="30%" style="background-color: #000;">

The [EDITO-Infra](https://edito-infra.eu) project is building the public infrastructure for the EU Digital Twin of the Ocean (EDITO). EDITO is using the [Autosubmit](autosubmit) workflow manager, which can export [Workflow Run Crates](https://www.researchobject.org/workflow-run-crate/profiles/workflow_run_crate/).

### Resources

* [Unifying EDITO-MODELLAB and EDITO-Infra for a seamless virtual environment](https://edito-infra.eu/news/unifying-edito-modellab-and-edito-infra-for-a-seamless-virtual-environment/)
* [EOSC and the Digital Twins](https://www.youtube.com/watch?v=qhzlEg7bdzo) session at EOSC Symposium 2024
    * EDITO-Infra slides: [EPSC and Digital Twins, DestinE+DTO: Iliad, AquaINFRA, DTO-BioFlow, EDITO](https://eosc.eu/wp-content/uploads/2024/10/Berre_EOSC-and-Digital-Twins.pdf)


## Destination Earth

<img src="assets/img/destine.svg" alt="Destination Earth logo" width="30%">

Destination Earth ([DestinE](https://destination-earth.eu)) is developing a highly-accurate digital twin of the Earth to model, monitor and simulate natural phenomena, hazards and the related human activities.

DestinE's [Digital Twin Engine](https://stories.ecmwf.int/the-digital-twin-engine/) uses the [Autosubmit](autosubmit) workflow manager to orchestrate the [Climate Change Adaptation Digital Twin](https://destine.ecmwf.int/climate-change-adaptation-digital-twin-climate-dt/). Autosubmit can export [Workflow Run Crates](https://www.researchobject.org/workflow-run-crate/profiles/workflow_run_crate/).

### Resources

* [DestinE User eXchange Day 1: Agriculture and biodiversity](https://www.youtube.com/watch?v=I4B6l5a1GYo&t=59s): Talk recording by Claus Weiland on BioDT's use of DestinE
[EOSC and the Digital Twins](https://www.youtube.com/watch?v=qhzlEg7bdzo) session at EOSC Symposium 2024
    * Destination Earth slides: [Destination Earth: A novel information system for a resilient society](https://eosc.eu/wp-content/uploads/2024/10/Greenen_Destination-Earth.pdf)


## Publications on Digital Twins and RO-Crate

### BioDT publications

Jonas Grieb, Claus Weiland, Alexander Wolodkin, Julian Lopez Gordillo, Sharif Islam (2025):  
**Implementing FAIR Semantic Mappings Leveraging on RO-Crate**  
_International FAIR Digital Objects Implementation Summit 2024_, Berlin, Germany, 2024-03-20/--21.  
_Open Conference Proceedings_ **5**  
<https://doi.org/10.52825/ocp.v5i.1179>

Julian Lopez Gordillo, Sharif Islam (2025):  
**FDO As an Interoperability Framework for the Biodiversity Digital Twin Project**  
_International FAIR Digital Objects Implementation Summit 2024_, Berlin, Germany, 2024-03-20/--21.  
_Open Conference Proceedings_ **5**  
<https://doi.org/10.52825/ocp.v5i.1190>

Claus Weiland, Daniel Bauer, Erik Kusch, Desalegn Chala, Dag Endresen (2025):  
**Crop Wild Relatives and Destination Earth : Benefits and Lessons Learned**  
_BioDT final conference_, 2025-04-02/--03, Rome, Italy  
<https://doi.org/10.5281/zenodo.15322593>

Leyla Jael Castro, Stian Soiland-Reyes, Jonas Grieb, Claus Weiland (2024):  
**Practical Web-based FDOs with RO-Crate and FAIR Signposting**  
Training material presented at _International FAIR Digital Objects Implementation Summit 2024_, 2024-03-19, Berlin, Germany.  
<https://doi.org/10.5281/zenodo.10892090>

Souza, Jussi Talaskivi, Gleb Tikhonov, Aurélie Vancraeyenest, Ari Lehtiö (2024):  
**Prototype Biodiversity Digital Twin: Real-time bird monitoring with citizen-science data.**  
_Research Ideas and Outcomes_ **10**:e125523  
<https://doi.org/10.3897/rio.10.e125523>

Simon Rolph, Chris Andrews, Dylan Carbone, Julian Lopez Lopez Gordillo, Tomáš Martinovič, Nick Oostervink, Dirk Pleiter, Kata Sara-aho, John Watkins, Christoph Wohner, Will Bolton, Jan Dick (2024):  
**Prototype Digital Twin: Recreation and biodiversity cultural ecosystem services.**  
_Research Ideas and Outcomes_ **10**:e125450   
<https://doi.org/10.3897/rio.10.e125450>

Desalegn Chala, Erik Kusch, Claus Weiland, Carrie Andrew, Jonas Grieb, Tuomas Rossi, Tomas Martinovic, Dag Endresen (2024):  
**Prototype Biodiversity Digital Twin: Crop Wild Relatives Genetic Resources for Food Security**  
_Research Ideas and Outcomes_ **10**:e125192  
<https://doi.org/10.3897/rio.10.e125192>

Jonas Grieb, Claus Weiland, Alexander Wolodkin, Leyla Jael Castro, Stian Soiland-Reyes, Maya Beukes, Martin Jansen (2024):  
**Using Webby FDOs to Integrate AI Taxon Identification and Citizen Science**  
_Biodiversity Information Science and Standards_ **8**:e134757  
<https://doi.org/10.3897/biss.8.134757>

Claus Weiland, Jonas Grieb, Daniel Bauer, Desalegn Chala, Erik Kusch, Carrie Andrew, Dag Endresen (2024):  
**Dataspace Integration for Agrobiodiversity Digital Twins with RO-Crate**  
_Biodiversity Information Science and Standards_ **8**:e134479  
<https://doi.org/10.3897/biss.8.134479>

Tomáš Martinovič, Kata Sara-aho, Ondrej Salamon, Simon Rolph, Allan T Souza (2024):  
**Graphical User Interface for Biodiversity Digital Twins: Data Challenges**  
_Biodiversity Information Science and Standards_ **8**:e135092  
<https://doi.org/10.3897/biss.8.135092>

Sharif Islam, Julian Lopez Gordillo, Dag Endresen, Carrie Andrew (2024):  
**Bridging Data Standards and FAIR Principles in Biodiversity Digital Twinning: Prototyping, Challenges, Lessons Learned, and Future Plans**  
_Biodiversity Information Science and Standards_ **8**:133089  
<https://doi.org/10.3897/biss.8.133089>
