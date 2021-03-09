---
layout: default
title: Data Entities
redirect_from:
  - /1.1-DRAFT/data-entities
excerpt: |
  ..
nav_order: 7
parent: RO-Crate 1.1
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

# Data Entities

The primary purpose for RO-Crate is to gather and describe a set of _Data entities_ in the form of:

* Files
* Directories
* Web resources

The data entities can be further described by referencing [contextual entitites](contextual-entities.md) such as persons, organizations and publications.

## Referencing files and folders from the Root Data Entity

Where files and folders are represented as _Data Entities_ in the RO-Crate JSON-LD, these MUST be linked to, either directly or indirectly, from the [Root Data Entity](root-data-entity.md) using the [hasPart] property. Directory hierarchies MAY be represented with nested [Dataset] _Data Entities_, or the Root Dataset MAY refer to files anywhere in the hierarchy using [hasPart].

_Data Entities_ representing files MUST have `"File"` as a value for `@type`. `File` is an RO-Crate alias for <http://schema.org/MediaObject>. The term _File_ here is liberal, and includes "downloadable" resources where `@id` is an absolute URI.

_Data Entities_ representing directories MUST be of `"@type": "Dataset"`. The term _directory_ here includes HTTP file listings where `@id` is an absolute URI, however "external" directories SHOULD have a programmatic listing of their content (e.g. another RO-Crate).

_Data Entities_ can also be other types, for instance an online database. These SHOULD be of `"@type": "CreativeWork"` and typically have a `@id` which is an absolute URI.

In all cases, `@type` MAY be an array in order to also specify a more specific type, e.g. `"@type": ["File", "ComputationalWorkflow"]`

```tip
There is no requirement to represent _every_ file and folder in an RO-Crate as Data Entities in the RO-Crate JSON-LD.
```

### Example linking to a file and folders

```
<RO-Crate root>/
  |   ro-crate-metadata.json
  |   cp7glop.ai
  |   lots_of_little_files/
  |    | file1
  |    | file2
  |    | ...
  |    | file54
```

An example _RO-Crate JSON-LD_ for the above would be as follows:

```json
{ "@context": "https://w3id.org/ro/crate/1.1/context",
  "@graph": [
    {
      "@type": "CreativeWork",
      "@id": "ro-crate-metadata.json",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1"},
      "about": {"@id": "./"}
    },  
    {
      "@id": "./",
      "@type": [
        "Dataset"
      ],
      "hasPart": [
        {
          "@id": "cp7glop.ai"
        },
        {
          "@id": "lots_of_little_files/"
        }
      ]
    },
    {
      "@id": "cp7glop.ai",
      "@type": "File",
      "name": "Diagram showing trend to increase",
      "contentSize": "383766",
      "description": "Illustrator file for Glop Pot",
      "encodingFormat": "application/pdf"
    },
    {
      "@id": "lots_of_little_files/",
      "@type": "Dataset",
      "name": "Too many files",
      "description": "This directory contains many small files, that we're not going to describe in detail."
    }
  ]
}
```

### Adding detailed descriptions of encodings

The above example provides a media type for the file `cp7glop.ai` - which is
useful as it may not be apparent that the file is readable as a PDF file from the
extension alone. To add more detail, encodings SHOULD be linked using a [PRONOM]
identifier to a _Contextual Entity_ of `@type` [WebSite].

``` json
  {
    "@id": "cp7glop.ai",
    "@type": "File",
    "name": "Diagram showing trend to increase",
    "contentSize": "383766",
    "description": "Illustrator file for Glop Pot",
    "encodingFormat": ["application/pdf", {"@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/19"}]
  },
  {
    "@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/19",
    "name": "Acrobat PDF 1.5 - Portable Document Format",
    "@type": "WebSite"
  }

```

If there is no PRONOM identifier, then a contextual entity with a URL as an `@id` MAY be used:

For example:

```json
 {
    "@id": "1st-tool.cwl",
    "@type": "File",
    "name": "First executable tool",
    "description": "An example Common Workflow Language File",
    "contentSize": "120",
    "encodingFormat": ["text/plain", {"@id": "https://www.commonwl.org/v1.0/Workflow.html"}]
  },
  {
    "@id": "https://www.commonwl.org/v1.0/Workflow.html",
    "@type": "WebSite",
    "name": "Common Workflow Language (CWL) Workflow Description, v1.0.2"
  }
```

If there is no web-accessible description for a file format it SHOULD be described locally in the dataset, for example in a file:

```json
 {
    "@id": "some-file.some_extension",
    "@type": "File",
    "name": "Some file",
    "description": "A file in a non-standard format",
    "contentSize": "120",
    "encodingFormat": ["text/plain", {"@id": "some_extension.md"}]
  },
  {
    "@id": "some_extension.md",
    "@type": ["File", "CreativeWork"],
    "name": "Description of some_extension file format",
    "encodingFormat": "text/markdown"
  }
```

## Core Metadata for Data Entities

The table below outlines the properties that Data Entities, when present, MUST have to be minimally valid.

### Encoding file paths

Note that all `@id` [identifiers must be valid URI references](appendix/jsonld.html#describing-entities-in-json-ld), care must be taken to express any relative paths using `/` separator, correct casing, and escape special characters like space (`%20`) and percent (`%25`), for instance a _File Data Entity_ from the Windows path `Results and Diagrams\almost-50%.png` becomes `"@id": "Results%20and%20Diagrams/almost-50%25.png"` in the _RO-Crate JSON-LD_.
 
In this document the term _URI_ includes international *IRI*s; the _RO-Crate Metadata File_ is always UTF-8 and international characters in identifiers SHOULD be written using native UTF-8 characters (*IRI*s), however traditional URL encoding of Unicode characters with `%` MAY appear in `@id` strings. Example: `"@id": "面试.mp4"` is preferred over the equivalent `"@id": "%E9%9D%A2%E8%AF%95.mp4"`

### File Data Entity

A [File] _Data Entity_ MUST have the following properties:

*  `@type`: MUST be `File`, or an array where `File` is one of the values.
*  `@id` MUST be either a _URI Path_ relative to the _RO Crate root_, or an absolute URI.

### Directory File Entity

A [Dataset] (directory) _Data Entity_ MUST have the following properties:

*  `@type` MUST be `Dataset` or an array where `Dataset` is one of the values.
*  `@id`  MUST be either an a _URI Path_ relative to the _RO Crate root_, or an absolute URI. The id SHOULD end with `/`

## Web-based Data Entities

While one use-case of RO-Crates is to describe _files_ contained within the _RO-Crate root_ directory, RO-Crates can also gather resources from the web identified by _absolute URIs_ instead of relative _URI paths_, i.e. Web-based data entities.

Using Web-based data entities can be important particularly where a file can't be included in the _RO-Crate root_ because of licensing concerns, large data sizes, privacy, or where it is desirable to link to the latest online version.

Example of an RO-Crate including a _File Data Entity_ external to the _RO-Crate root_ (file entity <https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf>):

```json
{ "@context": "https://w3id.org/ro/crate/1.1/context",
  "@graph": [
    {
        "@type": "CreativeWork",
        "@id": "ro-crate-metadata.json",
        "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1"},
        "about": {"@id": "./"}
  },  
  {
    "@id": "./",
    "@type": [
      "Dataset"
    ],
    "hasPart": [
      {
        "@id": "survey-responses-2019.csv"
      },
      {
        "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf"
      },
      ]
  },
  {
    "@id": "survey-responses-2019.csv",
    "@type": "File",
    "name": "Survey responses",
    "contentSize": "26452",
    "encodingFormat": "text/csv"
  },
  {
    "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf",
    "@type": "File",
    "name": "RO-Crate specification",
    "contentSize": "310691",
    "description": "RO-Crate specification",
    "encodingFormat": "application/pdf"
  }
]
}
```

Additional care SHOULD be taken to improve persistence and long-term preservation of web resources included 
in an RO-Crate as they can be more difficult to archive or move along with the _RO-Crate root_, and
may change intentionally or unintentionally leaving the RO-Crate with incomplete or outdated information.

File Data Entries with an `@id` URI outside the _RO-Crate Root_ SHOULD at the time of RO-Crate creation be directly downloadable by a simple retrieval (e.g. HTTP GET), permitting redirections and HTTP/HTTPS authentication. For instance, in the example above, <https://zenodo.org/record/3541888> and <https://doi.org/10.5281/zenodo.3541888> cannot be used as `@id` above as retrieving these URLs give a HTML landing page rather than the desired PDF as indicated by `encodingFormat`.

As files on the web may change, the timestamp property [sdDatePublished] SHOULD be included to indicate when the absolute URL was accessed, and derived metadata like [encodingFormat] and [contentSize] were considered to be representative:

```json
  {
    "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf",
    "@type": "File",
    "name": "RO-Crate specification",
    "contentSize": "310691",
    "encodingFormat": "application/pdf",
    "sdDatePublished": "2020-04-09T13:09:21+01:00Z"
  }
```

### Embedded data entities that are also on the web

File Data Entities may already have a corresponding web presence, for instance a landing page that describes the file, including persistent identifiers (e.g. DOI) resolving to an intermediate HTML page instead of the downloadable file directly. 

These can be included for File Data Entities as additional metadata, regardless of whether the File is included in the _RO-Crate Root_ directory or exists on the Web, by using the properties:

* [identifier] for formal identifier strings such as DOIs
* [url] with a string URL corresponding to a *download* link (if not available, a download landing page) for this file
* [subjectOf] to a [CreativeWork] (or [WebPage]) that mentions this file or its content (but also other resources)
* [mainEntityOfPage] to a [CreativeWork]  (or [WebPage]) that primarily describes this file (or its content) 

```json
  {
    "@id": "survey-responses-2019.csv",
    "@type": "File",
    "name": "Survey responses",
    "encodingFormat": "text/csv",
    "url": "http://example.com/downloads/2019/survey-responses-2019.csv",
    "subjectOf": {"@id": "http://example.com/reports/2019/annual-survey.html"}
  },
  {
    "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf",
    "@type": "File",
    "name": "RO-Crate specification",
    "encodingFormat": "application/pdf",
    "identifier": "https://doi.org/10.5281/zenodo.3541888",
    "url": "https://zenodo.org/record/3541888"
  }
```

### Directories on the web; dataset distributions

A _Directory File Entry_ or [Dataset] identifier expressed as an absolute URL on the web can be harder to download than a [File] because it consists of multiple resources. It is RECOMMENDED that such directories have a complete listing of their content in [hasPart], enabling download traversal.

Alternatively, a common mechanism to provide downloads of a reasonably sized directory is as an archive file in formats such as `.zip` or `.tar.gz`, described as a [DataDownload]. 

```json
  {
    "@id": "lots_of_little_files/",
    "@type": "Dataset",
    "name": "Too many files",
    "description": "This directory contains many small files, that we're not going to describe in detail.",
    "distribution": {"@id": "http://example.com/downloads/2020/lots_of_little_files.zip"}
  },
  {
    "@id": "http://example.com/downloads/2020/lots_of_little_files.zip",
    "@type": "DataDownload",
    "encodingFormat": "application/zip",
    "contentSize": "82818928"
  }
```

Similarly, the _RO-Crate root_ entity may also provide a [distribution] URL, in which case the download SHOULD be an archive that contains the _RO-Crate Metadata file_.

In all cases, consumers should be aware that a `DataDownload` is a snapshot that may not reflect the current state of the `Dataset` or RO-Crate.


{% include references.liquid %}
