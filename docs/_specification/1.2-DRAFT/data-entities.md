---
title: Data Entities
redirect_from:
  - /1.2-DRAFT/data-entities
nav_order: 6
parent: RO-Crate 1.2-DRAFT
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2024 The University of Manchester UK 
   Copyright 2019-2024 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# Data Entities {#data-entities}
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

The primary purpose for RO-Crate is to gather and describe a set of _Data entities_ in the form of:

* Files which are datastreams available on the local file system or over the web
* Directories

The data entities can be further described by referencing [contextual entities](contextual-entities) such as persons, organizations and publications.

## Referencing files and folders from the Root Data Entity

Where files and folders are represented as _Data Entities_ in the RO-Crate JSON-LD, these MUST be linked to, either directly or indirectly, from the [Root Data Entity](root-data-entity) using the [hasPart] property. Directory hierarchies MAY be represented with nested [Dataset] _Data Entities_, or the Root Data Entity MAY refer to files anywhere in the hierarchy using [hasPart].

_Data Entities_ representing files MUST have `"File"` as a value for `@type`. `File` is an RO-Crate alias for <http://schema.org/MediaObject>. The term _File_ includes:
-  Resources which are available locally (applicable only in the context of _Attached RO-Crate Packages_) and
-  [Web-based Data Entities](#web-based-data-entities) which can be downloaded and saved as a file. 

The rules for the `@id` property of Files are set out below.

In all cases, `@type` MAY be an array to also specify a more specific type, e.g. `"@type": ["File", "ComputationalWorkflow"]`

There is no requirement to represent _every_ file and folder in an RO-Crate as _Data Entities_ in the _RO-Crate JSON-LD_.  Reasons for not describing files would include that the files:
- are described in some other way, for example a manifest or another package management system,
- are supporting files for a software application,
- have metadata embedded in their filenames or paths which can be explained once,
- have a purpose that is unknown to the crate author, but they need to be preserved as part of an archive. 

In any of the above cases where files are not described, a directory containing a set of files _MAY_ be described using a `Dataset` _Data Entity_ that encapsulates the files with a `description` property that explains the contents. If the RO-Crate file structure is flat, or files are not grouped together, a `description` property on the _Root Data Entity_ may be used, or a `Dataset` with a local reference beginning with `#` (e.g. to describe a certain type of file which occurs throughout the crate). This approach is recommended for RO-Crates which are to be deposited in a long-term archive.


## Encoding file paths in `@id`s

Note that all `@id` [identifiers must be valid URI references](appendix/jsonld#describing-entities-in-json-ld), care must be taken to express any relative paths using `/` separator, correct casing, and escape special characters like space (`%20`) and percent (`%25`), for instance a _File Data Entity_ from the Windows path `Results and Diagrams\almost-50%.png` becomes `"@id": "Results%20and%20Diagrams/almost-50%25.png"` in the _RO-Crate JSON-LD_.
 
In this document the term _URI_ includes international *IRI*s; the _RO-Crate Metadata Document_ is always UTF-8 and international characters in identifiers SHOULD be written using native UTF-8 characters (*IRI*s), however traditional URL encoding of Unicode characters with `%` MAY appear in `@id` strings. Example: `"@id": "面试.mp4"` is preferred over the equivalent `"@id": "%E9%9D%A2%E8%AF%95.mp4"`

## Example _Attached RO-Crate Package_

The following is an example of an _Attached RO-Crate Package_ linking to a file and folders.

The file layout of the example is:

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

An example _RO-Crate JSON-LD_ for the above would be as follows.

This example contains both a [File Data Entity](#file-data-entity) and a [Directory Data Entity](#directory-data-entity). 

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
      "name": "Example Dataset",
      "datePublished": "2016-02-01",
      "author": "https://orcid.org/0000-0003-4953-0830",
      "license": "CC-BY",
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
    },
    {
      "@id": "https://orcid.org/0000-0003-4953-0830",
      "@type": "Person",
      "name": "Michael Lake",
    }
  ]
}
```

## Core Metadata for Data Entities

### File Data Entity {#file-data-entity}

A [File] _Data Entity_ MUST have the following properties:

*  `@type`: MUST be `File`, or an array where `File` is one of the values.
*  `@id`: MUST be a relative or absolute URI.


Further constraints on the `@id` are dependent on whether the [File] entity is being considered as part of an _Attached RO-Crate Package_ or _Detached RO-Crate Package_.

1. For an _Attached RO-Crate Package_:
  *  `@id` MUST be one of either:
    a. A relative URI, indicating that an file MUST be present at the path `@id` relative to the _RO-Crate Root_.
    b. An absolute URI, indicating that the entity is a [Web-based Data Entity](#web-based-data-entities).
   
   A [File] in an _Attached RO-Crate Package_ MAY have also a `contentURL` property which corresponds to a download link for the file. Following the link (allowing for HTTP redirects) SHOULD directly download the file.


2. For a _Detached RO-Crate Package_   `@id` MUST be an Absolute URI; all [File] Data Entities are [Web-based Data Entities](#web-based-data-entities).


Additionally, `File` entities SHOULD have:

* [name] giving a human readable name (not necessarily the filename)
* [description] giving a longer description, e.g. the role of this file within this crate
* [encodingFormat] indicating the the IANA [media type] as a string (e.g. `"text/plain") and/or a reference to [file format](#adding-detailed-descriptions-of-file-encodings) contextual entity.
* [conformsTo] to a contextual entity of type [Profile], that indicate a [profile](profiles) of the encoding format, if applicable
* [contentSize] with the size of the file in bytes

RO-Crate's `File` is an alias for schema.org type [MediaObject], any of its properties MAY also be used (adding contextual entities as needed).  [Files on the web](#data-entities-in-an-attached-ro-crate-that-are-also-on-the-web) SHOULD also use `identifier`, `url`, `subjectOf`, and/or `mainEntityOfPage`.



{% include callout.html type="note" content='It is up to implementers to decide whether to offer some form of URL "link checker" service for [Web-based Data Entities](#web-based-data-entities) for both attached and Detached RO-Crate Packages. If `contentUrl` has more than one value, then a checker service SHOULD try each provided value until one resolves and returns a correct [contentSize].' %}




### Directory Data Entity

A [Dataset] (directory) _Data Entity_ MUST have the following properties:

*  `@type` MUST be `Dataset` or an array where `Dataset` is one of the values.
*  `@id`  MUST be either:
    *   In an _Attached RO-Crate Package_ ONLY - a _URI Path_ that SHOULD end with `/`.  This MUST resolve to a directory which is present in the RO-Crate Root along with its parent directories. 
    *   An absolute URI which SHOULD resolve to a programmatic listing of the content of the "directory" (e.g. another RO-Crate). 
    *   A local reference beginning with `#`



For a _Detached RO-Crate Package_:
* The `localPath` property MAY be used to indicate the directory path to use when converting from a _Detached_ to an _Attached RO-Crate Package_. 


Additionally, `Dataset` entities SHOULD have:

* [name] giving a human readable name (not necessarily the directory name)
* [description] giving a longer description, e.g. the content of this directory
* [hasPart] listing directly contained data entities

Any of the properties of schema.org [Dataset] MAY additionally be used (adding contextual entities as needed). [Directories on the web](#directories-on-the-web-dataset-distributions) SHOULD also provide `distribution`.

If the dataset contained a large number of *.ai files which were spread throughout the crate structure and which did not have File Data Entities then a approach to describing them would be:

```JSON
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


### Web-based Data Entities


Using Web-based data entities can be important particularly where a file can't be included in the _RO-Crate Root_ because of licensing concerns, large data sizes, privacy, or where it is desirable to link to the latest online version.

Example of an RO-Crate including a _File Data Entity_ external to the _RO-Crate Root_ (file entity <https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf>):

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
in an RO-Crate, as they can be more difficult to archive or move along with the _RO-Crate Root_, and
may change intentionally or unintentionally, leaving the RO-Crate with incomplete or outdated information.

File Data Entries with an `@id` URI outside the _RO-Crate Root_ SHOULD at the time of RO-Crate creation be directly downloadable by a simple non-interactive retrieval (e.g. HTTP GET) of a single data stream, permitting redirections and HTTP/HTTPS authentication. For instance, in the example above, <https://zenodo.org/record/3541888> and <https://doi.org/10.5281/zenodo.3541888> cannot be used as `@id` above as retrieving these URLs give a HTML landing page rather than the desired PDF as indicated by `encodingFormat`. 

{ include callout.html type="note" content="_Web-based Data Entities_ SHOULD NOT reference intermediate resources such as splash-pages, search services or web-based viewer applications." }


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

Web-based entities MAY use the property [localPath] to indicate a path that can be used to when downloading the data in an _Attached RO-Crate Package_ context. This may be used to instantiate local copies of web-based resources in an _Attached RO-Crate Package_ or as part of a process to download a local resources from a _Detached RO-Crate Package_ relative to a new root directory.

```json
  {
    "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf",
    "localPath": "docs/ro-crate-1.0.0.pdf",
    "@type": "File",
    "name": "RO-Crate specification",
    "contentSize": "310691",
    "encodingFormat": "application/pdf",
    "sdDatePublished": "2020-04-09T13:09:21+01:00Z"
  }
```



{% include callout.html type="note" content="Do not use web-based URI identifiers for files which _are_ present in the crate root, see [below](#data-entities-in-an-attached-ro-crate-that-are-also-on-the-web)." %}

### Data entities in an _Attached RO-Crate_ that are also on the web

File Data Entities that are present as local files may already have a corresponding web presence, for instance a landing page that describes the file, including persistent identifiers (e.g. DOI) resolving to an intermediate HTML page instead of the downloadable file directly. 

These MAY be included for File Data Entities as additional metadata, regardless of whether the File is included in the _RO-Crate Root_ directory or exists on the Web, by using the properties:

* [identifier] for formal identifier strings such as DOIs
* [contentUrl] with a string URL corresponding to a *download* link. Following the link (allowing for HTTP redirects) SHOULD directly download the file.
* [url] with a string URL for a download/landing page for this particular file (e.g. direct download is not available)
* [subjectOf] to a [CreativeWork] (or [WebPage]) that mentions this file or its content (but also other resources)
* [mainEntityOfPage] to a [CreativeWork]  (or [WebPage]) that primarily describes this file (or its content) 


Note that if a local file is intended to be packaged within an _Attached RO-Crate Package_, the `@id` property MUST be a _URI Path_ relative to the _RO Crate Root_, for example `survey-responses-2019.csv` as in the example below, where the content URL points to a download endpoint as a string.

```json
  {
    "@id": "survey-responses-2019.csv",
    "@type": "File",
    "name": "Survey responses",
    "encodingFormat": "text/csv",
    "contentUrl": "http://example.com/downloads/2019/survey-responses-2019.csv",
    "subjectOf": {"@id": "http://example.com/reports/2019/annual-survey.html"}
  },
  {
    "@id": "http://example.com/reports/2019/annual-survey.html",
    "@type": "WebPage",
    "name": "Survey responses (landing page)"
  }
```


### Directories on the web; dataset distributions

A _Directory File Entry_ or [Dataset] identifier expressed as an absolute URL on the web can be harder to download than a [File] because it consists of multiple resources. It is RECOMMENDED that such directories have a complete listing of their content in [hasPart], enabling download traversal, or are themselves RO-Crates (see [Referencing other RO-Crates](#referencing-other-ro-crates)).

#### Downloadable dataset

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

Similarly, the _RO-Crate Root_ entity (or a reference to another RO-Crate as a `Dataset`) may provide a [distribution] URL, in which case the download SHOULD be an archive that contains the _RO-Crate Metadata Document_ (either directly in the archive's root, or within a single folder in the archive), indicated by a version-less `conformsTo`:

```json
  {
    "@id": "./",
    "@type": "Dataset",
    "identifier": "https://doi.org/10.48546/workflowhub.workflow.775.1",
    "name": "Research Object Crate for Jupyter Notebook Molecular Structure Checking",
    "distribution": {"@id": "https://workflowhub.eu/workflows/775/ro_crate?version=1"},
    "…": ""
  },
  {
    "@id": "https://workflowhub.eu/workflows/775/ro_crate?version=1",
    "@type": "DataDownload",
    "encodingFormat": ["application/zip", {"@id": "https://www.nationalarchives.gov.uk/PRONOM/x-fmt/263"}],
    "conformsTo": { "@id": "https://w3id.org/ro/crate" }
  }
```

In all cases, consumers should be aware that a `DataDownload` is a snapshot that may not reflect the current state of the `Dataset` or RO-Crate.




## Adding detailed descriptions of File encodings

The [above example](#example-attached-ro-crate-package) provides a media type for the file `cp7glop.ai` - which is
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

## File format profiles

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


{% include callout.html type="tip" content="Profiles expressed in formal languages (e.g. XML Schema for validation) can have their own `encodingFormat` and `conformsTo` to indicate their file format." %}

{% include callout.html type="note" content="The [Metadata Descriptor](root-data-entity#ro-crate-metadata-descriptor) `ro-crate-metadata.json` is not a data entity, but is described with `conformsTo` to an _implicit contextual entity_ for the RO-Crate specification, a profile of [JSON-LD](appendix/jsonld). RO-Crates themselves can be specialized using [Profile Crates](profiles), specified with `conformsTo` on the root data entity." %}


## Referencing other RO-Crates

A referenced RO-Crate is also a [Dataset] data entity, but where its [hasPart] do not need to be listed. Instead, its content and further metadata is available from its own RO-Crate Metadata Document, which may be retrieved or packaged within an archive. An entity representing a referenced RO-Crate SHOULD have `conformsTo` pointing to the generic RO-Crate profile using the fixed URI `https://w3id.org/ro/crate`.

This section defines how a _referencing_ RO-Crate ("A") can declare data entities within A's RO-Crate Metadata Document, in order to indicate a _referenced_ RO-Crate ("B"). There are different options on how to find the identifier to assign the referenced RO-Crate in A, and how a consumer of A finding such a reference can find the corresponding RO-Crate Metadata Document for B.

### Referencing RO-Crates that have a persistent identifier

If the referenced RO-Crate B has an `identifier` declared as B's [Root Data Entity identifier](root-data-entity#root-data-entity-identifier), then this is a _persistent identifier_ which SHOULD be used as the URI in the `@id` of the corresponding entity in RO-Crate A.  For instance, if RO-Crate B had declared the identifier `https://pid.example.com/another-crate/` then RO-Crate A can reference B as an entity:

```json
{
  "@id": "https://pid.example.com/another-crate/",
  "@type": "Dataset",
  "conformsTo": { "@id": "https://w3id.org/ro/crate" }
}
```

{% include callout.html type="tip" content="The `conformsTo` generic RO-Crate profile on a `Dataset` entity MUST be version-less. The referenced RO-Crate B is NOT required to conform to the same version of the RO-Crate specification as A's RO-Crate Metadata Document." %}

{% include callout.html type="warning" content="It is NOT RECOMMENDED to declare the generic profile `https://w3id.org/ro/crate` on the referencing RO-Crate A's own [root data entity](root-data-entity.html#direct-properties-of-the-root-data-entity), see [metadata descriptor](root-data-entity.html#ro-crate-metadata-descriptor). " %}

Consumers that find a reference to a `Dataset` with the generic RO-Crate profile indicated MAY attempt to resolve the persistent identifier, but SHOULD NOT assume that the `@id` directly resolves to an RO-Crate Metadata Document. See section [Retrieving an RO-Crate](#retrieving-an-ro-crate) below for the recommended algorithm. 

If an `identifier` is not declared in a referenced RO-Crate B, but the determined absolute URI has [Signposting] declared for a `Link:` with `rel=cite-as`, then that link MAY be considered as an equivalent permalink for B.


### Determining entity identifier for a referenced RO-Crate

In some cases, if the referenced RO-Crate B has not got a resolvable `identifier` declared, additional steps are needed to find the correct `@id` to use:

1. If RO-Crate A is an [Attached Ro-Crate Package](structure.html#attached-ro-crate-package) and RO-Crate B is a nested folder (e.g. `another-crate/`), then B SHOULD be treated as an _Attached RO-Crate Package_ (e.g. it has `another-crate/ro-crate-metadata.json`) and the relative path (`another-crate/`) used directly as `@id` as a [Directory Data Entity](#directory-data-entity) within crate A.
2. If B's _Root Data Entity_ has an `@id` that is an absolute URI indicating a [Detached RO-Crate Package](structure.html#detached-ro-crate-package), and that URI resolves according to [Retrieving an RO-Crate](#retrieving-an-ro-crate), then that can be used as the `@id` of the `Dataset` entity in A, equivalent to the `identifier` case above. However, as that URI was not declared as a persistent identifier, the timestamp property [sdDatePublished] SHOULD be included to indicate when the absolute URL was accessed.
2. If B's _RO-Crate Metadata Document_ was located on the Web, but uses a relative URI reference for its root data entity (`./`), then its absolute URI can be determined from the [RFC 3986] algorithm for [establishing a base URI](https://datatracker.ietf.org/doc/html/rfc3986#section-5). For example, if root `{"@id": "./" }` is in metadata document `http://example.com/another-crate/ro-crate-metadata.json`, then the absolute URI for the `Dataset` entity is `http://example.com/another-crate/` (with the trailing `/`). If that URI is resolvable as in point 1, it can be used as equivalent `@id`. It is NOT RECOMMENDED to resolve a relative root identifier if the metadata document was retrieved from a URI that does not end with `/ro-crate-metadata.json` or `/ro-crate-metadata.jsonld` -- these are not part of a valid [attached](structure.html#attached-ro-crate-package) or [Detached RO-Crate Pacakge](structure.html#detached-ro-crate-package).
4. If RO-Crate B is not on the Web, and does not have a persistent identifier, e.g. is within a ZIP file or local file system, then a non-resolvable identifier could be established. See appendix [Establishing a base URI inside a ZIP file](appendix/relative-uris.html#establishing-a-base-uri-inside-a-zip-file), e.g. `arcp://uuid,b7749d0b-0e47-5fc4-999d-f154abe68065/` if using a randomly generated UUID. This method may also be used if the above steps fail for an RO-Crate Metadata Document that is on the Web. In this case, the referenced RO-Crate entity MUST either declare a [referenced metadata document](#referencing-another-metadata-document) or [distribution](#downloadable-dataset).

If the RO-Crate Metadata Document is not available as a web resource, but only within an archive (e.g. ZIP), then instead reference it as a [Downloadable dataset](#downloadable-dataset).

### Referencing another metadata document

If a referenced RO-Crate Metadata Document is known at a given URI or path, but its corresponding RO-Crate identifier can't be determined as above (e.g. [Retrieving an RO-Crate](#retrieving-an-ro-crate) fails or requires heuristics), then a referenced metadata descriptor entity SHOULD be added. For instance, if `http://example.com/another-crate/ro-crate-metadata.json` resolves to an RO-Crate Metadata Document describing root `./`, but `http://example.com/another-crate/` always returns a HTML page without [Signposting] to the metadata document, then `subjectOf` SHOULD be added to an explicit metadata descriptor entity, which has `encodingFormat` declared for JSON-LD:

```json
{
  "@id": "http://example.com/another-crate/",
  "@type": "Dataset",
  "conformsTo": { "@id": "https://w3id.org/ro/crate" },
  "subjectOf": { "@id": "http://example.com/another-crate/ro-crate-metadata.json" }
},
{
  "@id": "http://example.com/another-crate/ro-crate-metadata.json",
  "@type": "CreativeWork",
  "encodingFormat": "application/ld+json",
  "sdDatePublished": "2024-08-22T23:57:03+01:00"
}
```

{% include callout.html type="tip" content="Counter to [file format profile](data-entities.html#file-format-profiles) recommendations, the referenced RO-Crate metadata descriptor SHOULD NOT include its own `conformsTo` declarations to `https://w3id.org/ro/crate` or reference the dataset with `about`; this is to avoid confusion with the referencing RO-Crate's own [metadata descriptor](root-data-entity#ro-crate-metadata-descriptor). " %}


### Profiles of referenced crates

If the referenced crate conforms to a given [RO-Crate profile](profiles), this MAY be indicated by expanding `conformsTo` on the `Dataset` to an array to reference the profile as an contextual entity:

```json
{
  "@id": "https://doi.org/10.48546/workflowhub.workflow.26.1",
  "@type": "Dataset",
  "conformsTo": [
    { "@id": "https://w3id.org/ro/crate" },
    { "@id": "https://w3id.org/workflowhub/workflow-ro-crate/1.0"}
  ]
},
{ "@id": "https://w3id.org/workflowhub/workflow-ro-crate/1.0",
  "@type": ["CreativeWork", "Profile"],
  "name": "Workflow RO-Crate Profile",
  "version": "1.0"
}
```

{% include callout.html type="note" content="The profile declaration of a referenced crate is a hint. Consumers should check `conformsTo` as declared in the retrieved RO-Crate, as it may have been updated after this RO-Crate." %}

### Retrieving an RO-Crate

To resolve a reference to an RO-Crate, but where `subjectOf` or `distribution` is unknown (e.g. an RO-Crate is cited from a journal article), the below approach is recommended to retrieve its [RO-Crate Metadata Document](structure#ro-crate-metadata-document-ro-crate-metadatajson):

1. Assuming the URI is a permalink,  after following HTTP redirects without content negotiation, try [Signposting] to look for `Link` headers that reference `Link rel="describedby"` for an _RO-Crate Metadata Document_, or `Link rel="item"` for a distribution archive -- in either case prefer a link with `profile="https://w3id.org/ro/crate"` declared. For example, signposting for `https://doi.org/10.48546/workflowhub.workflow.120.5` leads to the archive `https://workflowhub.eu/workflows/120/ro_crate?version=5` as:
  
    ```
    curl --location --head https://doi.org/10.48546/workflowhub.workflow.120.5

    HTTP/2 302
    Location: https://workflowhub.eu/workflows/120?version=5

    HTTP/2 200
    Content-Type: text/html; charset=UTF-8
    Link: <https://workflowhub.eu/workflows/120/ro_crate?version=5> ;
          rel="item" ; type="application/zip" ;
          profile="https://w3id.org/ro/crate"
    ```
2. [HTTP Content-negotiation] for the [RO-Crate media type](appendix/jsonld#ro-crate-json-ld-media-type), for example:  

    Requesting `https://w3id.org/workflowhub/workflow-ro-crate/1.0` with HTTP header
    `Accept: application/ld+json;profile=https://w3id.org/ro/crate` redirects to the _RO-Crate Metadata file_
    `https://about.workflowhub.eu/Workflow-RO-Crate/1.0/ro-crate-metadata.json`

3. The above approaches may fail or return a HTML page, e.g. for content-delivery networks that do not support content-negotiation. 
4. An optional heuristic fallback is to try resolving the path `./ro-crate-metadata.json` from the _resolved_ URI (after permalink redirects). For example:  
If permalink `https://w3id.org/workflowhub/workflow-ro-crate/1.0` redirects to `https://about.workflowhub.eu/Workflow-RO-Crate/1.0/index.html` (a HTML page), then
try retrieving `https://about.workflowhub.eu/Workflow-RO-Crate/1.0/ro-crate-metadata.json`. 
5. If the retrieved resource is a ZIP file (`Content-Type: application/zip`), then extract `ro-crate-metadata.json`, or, if the archive root only contains a single folder (e.g. `folder1/`), extract `folder1/ro-crate-metadata.json`
6. If the retrieved resource is a [BagIt archive](appendix/implementation-notes#combining-with-other-packaging-schemes), e.g. containing a single folder `folder1` with `folder1/bagit.txt`, then extract and verify BagIt checksums before returning the bag's `data/ro-crate-metadata.json`
7. If the returned/extracted document is valid JSON-LD and has a [root data entity](root-data-entity#finding-the-root-data-entity), this is the RO-Crate Metadata File.

{% include callout.html type="tip" content="Some PID providers such as DataCite may respond to content-negotiation and provide their own JSON-LD, which do not describe an RO-Crate (the `profile=` was ignored). The use of Signposting allows the repository to explicitly provide the RO-Crate." %}


{% include references.liquid %}
