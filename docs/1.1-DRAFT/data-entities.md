---
layout: default
title: Data Entities
excerpt: |
  ..
sort: 7
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
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [
    {
      "@type": "CreativeWork",
      "@id": "ro-crate-metadata.json",
      "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
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
      "contentSize": "383766",
      "description": "Illustrator file for Glop Pot",
      "encodingFormat": "application/pdf"
    },
    {
      "@id": "lots_of_little_files/",
      "@type": "Dataset",
      "description": "This directory contains many small files, that we're not going to describe in detail.",
      "name": "Too many files"
    }
  ]
}
```

### Adding detailed descriptions of encodings

The above example provides a media type for the file `cp7glop.ai` - which is
useful as it may not be apparent that the file readable as a PDF file from the
extension. To add more detail, encodings SHOULD be linked using a [PRONOM]
identifier to a _Contextual Entity_ of `@type` Website.

``` json
  {
    "@id": "cp7glop.ai",
    "@type": "File",
    "contentSize": "383766",
    "description": "Illustrator file for Glop Pot",
    "encodingFormat": ["application/pdf", {"@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/19"}]
  },
  {
    "@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/19",
    "name": "Acrobat PDF 1.5 - Portable Document Format",
    "@type": "Website"
  }

```

If there is no PRONOM identifier, then a contextual entity with a URL as an `@id` MAY be used:

For example:

```json
 {
    "@id": "1st-tool.cwl",
    "@type": "File",
    "contentSize": "120",
    "description": "An example Common Workflow Language File",
    "encodingFormat": ["text/plain", {"@id": "https://www.commonwl.org/v1.0/Workflow.html"}]
  },
    {
    "@id": "https://www.commonwl.org/v1.0/Workflow.html",
    "name": "Common Workflow Language (CWL) Workflow Description, v1.0.2",
    "@type": "Website"
  }
```

If there is no web-accessible description for a file format it SHOULD be described locally in the dataset, for example in a file:

```json
 {
    "@id": "some-file.some_extension",
    "@type": "File",
    "contentSize": "120",
    "description": "A file in a non-standard format",
    "encodingFormat": ["text/plain", {"@id": "https://www.commonwl.org/v1.0/Workflow.html"}]
  },
  {
    "@id": "some_extension.md",
    "encodingFormat": "text/markdown",
    "name": "Description of some_extension file format",
    "@type": ["File", "CreativeWork"]
  }
```

## Core Metadata for Data Entities

The table below outlines the properties that Data Entities, when present, MUST have to be minimally valid.

### Encoding file paths

Note that all `@id` [identifiers must be valid URI references](appendix/jsonld.html#describing-entities-in-json-ld), care must be taken to express any relative paths using `/` separator, correct casing, and escape special characters like space (`%20`) and percent (`%25`), for instance a _File Data Entity_ from the Windows path `Results and Diagrams\almost-50%.png` becomes `"@id": "Results%20and%20Diagrams/almost-50%25.png"` in the _RO-Crate JSON-LD_.
 
In this document the term _URI_ includes international *IRI*s; the _RO-Crate Metadata File_ is always UTF-8 and international characters in identifiers SHOULD be written using native UTF-8 characters (*IRI*s), however traditional URL encoding of Unicode characters with `%` MAY appear in `@id` strings. Example: `"@id": "面试.mp4"` is preferred over the equivalent `"@id": "%E9%9D%A2%E8%AF%95.mp4"`

### File Data Entity

A `File` _Data Entity_ MUST have the following properties:

*  `@type`: MUST be `File`, or an array where `File` is one of the values.
*  `@id` MUST be either a _URI Path_ relative to the _RO Crate root_, or an absolute URI.

### Directory File Entity

A `Dataset` (directory) _Data Entity_ MUST have the following properties:

*  `@type` MUST be `Dataset` or an array where `Dataset` is one of the values.
*  `@id`  MUST be either an a _URI Path_ relative to the _RO Crate root_, or an absolute URI. The id SHOULD end with `/`

## Web-based Data Entities

While one use-case of RO-Crates is to describe _files_ contained within the _RO-Crate root_ directory, RO-Crates can also gather resources on the web, identified using _absolute URIs_ instead of relative _URI paths_.

Using Web-based data entities can be important particularly where a file can't be included in the _RO-Crate root_ because of licensing concerns, large data sizes, privacy, or where it is desirable to link to the latest online version.

Example of an RO-Crate where some of the _File Data Entities_ are external to the _RO-Crate root_:

```json
{ "@context": "https://w3id.org/ro/crate/1.1-DRAFT/context",
  "@graph": [
    {
        "@type": "CreativeWork",
        "@id": "ro-crate-metadata.json",
        "conformsTo": {"@id": "https://w3id.org/ro/crate/1.1-DRAFT"},
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
    "contentSize": "26452",
    "description": "Survey responses",
    "encodingFormat": "text/csv"
  },
  {
    "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf",
    "@type": "File",
    "contentSize": "310691",
    "description": "RO-Crate specification",
    "encodingFormat": "application/pdf"
  }
]
}
```

Additional care SHOULD be taken to improve persistence and longevity of web resources included 
in an RO-Crate, as they can be more difficult to archive or move along with the _RO-Crate root_, and
may change intentionally or unintentionally leaving the RO-Crate with partial or outdated information.

File Data Entries with an `@id` URI outside the _RO-Crate Root_ SHOULD at the time of RO-Crate creation be directly downloadable by a simple retrieval (e.g. HTTP GET), permitting redirections and HTTP authentication. For instance in the example above, <https://zenodo.org/record/3541888> and <https://doi.org/10.5281/zenodo.3541888> cannot be used as `@id` above as retrieving these URLS give a HTML landing page rather than the desired PDF as indicated by `encodingFormat`.

A files on the web may change, the timestamp property `sdDatePublished` SHOULD be included to indicate when the absolute URL was accessed, and derived metadata like `encodingFormat` and `contentSize` was considered to be representative:

```json
  {
    "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf",
    "@type": "File",
    "contentSize": "310691",
    "encodingFormat": "application/pdf",
    "sdDatePublished": "2020-04-09T13:09:21+01:00Z"
  }
```

### Embedded data entities that are also on the web

File Data Entities may already have a corresponding web presence, for instance a landing page that describes the file, including persistent identifiers (e.g. DOI) that goes to an intermediate HTML page instead of the downloadable file directly. 

These can be included for File Data Entities as additional metadata, regardless of if the File is included in the _RO-Crate Root_ directory or exists on the Web, by using properties:

* `identifier` for formal identifier string such as DOIs
* `url` with a string URL for a *download* link (if not available, a download landing page) for this file
* `subjectOf` to a `CreativeWork` (or `WebPage`) that mentions this file or its content (but also other resources).
* `mainEntityOfPage` to a `CreativeWork`  (or `WebPage`) that primarily describes this file (or its content) 

```json
  {
    "@id": "survey-responses-2019.csv",
    "@type": "File",
    "encodingFormat": "text/csv",
    "url": "http://example.com/downloads/2019/survey-responses-2019.csv",
    "subjectOf": {"@id": "http://example.com/reports/2019/annual-survey.html"}
  },
  {
    "@id": "https://zenodo.org/record/3541888/files/ro-crate-1.0.0.pdf",
    "@type": "File",
    "encodingFormat": "application/pdf",
    "identifier": "https://doi.org/10.5281/zenodo.3541888",
    "url": "https://zenodo.org/record/3541888"
  }
```

### Directories on the web; dataset distributions

A _Directory File Entry_ or `Dataset` identifier by an absolute URL on the web can be harder to download than a `File` because it consists of multiple resources. It is RECOMMENDED that such directories have a complete listing of their content in `hasPart`, enabling download traversal.

Alternatively a common mechanism to provide downloads of a reasonably sized directory is as an archive file in formats like `.zip` or `.tar.gz`, described as a [DataDownload]. 

```json
  {
      "@id": "lots_of_little_files/",
      "@type": "Dataset",
      "description": "This directory contains many small files, that we're not going to describe in detail.",
      "name": "Too many files",
      "distribution": {"@id": "http://example.com/downloads/2020/lots_of_little_files.zip"}
  },
  {
    "@id": "http://example.com/downloads/2020/lots_of_little_files.zip",
    "@type": "DataDownload",
    "encodingFormat": "application/zip",
    "contentSize": "82818928"
  }
```

Similarly, the _RO-Crate root_ entity may also provide a `distribution` URL, in which case the download SHOULD be an archive that contain the _RO-Crate Metadata file_.

In all cases, consumers should be aware that a `DataDownload` is a snapshot that may not be reflecting the current state of the `Dataset` or RO-Crate.



<!--  Below are reference links not rendered in HTML, see
https://kramdown.gettalong.org/syntax.html#reference-links
-->

[BagIt]: https://en.wikipedia.org/wiki/BagIt
[BagIt profile]: https://github.com/ruebot/bagit-profiles
[BIBO]: http://purl.org/ontology/bibo/interviewee
[conformsTo]: http://purl.org/dc/terms/conformsTo
[CURIE]: https://www.w3.org/TR/curie/
[DataCite]: https://www.datacite.org/
[DataCite Schema v4.0]: https://schema.datacite.org/meta/kernel-4.0/metadata.xsd
[DCAT]: https://www.w3.org/TR/vocab-dcat/
[Exif]: https://en.wikipedia.org/wiki/Exif
[Flattened Document Form]: https://json-ld.org/spec/latest/json-ld/#flattened-document-form
[FRAPO]: https://www.sparontologies.net/ontologies/frapo
[geonames]: https://www.geonames.org
[git]: https://git-scm.com/
[hasFile]: https://pcdm.org/2016/04/18/models#hasFile
[hasMember]: https://pcdm.org/2016/04/18/models#hasMember
[isOutputOf]: https://sparontologies.github.io/frapo/current/frapo.html#d4e526
[JSON]: http://json.org/
[JSON-LD]: https://json-ld.org/
[linked data]: https://en.wikipedia.org/wiki/Linked_data
[OCFL]: https://ocfl.io/
[OCFL Object]: https://ocfl.io/1.0/spec/#object-spec
[ORCID]: https://orcid.org
[Pairtree]: https://confluence.ucop.edu/display/Curation/PairTree
[Pairtree specification]: https://confluence.ucop.edu/display/Curation/PairTree?preview=/14254128/16973838/PairtreeSpec.pdf
[PCDM]: https://github.com/duraspace/pcdm/wiki
[Pronom]: https://www.nationalarchives.gov.uk/PRONOM/Default.aspx
[RepositoryCollection]: https://pcdm.org/2016/04/18/models#Collection
[RepositoryObject]: https://pcdm.org/2016/04/18/models#Object
[ResearchObject]: https://www.researchobject.org/
[schema.org]: http://schema.org
[WorkflowSketch]: http://wf4ever.github.io/ro/2016-01-28/roterms/#Sketch

[Action]: http://schema.org/Action
[ActionStatusType]: http://schema.org/ActionStatusType
[ActiveActionStatus]: http://schema.org/ActiveActionStatus
[CompletedActionStatus]: http://schema.org/CompletedActionStatus
[ComputerLanguage]: http://schema.org/ComputerLanguage
[CreateAction]: http://schema.org/CreateAction
[CreativeWork]: http://schema.org/CreativeWork
[DataDownload]: http://schema.org/DataDownload
[Dataset]: http://schema.org/Dataset
[FailedActionStatus]: http://schema.org/FailedActionStatus
[File]: http://schema.org/MediaObject
[Journal]: http://schema.org/Periodical
[GeoCoordinates]: http://schema.org/GeoCoordinates
[ImageObject]: http://schema.org/ImageObject
[MediaObject]: http://schema.org/MediaObject
[Organization]: http://schema.org/Organization
[Person]: http://schema.org/Person
[PotentialActionStatus]: http://schema.org/PotentialActionStatus
[Place]: http://schema.org/Place
[Product]: http://schema.org/Product
[PropertyValue]: http://schema.org/PropertyValue
[ScholarlyArticle]: http://schema.org/ScholarlyArticle
[SoftwareApplication]: http://schema.org/SoftwareApplication
[SoftwareSourceCode]: http://schema.org/SoftwareSourceCode
[UpdateAction]: http://schema.org/UpdateAction

[about]: http://schema.org/about
[accountablePerson]: http://schema.org/accountablePerson
[actionStatus]: http://schema.org/actionStatus
[additionalType]: http://schema.org/additionalType
[affiliation]: http://schema.org/affiliation
[agent]: http://schema.org/agent
[alternateName]: http://schema.org/alternateName
[author]: http://schema.org/author
[citation]: http://schema.org/citation
[contact]: http://schema.org/accountablePerson
[contactPoint]: http://schema.org/contactPoint
[contactType]: http://schema.org/contactType
[contentLocation]: http://schema.org/contentLocation
[contributor]: http://schema.org/contributor
[copyrightHolder]: http://schema.org/copyrightHolder
[creator]: http://schema.org/creator
[dateCreated]: http://schema.org/dateCreated
[datePublished]: http://schema.org/datePublished
[defaultValue]: http://schema.org/defaultValue
[description]: http://schema.org/description
[distribution]: http://schema.org/distribution
[email]: http://schema.org/email
[encodingFormat]: http://schema.org/encodingFormat
[endTime]: http://schema.org/endTime
[error]: http://schema.org/error
[event]: http://schema.org/event
[familyName]: http://schema.org/familyName
[funder]: http://schema.org/funder
[geo]: http://schema.org/geo
[givenName]: http://schema.org/givenName
[hasPart]: http://schema.org/hasPart
[identifier]: http://schema.org/identifier
[IndividualProduct]: http://schema.org/IndividualProduct
[instrument]: http://schema.org/instrument
[keywords]: http://schema.org/keywords
[license]: http://schema.org/license
[memberOf]: http://schema.org/memberOf
[name]: http://schema.org/name
[object]: http://schema.org/object
[phone]: http://schema.org/phone
[programmingLanguage]: http://schema.org/programmingLanguage
[publisher]: http://schema.org/publisher
[relatedItem]: http://schema.org/relatedItem
[result]: http://schema.org/result
[sameAs]: http://schema.org/sameAs
[sdLicense]: http://schema.org/sdLicense
[sdPublisher]: http://schema.org/sdPublisher
[startTime]: http://schema.org/startTime
[temporalCoverage]: http://schema.org/temporalCoverage
[thumbnail]: http://schema.org/thumbnail
[translationOf]: http://schema.org/translationOf
[translator]: http://schema.org/translator
[url]: http://schema.org/url
[valueRequired]: http://schema.org/valueRequired
[version]: http://schema.org/version

[RFC 2119]: https://tools.ietf.org/html/rfc2119
[RFC 3986]: https://tools.ietf.org/html/rfc3986
[RFC 6838]: https://tools.ietf.org/html/rfc6838
[RFC 7159]: https://tools.ietf.org/html/rfc7159
[RFC 8493]: https://tools.ietf.org/html/rfc8493
