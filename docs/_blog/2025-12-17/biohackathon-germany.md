---
title:  "RO-Crate at the 4th BioHackathon Germany"
author: ["Phil Reed"]
date: 2025-12-17
---

The [4th BioHackathon Germany](https://www.denbi.de/de-nbi-events/1840-4th-biohackathon-germany) took place from 1-5 December 2025 in Walsrode, Germany, organised by de.NBI and ELIXIR Germany. 
Life scientists, data managers, software developers and project leaders attended the hybrid event to work together on open source code, standards and infrastructure to advance research data pratices and tools.

{% include image.html src="umbrellas.jpg" caption="BioHackathon Germany was hosted at the ANDERS Hotel Walsrode." alt="Colourful umbrellas mounted the ceiling as art." %}

## Improving RO-Crate support in federated storage systems

One of the hackathon projects was titled [Enhancing FAIR (Meta-)Data Practices in Life Science by Improving RO-Crates Support in Federated Storage Systems](https://das-abroxas.github.io/2025_Biohackathon_Documentation/project_description.html). 
It was led by Sebastian Beyvers and Jannis Schlegel (University of Giessen).

During their participation in the Biohackathon Germany 2025, their working group engaged in extensive discussions focused on the practical and technical challenges of integrating RO-Crates in federated storage systems for life science data. 
The following sections present the central questions and ideas that emerged from these collaborative sessions. 
They reflect the real-world needs and obstacles faced by researchers and developers striving to advance FAIR data practices in distributed environments, and highlight areas where current standards and tooling may require further development.

- Handling RO-Crates with Extremely Large Datasets and Integrated Metadata
- Integrating Content Consistency Checks in File Metadata
- Propagating Metadata Updates from Top-Level Crates to Referenced Subcrates
- Handling Property Conflicts in Nested RO-Crates

### Results

The group produced many outputs which will be of immediate benefit to the community:

- Extensions to [ro-crate-py](https://github.com/ResearchObject/ro-crate-py/pull/244) library: load most relevent subcrates of very large RO-Crates
- Extensions to ro-crate-rs library: interactive command line interface mode to traverse attached and detatched RO-Crates
- Built an [RO-Crate indexing tool](https://github.com/arunaengine/rocrate-indexer) for easier exploration
- Built the [RO-Crate Explorer](https://github.com/arunaengine/RO-Crate-Explorer), a demonstrator applicaiton to parse, visualise and traverse RO-Crates

For full details, please visit the [BioHackathon Germany 2025 RO-Crate documentation](https://das-abroxas.github.io/2025_Biohackathon_Documentation/)
