---
title: The focus of an RO-Crate
redirect_from:
  - /1.2/crate-focus
excerpt: |
  In addition to simple data packaging, RO-Crates may have a "main" entry point or topic (referenced with a singleton `mainEntity` property), or function as a bundle of one or more Contextual Entities referenced via the `mentions` property.
nav_order: 7
jekyll-mentions: false
parent: RO-Crate 1.2
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2020 The University of Manchester UK 
   Copyright 2019-2022 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# The focus of an RO-Crate {#crate-focus}

In addition to simple data packaging, RO-Crates may have a "main" entry point or topic (referenced with a singleton `mainEntity` property), or function as a bundle of one or more Contextual Entities referenced via the `mentions` property.

## RO-Crates with a "main entity"

An RO-Crate may have a single main entity that is considered the point, or focus of the RO-Crate. This may be referenced from the _Root Data Entity_ using the [mainEntity] property.

### RO-Crates with a data entity as `mainEntity`

The focus of an RO-Crate may be a single _Data Entity_ supplemented by other data and/or contextual entities.

For example, in the [Workflow RO-Crate profile](https://www.researchobject.org/ro-crate/profiles.html#workflow-ro-crate-profile), the use of `mainEntity` singles-out the workflow file from supporting files.

```json
{
    "@id": "./",
    "@type": "Dataset",
    "name": "Example Workflow",
    "description": "An example workflow RO Crate",
    "license": "Apache-2.0",
    "datePublished": "2023-01-01",
    "mainEntity": {
      "@id": "example_workflow.cwl"
    },
    "hasPart": [
      {
        "@id": "example_workflow.cwl"
      },
      {
        "@id": "diagram.svg"
      },
      {
        "@id": "README.md"
      }
    ]
}
```

### RO-Crates with a contextual entity as `mainEntity`

The focus of the RO-Crate may be a description of a _Contextual Entity_, for example in an RO-Crate used in a repository or encyclopedia where a `RepositoryObject` bundles together images and other files, but the main focus of the RO-Crate is on describing a person.

```json
{
    "@id": "./",
    "@type": ["Dataset", "RepositoryObject"],
    "name": "Reibey, Mary (1777 - 1855)",
    "...": "...",
    "mainEntity": {
        "@id": "https://en.wikipedia.org/wiki/Mary_Reibey"
    },
    "hasPart" : [
        {"@id": "photo1.jpg"},
        {"@id": "photo2.jpg"}
    ]
}

{
    "@id": "https://en.wikipedia.org/wiki/Mary_Reibey",
    "@type": "Person",
    "name": "Mary Reibey",
    "description": "Mary Reibey née Haydock (12 May 1777 – 30 May 1855) was an English-born merchant, shipowner and trader ..."
}
```

## RO-Crates which focus on multiple _Contextual Entities_

RO-Crates may describe _Contextual Entities_ which are linked to the [Root Data Entity](root-data-entity) via `mentions` relationships.

For example, RO-Crates can be used as containers for Schema.org-style vocabularies (here also [extending the RO-Crate JSON-LD context](appendix/jsonld.html#ro-crate-json-ld-context) to define the namespace for `txc:`):

```json
{ "@context": [
    "https://w3id.org/ro/crate/1.2/context",
    {"txc": "https://purl.archive.org/language-data-commons/terms#"}
  ],
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "description": "RO-Crate Metadata File Descriptor (this file)",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2"},
      "about": {"@id": "./"}
    },
    {
      "@id": "./",
      "@type": "Dataset",
      "description": "This is an experimental language data ontology based on OLAC terms for use in the ATAP and LDaCA projects",
      "hasPart": [],
      "name": "Language Data Ontology",
      "mentions": ["txc:Annotation", "txc:CollectionEvent"]
    },
    {
      "@id": "txc:Annotation",
      "@type": "rdfs:Class",
      "name": "Annotation",
      "sameAs": "http://www.language-archives.org/REC/type-20020628.html#annotation",
      "rdfs:comment": "The resource includes information which annotates some other linguistic record.",
      "rdfs:label": "Annotation",
      "rdfs:subClassOf": {
        "@id": "schema:CreativeWork"
      }
    },
    {
      "@id": "txc:CollectionEvent",
      "@type": "rdfs:Class",
      "name": "CollectionEvent",
      "rdfs:comment": "A description of an event at which one or more PrimaryTexts were captured, e.g. as video or audio",
      "rdfs:label": "CollectionEvent",
      "rdfs:subClassOf": [
        {
          "@id": "schema:Event"
        },
        {
          "@id": "schema:CreateAction"
        }
      ]
    }
  ]
}    
```


The following example shows how both `mainEntity` and `mentions` can be used together, in this case to describe a workflow with a test suite:
  * the `mainEntity` is the workflow file, a _Data Entity_
  * the test suite `#test1` is a _Contextual Entity_ highlighted using `mentions`.

```json
{
    "@id": "./",
    "@type": "Dataset",
    "name": "sort-and-change-case",
    "description": "sort lines and change text to upper case",
    "license": "Apache-2.0",
    "mainEntity": {
        "@id": "sort-and-change-case.ga"
    },
    "mentions": [ {"@id": "#test1"} ],
    "hasPart": [
        {
            "@id": "sort-and-change-case.ga"
        },
        {
            "@id": "test/test1/sort-and-change-case-test.yml"
        }
    ]
},
{
    "@id": "#test1",
    "name": "test1",
    "@type": "TestSuite",
    "instance": [
        {"@id": "#test1_1"}
    ],
    "definition": {"@id": "test/test1/sort-and-change-case-test.yml"}
},
{
    "@id": "#test1_1",
    "name": "test1_1",
    "@type": "TestInstance",
    "runsOn": {"@id": "#jenkins"},
    "url": "http://example.org/jenkins",
    "resource": "job/tests/"
},
{
    "@id": "test/test1/sort-and-change-case-test.yml",
    "@type": [
        "File",
        "TestDefinition"
    ],
    "conformsTo": {"@id": "#planemo"}
},
{
    "@id": "#jenkins",
    "@type": "TestService",
    "name": "Jenkins",
    "url": {"@id": "https://www.jenkins.io"}
},
{
    "@id": "#planemo",
    "@type": "SoftwareApplication",
    "name": "Planemo",
    "url": {"@id": "https://github.com/galaxyproject/planemo"},
    "version": ">=0.70"
}
```

{% include references.liquid %}
