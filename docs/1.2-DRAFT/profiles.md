---
title: Profiles
excerpt: |
  Profiles of RO-Crates and their entities can be used to specialize and recommend
  further which metadata types and properties are expected.
nav_order: 9
parent: RO-Crate 1.2-DRAFT 
---
    
While RO-Crates can be considered general-purpose containers of arbitrary data and open-ended metadata, in practical use within a particular domain, application or framework, it will be beneficial to further constrain RO-Crate to a specific **profile**: a set of conventions, types and properties that one minimally can require and expect to be present in that subset of RO-Crates.

Defining and conforming to such a profile enables reliable programmatic consumption of an RO-Crate’s content, as well as consistent creation, e.g. a form in a user interface form firmly suggest the required types and properties, and likewise a rendering of an RO-Crate can easier make rich UI components if it can reliably assume for instance that the [`Person`](contextual-entities.md#people) always has an `affiliation` to a [`Organization`](contextual-entities.md#organizations-as-values) which has a `url` - a restriction that may not be appropriate for all types of RO-Crates.

The RO-Crate profile can also lock down serialization expectation, for instance using a particular [version of RO-Crate](https://www.researchobject.org/ro-crate/specification.html), [JSON-LD context](appendix/jsonld.md?highlight=@context#ro-crate-json-ld-context) or particular [packaging](appendix/implementation-notes.md#combining-with-other-packaging-schemes) like .zip or BagIt.

## Declaring an RO-Crate profile

A profile can be defined informally or formally, may be declared by an RO-Crate 
in advance (explicit profile) or detected later (implicit profile). Profiles are identified 
with URIs, which SHOULD be a permalink.

<!--TODO: Could https://github.com/ResearchObject/ro-terms be used also for ad-hoc profiles? -->

To explicitly declare that an RO-Crate conforms to a particular profile, add another [contextual entity](contextual-entities.md):

```json
{
    "@id": "https://w3id.org/ro/curate/profile/cwl",
    "@type": "CreativeWork",
    "name": "Profile for Research Objects with CWL workflows"
}
```
<!-- FIXME: Above permalink is to a SHACL of Wf4Ever RO Bundle, not RO-Crate.
Make permalink for https://about.workflowhub.eu/Workflow-RO-Crate/ ? 
-->

Then expand the `conformsTo` declaration of the [metadata file descriptor](root-data-entity.md#ro-crate-metadata-file-descriptor) to be an array, adding the profile identifier:

```json
{
    "@type": "CreativeWork",
    "@id": "ro-crate-metadata.json",
    "about": {"@id": "./"},
    "conformsTo": [
        {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"},
        {"@id": "https://w3id.org/ro/curate/profile/cwl"}
    ]
}
```

An RO-Crate can conform to multiple profiles at the same time.   

## Which type of profile?

As a starting point, an RO-Crate profile can be written down in structured human language, as exemplified by [Workflow RO-Crate](https://about.workflowhub.eu/Workflow-RO-Crate/) or indeed by the RO-Crate specification itself.

For some uses of RO-Crate it may be beneficial to have a more **formal definition** of the profile, depending on the serialization requirements for the RO-Crate, and how open-ended or restricted the profile is intended to be.

Machine-readable profiles SHOULD have a [encodingFormat](data-entities.md#adding-detailed-descriptions-of-encodings) declared:

```json
{
    "@id": "https://w3id.org/ro/curate/profile/cwl",
    "@type": "CreativeWork",
    "name": "SHACL profile for Research Objects with CWL workflows",
    "encodingFormat": [
        "text/turtle",
        { "@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/874" }
    ]
},
{
    "@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/874",
    "@type": "WebSite",
    "name": "Turtle",
    "description": "Turtle (Terse RDF Triple Language) is a format for expressing data in the Resource Description Framework (RDF) data model.",
    "url": "https://www.w3.org/TR/turtle/"
}
```

Note here the use of the `url` field on the PRONOM file type to the W3C specification for the Turtle file format. Most structured formats for profiles will have a formal specification.

### Declaring an entity's profile

In some caes, the [encodingFormat](data-entities.md#adding-detailed-descriptions-of-encodings) of a profile or other data entities is not specific enough, because the file format is a generic structured data holder like JSON, XML or RDF. 

In these cases we can go _turtles all the way down_, and declare the _profile of the profile_:

```json
{
    "@id": "https://w3id.org/ro/curate/profile/cwl",
    "@type": "CreativeWork",
    "name": "SHACL profile for Research Objects with CWL workflows",
    "encodingFormat": [
        "text/turtle",
        { "@id": "https://www.nationalarchives.gov.uk/PRONOM/fmt/874" }
    ],
    "conformsTo": { "@id": "https://www.w3.org/TR/shacl/"}
},
{
    "@id": "https://www.w3.org/TR/shacl",
    "@type": "WebSite",
    "name": "Shapes Constraint Language (SHACL)"
}
```


The above states that the CWL profile is declared in the Turtle syntax, following the profile [Shapes Constraint Language (SHACL)](https://www.w3.org/TR/shacl/).