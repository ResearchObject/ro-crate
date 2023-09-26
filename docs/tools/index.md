---
title: Tools
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

# Tools

While we're mostly focusing on the [RO-Crate specification](../specification.md) some tools already
exist for working with RO-Crates:

-   [Crate-O](https://github.com/Language-Research-Technology/crate-o) --  browser-based editor for Research Object Crates, inspired by Describo, with vocabulary support for _Schema.org Style schemas_ (SOSSs) (~ _alpha_)
-   [Describo](https://describo.github.io/#/) - an ecosystem of tools, software components and
    services to create and manage Research Object Crates. (~ _RC_)
    -   Desktop: https://describo.github.io/#/desktop
    -   Browser: https://describo.github.io/#/web
    -   For Developers: https://describo.github.io/#/component
    -   JSON-LD Data Packs: https://describo.github.io/#/datapacks
    -   Profiles (interface definition): https://describo.github.io/#/profile
    -   [Describo Crate Builder Web](https://github.com/describo/crate-builder-component-react)
-   [dmbon-assistant](https://github.com/vliz-be-opsci/dmbon-assistant/#readme) -- Data management assistant that publishes RO-Crate (~ _alpha_)
-   [ro-crate-excel](https://www.npmjs.com/package/ro-crate-excel) -- Command-line tool to help
    create RO-Crates from spreadsheets (~ _beta_)
-   [ro-crate-html](https://www.npmjs.com/package/ro-crate-html) -- HTML rendering of RO-Crate (~
    _beta_)
-   [ro-crate-preview](https://github.com/marketplace/actions/ro-crate-preview) -- GitHub Action for
    _ro-crate-html_, e.g. publishing crates on GitHub Pages (~ _alpha_)
-   [rocrate-to-pages](https://github.com/vliz-be-opsci/rocrate-to-pages) -- GitHub action to generate a GitHub Pages web site from a RO-Crate git repository (~ _alpha_)
-   [rocrate-preview-widget](https://github.com/vliz-be-opsci/rocrate-preview-widget) -- React web application to dynamically preview an RO-Crate (~ _prototype_)
-   [ro-crate-js](https://www.npmjs.com/package/ro-crate) -- JavaScript/NodeJS library for RO-Crate
    rendering as HTML. (~ _beta_)
-   [ro-crate-ruby](https://github.com/fbacall/ro-crate-ruby) - Ruby library to consume/produce
    RO-Crates (~ _beta_)
-   [ro-crate-py](https://github.com/researchobject/ro-crate-py) -- Python library to
    consume/produce RO-Crates (~ _beta_)
-   [ro-crate-java](https://github.com/kit-data-manager/ro-crate-java) -- Java API for creating and
    modifying RO-Crate using builder pattern
-   [ROCrates.Net](https://uon-drs.github.io/ROCrates.Net/) -- programmatically create and manipulate RO-Crates in C# and .NET (~ _alpha_)
-   [galaxy2cwl](https://github.com/workflowhub-eu/galaxy2cwl) -- Wraps Galaxy workflow as Workflow
    RO-Crate (~ _alpha_)
-   [ya2ro](https://github.com/oeg-upm/ya2ro) -- Generate RO-Crate and HTML page from YAML template
    with look-up of DOI/ORCID/GitHub metadata (~ _prototype_)
-   [arc-to-roc](https://github.com/nfdi4plants/arc-to-roc) -- Generate RO-Crate from an Annotated
    Research Context ([ARC](https://nfdi4plants.org/content/docs/AnnotatedResearchContext.html)),
    see [DataPlant](../in-use/index.md#dataplant)
-   [ROCrate_enrichment_service](https://github.com/oeg-upm/ROCrate_enrichment_service) -- API-based
    metadata enrichment service for RO-Crates (~ _prototype_)
-   [FAIR-Research-Object](https://github.com/oeg-upm/FAIR-Research-Object) -- evaluate FAIRness of
    Research Objects through an [API](https://app.swaggerhub.com/apis/esgg/FAIROs/1.0.0-oas3) (~
    _prototype_)
-   [repo2crate](https://github.com/crs4/repo2crate) -- Generate a Workflow Testing RO-Crate from a
    "best-practices" workflow repository
-   [ro-crate-benchmarks](https://github.com/kit-data-manager/ro-crate-benchmarks) -- Benchmarks for
    performance testing RO-Crate libraries
-   [tonkaz](https://github.com/sapporo-wes/tonkaz) -- Tool to verify workflow reproducibility,
    compares RO-Crates of workflow execution results.
-   [signposting](https://pypi.org/project/signposting/) -- Python library & CLI tool for resolving
    PIDs as [FAIR Signposting](https://signposting.org/FAIR/), e.g. DOIs from
    [WorkflowHub](https://workflowhub.eu/) to RO-Crate (~ _beta_)
-   [RO-Crates-and-Excel](https://github.com/e11938258/RO-Crates-and-Excel) -- generate RO-Crate
    from Excel file, following the RO-Crates-and-Excel profile.
-   [rocrate-lang-py](https://github.com/Language-Research-Technology/rocrate-lang-py) -- RO Crate
    Python library to help you load language data from ro-crates (~ _prototype_)
-   [ROcrate-interface](https://github.com/GusEllerm/ROcrate-interface) -- Initial development in
    creating an interface between workflow languages and a LivePublication RO-crate specification (~
    _prototype_)
-   [aiida-rocrate](https://github.com/sphuber/aiida-rocrate) -- [AiiDA](https://www.aiida.net/)
    plugin that allows exporting (parts) of the provenance graph as Research Object Crates. (~
    _planning_)
-   [RO-Crate-Registry](https://github.com/XiaotianWang0918/RO-Crate-Registry) -- a Web-based
    registry of RO-Crates (assumes ZIP on http/https) (~ _prototype_)
-   [CheckMyCrate](https://github.com/KockataEPich/CheckMyCrate/tree/Version_0.2) -- Validation
    according to Workflow RO-Crate profile (~ _alpha_)
-   [ro-crate-validator-py](https://github.com/ResearchObject/ro-crate-validator-py/) -- a modular
    RO-Crate validator (~ _alpha_)
-   [Sciebo Research Data Services](https://www.research-data-services.org/) -- move research data from OwnCloud to Zenodo or OSF, parsing/creating RO-Crate Metadata file 
-   [tuw-rocrate-automation/](https://github.com/MoritzRenkin/tuw-rocrate-automation/) -- Convert RO-Crate (Research Object Crate) to reposit into InvenioRDM (~ _alpha_) 
-   [ro-crates-deposit](https://github.com/beerphilipp/ro-crates-deposit) -- Command line tool to deposit a RO-Crate directory to an InvenioRD (~_alpha_)
-   [rocrate-to-sembench](https://github.com/vliz-be-opsci/rocrate-to-sembench) -- github action to prepare a rocrate for pysembench (~ _alpha_)
-   [profile-repository-to-pages](https://github.com/vliz-be-opsci/profile-repository-to-pages) -- an RO-Crate profile registry that extracts metadata from Profile Crates (~ _prototype_) 


See also [applications using RO-Crate](../in-use/).
