---
layout: default
title: Workflows and scripts
excerpt: |
  Scientific workflows and Scripts that were used (or can be used) to 
  analyze or generate files contained in an RO-Crate can be embedded
  in an RO-Crate and described in detail.
sort: 10
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2020 The University of Manchester UK 
   Copyright 2019-2020 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# Workflows and Scripts

Scientific workflows and scripts that were used (or can be used) to analyze or generate files contained in an RO-Crate MAY be embedded in an RO-Crate. _Workflows_ and _scripts_ SHOULD be described using [data entities](data-entities.md) of type [SoftwareSourceCode].

The distinction between [SoftwareSourceCode] and [SoftwareApplication] for [software](#software) is fluid, and comes down to availability and understandability. For instance, office spreadsheet applications are generally available and do not need further explanation (`SoftwareApplication`); while a Python script that is customized for a particular data analysis might be important to understand further and should therefore be included as `SoftwareSourceCode` in the RO-Crate dataset.

## Describing scripts and workflows

A script is a _Data Entity_ which MUST have the following properties:

* `@type` is an array with at least `File` and `SoftwareSourceCode` as values
* `@id` is a File URI linking to the executable script
* `name`: a human-readable [name] for the script.

A workflow is a _Data Entity_ which MUST have the following properties:

* `@type` is an array with at least `File`, `SoftwareSourceCode` and `ComputationalWorkflow` as values
* `@id` is a File URI linking to the workflow entry-point.
* `name`: a human-readable [name] for the workflow.

Short example describing a _script_:

```json
{
  "@id": "scripts/analyse_csv.py",
  "@type": ["File", "SoftwareSourceCode"],
  "name": "Analyze CSV files",
  "programmingLanguage": {"@id": "https://www.python.org/downloads/release/python-380/"},
}
```

Short example describing a _workflow_:

```json
{
    "@id": "workflow/retropath.knime",  
    "@type": ["File", "SoftwareSourceCode", "ComputationalWorkflow"],
    "author": {"@id": "#thomas"},
    "name": "RetroPath Knime workflow",
    "description": "Retrosynthesis workflow calculating chemical reactions",
    "license": { "@id": "https://spdx.org/licenses/CC-BY-NC-SA-4.0"},
    "programmingLanguage": {"@id": "#knime"}
}
```

There is no strong distinction between a _script_ and a _workflow_; many computational workflows are written in script-like languages, and many scripts perform a _pipeline_ of steps.

Here are some indicators for when a script should be considered a _workflow_:

* It performs a series of steps (_pipeline_)
* The executed steps are mainly external tools or services
* The main work is performed by the steps (script is not algorithmic)
* The steps exchange data in a _dataflow_, typically file inputs/outputs
* The script has well-defined _inputs_ and _outputs_, e.g. file arguments

Here are some counter-indicators for when a script might **not** be a workflow:

* The script contains mainly algorithms or logic
* Data is exchanged out of bands, e.g. a SQL database
* The script relies on a particular state of the system (e.g. appends existing files)
* An interactive user interface that controls the actions

## Workflow Runtime and Programming Language

Scripts written in a _programming language_, as well as workflows, generally need a _runtime_; in RO-Crate the runtime SHOULD be indicated using a liberal interpretation of [programmingLanguage].

Note that the language and its runtime MAY differ (e.g. different C++ compilers), but for scripts and workflows, frequently the language and runtime are essentially the same, and thus the `programmingLanguage`, implied to be a [ComputerLanguage], can also be described as an executable [SoftwareApplication]:

```json
{
  "@id": "scripts/analyse_csv.py",
  "@type": ["File", "SoftwareSourceCode"],
  "name": "Analyze CSV files",
  "programmingLanguage": {"@id": "https://www.python.org/downloads/release/python-380/"},
},
{
  "@id": "https://www.python.org/downloads/release/python-380/",
  "@type": ["ComputerLanguage", "SoftwareApplication"],
  "name": "Python 3.8.0",
  "version": "3.8.0"
}
```

A _contextual entity_ representing a [ComputerLanguage] and/or [SoftwareApplication] MUST have a [name], [url] and [version], which should indicate a known version the workflow/script was developed or tested with. [alternateName] MAY be provided if there is a shorter colloquial name, for instance _“R”_ instead of _“The R Project for Statistical Computing”_.

It is possible to indicate _steps_ that are executed as part of an `ComputationalWorkflow` or `Script`, by using [hasPart] to relate additional `SoftwareApplication` or nested `SoftwareSourceCode` contextual entities:

```json
{
    "@id": "workflow/analyze.cwl",  
    "@type": ["File", "SoftwareSourceCode", "ComputationalWorkflow"],
    "name": "CWL workflow to analyze CSV and make PNG",
    "programmingLanguage": {"@id": "https://w3id.org/cwl/v1.1/"},
    "hasPart": [
      {"@id": "scripts/analyse_csv.py"},
      {"@id": "https://www.imagemagick.org/"},
    ]
}
```


## Workflow diagram/sketch

It can be beneficial to show a diagram or sketch to explain the script/workflow. This may have been generated from a workflow management system, or drawn manually as a diagram. This diagram MAY be included as an [ImageObject] which is [about] the `SoftwareSourceCode`:

```json
{
  "@id": "workflow/workflow.svg",
  "@type": ["File", "ImageObject"],
  "encodingFormat":  "image/svg+xml",
  "name": "Diagram of RetroPath2.0 workflow",
  "about": {"@id": "workflow/workflow.knime"}
}
```

The image file format SHOULD be indicated with [encodingFormat] using an IANA registered [media type](https://www.iana.org/assignments/media-types) like `image/svg+xml` or `image/png`. Additionally a reference to [Pronom] identifier SHOULD be provided, which MAY be described as an additional contextual entity to give human-readable name to the format:

```json
{
  "@id": "workflow/workflow.svg",
  "@type": ["File", "ImageObject"],
  "encodingFormat":  ["image/svg+xml"],
  "description": "Diagram of RetroPath2.0 workflow",
  "about": {"@id": "workflow/workflow.knime"}
},

```

A workflow diagram may still be provided even if there is no programmatic `SoftwareSourceCode` that can be executed (e.g. because the workflow was done by hand). In this case the sketch itself is a proxy for the workflow and SHOULD have an `about` property referring to the _RO-Crate dataset_ as a whole (assuming the RO-Crate represents the outcome of a single workflow), or to other [Data Entities](data-entities.md) otherwise:

```json
{
  "@id": "workflow/workflow.svg",
  "@type": ["File", "ImageObject"],
  "encodingFormat":  ["image/svg+xml"],
  "name": "Diagram of an ad hoc workflow",
  "about": {"@id": "./"}
}
```

## Complying with BioSchemas Computational Workflow profile

To comply with the [BioSchemas ComputationalWorkflow profile](https://bioschemas.org/profiles/ComputationalWorkflow/0.5-DRAFT-2020_07_21/),
where possible, data entities representing _workflows_ SHOULD describe these properties and their related contextual entities:

* [name] giving a short descriptive name of the workflow
* [programmingLanguage] identifying the workflow system, typed as `ProgrammingLanguage`
* [creator] identifying the [Person](s) and/or [Organization](s) that made the workflow. (This may differ from the [author] of the conceptual workflow, e.g. if the workflow was converted from one language to another).
* [dateCreated] the date the workflow was first made, e.g. `2020-05-23`
* [license] identifying a [CreativeWork] that details license for distributing or editing the workflow
* [input] and [output] identifying contextual entities for the [FormalParameter] describing input and output parameters/variables that may be varied on different workflow executions
* [sdPublisher] to identify the [Person] or [Organization] who has made the JSON-LD description of the workflow
* [url] to identify a public page or source code repository for the workflow
* [version] to indicate the released version of this workflow file

Contextual entities for [FormalParameter], referenced by `input` or `output`, SHOULD describe:

* [name] given the programmatic name for the parameter binding
* [additionalType] identifying the most specific subtype of [EDAM Data](http://edamontology.org/data_0006) (fallbacks [Data](http://edamontology.org/data_0006) or [Text data](http://edamontology.org/data_2526))
* [encodingFormat] identifying the most specific subtype of [EDAM Format](http://edamontology.org/format_1915) (fallbacks [Binary format](http://edamontology.org/format_2333) or [Textual format](http://edamontology.org/format_2330))
* [valueRequired] `true` if this (input) parameter must be specified to run the workflow, or `false` (default) if parameter is optional.
* [defaultValue] present if this (input) parameter has a default value. In RO-Crate this SHOULD be in the form of a `"string"` or a `{"@id": "data/entity.txt"}`

<!--
TODO: Update requirements from BioSchemas profile Workflow 0.5
-->

```note
`input`, `output` and `FormalParameter` are at time of writing proposed by BioSchemas and not yet integrated in schema.org
```

## Complete Workflow Example

The below is an example of an RO-Crate complying with the [BioSchemas ComputationalWorkflow profile 0.5](https://bioschemas.org/profiles/ComputationalWorkflow/0.5-DRAFT-2020_07_21/):

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context", 
  "@graph": [
    {
      "@type": "CreativeWork",
      "@id": "ro-crate-metadata.json",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
      "about": {"@id": "./"}
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "hasPart": [
          { "@id": "workflow/retropath.knime" }
      ]
    },
    {
      "@id": "workflow/alignment.knime",  
      "@type": ["File", "SoftwareSourceCode", "ComputationalWorkflow"],
      "name": "Sequence alignment workflow",
      "programmingLanguage": {"@id": "#knime"},
      "creator": {"@id": "#alice"},
      "dateCreated": "2020-05-23",
      "license": { "@id": "https://spdx.org/licenses/CC-BY-NC-SA-4.0"},
      "input": [
        { "@id": "#36aadbd4-4a2d-4e33-83b4-0cbf6a6a8c5b"}
      ],
      "output": [
        { "@id": "#6c703fee-6af7-4fdb-a57d-9e8bc4486044"},
        { "@id": "#2f32b861-e43c-401f-8c42-04fd84273bdf"}
      ],
      "sdPublisher": {"@id": "#workflow-hub"},
      "url": "http://example.com/workflows/alignment",
      "version": "0.5.0"
    },
    {
      "@id": "#36aadbd4-4a2d-4e33-83b4-0cbf6a6a8c5b",
      "@type": "FormalParameter",
      "name": "genome_sequence",
      "valueRequired": true,
      "additionalType": {"@id": "http://edamontology.org/data_2977"},
      "format": {"@id": "http://edamontology.org/format_1929"}
    },
    {
      "@id": "#6c703fee-6af7-4fdb-a57d-9e8bc4486044",
      "@type": "FormalParameter",
      "name": "cleaned_sequence",
      "additionalType": {"@id": "http://edamontology.org/data_2977"},
      "encodingFormat": {"@id": "http://edamontology.org/format_2572"}
    },
    {
      "@id": "#2f32b861-e43c-401f-8c42-04fd84273bdf",
      "@type": "FormalParameter",
      "name": "sequence_alignment",
      "additionalType": {"@id": "http://edamontology.org/data_1383"},
      "encodingFormat": {"@id": "http://edamontology.org/format_1982"}
    },
    {
      "@id": "https://spdx.org/licenses/CC-BY-NC-SA-4.0",
      "@type": "CreativeWork",
      "name": "Creative Commons Attribution Non Commercial Share Alike 4.0 International",
      "alternateName": "CC-BY-NC-SA-4.0"
    },
    {
      "@id": "#knime",
      "@type": "ProgrammingLanguage",
      "name": "KNIME Analytics Platform",
      "alternateName": "KNIME",
      "url": "https://www.knime.com/whats-new-in-knime-41",
      "version": "4.1.3"
    },
    {
      "@id": "#alice",
      "@type": "Person",
      "name": "Alice Brown"
    },
    {
      "@id": "#workflow-hub",
      "@type": "Organization",
      "name": "Example Workflow Hub",
      "url":"http://example.com/workflows/"
    },
    {
      "@id": "http://edamontology.org/format_1929",
      "@type": "Thing",
      "name": "FASTA sequence format"
    },
    {
      "@id": "http://edamontology.org/format_1982",
      "@type": "Thing",
      "name": "ClustalW alignment format"
    },
    {
      "@id": "http://edamontology.org/format_2572",
      "@type": "Thing",
      "name": "BAM format"
    },
    {
      "@id": "http://edamontology.org/data_2977",
      "@type": "Thing",
      "name": "Nucleic acid sequence"
    },
    {
      "@id": "http://edamontology.org/data_1383",
      "@type": "Thing",
      "name": "Nucleic acid sequence alignment"
    }
  ]
}

```


<!--  Below are reference links not rendered in HTML, see
https://kramdown.gettalong.org/syntax.html#reference-links
-->

[BagIt]: https://en.wikipedia.org/wiki/BagIt
[BagIt profile]: https://github.com/ruebot/bagit-profiles
[BIBO]: http://purl.org/ontology/bibo/interviewee
[conformsTo]: http://purl.org/dc/terms/conformsTo
[CURIE]: https://www.w3.org/TR/curie/
[DataCite]: https://www.datacite.org/
[DataCite Schema v4.0]: https://schema.datacite.org/meta/kernel-4.0/metadata.xsd
[DCAT]: https://www.w3.org/TR/vocab-dcat/
[Exif]: https://en.wikipedia.org/wiki/Exif
[Flattened Document Form]: https://json-ld.org/spec/latest/json-ld/#flattened-document-form
[FRAPO]: https://www.sparontologies.net/ontologies/frapo
[geonames]: https://www.geonames.org
[git]: https://git-scm.com/
[hasFile]: https://pcdm.org/2016/04/18/models#hasFile
[hasMember]: https://pcdm.org/2016/04/18/models#hasMember
[isOutputOf]: https://sparontologies.github.io/frapo/current/frapo.html#d4e526
[JSON]: http://json.org/
[JSON-LD]: https://json-ld.org/
[linked data]: https://en.wikipedia.org/wiki/Linked_data
[OCFL]: https://ocfl.io/
[OCFL Object]: https://ocfl.io/1.0/spec/#object-spec
[ORCID]: https://orcid.org
[Pairtree]: https://confluence.ucop.edu/display/Curation/PairTree
[Pairtree specification]: https://confluence.ucop.edu/display/Curation/PairTree?preview=/14254128/16973838/PairtreeSpec.pdf
[PCDM]: https://github.com/duraspace/pcdm/wiki
[Pronom]: https://www.nationalarchives.gov.uk/PRONOM/Default.aspx
[RepositoryCollection]: https://pcdm.org/2016/04/18/models#Collection
[RepositoryObject]: https://pcdm.org/2016/04/18/models#Object
[ResearchObject]: https://www.researchobject.org/
[schema.org]: http://schema.org
[WorkflowSketch]: http://wf4ever.github.io/ro/2016-01-28/roterms/#Sketch

[Action]: http://schema.org/Action
[ActionStatusType]: http://schema.org/ActionStatusType
[ActiveActionStatus]: http://schema.org/ActiveActionStatus
[CompletedActionStatus]: http://schema.org/CompletedActionStatus
[ComputerLanguage]: http://schema.org/ComputerLanguage
[CreateAction]: http://schema.org/CreateAction
[CreativeWork]: http://schema.org/CreativeWork
[DataDownload]: http://schema.org/DataDownload
[Dataset]: http://schema.org/Dataset
[FailedActionStatus]: http://schema.org/FailedActionStatus
[File]: http://schema.org/MediaObject
[Journal]: http://schema.org/Periodical
[GeoCoordinates]: http://schema.org/GeoCoordinates
[ImageObject]: http://schema.org/ImageObject
[MediaObject]: http://schema.org/MediaObject
[Organization]: http://schema.org/Organization
[Person]: http://schema.org/Person
[PotentialActionStatus]: http://schema.org/PotentialActionStatus
[Place]: http://schema.org/Place
[Product]: http://schema.org/Product
[PropertyValue]: http://schema.org/PropertyValue
[ScholarlyArticle]: http://schema.org/ScholarlyArticle
[SoftwareApplication]: http://schema.org/SoftwareApplication
[SoftwareSourceCode]: http://schema.org/SoftwareSourceCode
[UpdateAction]: http://schema.org/UpdateAction

[about]: http://schema.org/about
[accountablePerson]: http://schema.org/accountablePerson
[actionStatus]: http://schema.org/actionStatus
[additionalType]: http://schema.org/additionalType
[affiliation]: http://schema.org/affiliation
[agent]: http://schema.org/agent
[alternateName]: http://schema.org/alternateName
[author]: http://schema.org/author
[citation]: http://schema.org/citation
[contact]: http://schema.org/accountablePerson
[contactPoint]: http://schema.org/contactPoint
[contactType]: http://schema.org/contactType
[contentLocation]: http://schema.org/contentLocation
[contributor]: http://schema.org/contributor
[copyrightHolder]: http://schema.org/copyrightHolder
[creator]: http://schema.org/creator
[dateCreated]: http://schema.org/dateCreated
[datePublished]: http://schema.org/datePublished
[defaultValue]: http://schema.org/defaultValue
[description]: http://schema.org/description
[distribution]: http://schema.org/distribution
[email]: http://schema.org/email
[encodingFormat]: http://schema.org/encodingFormat
[endTime]: http://schema.org/endTime
[error]: http://schema.org/error
[event]: http://schema.org/event
[familyName]: http://schema.org/familyName
[funder]: http://schema.org/funder
[geo]: http://schema.org/geo
[givenName]: http://schema.org/givenName
[hasPart]: http://schema.org/hasPart
[identifier]: http://schema.org/identifier
[IndividualProduct]: http://schema.org/IndividualProduct
[instrument]: http://schema.org/instrument
[keywords]: http://schema.org/keywords
[license]: http://schema.org/license
[memberOf]: http://schema.org/memberOf
[name]: http://schema.org/name
[object]: http://schema.org/object
[phone]: http://schema.org/phone
[programmingLanguage]: http://schema.org/programmingLanguage
[publisher]: http://schema.org/publisher
[relatedItem]: http://schema.org/relatedItem
[result]: http://schema.org/result
[sameAs]: http://schema.org/sameAs
[sdLicense]: http://schema.org/sdLicense
[sdPublisher]: http://schema.org/sdPublisher
[startTime]: http://schema.org/startTime
[temporalCoverage]: http://schema.org/temporalCoverage
[thumbnail]: http://schema.org/thumbnail
[translationOf]: http://schema.org/translationOf
[translator]: http://schema.org/translator
[url]: http://schema.org/url
[valueRequired]: http://schema.org/valueRequired
[version]: http://schema.org/version

[input]: https://bioschemas.org/types/ComputationalWorkflow/0.1-DRAFT-2020_07_21/#input
[output]: https://bioschemas.org/types/ComputationalWorkflow/0.1-DRAFT-2020_07_21/#output
[FormalParameter]: https://bioschemas.org/types/FormalParameter/0.1-DRAFT-2020_07_21/

[RFC 2119]: https://tools.ietf.org/html/rfc2119
[RFC 3986]: https://tools.ietf.org/html/rfc3986
[RFC 6838]: https://tools.ietf.org/html/rfc6838
[RFC 7159]: https://tools.ietf.org/html/rfc7159
[RFC 8493]: https://tools.ietf.org/html/rfc8493
