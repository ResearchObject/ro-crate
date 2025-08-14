---
title:  "Advancing Geobiodiversity Research with RO-Crate at Senckenberg"
author: ["Daniel Bauer"]
date: 2025-09-01
---

In the [Digital Collection Infrastructures](https://www.senckenberg.de/en/science/research-infrastructure/sdmc/geobiodiversity-informatics/digital-collection-infrastructures/) group
at Senckenberg Society for Nature Research,
we develop infrastructure and standards to make
[FAIR](https://www.go-fair.org/fair-principles/) data practices accessible
for research communities.
Therefore, our group develops and deploys technologies
that empower researchers in making their data more FAIR.
RO-Crates have become a central cornerstone in this mission,
and are often used as the technical foundation for our projects.

Our approach combines the development of lighthouse projects
with contributions to national and international initiatives like
Germany's [National Research Data Infrastructure (NFDI)](http://nfdi.de/),
[Biodiversity Meets Data (BMD)](https://bmd-project.eu/),
and the [Biodiversity Digital Twin (BioDT)](https://biodt.eu/).
Through these collaborations,
we establish RO-Crate as a practical solution
for making research data more FAIR.
Our contributions in these projects often serve dual purposes:
they provide a proof of concept for
demonstrating how RO-Crates can be implemented in real world scenarios,
and allow us to explore the boundaries of what is possible with FAIR Digital Objects in general.

## AI4WildLIVE: RO-Crates applied to Biodiversity Monitoring

One example of this approach is our [AI4WildLIVE platform](https://wildlive.senckenberg.de).
Biodiversity monitoring with camera traps faces a data avalanche.
These projects routinely generate thousands of images annually,
a volume that quickly overwhelms traditional research workflows
due to the sheer amount of data that cannot be analyzed by human effort alone. 

Our platform tackles these challenges by combining automation with human expertise.
Machine learning models provide initial species annotations
and citizen scientists can then contribute by reviewing and refining these annotations.
The outcome of these collaborative work between AI and humans
is captured within RO-Crate packages.
Each RO-Crate wraps an individual biodiversity observation (a so-called capture event)
in a single RO-Crate package containing the raw media files
enriched with contextual information and provenance data.
To make these datasets discoverable, we combine the approach
of serving detached RO-Crates with FAIR signposting on our platform,
making it easy for machine agents to discover relevant metadata for automated processing.

## workflow.earth: Computational Reproducibility in Earth Observation

Our FAIR Workflow Platform [workflow.earth](https://workflow.earth),
deployed within the [Destination Earth](http://destination-earth.eu/) Data Lake (DEDL),
tackles a different challenge:
making computational workflows and their outputs FAIR
from execution through to publication.
Within the platform, researchers can submit workflows as executable Workflow RO-Crates.
The platform executes the workflows and automatically generates
FAIR-compliant datasets from workflow execution,
thus eliminating the manual overhead associated with FAIR data publication.
Execution metadata, parameters, authorship, etc. are all automatically captured
and made available as a single public Workflow Run RO-Crate
with the aim of enabling seamless data movement between repositories and data spaces.

This platform currently powers BioDT’s [Crop Wild Relatives Digital Twin](https://biodt.eu/use-cases/crop-wild-relatives),
which models habitat suitability for wild plant relatives of crops
to develop climate-resilient agriculture.
By packaging the entire computational process in RO-Crate,
we ensure that this climate adaptation research can be reproduced,
validated, and built upon by the global research community.

## Why RO-Crates work for us

Through our projects, we've learned that
applying the FAIR principles to research requires more than technical standards:
it requires the existence of working implementations,
both for showcasing the benefits of these standards,
and for establishing an ecosystem where it makes sense to adapt these technologies in the first place.

RO-Crates succeed in this context for us because
they strike the right balance between simplicity and practical usability.
The foundation in JSON-LD makes them approachable for researchers without
deep technical expertise in ontologies, while the extensibility enables
adopting them to address real pain points researchers face
when it comes to research data management.
Finally, the growing ecosystem of tools such as [ro-crate-py](https://github.com/ResearchObject/ro-crate-py)
and platforms such as [WorkflowHub](https://workflowhub.eu/) means
researchers can find support for their implementation needs.
Through our contributions, we aim to strengthen this ecosystem
and enable researchers and other infrastructures to adopt the FAIR principles.

## Resources

Our work has produced several open-source contributions to the RO-Crate ecosystem.
Additionally, a lot of our developed software is available open source
at our [Github organization](https://github.com/Senckenberg-DCBiodivIT).
