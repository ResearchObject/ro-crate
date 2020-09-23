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

# Research Object Crate (RO-Crate)
{:.no_toc}

Permalink: <https://w3id.org/ro/crate>

1. Table of Contents
{:toc}

**News**: [RO-Crate Metadata specification 1.0](https://w3id.org/ro/crate/1.0) released

## What is RO-Crate? 
RO-Crate is a community effort to establish a lightweight approach to packaging research data with their metadata. It is based on schema.org annotations in JSON-LD, and aims to make best-practice in formal metadata description accessible and practical for use in a wider variety of situations, from an individual researcher working with a folder of data, to large data-intensive computational research environments. 

## Where did RO-Crate come from?
RO-Crate is the marriage of [Research Objects](https://www.researchobject.org/) with [DataCrate](https://github.com/UTS-eResearch/datacrate). It aims to build on their respective strengths, but also to draw on lessons learned from those projects and similar research data packaging efforts. For more details, see [background](background.md).

## Who is it for?
The RO-Crate effort brings together practitioners from very different backgrounds, and with different motivations and use-cases. Among our core target users are: a) researchers engaged with computation and data-intensive, workflow-driven analysis; b) digital repository managers and infrastructure providers; c) individual researchers looking for a straight-forward tool or how-to guide to "FAIRify" their data; d) data stewards supporting research projects in creating and curating datasets.

We are still [gathering usecases](https://github.com/ResearchObject/ro-crate/issues?q=is%3Aissue+is%3Aopen+label%3Ause-case), please help us by [adding more](https://github.com/ResearchObject/ro-crate/issues/new/choose).
  
## When can I use it?
The RO-Crate 1.0 specification has been **released**.

* **[RO-Crate 1.0](1.0)** **(newest release)**
  * [RO-Crate 1.1-DRAFT](1.1-DRAFT) (draft for next release)
* [RO-Crate 0.2](0.2)
* [DataCrate 1.0 review](https://docs.google.com/document/d/150SzIG8Zs3wecPTUue7wxKn6V26oi7rYucS5lxnmWZU/edit) 
  * (imported from [datacrate](https://github.com/UTS-eResearch/datacrate/blob/master/spec/1.0/data_crate_specification_v1.0.md))
* [ROLite Draft 0.1.0](0.1.0) 

_Historical note_: After the initial draft, the community decided to base the specification on [DataCrate](https://github.com/UTS-eResearch/datacrate/), and changed the name from _ROLite_ to **RO-Crate**.

[Feedback](https://github.com/researchobject/ro-crate/issues) and improvements are welcome [towards RO-Crate 1.1](https://github.com/ResearchObject/ro-crate/tree/master/docs/1.1-DRAFT), taking into account backwards compatibility according to [semantic versioning](https://semver.org/spec/v2.0.0.html).

## How can I use it?

While we're mostly focusing on the specification, some tools already exist for working with RO-Crates:

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

You can also look at some [example RO-Crates](https://data.research.uts.edu.au/examples/ro-crate/0.2/): _Note: Some of these examples may be using RO-Crate 0.2, which may miss some subtle changes in RO-Crate 1.0._
* [Covid-19 Workflow Hub](https://covid19.workflowhub.eu/workflows) export workflows as RO-Crates, e.g. [a Galaxy workflow](https://covid19.workflowhub.eu/workflows/22/ro_crate?version=1)
* [Recordings in South Efate](http://vm-45-113-232-73.rc.cloud.unimelb.edu.au/paradisec.org.au/NT1/98007) ([ro-crate-metadata.jsonld](http://vm-45-113-232-73.rc.cloud.unimelb.edu.au/repository/3d/dc/34/6d/15/d2/66/c4/8e/ff/37/d3/2a/d1/29/7c/6e/56/7b/74/46/0d/85/23/d0/a7/ca/82/be/4e/c1/9d/v1/content/ro-crate-metadata.jsonld)) – one of [more than 10k RO-Crates](http://vm-45-113-232-73.rc.cloud.unimelb.edu.au/explore) from the [Pacific and Regional Archive for Digital Sources in Endangered Cultures](http://www.paradisec.org.au/) _(alpha)_
* [Dataset for IDRC Project: Exploring the opportunities and challenges of implementing open research strategies within development institutions](https://data.research.uts.edu.au/examples/ro-crate/0.2/Data_Package-IDRC_Opportunities_and_Challenges_Open_Research_Strategies/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/0.2/Data_Package-IDRC_Opportunities_and_Challenges_Open_Research_Strategies/ro-crate-metadata.jsonld))
* [Dataset, Book: Pioneer Work in the Alps of New Zealand](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/IE4783007/) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/IE4783007/ro-crate-metadata.jsonld))
* [Glop Pot data](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/Glop_Pot/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/Glop_Pot/ro-crate-metadata.jsonld)) – shows how Calcyte's preview HTML can [nest folders](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/Glop_Pot/ro-crate-preview.html#sketchsheets)
* [Dharmae Example Dataset](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-metadata.jsonld)) – shows how RO-Crate can carry [rich metadata](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-preview.html#https://dharmae.research.uts.edu.au/api/collections/24) for individual resources which can have [multiple representations](https://data.research.uts.edu.au/examples/ro-crate/examples/src/samples/dharmae/ro-crate-preview.html#385)
* [RetroPath2.0 IBISBA Node](https://github.com/ResearchObject/ro-crate/tree/master/examples/workflow-0.2.0) [ro-crate-metadata.jsonld](https://raw.githubusercontent.com/ResearchObject/ro-crate/master/examples/workflow-0.2.0/ro-crate-metadata.jsonld) – a dataset containing a scientific workflow represented in two different languages.
* [RO-Crate specification](https://researchobject.github.io/ro-crate/1.0/ro-crate-preview.html) ([ro-crate-metadata.jsonld](https://researchobject.github.io/ro-crate/1.0/ro-crate-metadata.jsonld)) – the specification itself and its publication

## Contribute

The _RO-Crate_ team is:

* Peter Sefton <https://orcid.org/0000-0002-3545-944X> (co-chair)
* Stian Soiland-Reyes <https://orcid.org/0000-0001-9842-9718> (co-chair)
* Eoghan Ó Carragáin <https://orcid.org/0000-0001-8131-2150> (emeritus chair)
* Oscar Corcho <https://orcid.org/0000-0002-9260-0753>
* Daniel Garijo <https://orcid.org/0000-0003-0454-7145>
* Raul Palma <https://orcid.org/0000-0003-4289-4922>
* Frederik Coppens <https://orcid.org/0000-0001-6565-5145>
* Carole Goble <https://orcid.org/0000-0003-1219-2137>
* José María Fernández <https://orcid.org/0000-0002-4806-5140>
* Kyle Chard <https://orcid.org/0000-0002-7370-4805>
* Jose Manuel Gomez-Perez <https://orcid.org/0000-0002-5491-6431>
* Michael R Crusoe <https://orcid.org/0000-0002-2961-9670>
* Ignacio Eguinoa <https://orcid.org/0000-0002-6190-122X>
* Nick Juty <https://orcid.org/0000-0002-2036-8350>
* Kristi Holmes <https://orcid.org/0000-0001-8420-5254>
* Jason A. Clark <https://orcid.org/0000-0002-3588-6257>
* Salvador Capella-Gutierrez <https://orcid.org/0000-0002-0309-604X>
* Alasdair J. G. Gray <https://orcid.org/0000-0002-5711-4872>
* Stuart Owen <https://orcid.org/0000-0003-2130-0865>
* Alan R Williams <https://orcid.org/0000-0003-3156-2105>
* Giacomo Tartari <https://orcid.org/0000-0003-1130-2154>
* Finn Bacall <https://orcid.org/0000-0002-0048-3300>
* Thomas Thelen <https://orcid.org/0000-0002-1756-2128>
* Hervé Ménager <https://orcid.org/0000-0002-7552-1009>
* Laura Rodríguez Navas <https://orcid.org/0000-0003-4929-1219>
* Paul Walk <https://orcid.org/0000-0003-1541-5631>
* brandon whitehead <https://orcid.org/0000-0002-0337-8610>
* Mark Wilkinson <https://orcid.org/0000-0001-6960-357X>
* Paul Groth <https://orcid.org/0000-0003-0183-6910>
* Erich Bremer <https://orcid.org/0000-0003-0223-1059>
* LJ Garcia Castro <https://orcid.org/0000-0003-3986-0510>
* Karl Sebby <https://orcid.org/0000-0001-6022-9825>
* Alexander Kanitz <https://orcid.org/0000-0002-3468-0652>
* Ana Trisovic <https://orcid.org/0000-0003-1991-0533>
* Gavin Kennedy <https://orcid.org/0000-0003-3910-0474>
* Mark Graves <https://github.com/myiremark>
* Jasper Koehorst <https://orcid.org/0000-0001-8172-8981>

To suggest changes, improvements or issues, use the GitHub repository <https://github.com/ResearchObject/ro-crate> - if you are new to GitHub or Open Source you may appreciate the [GitHub guides](https://guides.github.com/) like [Hello World](https://guides.github.com/activities/hello-world/), [MarkDown](https://guides.github.com/features/mastering-markdown/) and [How to contribute to open source](https://opensource.guide/how-to-contribute/)

You are welcome to [join us](https://github.com/ResearchObject/ro-crate/issues/1)! Contributors are expected to comply with our [Code of Conduct](https://github.com/ResearchObject/ro-crate/blob/master/CODE_OF_CONDUCT.md) to ensure an open and inclusive environment.

This specification and documentation is Open Source and licensed as [Apache License, version 2.0](https://github.com/ResearchObject/ro-crate/blob/master/LICENSE), see <https://www.apache.org/licenses/LICENSE-2.0> for details.

### Meetings
The RO-Crate team try to meet in a monthly telcon, see the [rolling agenda](https://s.apache.org/ro-crate-minutes) for schedule, call-in details and minutes.

See also [recent and upcoming events](outreach#upcoming-and-recent-events).

## Cite RO-Crate
Eoghan Ó Carragáin; Carole Goble; Peter Sefton; Stian Soiland-Reyes (2019): **A lightweight approach to research object data packaging** _Bioinformatics Open Source Conference (BOSC2019)_ <https://doi.org/10.5281/zenodo.3250687>

See also [recent publications, presentations and citations](outreach).
