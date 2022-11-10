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

The core of RO-Crate is a machine-readable linked-data document in JSON-LD format known as an **RO-Crate Metadata Document**. RO-Crate metadata documents can to a large extent be created and processed just like any other JSON, knowledge of JSON-LD is not needed unless extending RO-Crate with additional concepts or combining RO-Crate with other Linked Data technologies.

This page introduces the general RO-Crate concepts through a running example, while the normative pages in the rest of the RO-Crate specification define in more detail these and other concepts using separate examples and recommendations.

## An initial RO-Crate

In the simplest form, to describe some data on disk, an RO-Crate Metadata Document named `ro-crate-metadata.json` is placed in a directory alongside a set of files or directories. 

In the example below, a single file `data.csv` is placed with the RO-Crate Metadata Document in a directory named for instance `crate-dir`:


```
— crate-dir / 
            | - data.csv
            | - ro-crate-metadata.json
```

The presence of the `ro-crate-metadata.json` file means that `crate-dir` and its children can now be considered to be an **RO-Crate**.

In this example, the content of the RO Crate Metadata document is:


```json
{ "@context": "https://w3id.org/ro/crate/1.1/context", 
  "@graph": [

  {
    "@type": "CreativeWork",
    "@id": "ro-crate-metadata.json",
    "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"},
    "about": {"@id": "./"}
  },  
  {
    "@id": "./",
    "@type": "Dataset",
    "datePublished": "2022-12-01",
    "name": "Example dataset for RO-Crate specification",
    "description": "Official rainfall readings for Katoomba, NSW 2022, Australia",
    "hasPart": [ {"@id": "data.csv"} ]
  },
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

The pre-amble of `@context` and `@graph` are JSON-LD structures that help provide global identifiers to the JSON keys and types used in the rest of the RO-Crate document. These will largely map to definitions in the [schema.org](http://schema.org/) vocabulary, which can be used by RO-Crate extensions to provide additional metadata beyond the RO-Crate specifications. It is this feature of JSON-LD that helps make RO-Crate extensible for many different purposes -- this is explored further in [appendix on JSON-LD](appendix/jsonld.md).

However, in the general case it should be sufficient to follow the RO-Crate JSON examples directly without deeper JSON-LD understanding. In short, an RO-Crate metadata file contains a flat list of _entities_ as objects in the `@graph` array. These entities are cross-related using `@id` identifiers rather than being deeply nested.

The first JSON-LD _entity_ in our example above has the @id `ro-crate-metadata.json`:


```json
{
    "@type": "CreativeWork",
    "@id": "ro-crate-metadata.json",
    "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"},
    "about": {"@id": "./"}
}
```

This required entity, known as the *RO-Crate Metadata Descriptor*, self-identifies this file as an RO-Crate Metadata Document, that is conforming to the RO-Crate version 1.2-DRAFT specification (`conformsTo`). The descriptor also indicates via the `about` property which entity in the `@graph` array is the _RO-Crate Root Dataset_, that is, the starting point of this RO-Crate. We can visualise this as:


![alt_text](images/image1.png "image_tooltip")


By convention, in RO-Crate the `@id` value of  `./` means that this document describes the directory of content in which the RO-Crate metadata is located as in the example above. This reference from `ro-crate-metadata.json` is therefore marking the `crate-dir` directory as being the RO-Crate root.

{: .note }
This example is a directory-based RO-Crate stored on disk. If the crate is being served from a Web service, such as a data repository or database where files are not organized in directories, then the `@id` might be an absolute URI instead of `"./"` -- see section [Root Data Entity](root-data-entity.md) for details

In RO-Crate Metadata Files, entities are cross-referenced using `@id` reference objects, rather than using deeply nested JSON objects. In short this _flattened JSON-LD_ style allows any entity to reference any other entity, and for RO-Crate consumers to directly find all the descriptions of an entity within a single JSON object. So let's have a look at the Root Data Entity `./`:


```json
{
    "@id": "./",
    "@type": "Dataset",
    "…": "",
    "hasPart": [ {"@id": "data.csv"} ]
}
```

The root is always typed `Dataset` and have several metadata properties that describe the RO-Crate as a whole, as a collection of resources.

A main type of resources collected are _data_ -- retrievable files. These are aggregated by the Root Dataset with the `hasPart` property. In this example we have an array with a single value, a reference to the entity describing the file `data.csv`. 

Again following the `@id` reference for this _data entity_, we see it has `@type` value of `File` and additional metadata such as `encodingFormat`. It is recommended that every entity has a human readable `name`, which as shown in this example, do not need t omatch the filename/identifier.


```json
  {
    "@id": "data.csv",
    "@type": "File",
    "name": "Rainfall data for Katoomba, NSW Australia February 2022",
    "encodingFormat": "text/csv",
    "…": "",
    "license": "CC BY-NC-SA 3.0 AU"
  }
```

For more information on describing files and directories, see section on [data entities](data-entitites.md)

![alt_text](images/image2.png "image_tooltip")

Moving back to the RO-Crate root `./`, the publisher of this Dataset should be indicated using the property `publisher` using a URI to identify the `Organization`, linking to what is known as a _Contextual Entity_ that provides some information about the Organization such as its name and web address.


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

The section on [root data entity](root-data-entity.md) explores further the required and recommended properties of the root `./`.

You may notice the subtle difference between a _data entity_ that is conceptually part of the RO-Crate and is file-like (containing bytes), while this _contextual entity_ is a representation of a real-life organization that can't be downloaded, following the URL we would only get its _description_. The section [contextual entities](contextual-entities.md) explores several of the entities that can be added to the RO-Crate to provide it with a **context**, for instance how to link to authors and their affiliations.  Simplifying slightly, a data entity is referenced from `hasPart` in a `Dataset`, while a contextual entity is referenced using any other defined property.


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
