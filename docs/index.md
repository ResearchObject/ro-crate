# Research Object Crate (RO-Crate)

1. Table of Contents
{:toc}


**Note**: _ROLite_ has been [renamed](https://github.com/ResearchObject/ro-crate/issues/11) to **RO-Crate**.  The new homepage is [https://researchobject.github.io/ro-crate/](https://researchobject.github.io/ro-crate/)


## What is a Research Object

A [Research Object](http://researchobject.org/) (_RO_) provide a machine-readable mechanism to communicate the diverse set of digital and real-world resources that contribute to an item of research. The aim of an RO is to replace traditional academic publication as a PDF with a couple of supplementary materials; to instead provide a structured archive of all the items that contributed to the research outcome, including their identifiers, provenance, relations and annotations.

This is of particular importance as all domains of research and science are increasingly relying in computational analysis, yet we are facing a [reproducibility crisis](https://doi.org/10.1038/533452a) because key components are not sufficiently tracked, archived or reported. 

Examples of items that should be included in a Research Object:

* Manuscripts and preprints
* Lab notebooks
* Data (raw and processed)
* Computational workflows and scripts
* Results (graphs, derived data)
* Slides
* Metadata
* Computational logs


The Research Object initiative have iteratively been developing
[specifications](http://www.researchobject.org/specifications/) for
machine-readable formats to communicate Research Objects. These pages describes
the format **Research Object Crate** (or _RO-Crate_ for short) that aims to
simplify generation of ROs for researchers, e.g. to manually or
semi-automatically describe a single dataset or a loose collection of
documents. See the [background](background.md) for details on the other formats
that may be more appropriate for more complex
scenarios.


## Drafts

This specification is currently **work in progress** using our [GitHub repository](https://github.com/ResearchObject/ro-crate).  Future work will aim to
add validation mechanisms like [JSON Schema](https://json-schema.org/) and [W3C
Shapes Constraint Language](https://www.w3.org/TR/shacl/).

After the initial draft, the community decided to base the specification on [DataCrate](https://github.com/UTS-eResearch/datacrate/), and changed the name from _ROLite_ to **RO-Crate**.

* [ROLite Draft 0.1.0](0.1.0) 
* [DataCrate 1.0 review](https://docs.google.com/document/d/150SzIG8Zs3wecPTUue7wxKn6V26oi7rYucS5lxnmWZU/edit) (imported from [datacrate](https://github.com/UTS-eResearch/datacrate/blob/master/spec/1.0/data_crate_specification_v1.0.md))
* [RO-Crate 0.2-DRAFT](0.2-DRAFT) (TODO)


## Use cases

We are currently [gathering usecases](https://github.com/ResearchObject/ro-crate/issues?q=is%3Aissue+is%3Aopen+label%3Ause-case), please help us by [adding more](https://github.com/ResearchObject/ro-crate/issues/new/choose).


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

 
