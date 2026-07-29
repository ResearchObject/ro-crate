---
page_id: gide
title: Global Image Data Ecosystem
description: GIDE (Global Image Data Ecosystem) is a collaborative project working towards the interoperability of bioimage data repositories across the globe. The project was initially funded by a European Commission Horizon Grant as "foundingGIDE", including multiple partners from Europe, Australia and Japan. The GIDE project uses RO-Crates as a metadata exchange format to harmonize outputs from three major bioimaging repositories (SSBD, BioImage Archive and IDR).
url: https://founding-gide.eurobioimaging.eu/
image: gide.svg
domains: [biology, biomedical_science, medicine] # should match item(s) in pages/domains
tasks: [data_handling, manage_data] # should match item(s) in pages/tasks
roles: [researcher, repository_manager, data_steward] # should match item(s) in pages/roles
---

<!--
   Copyright 2019-2022 RO-Crate contributors
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

# Global Image Data Ecosystem

<a href="https://founding-gide.eurobioimaging.eu/">
<img src="assets/img/gide.svg" alt="foundingGIDE project logo" width="30%">
</a>

The [Global Image Data Ecosystem](https://founding-gide.eurobioimaging.eu/) (GIDE) is a collaborative project working towards the interoperability of bioimage data repositories across the globe. Initially funded by a European Commission Horizon Grant as "foundingGIDE", the project brings together partners from different parts of the world. Bioimaging has long lacked the kind of shared metadata agreements that nucleotide sequence and protein structure data have relied on for decades, and three of the field's major resources — the [BioImage Archive](https://www.ebi.ac.uk/bioimage-archive/) (BIA), the [Image Data Resource](https://idr.openmicroscopy.org/) (IDR) and [SSBD](https://ssbd.riken.jp/) — have each developed their own internal metadata models. GIDE works towards cross-resource discovery across these repositories without requiring any of them to abandon their existing systems.

RO-Crate is a core part of the [GIDE technical stack](https://founding-gide.eurobioimaging.eu/gide-stack/), used as the metadata exchange format that harmonizes outputs from BIA, IDR and SSBD.

## Why RO-Crate

The foundingGIDE project looked for a solution that would allow independently-operated resources to expose comparable metadata through compatible interfaces, while leaving their internal models untouched.

The structure of RO-Crate was a natural fit for the project, and the details on the reasons are present in the [D7.1 deliverable](https://doi.org/10.5281/zenodo.20808012) of the foundingGIDE EU Horizon porject. Particularly, RO-Crate is an actively maintained community standard with tooling in multiple languages, a better than creating an arbitrary format. As it is based on JSON-LD, RO-Crate allowed for use cases that both relied on semantic web technologies (such as generating RDF and running SPARQL queries) as well as more traditional JSON-based workflows, as used for building the [GIDE search portal](https://www.gide-project.org/portal). This choice means the crates produced by GIDE remain meaningful to tools and consumers well beyond the project itself.

## How detached RO-Crates are used in GIDE

Version 1.2 of the RO-Crate specification introduced the _detached RO-Crate_: a `ro-crate-metadata.json` file that stands alone, with no associated data payload. This construct is purpose-built for the bioimaging case, where metadata is exchanged but the data-heavy images stay at their publishing resource.

Each repository exports its catalogue as a set of detached RO-Crates, one per study, using a shared [GIDE RO-Crate profile](https://www.gide-project.org/ro-crate/search/1.0/profile) and JSON-LD context. These are then harvested and validated centrally, combined into a single RDF graph, and used to power downstream applications: a cross-resource search portal, a SPARQL endpoint, and downloadable data snapshots.

{% include image.html src="assets/img/gide-pipeline.png" caption="The technical pipeline of foundingGIDE. A) The flow from harmonized data through RO-Crate to the GIDE-Portal and RDF dumps. B-C) Internal dashboards used for validating data quality. D) A SPARQL interface for querying the RO-Crates as RDF" alt="A diagram showing the technical pipeline of foundingGIDE" border=false %}

## The GIDE RO-Crate Profile

An RO-Crate _profile_ is a layer of domain-specific rules on top of the base specification, defining which fields must be present, what they mean, and which vocabularies to draw on. The GIDE profile uses this mechanism to specify a minimal shared metadata set for bioimaging studies, built directly on the twelve metadata components found to be common across BIA, IDR and SSBD.

The profile adopts a two-tier structure. A small **core** of mandatory fields drives cross-resource search: every conformant crate must carry a resolvable identifier, a name and description, a publication date, a license, at least one author, a publisher, at least one organism (via `about`), and at least one imaging method (via `measurementMethod`). Organisms _should_ use [NCBI Taxonomy](https://www.ncbi.nlm.nih.gov/taxonomy) identifiers and imaging methods _should_ use terms from the [Biological Imaging Methods Ontology](https://obofoundry.org/ontology/fbbi) (FBbi), so that queries are simplified. Where terms are not available in these vocabularies, the profile allows for entries from other ontologies, but these are not guaranteed to be searchable across resources.

Beyond the core, an **extended** layer — aligned with the [REMBI](https://www.nature.com/articles/s41592-021-01166-8) recommendations — lets resources express richer detail where they have it: biological samples, detailed lab protocols, publications and funding, plus adding information such as dataset size and links to thumbnails.

{% include image.html src="assets/img/gide-ro-crate-simplified.png" caption="Simplified view of the GIDE RO-Crate profile" alt="A set of interconnected components representing the GIDE RO-Crate profile" border=false %}

## A pilot in the OME 2024 NGFF Challenge

The [OME 2024 NGFF Challenge](https://github.com/ome/ome2024-ngff-challenge/), a community effort that produced a large FAIR snapshot of bioimaging data in the OME-Zarr format, used a preliminary RO-Crate profile as its metadata layer. It also established the two controlled vocabularies the community was most ready to adopt consistently — FBbi for imaging methods and NCBI Taxonomy for species — which the GIDE profile carries forward as its two core ontology fields. (See the [OME use case]({{baseurl}}{% link pages/use_cases/ome.md %}) for more on this challenge.)

## Example detached RO-Crate

Below is an abbreviated example of a profile-conformant detached RO-Crate, showing the self-describing metadata descriptor, a root `Dataset` with its core provenance fields, and the typed organism and imaging-method references that make cross-resource search possible.

```json
{
  "@context": [
    "https://w3id.org/ro/crate/1.2/context",
    "https://www.gide-project.org/ro-crate/search/1.0/context"
  ],
  "@graph": [
    {
      "@id": "idr0108-ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.2"
      },
      "about": {
        "@id": "https://idr.openmicroscopy.org/study/idr0108/"
      }
    },
    {
      "@id": "https://idr.openmicroscopy.org/study/idr0108/",
      "@type": "Dataset",
      "name": "3D super-resolution fluorescence microscopy maps the variable molecular architecture of the Nuclear Pore Complex",
      "description": "We explored the power of 3D super-resolution microscopy combined with computational classification and averaging to explore the 3D structure of the NPC in single human cells.(...)",
      "datePublished": "2021-09-01",
      "license": "https://creativecommons.org/licenses/by/4.0/",
      "copyrightNotice": "Sabinina et al, CC-BY-4.0, 2021",
      "identifier": "idr0108",
      "publisher": {
        "@id": "https://idr.openmicroscopy.org/"
      },
      "author": [
        {
          "@id": "https://orcid.org/0000-0001-5909-701X"
        }
      ],
      "seeAlso": [
        {
          "@id": "https://doi.org/10.1091/mbc.E20-11-0728"
        }
      ],
      "about": [
        {
          "@id": "#experiment-biosample-1"
        },
        {
          "@id": "http://purl.obolibrary.org/obo/NCBITaxon_9606"
        }
      ],
      "measurementMethod": [
        {
          "@id": "#experiment-protocol-1-0"
        },
        {
          "@id": "#experiment-protocol-1-1"
        },
        {
          "@id": "http://purl.obolibrary.org/obo/MI_2213"
        }
      ],
      "thumbnailUrl": [
        "https://idr.openmicroscopy.org/webgateway/render_thumbnail/13425351/"
      ]
    },
    {
      "@id": "https://idr.openmicroscopy.org/",
      "@type": "Organization",
      "name": "Image Data Resource",
      "url": "https://idr.openmicroscopy.org/"
    },
    {
      "@id": "https://orcid.org/0000-0001-5909-701X",
      "@type": "Person",
      "name": "Jan Ellenberg"
    },
    {
      "@id": "https://doi.org/10.1091/mbc.E20-11-0728",
      "@type": "ScholarlyArticle",
      "name": "3D super-resolution fluorescence microscopy maps the variable molecular architecture of the Nuclear Pore Complex"
    },
    {
      "@id": "http://purl.obolibrary.org/obo/NCBITaxon_9606",
      "@type": "Taxon",
      "scientificName": "Homo sapiens"
    },
    {
      "@id": "#experiment-biosample-1",
      "@type": "BioSample",
      "name": "cell",
      "description": "Dual color super-resolution imaging of ELYS and NUP107, NUP133, RANBP2, SEH1, TPR.",
      "taxonomicRange": [
        {
          "@id": "http://purl.obolibrary.org/obo/NCBITaxon_9606"
        }
      ]
    },
    {
      "@id": "http://purl.obolibrary.org/obo/MI_2213",
      "@type": "DefinedTerm",
      "name": "super-resolution microscopy"
    },
    {
      "@id": "#experiment-protocol-1-0",
      "@type": "LabProtocol",
      "name": "super-resolution microscopy",
      "measurementTechnique": [
        {
          "@id": "http://purl.obolibrary.org/obo/MI_2213"
        }
      ],
      "description": "Dual color super-resolution imaging of ELYS and NUP107, NUP133, RANBP2, SEH1, TPR."
    },
    {
      "@id": "http://www.ebi.ac.uk/efo/EFO_0003789",
      "@type": "DefinedTerm",
      "name": "growth protocol"
    },
    {
      "@id": "#experiment-protocol-1-1",
      "@type": "LabProtocol",
      "name": "growth protocol",
      "description": "U2OS cells were cultured at 37C and 5% CO2 in 1x high glucose McCoy's 5A modified medium with 10% (v/v) fetal bovine serum, 100 U/ml penicillin-streptomycin, 2 mM L-glutamin, 1 mM sodium pyruvate and 1% MEM nonessential amino acid. Tests confirming the absence of mycoplasma were performed every 2 months.",
      "measurementTechnique": [
        {
          "@id": "http://www.ebi.ac.uk/efo/EFO_0003789"
        }
      ]
    }
  ]
}
```

## Resources

- GIDE RO-Crate profile: <https://www.gide-project.org/ro-crate/search/1.0/profile>
- GIDE RO-Crate context: <https://www.gide-project.org/ro-crate/search/1.0/context>
- GIDE cross-resource search portal: <https://www.gide-project.org/portal>
- foundingGIDE Data Deliverable (RO-Crates and an RDF collection in Turtle format): <https://github.com/foundingGIDE/gide-data-deliverable/>
- D7.1 — Minimal shared interoperability metadata set: <https://doi.org/10.5281/zenodo.20808012>
- D10.1 — Model description and snapshot: <https://doi.org/10.5281/zenodo.20807591>
- D11.1 — Data portal and supporting API: <https://doi.org/10.5281/zenodo.20807634>
