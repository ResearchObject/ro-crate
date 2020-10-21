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

The [RO-Crate structure](/1.0/#ro-crate-structure) is that a _RO-Crate root_ directory has a _RO-Crate Metadata File_ named `ro-crate-metadata.jsonld` that describe the other files, directories and URLs; as well as relating them to things in the world (e.g. people, instruments).

```note
From RO-Crate 1.1 this file will be renamed `ro-crate-metadata.json`
```

The [specification](specification.md) has several inline examples:
 * [Skeleton ro-crate-metadata.json](/1.0/#direct-properties-of-the-root-data-entity)
 * [Minimal example](/1.0/#direct-properties-of-the-root-data-entity)
 * [Example with files](/1.0/#example-linking-to-a-file-and-folders)
 * [Example with file, author, location](/1.0/#appendix-ro-crate-json-ld)

<!-- TODO: Find a golden exemplar we can showcase here -->

## UTS examples

You can also look at some [example RO-Crates](https://data.research.uts.edu.au/examples/ro-crate/0.2/).

```warning
Some of the below examples may be using [RO-Crate 0.2](0.2/), which may miss some subtle changes in [RO-Crate 1.0](1.0/).
 Implementers are advised to check relevant sections in the latest RO-Crate [specification](specification.md).
```

* [Covid-19 Workflow Hub](https://covid19.workflowhub.eu/workflows) export workflows as RO-Crates, e.g. [a Galaxy workflow](https://covid19.workflowhub.eu/workflows/22/ro_crate?version=1)
* [Recordings in South Efate](http://www.eopas.org/view/NT1/98007?version=v1) ([ro-crate-metadata.jsonldhttp://www.eopas.org/repository/72/b3/dc/14/01/c8/ff/06/aa/cb/a0/99/0a/12/8f/c1/13/cf/9a/d5/27/5f/49/4b/05/c1/14/21/77/35/65/61/bd/7f/4c/0e/88/00/ba/de/2c/bb/be/d7/5f/6d/9d/01/98/94/73/5a/d7/e4/07/62/68/4d/24/3a/44/2d/65/8a/v1/content/ro-crate-metadata.jsonld)) – one of [more than 14k RO-Crates](http://www.eopas.org/) from the [Pacific and Regional Archive for Digital Sources in Endangered Cultures](http://www.paradisec.org.au/) _(beta)_
* [Dataset for IDRC Project: Exploring the opportunities and challenges of implementing open research strategies within development institutions](https://data.research.uts.edu.au/examples/ro-crate/0.2/Data_Package-IDRC_Opportunities_and_Challenges_Open_Research_Strategies/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/0.2/Data_Package-IDRC_Opportunities_and_Challenges_Open_Research_Strategies/ro-crate-metadata.jsonld))
* [Dataset, Book: Pioneer Work in the Alps of New Zealand](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/IE4783007/) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/IE4783007/ro-crate-metadata.jsonld))
* [Glop Pot data](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/Glop_Pot/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/Glop_Pot/ro-crate-metadata.jsonld)) – shows how Calcyte's preview HTML can [nest folders](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/Glop_Pot/ro-crate-preview.html#sketchsheets)
* [Dharmae Example Dataset](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-metadata.jsonld)) – shows how RO-Crate can carry [rich metadata](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-preview.html#https://dharmae.research.uts.edu.au/api/collections/24) for individual resources which can have [multiple representations](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-preview.html#385)
* [RetroPath2.0 IBISBA Node](https://github.com/ResearchObject/ro-crate/tree/master/examples/workflow-0.2.0) [ro-crate-metadata.jsonld](https://raw.githubusercontent.com/ResearchObject/ro-crate/master/examples/workflow-0.2.0/ro-crate-metadata.jsonld) – a dataset containing a scientific workflow represented in two different languages.
* [RO-Crate specification](https://researchobject.github.io/ro-crate/1.0/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://researchobject.github.io/ro-crate/1.0/ro-crate-metadata.jsonld)) – the specification itself and its publication
