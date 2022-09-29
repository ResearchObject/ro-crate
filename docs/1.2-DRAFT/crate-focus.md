---
title: The focus of an RO-Crate
excerpt: |
  In addition to simple data packaging, Crates may have a "main" entry point or topic (referenced with a singleton `mainEntity` property), or function as a bundle of one or more Contextual Entities referenced via the `mentions` property.
nav_order: 7
jekyll-mentions: false
parent: RO-Crate 1.2-DRAFT
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

# The focus of an RO-Crate
<div id="crate-focus"></div>

In addition to simple data packaging, Crates may have a "main" entry point or topic (referenced with a singleton `mainEntity` property), or function as a bundle of one or more Contextual Entities referenced via the `mentions` property.

## Crates with a "main entity"

An RO-Crate may have a single main entity that is considered the point, or focus of the crate.

### mainEntity is a _Data Entity_

In the [Workflow RO_Crate profile](https://www.researchobject.org/ro-crate/profiles.html#workflow-ro-crate-profile) - where the `mainEntity` has a compund type `File,SoftwareSourceCode,ComputationalWorkflow`. the use of `mainEntity` singles-out the workflow file from supporting files.

```
{
    "@id": "./",
    "@type": "Dataset",
    "name": "Example Workflow",
    "description": "An example workflow RO Crate",
    "license": "Apache-2.0",
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


### mainEntity is a _contextualEntity_

The focus of the RO-Crate may be a description of a _Contextual Entity_ for example in an RO-Crate used in repository or encyclopedia where a RepositoryObject bundles together images and other files, but the main focus of the RO-Crate is on describing a person.


```
 {
    "@id": "./",
    "@type": ["Dataset", "RepostioryObject"],
    "name": "Reibey, Mary (1777 - 1855)",
    "mainEntity": {
        "@id": "https://en.wikipedia.org/wiki/Mary_Reibey"
    }
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


}
```

## Crates which describe _Contetual Entities_ 

RO-Crates may describe _Contextual Entities_ which are not linked to a_Root Dataset_ via `hasPart` relationships.

For example RO-Crates can be used as containers for schema.org-style vocabularies.

```

{
      "@id": "./",
      "@type": "Dataset",
      "hasFile": "",
      "description": "This is an experimental language data ontology based on OLAC terms for use in the ATAP and LDaCA projects",
      "hasPart": [],
      "name": "Language Data Ontology",
      "mentions": ["txc:Annotation", t"xc:CollectionEvent"]
    },
    {
      "@id": "txc:Annotation",
      "@type": "rdfs:Class",
      "name": "Annotation",
      "sameAs": "http://www.language-archives.org/REC/type-20020628.html#annotation",
      "rdfs:comment": "The resource includes information which annotates, describes or otherwise an some other linguistic record.",
      "rdfs:label": "Annotation",
      "rdfs:subClassOf": {
        "@id": "schema:CreativeWork"
      }
    },
    {
      "@id": "txc:CollectionEvent",
      "@type": "rdfs:Class",
      "name": "CollectionEvent",
      "rdfs:comment": "A description of an event at which one or more PrimaryTexts were captured,  eg as video or audio",
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
```



The following example shows both a `mainEntity` which is a _Data Entity_ and also a _Contextual Entity_ which is a test suite (`#test1`)

```
 {
            "@id": "./",
            "@type": "Dataset",
            "name": "sort-and-change-case",
            "description": "sort lines and change text to upper case",
            "license": "Apache-2.0",
            "mainEntity": {
                "@id": "sort-and-change-case.ga"
            },
            "mentions": [ {"@id": "#test1" } ],
            "hasPart": [
                {
                    "@id": "sort-and-change-case.ga"
                },
                {
                    "@id": "test/test1/sort-and-change-case-test.yml"
                }
            ]
        } {
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
