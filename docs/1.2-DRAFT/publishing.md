---
title: Provenance of entities
nav_order: 8
parent: RO-Crate 1.2-DRAFT 
---
<!--
   Copyright 2022 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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