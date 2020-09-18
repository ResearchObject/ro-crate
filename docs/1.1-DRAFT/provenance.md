---
layout: default
title: Provenance of entities
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


# Detailing provenance of entities


## Equipment used to create files

To specify which equipment was used to create or update a _Data Entity_, the _RO-Crate_ JSON-LD SHOULD have a _Context Entity_ for each item of equipment which SHOULD be of `@type` [IndividualProduct]. The entity SHOULD have a serial number, manufacturer that identifies it as completely as possible. In this case the equipment is a bespoke machine. The equipment SHOULD be described on a web page, and the address of the description SHOULD be used as its `@id`.


```json
{
  "@id": "https://confluence.csiro.au/display/ASL/Hovermap",
  "@type": "IndividualProduct",
  "description": "The CSIRO bentwing is an unmanned aerial vehicle (UAV, commonly known as a drone) with a LIDAR ... ",
  "identifier": "https://confluence.csiro.au/display/ASL/Hovermap",
  "name": "Bentwing"
}
```


Uses [CreateAction] and [UpdateAction] class to model the contributions of _Context Entities_ of type [Person] or [Organization] in the creation of files.

In this example the CreateAction has a human [agent], the object is a Place (a cave) and the Hovermap drone is the [instrument] used in the file creation event.


```json
{
      "@id": "#DataCapture_wcc02",
      "@type": "CreateAction",
      "agent": {
        "@id": "https://orcid.org/0000-0002-1672-552X"
      },
      "instrument": {
        "@id": "https://confluence.csiro.au/display/ASL/Hovermap"
      },
      "object": {
        "@id": "#victoria_arch"
      },
      "result": [
        {
          "@id": "wcc02_arch.laz"
        },
        {
          "@id": "wcc02_arch_traj.txt"
        }
      ]
    },
  {
      "@id": "#victoria_arch",
      "@type": "Place",
      "address": "Wombeyan Caves, NSW 2580",
      "name": "Victoria Arch"
  }
```




## Software used to create files

To specify which software was used to create or update a file the software application SHOULD be represented with an entity of type [SoftwareApplication], with a [version] property, e.g. from `tool --version`.

For example:

```json
{
      "@id": "https://www.imagemagick.org/",
      "@type": "SoftwareApplication",
      "url": "https://www.imagemagick.org/",
      "name": "ImageMagick",
      "version": "ImageMagick 6.9.7-4 Q16 x86_64 20170114 http://www.imagemagick.org"
}
```

The software SHOULD be associated with the [File] it created using a [CreateAction] with the [File] referenced by a [result] property. Any input files SHOULD be referenced by the [object] property.

In the below example, an image with the `@id` of `pics/2017-06-11%2012.56.14.jpg` was transformed into an new image `pics/sepia_fence.jpg` using the _ImageMagick_ software application. Actions MAY have human-readable names, which MAY be machine generated for use at scale.

```json
{
      "@id": "#Photo_Capture_1",
      "@type": "CreateAction",
      "agent": {
        "@id": "https://orcid.org/0000-0002-3545-944X"
      },
      "description": "Photo snapped on a photo walk on a misty day",
      "endTime": "2017-06-11T12:56:14+10:00",
      "instrument": [
        {
          "@id": "#EPL1"
        },
        {
          "@id": "#Panny20mm"
        }
      ],
      "result": {
        "@id": "pics/2017-06-11%2012.56.14.jpg"
      }
    },
    {
      "@id": "#SepiaConversion_1",
      "@type": "CreateAction",
      "name": "Convert dog image to sepia",
      "description": "convert -sepia-tone 80% test_data/sample/pics/2017-06-11\\ 12.56.14.jpg test_data/sample/pics/sepia_fence.jpg",
      "endTime": "2018-09-19T17:01:07+10:00",
      "instrument": {
        "@id": "https://www.imagemagick.org/"
      },
      "object": {
        "@id": "pics/2017-06-11%2012.56.14.jpg"
      },
      "result": {
        "@id": "pics/sepia_fence.jpg"
      }
    },
```

Note the use of double escape `\\` so that JSON preserves the `\` character from the command line.

## Recording changes to RO-Crates

To record an action which changes the DataSet's metadata, or changes its state in a publication or other workflow, a [CreateAction] or [UpdateAction] SHOULD be associated with a _Data Entity_.

A curation Action MUST have at least one [object] which associates it with either the DataSet or one of its components.

An Action which creates new _Data entities_ - for example, the creation of a new metadata file - SHOULD have these as [result]s.

An Action SHOULD have a [name] and MAY have a [description].

An Action SHOULD have an [endTime], which MUST be in ISO 8601 date format and SHOULD be specified to at least the precision of a day. An Action MAY have a [startTime] meeting the same specifications.

An Action SHOULD have a human [agent] who was responsible for authorizing the action, and MAY have an [instrument] which associates the action with a particular piece of software (for example, the content management system or data catalogue through which an update was approved) which SHOULD be of `@type` SoftwareApplication.

An Action's status MAY be recorded in an [actionStatus] property. The status must be one of the values enumerated by [ActionStatusType]: [ActiveActionStatus], [CompletedActionStatus], [FailedActionStatus] or [PotentialActionStatus].

An Action which has failed MAY record any error information in an [error](http://schema.org/error) property.

[UpdateAction] SHOULD only be used for actions which affect the DataSet as a whole, such as movement through a workflow.

To record curation actions which modify a [File] within a DataSet - for example, by correcting or enhancing metadata - the old version of the [File] SHOULD be retained, and a [CreateAction] added which has the original version as its [object] and the new version as its [result].

```json
{
    "@id": "#history-01",
    "@type": "CreateAction",
    "object": { "@id": "https://doi.org/10.5281/zenodo.1009240" },
    "name": "RO-Crate created",
    "endTime": "2018-08-31",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus":  { "@id": "http://schema.org/CompletedActionStatus" }
},

{
    "@id": "#history-02",
    "@type": "UpdateAction",
    "object": { "@id": "https://doi.org/10.5281/zenodo.1009240" },
    "name": "RO-Crate published",
    "endTime": "2018-09-10",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus":  {"@id":" http://schema.org/CompletedActionStatus" }
},

{ 
    "@id": "#history-03",
    "@type": "CreateAction",
    "object": { "@id": "metadata.xml.v0.1" },
    "result": { "@id": "metadata.xml" },
    "name": "metadata update",
    "endTime": "2018-09-12",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus": { "@id": "http://schema.org/CompletedActionStatus" }
},

{
    "@id": "#history-04",
    "@type": "UpdateAction",
    "object": { "@id": "https://doi.org/10.5281/zenodo.1009240" },
    "name": "RO-Crate published",
    "endTime": "2018-09-13",
    "agent": { "@id": "https://orcid.org/0000-0001-5152-5307" },
    "instrument": { "@id": "https://stash.research.uts.edu.au" },
    "actionStatus": { "@id": "http://schema.org/FailedActionStatus" },
    "error": "Record is already published"
},


{
    "@id": "https://stash.research.uts.edu.au",
    "@type": "IndividualProduct",
    "name": "Stash",
    "description": "UTS Research Data Catalogue",
    "identifier": "https://stash.research.uts.edu.au"
}
```




## Digital Library and Repository content

To describe an export from a Digital Library or repository system, RO-Crate uses the _Portland Common Data Model_ ([PCDM]). A _Contextual Entity_ from a repository, representing an abstract entity such as a person, or a work, or a place SHOULD have a`@type` of [RepositoryObject](https://pcdm.org/2016/04/18/models#Object), in addition to any other types. Objects MAY be grouped together in [RepositoryCollection](https://pcdm.org/2016/04/18/models#Collection)s with [hasMember] pointing to the the [RepositoryObject](https://pcdm.org/2016/04/18/models#Object). The keys RepositoryObject and RepositoryCollection were chosen to avoid collision between the terms Collection and Object with other vocabularies.

NOTE: PCDM specifies that Files should have only technical metadata, not descriptive metadata, which is _not_ a restriction in RO-Crate. If the RO-Crate is to be imported into a strict PCDM repository, modeling of object/file relationships will be necessary.

For example, this data is exported from an [Omeka](https://omeka.org) repository:


```json
{
   "@id": "https://omeka.uws.edu.au/farmstofreeways/api/collections/6",
   "@type": "RepositoryCollection",
   "title":  "Project Materials",   
   "description": [
      "Materials associated with the project, including fliers seeking participants, lists of sources and question outline.   "
   ],
   "publisher": {"@id": "University of Western Sydney"},
   "rights": "Copyright University of Western Sydney 2015",
   "hasMember": [
      {
         "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/166"
      },
      {
         "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/167"
      },
      {
         "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/168"
      },
      {
         "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/169"
      }
   ]
},
{
   "@id": "https://omeka.uws.edu.au/farmstofreeways/api/items/166",
   "@type": "RepositoryObject",
   "title": [
      "Western Sydney Women's Oral History Project: Flier (illustrated)"
   ],
   "description": [
      "Flier (illustrated) seeking participants for the project."
   ],
   "publisher": { "@id": "https://westernsydney.edu.au"},
   "rights": "Copyright University of Western Sydney 2015",
   "originalFormat": "Paper",
   "identifier": "FTF_flier_illust"
   ],
   "rightsHolder": [
      "Western Sydney University"
   ],
   "license": { 
     "@id": "https://creativecommons.org/licenses/by/3.0/au/"
   },
   "hasFile": [
      {
         "@id": "content/166/original_eece70f73bf8979c0bcfb97065948531.pdf"
      },
     ...
   ]
},
{
   "@type": "File",
   "@id": "content/166/original_eece70f73bf8979c0bcfb97065948531.pdf"
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
[OCFL Object]: https://ocfl.io/0.3/spec/#object-spec
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
