---
title: Data Entities
nav_order: 6
parent: RO-Crate 1.2-DRAFT
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2023 The University of Manchester UK 
   Copyright 2019-2023 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

The primary purpose for RO-Crate is to gather and describe a set of _Data entities_ in the form of:

* Files
* Directories
* Web resources

The data entities can be further described by referencing [contextual entities](contextual-entities.md) such as persons, organizations and publications.

## Referencing files and folders from the Root Data Entity

Where files and folders are represented as _Data Entities_ in the RO-Crate JSON-LD, these MUST be linked to, either directly or indirectly, from the [Root Data Entity](root-data-entity.md) using the [hasPart] property. Directory hierarchies MAY be represented with nested [Dataset] _Data Entities_, or the Root Dataset MAY refer to files anywhere in the hierarchy using [hasPart].

_Data Entities_ representing files: MUST have `"File"` as a value for `@type`. `File` is an RO-Crate alias for <http://schema.org/MediaObject>. The term _File_ includes:
-  _Attached_ resources where `@id` is a URI (path) relative to the _RO-Crate Root_ which MUST resolve to file.
-  _Detached_ "downloadable" resources where `@id` is an absolute URI which resolves to a single datastream that can be downloaded and saved as a file. _Detached_ Files SHOULD NOT reference intermediate resources such as splash-pages, search services or web-based viewer applications.

_Data Entities_ representing directories MUST have `Dataset` as a value for `@type`. The term _directory_ here includes HTTP file listings where `@id` is an absolute URI, however "external, _Detached_ directories SHOULD have a programmatic listing of their content (e.g. another RO-Crate). It follows that the _RO-Crate Root_ is itself a data entity.

_Data Entities_ can also be other types, for instance an online database. These SHOULD be a `@type` of [CreativeWork] (or one of its subtypes) and typically have a `@id` which is an absolute URI.

In all cases, `@type` MAY be an array in order to also specify a more specific type, e.g. `"@type": ["File", "ComputationalWorkflow"]`

There is no requirement to represent _every_ file and folder in an RO-Crate as Data Entities in the RO-Crate JSON-LD.  Reasons for not describing files would include that the files:
- are described in some other way, for example a manifest or another package management system,
- are supporting files for a software application,
- have metadata embedded in their filenames or paths which can be explained once,
- have a purpose that is unknown to the crate author, but they need to be preserved as part of an archive. 

In any of the above cases where files are not described, a directory containing a set of files _MAY_ be described using a `Dataset` _Data Entity_ that encapsulates the files with a `description` property that explains the contents. If the RO-Crate file structure is flat, or files are not grouped together a `description` property on the _Root Data Entity_ may be used, or a `Dataset` with a local reference beginning with `#` (eg to describe certain type of file which occurs throughout the crate). This approach is recommended for RO-Crates which are to be deposited in a long-term archive.




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
{ "@context": "https://w3id.org/ro/crate/1.2-DRAFT/context",
  "@graph": [
    {
      "@type": "CreativeWork",
      "@id": "ro-crate-metadata.json",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"},
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
      "description": "This directory contains many small files - the name of the file is a date in YYYY-MM-DD.csv, each file contains daily temperature readings, sampled hourly for the Glop Pot cave."
    }
  ]
}
```

If the dataset contained  a large number of `*.ai` files which were spread throughout the crate structure and which did not have `File Data Entities` then a approach to describing them would be:

```
{
      "@id": "./",
      "@type": [
        "Dataset"
      ],
      "hasPart": [
        {
          "@id": "#ai-files"
        }
      ]
    },

{
      "@id": "#ai-files",
      "@type": "Dataset",
      "name": ".ai Files",
      "description": "This dataset contains some files with the extension '.ai' which despite their extension have an encoding format of 'application/pdf'. These have yet to be catalogued."
}


```

### Adding detailed descriptions of encodings

The above example provides a media type for the file `cp7glop.ai` - which is
useful as it may not be apparent that the file is readable as a PDF file from the
extension alone. To add more detail, encodings SHOULD be linked using a [PRONOM]
identifier to a _Contextual Entity_ with `@type` array containing [WebPage] and `Standard`.

``` json
  {
    "@id": "cp7glop.ai",
    "@type": "File",
    "name": "Glop Plot map",
    "contentSize": "383766",
    "description": "Illustrator file for Glop Pot",
    "encodingFormat": ["application/pdf", {"@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/19"}]
  },
  {
    "@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/19",
    "name": "Acrobat PDF 1.5 - Portable Document Format",
    "@type": ["WebPage", "Standard"]
  }

```

If there is no PRONOM identifier (and typically no media type string), then a contextual entity with a different URL as an `@id` MAY be used, e.g. documentation page of a software's file format. The contextual entity SHOULD NOT include `Standard` in its `@type` if the page do not sufficiently document the format. The `@type` SHOULD include [WebPage], or MAY include [WebPageElement] to indicate a section of the page.

For example, `.trr` is a an internal GROMACS file format that is not further documented as a standard, but is referenced from a `WebPageElement` adressable by an `#anchor`:

```json
 {
    "@id": "traj.trr",
    "@type": "File",
    "name": "Trajectory",
    "description": "Trajectory of molecular dynamics simulation using GROMACS",
    "contentSize": "45512",
    "encodingFormat": {"@id": "https://manual.gromacs.org/documentation/2021/reference-manual/file-formats.html#trr"}
  },
  {
    "@id": "https://manual.gromacs.org/documentation/2021/reference-manual/file-formats.html#trr",
    "@type": "WebPageElement",
    "name": "GROMACS trajectory of a simulation (trr)"
  }
```

If there is no web-accessible description for a file format it SHOULD be described locally in the RO-Crate, for example in a Markdown file:

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
    "name": "Description of some_extension text-based file format",
    "encodingFormat": "text/markdown"
  }
```

### File format profiles

Some generic file formats like `application/json` may be specialized using a _profile_ document that define expectations for the file's content as expected by some applications, by using [conformsTo] to a contextual entity with types [CreativeWork] and [Profile]:

```json
 { 
  "@id": "attributes.csv",
  "@type": "File",
  "encodingFormat": ["text/csv", {"@id": "https://www.nationalarchives.gov.uk/PRONOM/x-fmt/18"}],
  "conformsTo": {"@id": "https://docs.ropensci.org/dataspice/#create-spice"}
 },
 {
  "@id": "https://docs.ropensci.org/dataspice/#create-spice",
  "@type": ["CreativeWork", "Profile"],
  "name": "dataspice CSV profile"
 }
```


{: .tip }
Profiles expressed in formal languages (e.g. XML Schema for validation) can have their own `encodingFormat` and `conformsTo` to indicate their file format.

{: .note}
The [Metadata Descriptor](root-data-entity.md#ro-crate-metadata-file-descriptor) `ro-crate-metadata.json` is not a data entity, but is described with `conformsTo` to an _implicit contextual entity_ for the RO-Crate specification, a profile of [JSON-LD](appendix/jsonld). RO-Crates themselves can be specialized using [Profile Crates](profiles), specified with `conformsTo` on the root data entity.


## Core Metadata for Data Entities


### Encoding file paths

Note that all `@id` [identifiers must be valid URI references](appendix/jsonld.md#describing-entities-in-json-ld), care must be taken to express any relative paths using `/` separator, correct casing, and escape special characters like space (`%20`) and percent (`%25`), for instance a _File Data Entity_ from the Windows path `Results and Diagrams\almost-50%.png` becomes `"@id": "Results%20and%20Diagrams/almost-50%25.png"` in the _RO-Crate JSON-LD_.
 
In this document the term _URI_ includes international *IRI*s; the _RO-Crate Metadata Document_ is always UTF-8 and international characters in identifiers SHOULD be written using native UTF-8 characters (*IRI*s), however traditional URL encoding of Unicode characters with `%` MAY appear in `@id` strings. Example: `"@id": "面试.mp4"` is preferred over the equivalent `"@id": "%E9%9D%A2%E8%AF%95.mp4"`


### File Data Entity

A [File] _Data Entity_ MUST have the following properties:

*  `@type`: MUST be `File`, or an array where `File` is one of the values.
*  `@id` MUST be either a _URI Path_ relative to the _RO-Crate root_ which MUST resolve to a file that is present in the _RO-Crate Root_, or an absolute URI. 

Additionally, `File` entities SHOULD have:

* [name] giving a human readable name (not necessarily the filename)
* [description] giving a longer description, e.g. the role of this file within this crate
* [encodingFormat] indicating the the IANA [media type] as a string (e.g. `"text/plain") and/or a reference to [file format](#adding-detailed-descriptions-of-encodings) contextual entity.
* [conformsTo] to a contextual entity of type [Profile], that indicate a [profile](profiles) of the encoding format
* [contentSize] with the size of the file in bytes

RO-Crate's `File` is an alias for schema.org type [MediaObject], any of its properties MAY also be used (adding contextual entities as needed).  [Files on the web](#embedded-data-entities-that-are-also-on-the-web) SHOULD also use `identifier`, `url`, `subjectOf`, and/or `mainEntityOfPage`.

### Directory File Entity

A [Dataset] (directory) _Data Entity_ MUST have the following properties:

*  `@type` MUST be `Dataset` or an array where `Dataset` is one of the values.
*  `@id`  MUST be either:
  -   a _URI Path_ relative to the _RO Crate root_ which MUST resolve to a directory that is present in the _RO-Crate Root_. The id SHOULD end with `/`.
  -   an absolute URI
  -   a local reference beginning with `#`

Additionally, `Dataset` entities SHOULD have:

* [name] giving a human readable name (not necessarily the directory name)
* [description] giving a longer description, e.g. the content of this directory
* [hasPart] listing directly contained data entities

Any of the properties of schema.org [Dataset] MAY additionally be used (adding contextual entities as needed). [Directories on the web](#directories-on-the-web-dataset-distributions) SHOULD also provide `distribution`.



## Web-based Data Entities

While one use-case of RO-Crates is to describe _files_ contained within the _RO-Crate root_ directory, RO-Crates can also gather resources from the web identified by _absolute URIs_ instead of relative _URI paths_, i.e. Web-based data entities.

Using Web-based data entities can be important particularly where a file can't be included in the _RO-Crate root_ because of licensing concerns, large data sizes, privacy, or where it is desirable to link to the latest online version.

Example of an RO-Crate including a _File Data Entity_ external to the _RO-Crate root_ (file entity <https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf>):

```json
{ "@context": "https://w3id.org/ro/crate/1.2-DRAFT/context",
  "@graph": [
    {
        "@type": "CreativeWork",
        "@id": "ro-crate-metadata.json",
        "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"},
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
      }
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

File Data Entries with an `@id` URI outside the _RO-Crate Root_ SHOULD at the time of RO-Crate creation be directly downloadable by a simple non-interactive retrieval (e.g. HTTP GET) of a single data stream, permitting redirections and HTTP/HTTPS authentication. For instance, in the example above, <https://zenodo.org/record/3541888> and <https://doi.org/10.5281/zenodo.3541888> cannot be used as `@id` above as retrieving these URLs give a HTML landing page rather than the desired PDF as indicated by `encodingFormat`. 

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


{: .note}
Do not use web based URI identifiers for files which _are_ present in the crate root, see [below](#embedded-data-entities-that-are-also-on-the-web).


### Encoding file paths

Note that all `@id` [identifiers must be valid URI references](appendix/jsonld.md#describing-entities-in-json-ld), care must be taken to express any relative paths using `/` separator, correct casing, and escape special characters like space (`%20`) and percent (`%25`), for instance a _File Data Entity_ from the Windows path `Results and Diagrams\almost-50%.png` becomes `"@id": "Results%20and%20Diagrams/almost-50%25.png"` in the _RO-Crate JSON-LD_.
 
In this document the term _URI_ includes international *IRI*s; the _RO-Crate Metadata File_ is always UTF-8 and international characters in identifiers SHOULD be written using native UTF-8 characters (*IRI*s), however traditional URL encoding of Unicode characters with `%` MAY appear in `@id` strings. Example: `"@id": "面试.mp4"` is preferred over the equivalent `"@id": "%E9%9D%A2%E8%AF%95.mp4"`


### Embedded data entities that are also on the web

File Data Entities that are present as local files may already have a corresponding web presence, for instance a landing page that describes the file, including persistent identifiers (e.g. DOI) resolving to an intermediate HTML page instead of the downloadable file directly. 

These MAY be included for File Data Entities as additional metadata, regardless of whether the File is included in the _RO-Crate Root_ directory or exists on the Web, by using the properties:

* [identifier] for formal identifier strings such as DOIs
* [contentUrl] with a string URL corresponding to a *download* link. Following the link (allowing for HTTP redirects) SHOULD directly download the file.
* [url] with a string URL for a download/landing page for this particular file (e.g. direct download is not available)
* [subjectOf] to a [CreativeWork] (or [WebPage]) that mentions this file or its content (but also other resources)
* [mainEntityOfPage] to a [CreativeWork]  (or [WebPage]) that primarily describes this file (or its content) 

Note that if a local file is intended to be packaged within an Attached RO-Crate, the `@id` property MUST be a _URI Path_ relative to the _RO Crate root_, for example `survey-responses-2019.csv` as in the example below, where the content URL points to a download endpoint as a string.

```json
  {
    "@id": "survey-responses-2019.csv",
    "@type": "File",
    "name": "Survey responses",
    "encodingFormat": "text/csv",
    "contentUrl": "http://example.com/downloads/2019/survey-responses-2019.csv",
    "subjectOf": {"@id": "http://example.com/reports/2019/annual-survey.html"}
  } ````


### Directories on the web; dataset distributions

A _Directory File Entry_ or [Dataset] identifier expressed as an absolute URL on the web can be harder to download than a [File] because it consists of multiple resources. It is RECOMMENDED that such directories have a complete listing of their content in [hasPart], enabling download traversal.

Alternatively, a common mechanism to provide downloads of a reasonably sized directory is as an archive file in formats such as [`application/zip`](https://www.nationalarchives.gov.uk/PRONOM/x-fmt/263) or [`application/gzip`](https://www.nationalarchives.gov.uk/PRONOM/x-fmt/266), described as a [DataDownload]. 

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
    "encodingFormat": ["application/zip", {"@id": "https://www.nationalarchives.gov.uk/PRONOM/x-fmt/263"}],
    "contentSize": "82818928"
  }
```

Similarly, the _RO-Crate root_ entity may also provide a [distribution] URL, in which case the download SHOULD be an archive that contains the _RO-Crate Metadata Document_.

In all cases, consumers should be aware that a `DataDownload` is a snapshot that may not reflect the current state of the `Dataset` or RO-Crate.


{% include references.liquid %}
