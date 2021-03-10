---
title: Profiles
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

# RO-Crate Profiles
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

While RO-Crates can be considered general-purpose containers of arbitrary data and open-ended metadata, in practical use within a particular domain, application or framework, it will be benefitial to further constrain RO-Crate to a specific **profile**: a set of conventions, types and properties that one minimally can require and expect to be present in that subset of RO-Crates.

Defining and conforming to such a profile enables reliable programmatic consumption of an RO-Crate's content, as well as consistent creation, e.g. a form in a user interface form firmly suggest the required types and properties, and likewise a rendering of an RO-Crate can easier make rich UI components if it can reliably assume for instance that the [`Person`](1.1/contextual-entities.html#people) always has a `affiliation` to a [`Organization`](1.1/contextual-entities.html#organizations-as-values) which has a `url` - a restriction that may not be appropriate for all types of RO-Crates.

The RO-Crate profile can also lock down serialization expectation, for instance using a particular [version of RO-Crate](specification.html), [JSON-LD context](1.1/appendix/jsonld.html?highlight=@context#ro-crate-json-ld-context) or particular [packaging](1.1/appendix/implementation-notes.html#combining-with-other-packaging-schemes) like .zip or BagIt.

## Workflow RO-Crate

[Workflow RO-Crate](https://about.workflowhub.eu/Workflow-RO-Crate/) is a profile of RO-Crate 1.1, which requires at least one [data entity](1.1/data-entities.html) that is a [ComputationalWorkflow](1.1/workflows.html). This workflow must also be indicated with `mainEntity` from the [Root Data set](1.1/root-data-entity.html). The Workflow RO-Crate profile further recommends how to accompany the native workflow definition with a [abstract CWL description](https://www.commonwl.org/v1.2/Workflow.html#Operation), diagram, and meaning of named subfolders `test` and `examples`. 

Profiles can also provide recommendations, for instance Workflow RO-Crate has a list of recognized [workflow languages](https://about.workflowhub.eu/Workflow-RO-Crate/#supported-workflow-types) and licenses. Serialization of Workflow RO-Crates are restricted to ZIP archives and with a filename ending with `.crate.zip`.

This profile of RO-Crate is used by the [WorkflowHub](https://workflowhub.eu/) both as downloadable archives of workflow entries and their metadata, but also for manual and programmatic upload of workflows, such as generated by [galaxy2cwl](https://github.com/workflowhub-eu/galaxy2cwl).  The associated services [Life Monitor](use_cases/life_monitor) and the workflow execution service [WfExS](https://github.com/inab/WfExS-backend) likewise access the Workflow RO-Crates through the hubs' implementation of the [Tool Registry Service API](https://about.workflowhub.eu/TRS/) to then pick up the tests and workflow to be executed.


## Describo profiles

[Describo](tool/describo) has pre-defined _default profile_ based on the RO-Crate specifications, which informs the user interface which entity types and properties should be offered and requested when a user is editing an RO-Crate.

The [default profile](https://github.com/UTS-eResearch/describo/blob/master/src/components/profiles/default/index.js) covers the recommendations in [RO-Crate 1.1 specifications](1.1/), adding form help such as description of each field. 

In addition, a [Domain-specific profile](https://github.com/Arkisto-Platform/describo/wiki/dsp-index) can be created as JSON and used by Describo to customize the selection of types and properties, including adding third-party vocabularies.

## Paradisec profiles

The [PARADISEC Describo profile](https://github.com/UTS-eResearch/describo/blob/master/src/components/profiles/paradisec.describo.profile.json) is built in to 
[Describo](tool/describo) and is the basis for the [PARADISEC](https://arkisto-platform.github.io/case-studies/paradisec/) RO-Crates exposed in the [Modern PARADISEC demonstrator](https://mod.paradisec.org.au/) to annotate and expose digital cultural heritage records.


## Making a RO-Crate profile

As a starting point, an RO-Crate profile can be written down in structured human language, as exemplified by [Workflow RO-Crate](https://about.workflowhub.eu/Workflow-RO-Crate/). 

Consistent use of the key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL as described in [RFC 2119](https://tools.ietf.org/html/rfc2119) makes explicit what is a strict requirement of the profile, what are best practice recommendations, and what are open-ended extensions.

A more formal definition of the profile can take multiple forms, depending on the serialization requirements for the RO-Crate, and how open-ended or restricted the profile is intended to be:

* [JSON Schema](https://json-schema.org/) requiring a restricted JSON form of [RO-Crate JSON-LD](1.1/appendix/jsonld.html). May include restricted JSON forms for expressing selected [data](1.1/data-entities.html) and [contextual entities](1.1/contextual-entities.html) in a certain way.
* RDF Shapes expressed in [ShEx](https://shex.io/) or [SHACL](https://www.w3.org/TR/shacl/) to check graph patterns like _`author` must be of `@type: Person` and have `affiliation` to a `@type: Organization` that has a `url` to a valid URL_
* Hard-coded validator, e.g. checking expected folders like `test/` exists or that a file really is of declared media type.

Implementors making validators may also want to first check that the [RO-Crate metadata file](1.1/structure.html#ro-crate-metadata-file-ro-crate-metadatajson) is:

* Valid [JSON](https://www.json.org/)
* Has expected/supported JSON-LD `@context`
* Valid JSON-LD Compacted form
* Valid [JSON-LD](https://json-ld.org/)
* Valid RDF triples
* Correct use of schema.org types/properties

Depending on requirements it may be benefitial to combine these approaches - for instance a hard-coded validator can rely on structural RO-Crate JSON checks before inspecting a particular data item in detail.