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


**Note**: _ROLite_ and _DataCrate_ have been merged to **RO-Crate**.  This is the new homepage [http://researchobject.org/ro-crate/](http://researchobject.org/ro-crate/)


## What is a Research Object

A [Research Object](http://researchobject.org/) (_RO_) provide a machine-readable mechanism to communicate the diverse set of digital and real-world resources that contribute to an item of research. The aim of an RO is to replace traditional academic publication as a PDF with a couple of supplementary materials; to instead provide a structured archive of all the items that contributed to the research outcome, including their identifiers, provenance, relations and annotations.

This is of particular importance as all domains of research and science are increasingly relying in computational analysis, yet we are facing a [reproducibility crisis](https://doi.org/10.1038/533452a) because key components are not sufficiently tracked, archived or reported. 

### RO-Crate

This project define **Research Object Crate** (or _RO-Crate_ for short), an emerging lightweight approach to package research data with their structured metadata, based on [schema.org](https://schema.org/) annotations in a formalized [JSON-LD](http://json-ld.org/) format that can be used independent of infrastructure to encourage FAIR sharing of reproducible datasets and analytical methods.

Examples of items that should be included in a Research Object:

* Manuscripts and preprints
* Lab notebooks
* Data (raw and processed)
* Computational workflows and scripts
* Results (graphs, derived data)
* Slides
* Metadata
* Computational logs

See [background](background.md) for how this work build on existing [Research Object specifications](http://www.researchobject.org/specifications/).


### Motivation

Many [data packaging](https://rd-alliance.org/approaches-research-data-packaging-rda-11th-plenary-bof-meeting) initiatives arrive at similar principles: simple folder structure; JSON-LD manifest; schema.org for core metadata; BagIt for fixity; OAI-ORE for aggregation. This points to: a) appetite for general package/folder-oriented approach in different contexts; b) a generic solution won’t work for all and needs to be domain-extensible; c) a tendency to re-invent the wheel, leading to sub-optimal interoperability and duplication of effort.
We have identified a gap for a solid base format for data packaging that also allow communities to build domain-specific solutions. 

Our proposal is to build on [DataCrate](https://github.com/UTS-eResearch/datacrate) to evolve _RO-Crate_, based around these principles: a) metadata as Linked Data, using [schema.org](https://schema.org/) as much as possible; b) extensible for different domains; c) retain the core [Research Object principles](http://www.researchobject.org/overview/) _Identity, Aggregation, Annotation_; d) inferred metadata rather than repetition; e) “just-enough” provenance; f) layered validation; g) archivable with BagIt; h) hooks to reuse existing domain formats; i) lightweight programmatic generation and consumption. Similar to the approach of [BioSchemas](https://bioschemas.org/), rather than building new specifications from scratch, we aim to build best-practice guides and validatable profiles for building rich research data packages with existing standards, without requiring expert knowledge for developing producers and consumers.



## Drafts

The RO-Crate specification is currently **work in progress** using Google Docs before being added to our [GitHub repository](https://github.com/ResearchObject/ro-crate). 

* [RO-Crate 0.2-DRAFT](https://docs.google.com/document/d/1sH9CscItg7PbkEOcHPX_tVXfWNP4R57ys2y3W-FfNuA/edit?usp=sharing) (in progress)
* [DataCrate 1.0 review](https://docs.google.com/document/d/150SzIG8Zs3wecPTUue7wxKn6V26oi7rYucS5lxnmWZU/edit) (imported from [datacrate](https://github.com/UTS-eResearch/datacrate/blob/master/spec/1.0/data_crate_specification_v1.0.md))
* [ROLite Draft 0.1.0](0.1.0) 

_Historical note_: After the initial draft, the community decided to base the specification on [DataCrate](https://github.com/UTS-eResearch/datacrate/), and changed the name from _ROLite_ to **RO-Crate**.

## Use cases

We are also [gathering usecases](https://github.com/ResearchObject/ro-crate/issues?q=is%3Aissue+is%3Aopen+label%3Ause-case), please help us by [adding more](https://github.com/ResearchObject/ro-crate/issues/new/choose).


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

To suggest changes, improvements or issues, use the GitHub repository
<https://github.com/ResearchObject/ro-crate> - if you are new to GitHub or Open
Source you may appreciate the [GitHub guides](https://guides.github.com/) like
[Hello World](https://guides.github.com/activities/hello-world/),
[MarkDown](https://guides.github.com/features/mastering-markdown/) and [How to
contribute to open source](https://opensource.guide/how-to-contribute/)

You are welcome to [join
us](https://github.com/ResearchObject/ro-crate/issues/1)! Contributors are
expected to comply with our [Code of
Conduct](https://github.com/ResearchObject/ro-crate/blob/master/CODE_OF_CONDUCT.md)
to ensure an open and inclusive environment.

This specification and documentation is Open Source and licensed as [Apache License, version 2.0](https://github.com/ResearchObject/ro-crate/blob/master/LICENSE), see <https://www.apache.org/licenses/LICENSE-2.0> for details.

### Meetings

The RO-Crate team try to meet in a monthly telcon, see the [rolling agenda](https://s.apache.org/ro-crate-minutes) for schedule, call-in details and minutes.

## Cite RO-Crate

Eoghan Ó Carragáin; Carole Goble; Peter Sefton; Stian Soiland-Reyes (2019):
**A lightweight approach to research object data packaging**
_Bioinformatics Open Source Conference (BOSC2019)_
https://doi.org/10.5281/zenodo.3250687

