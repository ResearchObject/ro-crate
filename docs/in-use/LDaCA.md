---
title: Language Data Commons of Australia (LDaCA) Program
parent: RO-Crate In Use
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

# Lanagugue Data Commons of Australia Program

<!-- linking to logo online cos the current one is a placeholder only and should get updated -->
[![LDaCA Logo](https://www.ldaca.edu.au//LDaCA_logo-sm.png)][LDaCA]

[![ATAP LOGO](https://www.atap.edu.au/ATAP_logo-sm.png)][ATAP]

The LDaCA Program architecture consists of a set of modular services; data preservation/archiving, APIs for delivery, access control and a discovery portal for data and analysis tools as well as automated container-based notebook environments to run analytics via the Australian Text Analytics Platform (which is a component of the broader program). 





![Example screenshot with RO-Crate(../assets/img/example-screenshot.png)


## RO-Crate in the LDaCA Program

RO-Crate is the central metadata standard for all data within the LDaCA environment.

### Archiving

Provide a consitent metadata model for long term archiving and preservation. RO-Crate data is used to store archival copies of lanuage datasets using the [Oxford Common File Layout](https://arkisto-platform.github.io/standards/ocfl/). 

### API ACcess / 
 Provide access-controlled API access to data. Access control is important for language data as it is created by and collected from humans who have intellectual property rights over the data and some of he content may be confidential

 RO-Crates can be made available over an API using the [Oni]() tool.

 For example, this query looks for RO-Crates which package objects, with a conformsTo property from the (draft) profile: <https://purl.archive.org/textcommons/profile#Collection>

```
 curl --location --request GET 'http://localhost:9000/api/object?conformsTo=https://purl.archive.org/textcommons/profile%23Collection' \
--header 'Authorization: Bearer XXXXX-XXXXX-XXXXX-XXXXX'
```


In this demonstration this returns 10 results (turncated here), which can then be fetched using the crateId property.

```
{
    "total": 10,
    "data": [
        {
            "conformsTo": "https://purl.archive.org/textcommons/profile#Collection",
            "crateId": "arcp://name,multilingual.gov.au/corpus/root",
            "record": {
                "name": "Collection of Australian Government Documents in six languages",
                "license": "https://creativecommons.org/licenses/by/3.0/au/",
                "description": "This dataset consists of documents created by government agencies in Australia which provide information to members of the Australian community. They originate as English text and also exist as translations into various other languages used in the Australian community. The initial dataset (12/2021) includes documents prepared by Services Australia (https://www.servicesaustralia.gov.au/) and by the Victorian Department of Health ( Health Translations) in English, Arabic, Farsi, Turkish, Vietnamese and Chinese."
            }
        },
        {
            "conformsTo": "https://purl.archive.org/textcommons/profile#Collection",
            "crateId": "arcp://name,cooee-corpus/corpus/root",
            "record": {
                "name": "A COrpus of Oz Early English (COOEE)",
                "license": "https://creativecommons.org/licenses/by/4.0/",
                "description": "Material to be included had to meet with a regional and a temporal criterion. The latter required texts to have been produced between 1788 and 1900 in order to become eligible for COOEE. It was mandatory for a text to have been written in Australia, New Zealand or Norfolk Island. But in a few cases, other localities were allowed. For example, if a person who was a native Australian or who had lived in Australia for a considerable time, wrote a shipboard diary or travelled in other countries. Contains: Letters, published materials in book form, historical texts"
            }
        },
        ...
        {
            "conformsTo": "https://purl.archive.org/textcommons/profile#Collection",
            "crateId": "arcp://name,ausnc-ace/root/collection",
            "record": {
                "name": "The Australian Corpus of English",
                "license": "license.txt",
                "description": "The Australian Corpus of English (ACE) was compiled to match Australian data from 1986 with the American (Brow) and British (LOB) corpora of written English from the 1960s. It includes 500 samples of published texts taken from 15 different categories of nonfiction and fiction, including newspapers, reportage, editorials, reviews; magazines and journals popular, academic; government and corporate documents; fiction monographs and short stories (both popular and literary)."
            }
        }
    ]
}

```



### Discovery portals

The structural API described above is used to build discovery and access portals which use the metadata from RO-Crate objects to generate an Elasticsearch index and a web site to search and browse the RO-Crate-packaged data.

The portal/index system us highly configurable to work with differently structured RO-Crate data.

![Oni Portal Screencast](../assets/img/ldaca-oni-demo.gif)





## Resources

* [Language Data Commons of Australia (LDaCA) Homepage](https://ldaca.edu.au)
* [Australian Text Analytics Platform](https://atap.edu.au)
* [RO-Crate profile for Ldaca (DRAFT - in development)](https://purl.archive.org/textcommons/profile)
* [RO-Crate metadata vocabulary (DRAFT - in development)](https://purl.archive.org/textcommons/terms)
* [Presentation explaining the LDaCA architecture](https://www.ldaca.edu.au/rdc-tech-meeting/)


[ATAP]: https://atap.edu.au
[LDaCA]: https://ldaca.edu.au