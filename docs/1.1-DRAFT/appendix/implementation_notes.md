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
  aspects of the specification as well. Some key points, such as _items may have
  more than one value for `@type`_, may not be apparent from a quick reading.


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
{% include references.liquid %}
