---
title: Introduction
nav_order: 1
parent: RO-Crate 1.2-DRAFT
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2022 The University of Manchester UK 
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

# Introduction


This document specifies a method, known as _RO-Crate_ (Research Object Crate), of aggregating and describing data for distribution, re-use, publishing, preservation and archiving. RO-Crates aggregate data into a Dataset, and may describe any resource including files, URI-addressable resources, or use other addressing schemes to locate digital or physical data. Describing resources includes technical metadata such as file sizes and types as well as contextual information including how datasets and files were created, and where, how they were collated and collected, who was involved in the process, what equipment and software was who funded the work, how to cite it, and crucially, how it may be reused, and by whom.

The core of RO-Crate is a machine-readable linked-data document in JSON-LD format known as an **RO-Crate Metadata Document**. 

To describe data on disk an RO-Crate Metadata Document named `ro-crate-metadata.json`  is placed in a directory alongside a set of files or directories. In the case, just one file named `data.csv` with the RO-Crate Metadata Document and data in a directory named `crate-dir`:


```
— crate-dir / 
            | - data.csv
            | - ro-crate-metadata.json
```


The contents of the RO Crate Metadata document are:


```
{ "@context": "https://w3id.org/ro/crate/1.1/context", 
  "@graph": [

 {
    "@type": "CreativeWork",
    "@id": "ro-crate-metadata.json",
    "conformsTo": {"@id": "https://w3id.org/ro/crate/2.0"},
    "about": {"@id": "./"}
 },  
 {
    "@id": "./",
    "@type": "Dataset",
    "datePublished": "2022-02-01",
    "name": "Example dataset for RO-Crate specification",
    "description": "Official ainfall readings for Katoomba, NSW 2022, Australia"
    "hasPart": [{"@id": "data.csv"}]
 }
{
    "@id": "data.csv",
    "@type": "File",
    "encodingFormat": "text/csv",
    "name": "Rainfall data for Katoomba, NSW Australia February 2022",
    "license": "CC BY-NC-SA 3.0 AU"
 }
]
}


```


The first JSON-LD entity in this example has the @id “ro-crate-metadata.json”


```
 {
    "@type": "CreativeWork",
    "@id": "ro-crate-metadata.json",
    "conformsTo": {"@id": "https://w3id.org/ro/crate/2.0"},
    "about": {"@id": "./"}
 }
```


The presence of the entity, known as the *RO-Crate Metadata Descriptor* identifies this as an RO-Crate Metadata Document conforming to the RO-Crate version 2.0 specification, via the `conformsTo` property, and it indicates via the `about` property which other entity is the RO-Crate Root Dataset, that is, the main Data Entity of this RO-Crate package.



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")


By convention in RO-Crate the `@id` value of  `./` means that this document describes the directory of content in which the RO-Crate metadata is located as in the example above. (If data is being served from a service such as a data repository or database where files are not expected to be stored or distributed  then the ID MAY be a URI instead of “./”  TODO - link to the relevant section.

Data aggregated from the Root Dataset is via `hasPart` property, which in this example is an array with one value only, a reference to an entity describing the file `data.csv`, which has `@type` value of `File`. For more information on files and directories, which are known as `Data Entities` see xxxxxxx (TODO: Link to the section on File and Dataset Data Entities).



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")


The publisher of this Dataset SHOULD be indicated using the property `publisher` using a URI to identify the `Organization`, linking to what is known as a `Contextual Entity` that provides some information about the Organization such as its name and web address.


```
{
    "@id": "./",
    "@type": "Dataset",
    "publisher": {"@id": "https://ror.org/04dkp1p98"},
…
 }

{
   "@id": "https://ror.org/04dkp1p98",
   "@type": "Organization"
   "name": "Bureau of Meteorology",
   "description: "Australian Government Bureau of Meteorology",
   "URL": "http://www.bom.gov.au/"

}
```


There is more information about providing information on data context in the section on Contextual Entities, which includes how to provide links to authors and their affiliations, etc.


## HTML preview

For distribution on disk or in packaged format such as a zip file or disk image, or when placed on a plain-old website an RO-Crate SHOULD have an accompanying HTML version which is designed to be readable for people. The contents of this may vary and may be generated automatically from the RO-Crate Metadata Document, or by hand.

TODO: Screenshot and links to examples.


## NEW SECTION Serving RO-Crate metadata documents from a service

If an RO-Crate Metadata Document is served from a service use the following DCAT properties:


```
dcat:accessURL – RO-Crate Metadata Documents

dcat:downloadURL - Direct downloads of bitstreams (files)
```


Client software to construct RO-Crates SHOULD:



* Save the RO-Crate Metadata file into an empty create download directory 
* For Dataset that has a relative URI, make a subdirectory  with the same path as the Dataset id - eg /data/pictures
* For each File Entity fetch the datastream using downloadURI and write it to a relative path that corresponds to its “@id” (creating directories as needed, even if they are not described in the RO-Crate).

In the case where the RO-Crate metadata Document is being served from a service,


```
{ "@context": "https://w3id.org/ro/crate/1.1/context", 
  "@graph": [

 {
    "@type": "CreativeWork",
    "@id": "ro-crate-metadata.json",
    "conformsTo": {"@id": "https://w3id.org/ro/crate/2.0"},
    "about": {"@id": "./"}
 },  
 {
    "@id": "./",
    "accessUrl": "https://example.com/ro-crate/api/crate/000001",
    "@type": "Dataset",
    "datePublished": "2022-02-01",
    "name": "Example dataset for RO-Crate specification",
    "description": "If this were real data it would contain a minute-by-minute rainfall readings for my weather gauge",             "license": "CC BY-NC-SA 3.0"
    "hasPart": {"@id": "data.csv"}
 }
{
    "@id": "data.csv",
    "downloadURL": https://example.com/ro-crate/api/crate/000001?file=data.csv,
    "@type": "File",
    "encodingFormat": "text/csv",
    "name": "Rainfall data for Katoomba, NSW Australia, 2022-02-01",
    "license": "CC BY-NC-SA 3.0 AU"

 }

]
}
```


TODO: link

To get started quickly on building crates, here are some direct  links to examples: (LINKS TODO)



* Adding authors
* Adding project and funder information
* Packaging workflows or code
* etc

{% include references.liquid %}
