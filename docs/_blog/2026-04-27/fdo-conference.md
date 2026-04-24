---
title:  "RO-Crate at the FAIR Digital Objects Conference 2026"
description: "A summary of RO-Crate applications and related topics presented by the community."
author: ["Eli Chadwick"]
date: 2026-04-27
related_pages:
    use_cases: [aroma, dataplant, ldaca, life-monitor, workflowhub] # should match items in pages/use_cases
---

The [3rd FAIR Digital Objects (FDO) Conference](https://fairdo.org/fdo-conference-2026/) was held from 25-27 March 2026, with a pre-conference training day on 24 March. Representatives of projects spanning academia, industry, and government gathered together to discuss how to advance FAIR and open science through the adoption of FAIR Digital Objects.

This post references abstracts from the conference (some of which take the form of draft papers), all of which are publicly available in the [full conference program](https://fairdo.org/fdo-conference-2026-full-program/). Slide decks and posters are also linked if they have been made public.

## How RO-Crate relates to FAIR Digital Objects

RO-Crate aims to provide FAIR provenance metadata for research objects - but it's not the only standard with this goal. The FAIR Digital Object (FDO) concept and community arose as a way to find common ground between different FAIR metadata approaches, and there is now a shared FDO Specification defining the minimum metadata required for all approaches.

Currently, there are three main approaches to FAIR Digital Objects, informally known as "flavours":

* RO-Crate combined with [FAIR Signposting](https://signposting.org/FAIR/); this approach is also known as "webby FDO." Signposting is used to aid automated retrieval of the RO-Crate metadata given the persistent identifier for the dataset.
* "Handle FDOs" where metadata is attached directly to persistent identifiers, building on the [Handle System](https://www.dona.net/handle-system).
* [Nanopublications](https://nanopub.net) - small knowledge graphs each containing an assertion, the provenance of that assertion, and the provenance of the graph.

## Training

Stian Soiland-Reyes and Thivisha Uthayakumar (both University of Manchester) delivered a training session covering FAIR Signposting and RO-Crate at the pre-conference training day. There were also training sessions on Handle FDOs and Nanopublications, enabling learners to compare the different approaches.

## RO-Crate Applications

Willem Elbers (CLARIN) shared plans to use [RO-Crates for "virtual collections" within CLARIN](https://fairdo.org/wp-content/uploads/2026/03/8-3107-elbers.pdf), a digital infrastructure supporting research based on language resources. The "virtual collections" are collections of datasets which can be linked together using web-based data entities within RO-Crate. This vision takes inspiration from the use of RO-Crate in the [Language Data Commons of Australia]({{baseurl}}{% link pages/use_cases/ldaca.md %}).

Lukas Weil (DataPLANT) provided an [overview of the ARC (Annotated Research Context) Framework](https://fairdo.org/wp-content/uploads/2026/03/33-3135-weil.pdf). ARCs can be used to describe complex experiments, including samples, lab processes, and workflow executions, and can be represented as RO-Crates for publication.  
*See also: [DataPLANT use case]({{baseurl}}{% link pages/use_cases/dataplant.md %}), [ARC website](https://arc-rdm.org)*

Theodor Strauch (IPK Gatersleben) shared how the [ARC framework is being applied in the INTEGRA project](https://fairdo.org/wp-content/uploads/2026/03/12-3111-strauch.pdf) to capture measurements of seeds, plants, and samples in agriculture studies.

Esteban Gonzalez (Technical University of Madrid) shared how the [FAIR2Adapt project integrates RO-Crate and Nanopublications together](https://fairdo.org/wp-content/uploads/2026/03/28-3130-fremout.pdf) - RO-Crate for linked datasets and publications, and Nanopublications to describe claims made within or by those data and publications. [[slides](https://doi.org/10.5281/zenodo.19723489)]

Joy Owango (Africa PID Alliance) presented [DOCiD, an Africa-led PID ecosystem](https://fairdo.org/wp-content/uploads/2026/03/22-3124-owango.pdf) which can connect resources across different locations and institutions, with a focus on the [CARE principles for Indigenous Data Governance](https://doi.org/10.5334/dsj-2020-043) .

Balázs E. Pataki (HUN-REN SZTAKI) delivered a lightning talk on [RO-Crate in Hungary’s multidisciplinary research repository](https://fairdo.org/wp-content/uploads/2026/03/2-3095-pataki.pdf).  
*See also: [ARP AROMA use case]({{baseurl}}{% link pages/use_cases/aroma.md %}), [ARP blog post]({{baseurl}}{% link _blog/2025-10-13/dataverse-cedar-and-ro-crate-the-building-blocks-of-arp.md %})*

Finally, Leyla Jael Castro (ZB MED) presented a lightning talk on [enriching FDO provenance in MLentory](https://fairdo.org/wp-content/uploads/2026/03/27-3129-ravinder1.pdf), a registry for machine learning models which already supports RO-Crate.

Several posters also covered RO-Crate applications:

* Betz et al.: [Conceptualising an Integrated Data Model Using RO-Crates for Sports Facility Building Information: Linking Distributed Data, Persistent Identifiers, and Building Information for Sports Facilities](https://fairdo.org/wp-content/uploads/2026/03/23-3125-betz.pdf)
* Ravinder et al.: [Two Use Cases on Adoption of Webby FDOs](https://fairdo.org/wp-content/uploads/2026/03/29-3131-ravinder2.pdf) [[poster](https://doi.org/10.5281/zenodo.19431876)]. *See also: [Geobiodiversity applications blog post]({{baseurl}}{% link _blog/2025-09-01/rocrate-at-senckenberg.md %}), [MLentory website](https://mlentory.zbmed.de)*
* Zheng et al.: [Building a FDO Profile registry with RO-Crate](https://fairdo.org/wp-content/uploads/2026/03/52-3155-soiland.pdf). *See also: [RO-Crate profile registry](https://profiles.ro-crate.org)*
* Uthayakumar and Soiland-Reyes: [The FAIR Signposting Crawler](https://fairdo.org/wp-content/uploads/2026/03/51-3154-uthayakumar.pdf)
* Schweikert et al.: [Advancing FAIR Digital Objects in RADAR: RO-Crate Integration, Machine-Actionable Access, and AI-Supported Metadata Annotation and FAIRness Assessment](https://fairdo.org/wp-content/uploads/2026/03/25-3127-schweikert.pdf)

## Panel Discussions

The panel on "FDO Motivation" included a call from from Joy Owango (Africa PID Alliance) for community building and making FDOs an invisible part of the research infrastructure. The panel highlighted that adaptability and interoperability are both essential in working together toward a shared goal.

Carole Goble (University of Manchester) spoke on the "Interoperability" panel, sharing success stories such as the computational workflows ecosystem (including [WorkflowHub]({{baseurl}}{% link pages/use_cases/workflowhub.md %}), [Workflow Run RO-Crate](https://www.researchobject.org/workflow-run-crate/), and [LifeMonitor]({{baseurl}}{% link pages/use_cases/life-monitor.md %})). The panel discussed the need for flexibility, loose coupling, and fallbacks when handling FDOs, as well as touching on the human factors of interoperability - including data stewards, software engineers, and user communities.

Stian Soiland-Reyes (University of Manchester) chaired a panel on "FDO Security & Data Spaces" which touched on the challenges of trust in FDO provision, especially across international boundaries.

## FDO Comparisons and Interoperability

There were also presentations comparing the different FDO flavours.

Christian Backe (German Research Centre for Artificial Intelligence) and Jana Böhm (GWDG) both presented comparisons of the different FDO approaches, the former through [conversion of an existing data corpus into each FDO flavour](https://fairdo.org/wp-content/uploads/2026/03/49-3138-backe.pdf), and the latter through a [comparison of each flavour with the minimum FDO elements](https://fairdo.org/wp-content/uploads/2026/03/21-3123-castro.pdf) from the [FDO specifications](https://fairdo.org/specifications/).

The [full poster list](https://fairdo.org/fdo-conference-2026-posters/) also included several posters on interoperability, consistency, and security of FAIR Digital Objects, such as:

* El-Gebali: [Towards a Common Metadata Framework for FDOs in NFDI: From Kernel Profiles to Semantic Cross-Walks](https://fairdo.org/wp-content/uploads/2026/03/42-3147-elgebali.pdf)
* Fitschen and Kuhn: [Trusty PID: A Pattern for Immutable FDOs](https://fairdo.org/wp-content/uploads/2026/03/44-3149-fitschen2.pdf)
* Dietrich: [Implementing the STAP Principles for FAIR Digital Objects in Europe’s Green Deal Data Space: Plans for SAGE: the Data Space for a Sustainable Green Europe](https://fairdo.org/wp-content/uploads/2026/03/35-3137-dietrich.pdf)
