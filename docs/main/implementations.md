---
layout: default
title: Implementations
---
<!--
   Copyright 2019-2020 The University of Manchester and RO Crate contributors 
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

# RO-Crate implementations

While we're mostly focusing on the [RO-Crate specification](specification.md) some tools already exist for working with RO-Crates:

 - [Describo](https://uts-eresearch.github.io/describo/) interactive desktop application to create, update and export RO-Crates for different profiles. (~ _beta_)
 - [CalcyteJS](https://github.com/UTS-eResearch/CalcyteJS) is a command-line tool to help create RO-Crates and HTML-readable rendering (~ _beta_)
 - [ro-crate](https://www.npmjs.com/package/ro-crate) - JavaScript/NodeJS library for RO-Crate rendering as HTML. (~ _beta_)
 - [ro-crate-js](https://github.com/UTS-eResearch/ro-crate-js) - utility to render HTML from RO-Crate (~ _alpha_)
 - [ro-crate-ruby](https://github.com/fbacall/ro-crate-ruby) Ruby library to consume/produce RO-Crates (~ _alpha_)
 - [ro-crate-py](https://github.com/researchobject/ro-crate-py) Python library to consume/produce RO-Crates (~ _planning_)

These applications use or expose RO-Crates:

 - [Workflow Hub](https://about.workflowhub.eu/) imports and exports [Workflow RO-Crates](https://about.workflowhub.eu/Workflow-RO-Crate/)
 - [OCFL-indexer](https://github.com/CoEDL/modpdsc/) NodeJS application that walks the [Oxford Common File Layout](https://ocfl.io/) on the file system, validate RO-Crate Metadata Files and parse into objects registered in Elasticsearch. (~ _alpha_)
 - [ONI indexer](https://github.com/UTS-eResearch/oni-indexer)
 - [ocfl-tools](https://github.com/CoEDL/ocfl-tools)
 - [ocfl-viewer](https://hub.docker.com/r/coedl/ocfl-viewer)
 - [Research Object Composer](https://github.com/researchobject/research-object-composer) is a REST API for gradually building and depositing Research Objects according to a pre-defined profile.  (RO-Crate support _alpha_)
- ... (yours?)