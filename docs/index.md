# Research Object Lite

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
the format **Research Object Lite** (or _ROLite_ for short) that aims to
simplify generation of ROs for researchers, e.g. to manually or
semi-automatically describe a single dataset or a loose collection of
documents. See the [background](background) for details on the other formats
that may be more appropriate for more complex
scenarios.


## Drafts

This specification is currently **work in progress**.  Future work will aim to
add validation mechanisms like [JSON Schema](https://json-schema.org/) and [W3C
Shapes Constraint Language](https://www.w3.org/TR/shacl/).

* [draft-01](draft-01/)

## Contribute

The _ROLite_ work is coordinated by:

* Peter Sefton <https://orcid.org/0000-0002-3545-944X>
* Eoghan Ó Carragáin <https://orcid.org/0000-0001-8131-2150>
* Stian Soiland-Reyes <https://orcid.org/0000-0001-9842-9718>


To suggest changes, improvements or issues, use the GitHub repository
<https://github.com/ResearchObject/ro-lite> - if you are new to GitHub or Open
Source you may appreciate the [GitHub guides](https://guides.github.com/) like
[Hello World](https://guides.github.com/activities/hello-world/),
[MarkDown](https://guides.github.com/features/mastering-markdown/) and [How to
contribute to open source](https://opensource.guide/how-to-contribute/)

You are welcome to [join
us](https://github.com/ResearchObject/ro-lite/issues/1)! Contributors are
expected to comply with our [Code of
Conduct](https://github.com/ResearchObject/ro-lite/blob/master/CODE_OF_CONDUCT.md)
to ensure an open and inclusive environment.

This specification and documentation is Open Source and licensed as [Apache License, version 2.0](https://github.com/ResearchObject/ro-lite/blob/master/LICENSE), see <https://www.apache.org/licenses/LICENSE-2.0> for details.
