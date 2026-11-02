---
page_id: conductscience
title: ConductScience
description: ConductScience publishes an RO-Crate for every public dataset on ConductScience Data and every paper page on ReplicateScience.
url: https://conductscience.org/data
image: conductscience.png
domains: [biomedical_science, medicine] # should match item(s) in pages/domains
tasks: [manage_data, curation] # should match item(s) in pages/tasks
roles: [repository_manager, researcher] # should match item(s) in pages/roles
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

# ConductScience

<a href="https://conductscience.org/data">
<img src="assets/img/conductscience.png" alt="ConductScience logo" width="30%">
</a>

[ConductScience](https://conductscience.com) makes research equipment and software, and it publishes journals and datasets. [ConductScience Data](https://conductscience.org/data) holds health and behavioral research datasets with DOIs. [ReplicateScience](https://replicatescience.com) records how behavioral tests were run, taken from the Methods sections of open-access papers. Every value there comes with a quote from the paper.

## RO-Crate in ConductScience

Every public dataset has a detached RO-Crate 1.3 that describes its rights, creators and files, with a size and SHA-256 checksum per file. Its DOI resolves to a landing page whose `Link` header names the crate with `rel="describedby"`, so a tool can get from the DOI to the metadata. [Example dataset crate](https://conductscience.org/api/data/records/timing-aware-ddi/ro-crate-metadata.json).

Every paper page on ReplicateScience has a crate to download. The crate names any NIH grants and the equipment the paper reports, so a tool can link a method to its funding and apparatus. A `CreateAction` describes how the record was made, including the AI model that read the paper. `creativeWorkStatus` stays `Unchecked` until a person has reviewed the record. [Example paper crate](https://replicatescience.com/crates/PMC10411578-ro-crate-metadata.json).

All of these crates pass [rocrate-validator](https://github.com/crs4/rocrate-validator) at the required level of its RO-Crate 1.3 profile.
