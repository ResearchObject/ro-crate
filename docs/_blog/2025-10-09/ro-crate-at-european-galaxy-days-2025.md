---
title:  "RO-Crate and WorkflowHub at the European Galaxy Days 2025"
author: ["Eli Chadwick"]
date: 2025-10-09
related_pages:
    use_cases: [galaxy, rexafs, wfexs, workflowhub] # should match items in pages/use_cases
---

The [European Galaxy Days](https://galaxyproject.org/events/2025-10-01-egd2025/#getting-to-freiburg) took place from 1-3 October 2025 in Freiburg im Breisgau, Germany. Users, developers, teachers, and administrators of [Galaxy](https://galaxyproject.org) in Europe gathered to discuss new developments in research, the Galaxy platform, and the Galaxy community.

## RO-Crate and WorkflowHub in Galaxy

Galaxy can import and export RO-Crates for both regular datasets (following the base RO-Crate specification) and workflow executions (following the [Workflow Run Crate](https://www.researchobject.org/workflow-run-crate/profiles/workflow_run_crate/) profile). The [European Galaxy instance](https://usegalaxy.eu) uses RO-Crate as its export format by default, including when publishing data and workflow executions to Zenodo and other RDM repositories.

{% include image.html src="galaxy_export_ro_crate.png" caption="A workflow invocation can be exported from Galaxy using the Workflow Run RO-Crate format." alt="Screenshot of a Galaxy workflow invocation with the Export tab selected. Workflow Run RO-Crate is selected as the output format." %}

Galaxy has two-way integration with [WorkflowHub]({{baseurl}}{% link pages/use_cases/workflowhub.md %}), a registry for describing, sharing and publishing scientific computational workflows. This means that:
* a Galaxy user can import a WorkflowHub workflow within the Galaxy interface
* a WorkflowHub user can click a button in the WorkflowHub interface to launch a Galaxy workflow in an instance that has the necessary tools installed

{% include image.html src="galaxy_wfh_integration.png" caption="Two-way integration between Galaxy and WorkflowHub" alt="Two screenshots, the first shows the Galaxy workflow import page configured to import from WorkflowHub, the second shows a WorkflowHub workflow page with a 'Run in Galaxy' button circled." %}

The Galaxy Training Network also includes multiple hands-on [RO-Crate tutorials](https://training.galaxyproject.org/training-material/search2?query=ro-crate).

Eli Chadwick presented a talk which showcased all of the RO-Crate and WorkflowHub features in Galaxy - keep an eye out for a future blog post on this topic!

## Galaxy community projects using RO-Crate

Multiple presenters shared projects that are using RO-Crate, either directly through Galaxy or alongside it. These include:
* simulation of the [Extreme Photonics Application Centre](https://www.clf.stfc.ac.uk/Pages/EPAC.aspx), a new experimental facility in the UK. An end-to-end simulation workflow will be built using Galaxy, and outputs will be archived using RO-Crate (Leandro Liborio)
* WorkflowHub workflows are automatically incorporated into the [Galaxy Codex](https://galaxyproject.github.io/galaxy_codex/workflows), which includes curated collections of tools/workflows for particular domains (Solenne Correard)
* The [FIESTA (FAIR Image Ecosystem for Shared Tools and Analysis)](https://oscars-project.eu/projects/fair-image-analysis-across-sciences) project (part of [OSCARS](https://oscars-project.eu)) is developing FAIR workflows for image analysis across multiple disciplines - bioimaging, astrophysics, and environmental sciences. To achieve this they are using using WorkflowHub, Galaxy, and RO-Crate (Beatriz Serrano-Solano)
* [LabID (Lab Integrated Data)](https://grp-gbcs.embl-community.io/labid-user-docs/), a web platform for research data management, is integrated with Galaxy and WorkflowHub, and can also export workflows as Workflow RO-Crates directly (Charles Girardot)

## EuroScienceGateway final meeting

{% include image.html src="eurosciencegateway.svg" alt="EuroScienceGateway logo" %}

The [EuroScienceGateway](https://eurosciencegateway.eu) project, a 3-year project which funded the development of the RO-Crate features in Galaxy, had its final meeting at this event.

Stian Soiland-Reyes and Eli Chadwick presented the achievements of Work Package 2, which focused on stimulating FAIR and reusable research within and beyond the Galaxy community:
* Establishing [FAIR Computational Workflow](https://doi.org/10.1038/s41597-025-04451-9) principles & practices
* Enabling workflows and their data to be published, shared, and reused as FAIR Digital Objects (FDOs), using [RO-Crate and FAIR Signposting](https://doi.org/10.52825/ocp.v5i.1273) plus the [Workflow Run RO-Crate profile](https://doi.org/10.1371/journal.pone.0309210)
* Facilitating [workflow publication into EOSC (European Open Science Cloud)](https://doi.org/10.5281/zenodo.15094824)
* Developing RO-Crate, Galaxy, WorkflowHub, and [WfExS]({{baseurl}}{% link pages/use_cases/wfexs.md %}) to support these practices

Nikolay Vazov, Antony Bretaudeau, Leandro Liborio, and Volodymyr Savchenko presented successes in onboarding new domain communities into Galaxy as part of Work Package 5. This included building FAIR workflows for biodiversity, materials science, astronomy, and cancer research, all of which are visible in the [EuroScienceGateway team on WorkflowHub](https://workflowhub.eu/projects/166). The materials science subcommunity also highlighted their use of Galaxy and RO-Crate to [test the reproducibility of catalysis research](https://doi.org/10.1002/cctc.202401676) (see related use case: [Reproducible XAFS Analyses]({{baseurl}}{% link pages/use_cases/rexafs.md %})).
