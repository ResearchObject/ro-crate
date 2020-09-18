---
layout: default
title: Appendix: RO-Crate JSON-LD
excerpt: 
sort: 5
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


# Changelog

* [RO-Crate 1.1.0](https://github.com/ResearchObject/ro-crate/releases/tag/1.1.0) <https://w3id.org/ro/crate/1.1>
  * **Note**: The RO-Crate metadata file is renamed to `ro-crate-metadata.json` to facilitate use of JSON editors.  [#82](https://github.com/ResearchObject/ro-crate/issues/82) [#84](https://github.com/ResearchObject/ro-crate/issues/84)
  * _Data entities_ can reference external resources with absolute URI [#74](https://github.com/ResearchObject/ro-crate/issues/74)
  * Added section on considerations for _Web-based Data Entities_  [#74](https://github.com/ResearchObject/ro-crate/issues/74)
  * The _root dataset_ is no longer required to be `./` [#74](ttps://github.com/ResearchObject/ro-crate/issues/74)
  * _RO-Crate Root_ directory no longer requires payload files [#74](https://github.com/ResearchObject/ro-crate/issues/74)
  * _Workflows and scripts_ section now aligned with [BioSchemas ComputationalWorkflow profile](https://bioschemas.org/profiles/ComputationalWorkflow/0.5-DRAFT-2020_07_21/)  [#81](https://github.com/ResearchObject/ro-crate/issues/81)
  * Added section _Programming with JSON-LD_ and note that `@type` might be an array [#85](https://github.com/ResearchObject/ro-crate/issues/85)
  * Added new section _Handling relative URI references_ [#73](https://github.com/ResearchObject/ro-crate/issues/73)
  * JSON-LD context no longer sets `@base: null` [#73](https://github.com/ResearchObject/ro-crate/issues/73)
  * Added note on _Encoding file paths_ [#77](https://github.com/ResearchObject/ro-crate/issues/77) [#80](https://github.com/ResearchObject/ro-crate/issues/80)
  * Added section _Choosing URLs for ad hoc terms_ [#71](https://github.com/ResearchObject/ro-crate/issues/71) [#90](https://github.com/ResearchObject/ro-crate/issues/90)
  * Section _RO-Crate JSON-LD Media type_ expanded to suggest HTTP server configuration
  * Update JSON-LD context to schema.org 10.0 
  * Fixed some JSON typos
* [RO-Crate 1.0.1](https://github.com/ResearchObject/ro-crate/releases/tag/1.0.1)
  * Fix JSON typo in example  
* [RO-Crate 1.0.0](https://github.com/ResearchObject/ro-crate/releases/tag/1.0.0) <https://w3id.org/ro/crate/1.0>
  * Description of RO-Crate Metadata File now required
    * .. must use `conformsTo` to indicate RO-Crate version
  * Clarified use of RO-Crate JSON-LD Context
  * Linked Data principles added
  * RO-Crate JSON-LD Context updated to use schema.org 5.0
  * Workflow and Script now typed with `@type` array instead of `additionalType`
  * Simplified tables of direct properties to list of properties
  * Simplified example of `affiliation`
  * Clarified `#identifiers` and `_:identifiers`
  * Removed links to data.research.uts.edu.au examples
  * Added licensing of metadata
  * Expanded on _Equipment used to create files_
  * Simplified Workflow and Script section
  * Added appendix on JSON-LD 
  * Added BagIt implementation notes
  * Added Repository-specific identifiers
  * RO-Crate JSON-LD now licensed CC0
  * RO-Crate JSON-LD self-identifies its version
* [RO-Crate 0.2.1](https://github.com/ResearchObject/ro-crate/releases/tag/0.2.1) 
  * Added DOI and document metadata
* [RO-Crate 0.2.0](https://github.com/ResearchObject/ro-crate/releases/tag/0.2.0) <https://w3id.org/ro/crate/0.2>
  * Based on two earlier specifications:
    * [RO Lite 0.1.0](https://www.researchobject.org/ro-crate/0.1.0/)
    * [DataCrate Specification version 1.0.0 2019-04-12](https://github.com/UTS-eResearch/datacrate/blob/47a5046b6fb54fc8f2e751f67fb98b8b2216c955/spec/1.0/data_crate_specification_v1.0.md)
  * RO-Crate Metadata file has been renamed to `ro-crate-metadata.jsonld` instead of `CATALOG.json` (DataCrate) or `manifest.jsonld` (RO-Lite)
  * RO Crate Website renamed to `ro-crate-metadata.html` instead of DataCrate's `CATALOG.html`
  * "RO-Lite" and "DataCrate" renamed to "RO-Crate"
  * Multiple examples and clarifications added
  * RO-Crate directory no longer requires BagIt structure
  * Added section on Workflows and scripts
  * RO-Crate Metadata File must describe itself as being `about` the RO-Crate Dataset.
  * JSON-LD should now be flattened and then compacted (RO-Lite allowed any JSON-LD, DataCrate required flattened)

