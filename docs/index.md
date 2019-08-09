<!--
   Copyright 2019 The University of Manchester and RO Crate contributors 
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
1. Table of Contents
{:toc}

**Note**: _ROLite_ and _[DataCrate](https://github.com/UTS-eResearch/datacrate)_ have been merged to **RO-Crate**. This is the new homepage [http://researchobject.org/ro-crate/](http://researchobject.org/ro-crate/)

## What is RO-Crate? 
RO-Crate is a community effort to establish a lightweight approach to packaging research data with their metadata. It is based on schema.org annotations in JSON-LD, and aims to make best-practice in formal metadata description accessible and practical for use in a wider variety of situations, from an individual researcher working with a folder of data, to large data-intensive computational research environments. 

## Where did RO-Crate come from?
RO-Crate is the marriage of [Research Objects](https://www.researchobject.org/) with [DataCrate](https://github.com/UTS-eResearch/datacrate). It aims to build on their respective strengths, but also to draw on lessons learned from those projects and similar research data packaging efforts. For more details, see [background](background.md).

## Who is it for?
The RO-Crate effort brings together practitioners from very different backgrounds, and with different motivations and use-cases. Among our core target users are: a) research engaged with computation and data-intensive, wokflow-driven analysis; b) digital repository managers and infrastructure providers; c) individual researchers looking for a straight-forward tool or how-to guide to "FAIRify" their data; d) data stewards supporting research projects in creating and curating datasets.

We are  [gathering usecases](https://github.com/ResearchObject/ro-crate/issues?q=is%3Aissue+is%3Aopen+label%3Ause-case), please help us by [adding more](https://github.com/ResearchObject/ro-crate/issues/new/choose).
  
## When can I use it?
The RO-Crate specification is currently **work in progress** :

* [RO-Crate 0.2-DRAFT](0.2-DRAFT/) (newest, in progress)
  * Annotated in [RO-Crate 0.2-DRAFTS Google Docs](https://docs.google.com/document/d/1sH9CscItg7PbkEOcHPX_tVXfWNP4R57ys2y3W-FfNuA/edit?usp=sharing)
* [DataCrate 1.0 review](https://docs.google.com/document/d/150SzIG8Zs3wecPTUue7wxKn6V26oi7rYucS5lxnmWZU/edit) 
  * (imported from [datacrate](https://github.com/UTS-eResearch/datacrate/blob/master/spec/1.0/data_crate_specification_v1.0.md))
* [ROLite Draft 0.1.0](0.1.0) 

_Historical note_: After the initial draft, the community decided to base the specification on [DataCrate](https://github.com/UTS-eResearch/datacrate/), and changed the name from _ROLite_ to **RO-Crate**.

## How can I use it?
While we're mostly focusing on the specification, some tools already exist for working with RO-Crates:

 - [Calcyte](https://code.research.uts.edu.au/eresearch/CalcyteJS/tree/ro-crate) is a command-line tool to help create RO-Crates
 - ...

## Contribute

The _RO-Crate_ team is:

* Eoghan Ó Carragáin <https://orcid.org/0000-0001-8131-2150> (chair)
* Peter Sefton <https://orcid.org/0000-0002-3545-944X> (co-chair)
* Stian Soiland-Reyes <https://orcid.org/0000-0001-9842-9718> (co-chair)
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

To suggest changes, improvements or issues, use the GitHub repository <https://github.com/ResearchObject/ro-crate> - if you are new to GitHub or Open Source you may appreciate the [GitHub guides](https://guides.github.com/) like [Hello World](https://guides.github.com/activities/hello-world/), [MarkDown](https://guides.github.com/features/mastering-markdown/) and [How to contribute to open source](https://opensource.guide/how-to-contribute/)

You are welcome to [join us](https://github.com/ResearchObject/ro-crate/issues/1)! Contributors are expected to comply with our [Code of Conduct](https://github.com/ResearchObject/ro-crate/blob/master/CODE_OF_CONDUCT.md) to ensure an open and inclusive environment.

This specification and documentation is Open Source and licensed as [Apache License, version 2.0](https://github.com/ResearchObject/ro-crate/blob/master/LICENSE), see <https://www.apache.org/licenses/LICENSE-2.0> for details.

### Meetings
The RO-Crate team try to meet in a monthly telcon, see the [rolling agenda](https://s.apache.org/ro-crate-minutes) for schedule, call-in details and minutes.


## Cite RO-Crate
Eoghan Ó Carragáin; Carole Goble; Peter Sefton; Stian Soiland-Reyes (2019): **A lightweight approach to research object data packaging** _Bioinformatics Open Source Conference (BOSC2019)_ <https://doi.org/10.5281/zenodo.3250687>

### Recent publications, presentations, citations

_Feel free to add to this list, either [edit and raise pull request](https://github.com/ResearchObject/ro-crate/blob/master/docs/index.md) or [raise issue](https://github.com/ResearchObject/ro-crate/issues/new?assignees=&labels=bug&template=bug_report.md&title=) using your GitHub account._

Eoghan Ó Carragáin, Carole Goble, Peter Sefton, Stian Soiland-Reyes (2019): **RO-Crate, a lightweight approach to Research Object data packaging.**
RO-15 at _Workshop on Research Objects ([RO 2019](http://www.researchobject.org/ro2019/))_, IEEE eScience 2019, 2019-09-24, San Diego, CA, USA.
<https://doi.org/10.5281/zenodo.3337883>


Kyle Chard, Niall Gaffney, Matthew B. Jones, Kacper Kowalik, Bertram Ludäscher, Jarek Nabrzyski, Victoria Stodden, Ian Taylor, Thomas Thelen, Matthew J. Turk, Craig Willis (2019):
**Application of BagIt-Serialized Research Object Bundles for Packaging and Re-execution of Computational Analyses.**
at _Workshop on Research Objects ([RO 2019](http://www.researchobject.org/ro2019/))_, IEEE eScience 2019, 2019-09-24, San Diego, CA, USA.
To appear in _2019 IEEE 15th International Conference on e-Science (e-Science)_.
[preprint <https://doi.org/10.5281/zenodo.3271763>]

Eoghan Ó Carragáin; Carole Goble; Peter Sefton; Stian Soiland-Reyes (2019): ***RO-Crate, a lightweight approach to Research Object data packaging*** [version 1; not peer reviewed]. Poster at _Bioinformatics Open Source Conference (BOSC2019)_.  _F1000Research_ 2019, **8**(ISCB Comm J):1197 (poster) <https://doi.org/10.7490/f1000research.1117130.1> 

Eoghan Ó Carragáin; Carole Goble; Peter Sefton; Stian Soiland-Reyes (2019): ***RO-Crate, a lightweight approach to Research Object data packaging*** [version 1; not peer reviewed]. Talk at _Bioinformatics Open Source Conference (BOSC2019)_. _F1000Research_ 2019, **8**(ISCB Comm J):1196 (slides) <https://doi.org/10.7490/f1000research.1117129.1> <https://slides.com/soilandreyes/2019-07-24-bosc-ro-crate>

Peter Sefton (2019): **DataCrate - a progress report on packaging research data for distribution via your repository**
<https://eresearch.uts.edu.au/2019/07/01/DataCrate-OR2019.htm> Talk at _Open Repositories (OR2019)_, Hamburg, 2019-06-11 


Peter Sefton (2019) **What's in a package? Data packaging overview** [[slides](https://docs.google.com/presentation/d/1qPDaLAqzOghnLTdpk01grp3Ya6qvmGCdVvYeTIe6V8I/edit?usp=sharing)] at _Open Repositories (OR2019)_, Hamburg, 2019-06-10 

Stian Soiland-Reyes; Carole Goble (2019): **Research Object** at _Research Data Packaging Workshop_ at _Open Repositories (OR2019)_, Hamburg, 2019-06-10 <https://slides.com/soilandreyes/2019-06-10-ro-or2019>

Peter Sefton (2019): **Research Data Packaging** at _Research Data Packaging Workshop_ at _Open Repositories (OR2019)_, Hamburg, 2019-06-10 [[slides](https://docs.google.com/presentation/d/1T_VX8WPh3MZny2VUVR8n81uENEuQsyrAIYAUOlnS-2A/edit?usp=sharing)]

Peter Sefton, Michael Lynch, Liz Stokes, Gerard Devine (2018): **Launching DataCrate v1.0 a general purpose data packaging format for research data distribution and web-display** Talk at _eResearch Australasia 2018_ <https://eresearch.uts.edu.au/2018/11/01/launch_datacrate_1.htm>

Peter Sefton, Gerard Devine, Christian Evenhuis, Michael Lynch, Sharyn Wise, Michael Lake, Duncan Loxton (2018):
**DataCrate: a method of packaging, distributing, displaying and archiving Research Objects**
Talk at _Workshop on Research Objects ([RO 2018](http://www.researchobject.org/ro2018/))_, 29 Oct 2018, Amsterdam, Netherlands.
<https://doi.org/10.5281/zenodo.1445817> [[abstract](https://data.research.uts.edu.au/examples/v1.0/datacrate-RO-2018/data/paper.html)] [[slides](http://ptsefton.com/2018/10/29/sefton-ro2018.htm)]

### Upcoming and recent events

_To suggest an event, either [edit and raise pull request](https://github.com/ResearchObject/ro-crate/blob/master/docs/index.md) or [raise issue](https://github.com/ResearchObject/ro-crate/issues/new?assignees=&labels=bug&template=bug_report.md&title=) using your GitHub account._

**[Workshop on Research Objects 2019](http://www.researchobject.org/ro2019)** (RO2019). Workshop at _[IEEE eScience 2019](https://escience2019.sdsc.edu/)_, 2019-09-24, San Diego, CA, USA. <http://www.researchobject.org/ro2019/>

**[Research Data Packaging Workshop](https://docs.google.com/document/d/16Gp7I4pTQ79nbqqsYXhL8bpRc9RPEeGy2I9peH8ppZs/edit)** at _[Open Repositories (OR2019)](https://or2019.blogs.uni-hamburg.de/workshops/)_, 2019-06-10, Hamburg, Germany.  [[trip report](https://eresearch.uts.edu.au/2019/07/01/OR2019.htm)] <https://or2019.blogs.uni-hamburg.de/workshops/>

**[Workshop on Research Objects 2018](http://www.researchobject.org/ro2018)** (RO2018). Workshop at _[IEEE eScience 2018](https://www.escience2018.com/)_, 2018-10-29, Amsterdam, The Netherlands. <http://www.researchobject.org/ro2018/>

**[Approaches to Research Data Packaging](https://rd-alliance.org/approaches-research-data-packaging-rda-11th-plenary-bof-meeting)**  BoF meeting at _RDA 11th Plenary_ 2018-03-22, Berlin, Germany. <https://rd-alliance.org/approaches-research-data-packaging-rda-11th-plenary-bof-meeting>