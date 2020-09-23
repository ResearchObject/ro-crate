---
layout: default
title: Implementation notes
excerpt: 
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

# Implementation notes

## Programming with JSON-LD

When implementing tools to work with RO-Crate it is not necessary to use JSON-LD
software libraries, however, programmers should keep in mind the following:

-  _RO-Crate JSON-lD_ has a flat structure; every item is in a list in the `@graph` in the _RO-Crate Metadata File_. A useful strategy when processing a crate is to build a look-up table and/or function so that items can be found via their ID, for example provide a method such as `getItem(id)` which returns an item by its id or a null value if it's not there.

- Code defensively. Code should not assume that values will always be a String; values for properties may be single scalar values such as strings or integers (`"2"` or 2), or references to other items such as `{"@id", "_:1"}` (where the referenced item may or may not be in the crate, see the point above about having a `getItem()` method).

- Read the *whole* specification. In order to make the RO-Crate specification
  readable it deals with common use cases on a case by case basis, introducing
  aspects of the specification as well. Some key points, such as "items may have
  more than one value for @type" may not be apparent from a quick reading.


## Combining with other packaging schemes

RO-Crates may co-exist with other packaging schemes, such as [BagIt] using two
general approaches; either (a) _adding_ RO-Crate into a package as part of the payload
or (b) _wrapping_ another kind of package. Examples using BagIt follow.

BagIt is described in [RFC 8493]:

> [BagIt is] ... a set of hierarchical file layout conventions
> for storage and transfer of arbitrary digital content. A "bag" has just enough
> structure to enclose descriptive metadata "tags" and a file "payload" but does
> not require knowledge of the payload's internal semantics. This BagIt format
> is suitable for reliable storage and transfer.

BagIt and RO-Crate have largely separate concerns - RO-Crate is focussed on rich
metadata, the semantics of data, while BagIt is about reliable transfer.

### Example of adding RO-Crate to Bagit

RO-Crate can be combined with BagIt simply by placing the RO-Crate files in the BagIt
payload (`data/`) directory.

```
<RO-Crate root directory>/
  |   bagit.txt                 # As per BagIt specification
  |   bag-info.txt              # As per BagIt specification
  |   manifest-<algorithm>.txt  # As per BagIt specification
  |   fetch.txt                 # Optional, per BagIt Specification
  |   data/
      |   ro-crate-metadata.json  # RO-Crate Metadata File MUST be present
      |   ro-crate-preview.html     # RO-Crate Website homepage MAY be present
      |   ro-crate-preview_files/   # MAY be present
      |     [payload files and directories]  # 1 or more SHOULD be present
```

**Base URI**: The arcp specification suggests how [BagIt UUID identifiers](https://tools.ietf.org/html/draft-soilandreyes-arcp-03#appendix-A.4) can be used to calculate the base URI of a bag, see section [Establishing a base URI inside a ZIP file](#establishing-a-base-uri-inside-a-zip-file).  For this purpose it is RECOMMENDED that `bag-info.txt` includes a fresh UUID like:

    External-Identifier: urn:uuid:24e51ca2-5067-4598-935a-dac4e327d05a


### Example of wrapping a BagIt bag in an RO-Crate

Alternatively, an RO-Crate can _wrap_ a BagIt bag, so that the RO-Crate metadata
is outside of the bag directory and can be changed without changing the payload's checksums. 

```
<RO-Crate root directory>/
  |   ro-crate-metadata.json  # RO-Crate Metadata File MUST be present
  |   ro-crate-preview.html     # RO-Crate Website homepage MAY be present
  |   ro-crate-preview_files/   # MAY be present
  |   bag/                      # "Wrapped" bag - could have any name
  |      bagit.txt                 # As per BagIt specification
  |      bag-info.txt              # As per BagIt specification
  |      manifest-<algorithm>.txt  # As per BagIt specification
  |      fetch.txt                 # Optional, per BagIt Specification
  |      data/
  |         [payload files and directories]  # 1 or more SHOULD be present
  |          example.txt 
```

A [Data Entity](../data-entities.md) describing `example.txt` in this scenario would have an `@id` of `bag/data/example.txt`:

```json
{
  "@id": "bag/data/example.txt",
  "name": "Example file"
}
```


## Repository-specific identifiers

_Root Data Entities_ MAY also have additional repository specific identifiers, described using [Contextual Entities](../contextual-entities.md) using a [PropertyValue], with a [name] that identifies the repository and the [identifier] as a value. The _same_ identifier MAY be used in multiple different repositories and effectively namespaced using the `name` of the `ProperyValue`.

```json
{
  "@id": "./",
  "@type": "Dataset",
  "identifier": ["https://doi.org/10.4225/59/59672c09f4a4b", {"@id": "_:localid:my-repo:my-id"}, {"@id": "_:localid:other-repo:https://doi.org/10.4225/59/59672c09f4a4b"}]
}

 {
   "@id": "_:localid:my-repo:my-id",
   "@type": "PropertyValue",
   "name": "my-repo",
   "value": "my-id"
 }

  {
   "@id": "_:localid:other-repo:https://doi.org/10.4225/59/59672c09f4a4b",
   "@type": "PropertyValue",
   "name": "other-repo",
   "value": "https://doi.org/10.4225/59/59672c09f4a4b"
 }
```


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
