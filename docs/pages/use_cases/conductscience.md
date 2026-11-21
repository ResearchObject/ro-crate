---
page_id: conductscience
title: ConductScience
description: ConductScience publishes an RO-Crate for every public dataset on ConductScience Data.
url: https://conductscience.org/data
image: conductscience.png
domains: [biomedical_science, medicine] # should match item(s) in pages/domains
tasks: [manage_data, curation] # should match item(s) in pages/tasks
roles: [repository_manager, researcher] # should match item(s) in pages/roles
---

<!--
   Copyright 2026 RO-Crate contributors
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

[ConductScience](https://conductscience.com) makes research equipment and software, and publishes journals and datasets. We build our tools for open data, so we stay away from proprietary formats and try to follow community standards with good metadata. [ConductScience Data](https://conductscience.org/data) is our repository for health and behavioral research datasets, each with a DOI.

## What we use RO-Crate for

Every public dataset on ConductScience Data has an RO-Crate. If you find one of our datasets, the crate tells you (or your software) who made it, what license it's under and which files belong to it. You can get to the crate straight from the DOI.

## Why RO-Crate

We didn't want to invent our own format. RO-Crate is a community standard for describing a dataset and its files, and it's built on Schema.org, which our dataset pages were already using for search engines. Detached crates suit us too, since our files stay where they are and the crate just points to them. And there's an official validator, so we aren't the ones deciding whether our crates are right.

Before, a program that started at one of our DOIs landed on a web page. Now it can follow the DOI to the crate and get a description of the dataset and every file in it.

## How it works

Each crate is a detached RO-Crate 1.3. It lists the dataset's license, creators and files, with each file's size and SHA-256 checksum. The DOI resolves to the dataset's landing page, which sends a `Link` header (`rel="describedby"`) pointing to the crate. We generate the crates from our records. They're never the source data, so we can always rebuild them. Here's an [example crate](https://conductscience.org/api/data/records/timing-aware-ddi/ro-crate-metadata.json).

All of our crates pass [rocrate-validator](https://github.com/crs4/rocrate-validator) at the required level of the RO-Crate 1.3 profile.

## What's changed

Moving to RO-Crate 1.3 pushed us to state the license properly on every dataset. 1.3 requires a license on the root, and 14 of our 19 datasets didn't have a single license link, mostly because they're under MIT and CC BY 4.0 together (12 of the 14). Their crates now point to an entity that holds the full rights statement.

The crates also double as a checklist when we release. They list every file with its size and checksum, so we can check a release against them. In the November 2026 release, all 223 files were there and matched their listed sizes.

Since then, RO-Crate 1.3 has become the format we use for data releases across ConductScience products.

## Next

We'd like to publish crates for the databases in our [research library](https://conductscience.org/library) next, and have our software write a crate alongside the data it exports, starting with [ConductVision](https://conductscience.com/conductvision), our behavior tracking software.

## Resources

* [ConductScience Data](https://conductscience.org/data)
* [Example dataset crate](https://conductscience.org/api/data/records/timing-aware-ddi/ro-crate-metadata.json)
* [rocrate-validator](https://github.com/crs4/rocrate-validator)
