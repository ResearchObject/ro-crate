---
title: Changelog
parent: Appendix
grand_parent: RO-Crate 1.2-DRAFT
excerpt: List of changes in releases of this specifications
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


# APPENDIX: Changelog

* RO-Crate 1.2-DRAFT
  * [Clarify entity terminology](../contextual-entities.md#contextual-vs-data-entities)  [#204](https://github.com/ResearchObject/ro-crate/issues/204)
  * [Update JSON-LD context] to [schema.org 15.0]](https://github.com/schemaorg/schemaorg/tree/main/data/releases/15.0/). Note that upstream adds ~230 terms and removed terms `AuthenticContent` `MissingContext`.
  * Remove custom mapping of `funding` for Bioschemas (now officially in schema.org)
  * [Specify format application/zip] (../data-entities.html#directories-on-the-web-dataset-distributions)  [#205](https://github.com/ResearchObject/ro-crate/issues/235)  
  * [Updated introduction (running example)](../introduction.html)  [#227](https://github.com/ResearchObject/ro-crate/issues/227) [#215](https://github.com/ResearchObject/ro-crate/issues/215) [#219](https://github.com/ResearchObject/ro-crate/issues/219)
* [Define terms for Profiles](../metadata.html#additional-metadata-standards)  [#248](https://github.com/ResearchObject/ro-crate/issues/248)
* [Added Profiles section](../profiles)  [#250](https://github.com/ResearchObject/ro-crate/issues/250) [#251](https://github.com/ResearchObject/ro-crate/issues/251) [#255](https://github.com/ResearchObject/ro-crate/issues/255) [#256](https://github.com/ResearchObject/ro-crate/issues/256)
* [Allow more types on root](../root-data-entity.html#ro-crate-metadata-file-descriptor)  [#182](https://github.com/ResearchObject/ro-crate/issues/182) [#223](https://github.com/ResearchObject/ro-crate/issues/223)
* [Added new name-based algorithm for root](../root-data-entity.html#finding-the-root-data-entity)  [#198](https://github.com/ResearchObject/ro-crate/issues/198)
* [Added subsection on root data entity identifier](../root-data-entity.html#root-data-entity-identifier)   [#183](https://github.com/ResearchObject/ro-crate/issues/183)
  (new subsection) @ljgarcia   
  
  * [TITLE](../metadata.html#additional-metadata-standards)  [#](https://github.com/ResearchObject/ro-crate/issues/)
  
  


* [x] [1.2-DRAFT/structure](https://www.researchobject.org/ro-crate/1.2-DRAFT/structure)   #189 #183 
  (adds distinction Attached/Detached RO-Crate) @ptsefton  --> #248
* [ ] [1.2-DRAFT/structure#payload-files-and-directories](https://www.researchobject.org/ro-crate/1.2-DRAFT/structure#payload-files-and-directories)  
  (rephrased on payload files)
* [x] [1.2-DRAFT/structure#ro-crate-website-ro-crate-previewhtml-and-ro-crate-preview_files](https://www.researchobject.org/ro-crate/1.2-DRAFT/structure#ro-crate-website-ro-crate-previewhtml-and-ro-crate-preview_files) #106 #210  
  (allows `ro-crate-preview.html` as entity) 
* [x] [1.2-DRAFT/terminology](https://www.researchobject.org/ro-crate/1.2-DRAFT/terminology)  
  (adds Attached/Detached) @ptsefton  --> #248
* [x] [1.2-DRAFT/workflows#complying-with-bioschemas-computational-workflow-profile](https://www.researchobject.org/ro-crate/1.2-DRAFT/workflows#complying-with-bioschemas-computational-workflow-profile)   
  (updated for ComputationalWorkflow 1.0 profile, uses DefinedTerm) @marc-portier 
* [x] [1.2-DRAFT/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms](https://www.researchobject.org/ro-crate/1.2-DRAFT/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms)   #232 #208 #106
  (uses DefinedTerm with name/description; rdfs:label and rdfs:comment now optional) @abigail-miller  --> #252
* [x] [1.2-DRAFT/appendix/jsonld.html#grouping-extensions-as-an-ro-crate-profile](https://www.researchobject.org/ro-crate/1.2-DRAFT/appendix/jsonld.html#grouping-extensions-as-an-ro-crate-profile)   #233 
  (new subsection) @abigail-miller --> #252
* [x] [1.2-DRAFT/appendix/relative-uris.html#converting-from-attached-to-detached-ro-crate](https://www.researchobject.org/ro-crate/1.2-DRAFT/appendix/relative-uris.html#converting-from-attached-to-detached-ro-crate)  
   (new subsections for Attached/Detached conversion) 
  * [ ] Remove missing section _Converting from Detached to Attached RO-Crate_
* [x] [1.2-DRAFT/appendix/relative-uris.html#finding-ro-crate-root-in-rdf-triple-stores](https://www.researchobject.org/ro-crate/1.2-DRAFT/appendix/relative-uris.html#finding-ro-crate-root-in-rdf-triple-stores)
    - Now always uses string filter in SPARQL to find root (see [algorithm](https://www.researchobject.org/ro-crate/1.2-DRAFT/root-data-entity.html#finding-the-root-data-entity))
* [x](https://www.researchobject.org/ro-crate/1.2-DRAFT/root-data-entity#resolvable-persistent-identifiers) Specify cite-as and Signposting for root data entity #255 @ptsefton 
* [ ] List required properties for entities #260 @simleo 
* [x] contentUrl for direct download, add section on Converting to Attached RO-Crate #259 @ptsefton 

* [RO-Crate 1.1.2](https://github.com/ResearchObject/ro-crate/releases/tag/1.1.2) 
  * Typo fixes in [data entity section](../data-entities.md) [#177](https://github.com/ResearchObject/ro-crate/issues/177), [workflow section](../workflows.md) [#180](https://github.com/ResearchObject/ro-crate/issues/180), [metadata section](../metadata.md) [#181](https://github.com/ResearchObject/ro-crate/issues/181) 
  * Correct namespace for `rdfs:comment` on [ad-hoc terms](jsonld.md#add-local-definitions-of-ad-hoc-terms) [#164](https://github.com/ResearchObject/ro-crate/issues/164)
  * Fixed broken links to Bioschemas and SPAR ontologies [#185](https://github.com/ResearchObject/ro-crate/issues/185) (note: `conformsTo` URIs unchanged, will be updated in RO-Crate 1.2)
* [RO-Crate 1.1.1](https://github.com/ResearchObject/ro-crate/releases/tag/1.1.1)
  * Introduction highlight not all Data entities are files [#125](https://github.com/ResearchObject/ro-crate/issues/125) [#127](https://github.com/ResearchObject/ro-crate/pull/127)
* [RO-Crate 1.1.0](https://github.com/ResearchObject/ro-crate/releases/tag/1.1.0) <https://w3id.org/ro/crate/1.1>
  * **Note**: The RO-Crate metadata file is renamed to `ro-crate-metadata.json` to facilitate use of JSON editors.  [#82](https://github.com/ResearchObject/ro-crate/issues/82) [#84](https://github.com/ResearchObject/ro-crate/issues/84)
  * [Data entities](../data-entities.md) can reference external resources with absolute URI [#74](https://github.com/ResearchObject/ro-crate/issues/74)
  * Added section on considerations for [Web-based Data Entities](../data-entities.md#web-based-data-entities)  [#74](https://github.com/ResearchObject/ro-crate/issues/74)
  * The [root dataset](../root-data-entity.md#direct-properties-of-the-root-data-entity) is no longer required to be `./` [#74](https://github.com/ResearchObject/ro-crate/issues/74)
  * [RO-Crate Root](../structure.md) directory no longer requires payload files [#74](https://github.com/ResearchObject/ro-crate/issues/74)
  * [Workflows and scripts](../workflows.md) section now aligned with [BioSchemas ComputationalWorkflow profile](https://bioschemas.org/profiles/ComputationalWorkflow/0.5-DRAFT-2020_07_21/)  [#81](https://github.com/ResearchObject/ro-crate/issues/81) [#100](https://github.com/ResearchObject/ro-crate/pull/100)
  * Added section [Programming with JSON-LD](implementation-notes.md#programming-with-json-ld) and note that `@type` might be an array [#85](https://github.com/ResearchObject/ro-crate/issues/85)
  * Added new section [Handling relative URI references](jsonld.md#handling-relative-uri-references) [#73](https://github.com/ResearchObject/ro-crate/issues/73)
  * JSON-LD context no longer sets `@base: null` [#73](https://github.com/ResearchObject/ro-crate/issues/73)
  * Added note on [Encoding file paths](../data-entities.md#encoding-file-paths) [#77](https://github.com/ResearchObject/ro-crate/issues/77) [#80](https://github.com/ResearchObject/ro-crate/issues/80)
  * Added section [Choosing URLs for ad hoc terms](jsonld.md#adding-new-or-ad-hoc-vocabulary-terms) [#71](https://github.com/ResearchObject/ro-crate/issues/71) [#90](https://github.com/ResearchObject/ro-crate/issues/90)
  * Section [RO-Crate JSON-LD Media type](jsonld.md#ro-crate-json-ld-media-type) expanded to suggest HTTP server configuration
  * Update JSON-LD context to [Schema.org 10.0](http://schema.org/version/10.0/)
  * Remove HTML use of `relatedLink` property in [RepositoryCollection example](../provenance.md#digital-library-and-repository-content) [#91](https://github.com/ResearchObject/ro-crate/pull/91)
  * Distinguish between [contextual/data entities](../contextual-entities.md#contextual-vs-data-entities) [#94](https://github.com/ResearchObject/ro-crate/pull/94)
  * RO-Crate preview HTML no longer needs to "contain same information as JSON-LD" [#108](https://github.com/ResearchObject/ro-crate/issues/108)
  * Change theme to `jekyll-rtd-theme` and split into multiple pages [#95](https://github.com/ResearchObject/ro-crate/pull/95)
  * Fixed typos in JSON and English 
  * [Additional metadata standards](../metadata.md#additional-metadata-standards) showed wrong PCDM namespace [#112](https://github.com/ResearchObject/ro-crate/pull/112)
  * [Citation example](../contextual-entities.md#publications-via-citation-property) expanded 12a6754
  * [Terminology](../terminology.md) adds property, type, entity cc10e28
  * In [People](../contextual-entities.md#people) `author` can also be applied to `CreativeWork` e086b8b
  * [Provenance section](../provenance.md) on Software-used now points to [Workflows](../workflows.md) section (and vice versa) 5d89872 40de6c7
  * In [JSON-LD appendix](jsonld.md) `@id` should not include `../` 74ef6f1
  * Several sections reviewed to improve language and examples
    [#91](https://github.com/ResearchObject/ro-crate/pull/91)
    [#92](https://github.com/ResearchObject/ro-crate/pull/92)
    [#93](https://github.com/ResearchObject/ro-crate/pull/93)
    [#94](https://github.com/ResearchObject/ro-crate/pull/94)
    [#96](https://github.com/ResearchObject/ro-crate/pull/96)
    [#97](https://github.com/ResearchObject/ro-crate/pull/97)
    [#98](https://github.com/ResearchObject/ro-crate/pull/98)
    [#101](https://github.com/ResearchObject/ro-crate/pull/101)
    [#102](https://github.com/ResearchObject/ro-crate/pull/102)
    [#103](https://github.com/ResearchObject/ro-crate/pull/103)
    [#104](https://github.com/ResearchObject/ro-crate/pull/104)
    [#105](https://github.com/ResearchObject/ro-crate/pull/105)
    [#111](https://github.com/ResearchObject/ro-crate/pull/111)
    [#114](https://github.com/ResearchObject/ro-crate/pull/114)
* [RO-Crate 1.0.1](https://github.com/ResearchObject/ro-crate/releases/tag/1.0.1)
  * Fix JSON typo in example  
* [RO-Crate 1.0.0](https://github.com/ResearchObject/ro-crate/releases/tag/1.0.0) <https://w3id.org/ro/crate/1.0>
  * Description of RO-Crate Metadata File now required
    * .. must use `conformsTo` to indicate RO-Crate version
  * Clarified use of RO-Crate JSON-LD Context
  * Linked Data principles added
  * RO-Crate JSON-LD Context updated to use [Schema.org 5.0](http://schema.org/version/5.0/)
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

