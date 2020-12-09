---
layout: default
title: Workflows and scripts
redirect_from:
  - /1.1-DRAFT/workflows
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

<div id="workflows"></div>

# Workflows and Scripts

Scientific workflows and scripts that were used (or can be used) to analyze or generate files contained in an RO-Crate MAY be embedded in an RO-Crate. See also the Provenance section on [Software Used to Create Files](provenance.md#software-used-to-create-files).

_Workflows_ and _scripts_ SHOULD be described using [data entities](data-entities.md) of type [SoftwareSourceCode].

The distinction between [SoftwareSourceCode] and [SoftwareApplication] for [software](provenance.md#software-used-to-create-files) is fluid, and comes down to availability and understandability. For instance, office spreadsheet applications are generally available and do not need further explanation (`SoftwareApplication`); while a Python script that is customized for a particular data analysis might be important to understand deeper and should therefore be included as `SoftwareSourceCode` in the RO-Crate dataset.

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

It can be beneficial to show a diagram or sketch to explain the script/workflow. This may have been generated from a workflow management system, or drawn manually as a diagram. This diagram MAY be included from the `SoftwareSourceCode` data entity by using `image`, pointing to an [ImageObject] data entity which is [about] the `SoftwareSourceCode`:

```json
{
  "@id": "workflow/workflow.knime",  
  "@type": ["File", "SoftwareSourceCode", "ComputationalWorkflow"],
  "name": "RetroPath2.0 workflow",
  "image": {"@id": "workflow/workflow.svg" } 
},
{
  "@id": "workflow/workflow.svg",
  "@type": ["File", "ImageObject"],
  "encodingFormat":  "image/svg+xml",
  "name": "Diagram of RetroPath2.0 workflow",
  "about": {"@id": "workflow/workflow.knime"}
}
```

The image file format SHOULD be indicated with [encodingFormat] using an IANA registered [media type] like `image/svg+xml` or `image/png`. Additionally a reference to a [Pronom] identifier SHOULD be provided, which MAY be described as an additional contextual entity to give human-readable name to the format:

```json
{
  "@id": "workflow/workflow.svg",
  "@type": ["File", "ImageObject"],
  "encodingFormat":  ["image/svg+xml"],
  "name": "Diagram of RetroPath2.0 workflow",
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

## Complying with Bioschemas Computational Workflow profile

Data entities representing _workflows_ (`@type: ComputationalWorkflow`)
SHOULD comply with the Bioschemas [ComputationalWorkflow profile],
where possible. 

When complying with this profile, the workflow data entities
MUST describe these properties and their related contextual entities:
[name], [programmingLanguage], [creator], [dateCreated], [license], [sdPublisher], [url], [version].

The [ComputationalWorkflow profile] explains the above and list additional properties that a compliant [ComputationalWorkflow] data entity SHOULD include: [citation], [contributor], [creativeWorkStatus], [description], [funding], [hasPart], [isBasedOn], [keywords], [maintainer], [producer], [publisher], [runtimePlatform], [softwareRequirements], [targetProduct]

A data entity conforming to the [ComputationalWorkflow profile] SHOULD declare the versioned profile URI using [conformsTo]:

```json
{ "@id": "workflow/alignment.knime",  
  "@type": ["File", "SoftwareSourceCode", "ComputationalWorkflow"],
  "conformsTo": 
    {"@id": "https://bioschemas.org/profiles/ComputationalWorkflow/0.5-DRAFT-2020_07_21/"},
  "..": ""
}
```

### Describing inputs and outputs

The input and output _parameters_ for a workflow or script can be given with `input` and `output` to [FormalParameter]
contextual entities. Note that this entity usually represent a _potential_ input/output value in a reusable
workflow, much like [function parameter definitions] in general programming.

If complying with the Bioschemas [FormalParameter profile],
the _contextual entities_ for [FormalParameter], referenced by `input` or `output`, MUST describe: [name], [additionalType], [encodingFormat]

The Bioschemas [FormalParameter profile] explains the above and lists additional properties that can be used, including [description], [valueRequired], [defaultValue] and [identifier].

A contextual entity conforming to the [FormalParameter profile] SHOULD declare the versioned profile URI using [conformsTo], e.g.:

```json
{
  "@id": "#36aadbd4-4a2d-4e33-83b4-0cbf6a6a8c5b",
  "@type": "FormalParameter",
  "conformsTo": 
    {"@id": "https://bioschemas.org/profiles/FormalParameter/0.1-DRAFT-2020_07_21/"},
  "..": ""
}
```

```note
`input`, `output` and `FormalParameter` are at time of writing proposed by Bioschemas and not yet integrated in Schema.org
```

## Complete Workflow Example

The below is an example of an RO-Crate complying with the [Bioschemas ComputationalWorkflow profile 0.5][ComputationalWorkflow profile]:

```json
{ "@context": "https://w3id.org/ro/crate/1.1/context", 
  "@graph": [
    {
      "@type": "CreativeWork",
      "@id": "ro-crate-metadata.json",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1"},
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
      "conformsTo": 
        {"@id": "https://bioschemas.org/profiles/ComputationalWorkflow/0.5-DRAFT-2020_07_21/"},
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
      "conformsTo": {"@id": "https://bioschemas.org/profiles/FormalParameter/0.1-DRAFT-2020_07_21/"},
      "name": "genome_sequence",
      "valueRequired": true,
      "additionalType": {"@id": "http://edamontology.org/data_2977"},
      "format": {"@id": "http://edamontology.org/format_1929"}
    },
    {
      "@id": "#6c703fee-6af7-4fdb-a57d-9e8bc4486044",
      "@type": "FormalParameter",
      "conformsTo": {"@id": "https://bioschemas.org/profiles/FormalParameter/0.1-DRAFT-2020_07_21/"},
      "name": "cleaned_sequence",
      "additionalType": {"@id": "http://edamontology.org/data_2977"},
      "encodingFormat": {"@id": "http://edamontology.org/format_2572"}
    },
    {
      "@id": "#2f32b861-e43c-401f-8c42-04fd84273bdf",
      "@type": "FormalParameter",
      "conformsTo": {"@id": "https://bioschemas.org/profiles/FormalParameter/0.1-DRAFT-2020_07_21/"},
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

{% include references.liquid %}
