---
page_id: paradisec
redirect_from:
    - /in-use/paradisec
title: "PARADISEC"
description:  Pacific and Regional Archive for Digital Sources in Endangered Cultures (PARADISEC) holds 16,100 hours of audio recordings and 2,800 hours of video recordings that might otherwise have been lost. These recordings are of performance, narrative, singing, and other oral tradition. This amounts to over 220 terabytes, and represents 1,370 languages, mainly from the Pacific region. 
url: https://www.paradisec.org.au/
domains: [language_text]
tasks: [data_handling]
roles: [information_architect, repository_manager]
---

# PARADISEC: Pacific and Regional Archive for Digital Sources in Endangered Cultures



## PARADISEC and the Language Data Commons of Australia

From 2022 - 2028 PARADISEC is working with the national project the [Language Data Commons of Australia  (LDACA)] to build accessible language material from Australia and the Pacific region. This work allows us to plan more digitisation projects and to add textual transcripts and summaries to audio items in the collection.

PARADISEC has an architecture which ensures that all data is stored in commodity storage with metadata adjacent to the files. This way of working has proved to be a low-cost and robust way to maintain an archive and this has been an inspiration for the [PILARS: Protocols for Implementing Long-term Archival Repository Services]. PARADISEC is currently undergoing an update where metadata is being migrated to RO-Crate which will be stored alongside materials.

PARADISEC uses the same API as the [Language Data Commons of Australia (LDACA)] which can serve RO-Crate.

[Language Data Commons of Australia  (LDACA)]: ldaca
[PILARS: Protocols for Implementing Long-term Archival Repository Services]: pilars


## Example Crate

``` 
{
  "@context": [
    "https://w3id.org/ro/crate/1.2/context",
    {
      "@vocab": "http://schema.org/"
    },
    "http://purl.archive.org/language-data-commons/context.json",
    {
      "Geometry": "http://www.opengis.net/ont/geosparql#Geometry",
      "asWKT": "http://www.opengis.net/ont/geosparql#asWKT"
    },
    "https://w3id.org/ldac/context"
  ],
  "@graph": [
    {
      "@id": "https://catalog.paradisec.org.au/repository/RL1/011",
      "@type": [
        "Data",
        "Object",
        "RepositoryObject"
      ],
      "conformsTo": {
        "@id": "https://w3id.org/ldac/profile#Object"
      },
      "additionalType": "item",
      "identifier": [
        {
          "@id": "#identifier_domain"
        },
        {
          "@id": "#identifier_id"
        },
        {
          "@id": "#identifier_itemIdentifier"
        },
        {
          "@id": "#identifier_doi"
        },
        {
          "@id": "#identifier_collectionIdentifier"
        }
      ],
      "name": "Singing and Enchanting, Conversations on Traditional tribal battles",
      "description": "Singing and enchanting by women and general conversations with group of men mainly on traditional feuds and tribal battles by warring groups.\r\n(Steven Gagau, May 2018)",
      "contentLocation": [
        {
          "@id": "#place-Kiriwina"
        }
      ],
      "dateCreated": "2018-05-09",
      "dateModified": "2019-11-20",
      "datePublished": "2019-11-20",
      "publisher": {
        "@id": "http://nla.gov.au/nla.party-811611"
      },
      "private": false,
      "inLanguage": [
        {
          "@id": "#language-kij"
        }
      ],
      "subjectLanguages": [
        {
          "@id": "#language-kij"
        }
      ],
      "countries": [
        {
          "@id": "#country-Papua New Guinea"
        }
      ],
      "license": {
        "@id": "#license-3"
      },
      "memberOf": {
        "@id": "https://catalog.paradisec.org.au/repository/RL1"
      },
      "bornDigital": false,
      "digitisedOn": "2018-04-27",
      "external": false,
      "languageAsGiven": "Kiriwina",
      "metadataExportable": true,
      "tapesReturned": false,
      "hasPart": [
        {
          "@id": "https://catalog.paradisec.org.au/repository/RL1/011/RL1-011-A.mp3"
        },
        {
          "@id": "https://catalog.paradisec.org.au/repository/RL1/011/RL1-011-A.wav"
        }
      ],
      "translator": [
        {
          "@id": "#person-4871"
        }
      ]
    },
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": {
        "@id": "https://w3id.org/ro/crate/1.2"
      },
      "about": {
        "@id": "https://catalog.paradisec.org.au/repository/RL1/011"
      }
    },
    {
      "@id": "http://nla.gov.au/nla.party-595489",
      "@type": "Organisation",
      "name": "Australian National University"
    },
    {
      "@id": "#identifier_domain",
      "@type": "PropertyValue",
      "name": "domain",
      "value": "paradisec.org.au"
    },
    {
      "@id": "#identifier_id",
      "@type": "PropertyValue",
      "name": "id",
      "value": "RL1-011"
    },
    {
      "@id": "#identifier_itemIdentifier",
      "@type": "PropertyValue",
      "name": "itemIdentifier",
      "value": "011"
    },
    {
      "@id": "#identifier_doi",
      "@type": "PropertyValue",
      "name": "doi",
      "value": "10.4225/72/5afda71574a1c"
    },
    {
      "@id": "#identifier_collectionIdentifier",
      "@type": "PropertyValue",
      "name": "collectionIdentifier",
      "value": "RL1"
    },
    {
      "@id": "#country-Papua New Guinea",
      "@type": "Country",
      "code": "PG",
      "name": "Papua New Guinea"
    },
    {
      "@id": "#license-3",
      "@type": "CreativeWork",
      "name": "Closed (subject to the access condition details)"
    },
    {
      "@id": "http://nla.gov.au/nla.party-811611",
      "@type": "Person",
      "familyName": "Lawton",
      "givenName": "Ralph",
      "name": "Ralph Lawton",
      "email": "ralph.lawton@anu.edu.au"
    },
    {
      "@id": "#person-4871",
      "@type": "Person",
      "familyName": "Hull",
      "givenName": "Grace",
      "name": "Grace Hull"
    },
    {
      "@id": "https://catalog.paradisec.org.au/repository/RL1/011/RL1-011-A.mp3",
      "@type": "File",
      "contentSize": 17315968,
      "dateCreated": "2018-05-11",
      "dateModified": "2018-05-18",
      "encodingFormat": "audio/mpeg",
      "name": "RL1-011-A.mp3",
      "doi": "10.4225/72/5afda751b05d1",
      "bitrate": 127718,
      "duration": 1084.63,
      "channels": 2,
      "sampleRate": 44100
    },
    {
      "@id": "https://catalog.paradisec.org.au/repository/RL1/011/RL1-011-A.wav",
      "@type": "File",
      "contentSize": 625002484,
      "dateCreated": "2018-05-11",
      "dateModified": "2018-05-18",
      "encodingFormat": "audio/vnd.wav",
      "name": "RL1-011-A.wav",
      "doi": "10.4225/72/5afda74dd11d2",
      "bitrate": 4609917,
      "duration": 1084.62,
      "channels": 2,
      "sampleRate": 96000
    },
    {
      "@id": "#geo-151.0,-8.6-151.2,-8.4",
      "@type": "Geometry",
      "asWKT": "POLYGON((151.0 -8.4, 151.2 -8.4, 151.2 -8.6, 151.0 -8.6, 151.0 -8.4))"
    },
    {
      "@id": "#geo-150.294,-8.879-151.2,-8.32",
      "@type": "Geometry",
      "asWKT": "POLYGON((150.294 -8.32, 151.2 -8.32, 151.2 -8.879, 150.294 -8.879, 150.294 -8.32))"
    },
    {
      "@id": "#place-Kiriwina",
      "@type": "Place",
      "geo": {
        "@id": "#geo-151.0,-8.6-151.2,-8.4"
      },
      "name": "Kiriwina"
    },
    {
      "@id": "#language-kij",
      "@type": "Language",
      "code": "kij",
      "location": {
        "@id": "#geo-150.294,-8.879-151.2,-8.32"
      },
      "name": "Kilivila"
    }
  ]
}

```
