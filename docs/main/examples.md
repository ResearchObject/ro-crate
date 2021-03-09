---
layout: default
title: Examples
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

# Example RO-Crates

The [RO-Crate structure](1.1/structure.html) is that a _RO-Crate root_ directory has a _RO-Crate Metadata File_ named `ro-crate-metadata.json` that describe the other files, directories and URLs; as well as relating them to things in the world (e.g. people, instruments).

```note
From RO-Crate 1.1 `ro-crate-metadata.jsonld` was renamed `ro-crate-metadata.json`.
```

The [specification](specification.md) has several inline examples:
 * [Skeleton ro-crate-metadata.json](1.1/root-data-entity.html#ro-crate-metadata-file-descriptor)
 * [Minimal example](1.1/root-data-entity.html#minimal-example-of-ro-crate)
 * [Example with files](1.1/data-entities.html#example-linking-to-a-file-and-folders)
 * [Example with web resources](1.1/data-entities.html#web-based-data-entities)
 * [Example with file, author, location](1.1/appendix/jsonld.html)
 * [Example with computational workflow](1.1/workflows.html#complete-workflow-example)
 * [RO-Crate specification](1.1/ro-crate-preview.html) ([ro-crate-metadata.jsonld](1.1/ro-crate-metadata.jsonld)) – the specification itself and its publication

The [RO-Crate 1.1](https://w3id.org/ro/crate/1.1/) specification is largely **explained by examples** by showing additional fragments:
 * [Data entities](1.1/data-entities.html) (files, folders)
 * [Web resources](1.1/data-entities.html#web-based-data-entities)
 * [Contextual entities](1.1/contextual-entities.html) such as [people](1.1/contextual-entities.html#people), [organizations](1.1/contextual-entities.html#organizations-as-values), [citations](1.1/contextual-entities.html#publications-via-citation-property), [licensing](1.1/contextual-entities.html#licensing-access-control-and-copyright), [places](1.1/contextual-entities.html#places)
 * Section on [provenance](1.1/provenance.html) details how the creation of resources can be recorded
 * [Computational workflows and scripts](1.1/workflows.html) can be further described showing programming language, inputs, outputs, etc.
 * The RO-Crate [JSON-LD can be extended](1.1/appendix/jsonld.html#extending-ro-crate) for additional vocabularies, including [ad-hoc](1.1/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms) terms
 * Section on [combining with other packaging schemas](1.1/appendix/implementation-notes.html#combining-with-other-packaging-schemes) explain how an RO-Crate can be packaged in a single archive using BagIt
 
<!-- TODO: Find a golden exemplar we can showcase here -->

## UTS examples

The [Arkisto platform case studies](https://arkisto-platform.github.io/case-studies/) highlight multiple ways RO-Crate has been used:
* [PARADISEC](https://arkisto-platform.github.io/case-studies/paradisec/) (the Pacific And Regional Archive for Digital Sources in Endangered Cultures) deployed on <http://mod.paradisec.org.au/> (example [ro-crate-metadata.jsonld](http://mod.paradisec.org.au/repository/72/b3/dc/14/01/c8/ff/06/aa/cb/a0/99/0a/12/8f/c1/13/cf/9a/d5/27/5f/49/4b/05/c1/14/21/77/35/65/61/bd/7f/4c/0e/88/00/ba/de/2c/bb/be/d7/5f/6d/9d/01/98/94/73/5a/d7/e4/07/62/68/4d/24/3a/44/2d/65/8a/v1/content/ro-crate-metadata.jsonld) via OCFL)


You can also look at some [example RO-Crates](https://data.research.uts.edu.au/examples/ro-crate/0.2/).

```warning
Some of the below examples may be using [RO-Crate 0.2](0.2/), which may miss some subtle changes in [RO-Crate 1.0](1.0/) and [RO-Crate 1.1](1.1/).
 Implementers are advised to check relevant sections in the latest RO-Crate [specification](specification.md).
```

* [Recordings in South Efate](http://mod.paradisec.org.au/view/NT1/98007?version=v1) ([ro-crate-metadata.jsonld](http://mod.paradisec.org.au/repository/72/b3/dc/14/01/c8/ff/06/aa/cb/a0/99/0a/12/8f/c1/13/cf/9a/d5/27/5f/49/4b/05/c1/14/21/77/35/65/61/bd/7f/4c/0e/88/00/ba/de/2c/bb/be/d7/5f/6d/9d/01/98/94/73/5a/d7/e4/07/62/68/4d/24/3a/44/2d/65/8a/v1/content/ro-crate-metadata.jsonld)) – one of [more than 14k RO-Crates](http://mod.paradisec.org.au/) from the [Pacific and Regional Archive for Digital Sources in Endangered Cultures](http://www.paradisec.org.au/) _(beta)_
* [Dataset for IDRC Project: Exploring the opportunities and challenges of implementing open research strategies within development institutions](https://data.research.uts.edu.au/examples/ro-crate/0.2/Data_Package-IDRC_Opportunities_and_Challenges_Open_Research_Strategies/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/0.2/Data_Package-IDRC_Opportunities_and_Challenges_Open_Research_Strategies/ro-crate-metadata.jsonld))
* [Dataset, Book: Pioneer Work in the Alps of New Zealand](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/IE4783007/) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/IE4783007/ro-crate-metadata.jsonld))
* [Glop Pot data](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/Glop_Pot/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/Glop_Pot/ro-crate-metadata.jsonld)) – shows how Calcyte's preview HTML can [nest folders](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/Glop_Pot/ro-crate-preview.html#sketchsheets)
* [Dharmae Example Dataset](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-metadata.jsonld)) – shows how RO-Crate can carry [rich metadata](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-preview.html#https://dharmae.research.uts.edu.au/api/collections/24) for individual resources which can have [multiple representations](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-preview.html#385)

## WorkflowHub examples

The <https://workflowhub.eu/> accepts upload by RO-Crate and generates RO-Crate to improve reproducability of computational workflow that follow the [Workflow RO-Crate profile](https://about.workflowhub.eu/Workflow-RO-Crate/), see also [RO-Crate section on workflows](1.1/workflows.html).

Workflows can be exported from Workflow Hub as RO-Crates, e.g. [a Galaxy workflow](https://workflowhub.eu/workflows/22/ro_crate?version=1). Workflows can also be navigated programmatically using the [TRS API](https://about.workflowhub.eu/TRS/), e.g. <https://workflowhub.eu/ga4gh/trs/v2/tools/26/versions/1/PLAIN_CWL/descriptor/ro-crate-metadata.jsonld>



## Biocompute Object

<https://github.com/biocompute-objects/bco-ro-example-chipseq> hosts an example RO-Crate ([ro-crate-metadata.json](https://rawcdn.githack.com/biocompute-objects/bco-ro-example-chipseq/76cb84c8d6a17a3fd7ae3102f68de3f780458601/data/ro-crate-metadata.json), [ro-crate-preview.html](https://rawcdn.githack.com/biocompute-objects/bco-ro-example-chipseq/76cb84c8d6a17a3fd7ae3102f68de3f780458601/data/ro-crate-preview.html)) that capture a [BioCompute Object](https://www.biocomputeobject.org/) (IEEE 2791) using [BagIt](https://www.researchobject.org/ro-crate/1.1/appendix/implementation-notes.html#adding-ro-crate-to-bagit).  See the tutorial [Create an BCO RO-Crate](https://biocompute-objects.github.io/bco-ro-crate/tutorial/) for step-by-step details.
