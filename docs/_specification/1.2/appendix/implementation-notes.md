---
title: Implementation notes
description: Guidance on programming with JSON-LD, combining RO-Crate with other packaging schemes, and repository-specific identifiers
redirect_from:
  - /1.2-DRAFT/appendix/implementation-notes
  - /specification/1.2-DRAFT/appendix/implementation-notes
  - /specification/1.2-RC1/appendix/implementation-notes
parent: Appendix
grand_parent: RO-Crate 1.2
nav_order: 21
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2025 The University of Manchester UK 
   Copyright 2019-2025 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# APPENDIX: Implementation notes {#implementation-notes}
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

## Programming with JSON-LD

When implementing tools to work with RO-Crate it is not necessary to use JSON-LD software libraries, however, programmers should keep in mind the following:

- **_RO-Crate JSON-LD_ has a flat structure**; every entity is a JSON object directly within the `@graph` array in the _RO-Crate Metadata Document_. A useful strategy when processing a crate is to build a look-up table and/or function so that entities can be found via their ID, for example provide a method such as `getEntity(id)` which returns an entity by its id or a `null` value if it's not there.

- **Code defensively**. Code should not assume that values will always be a String; values for properties may be single scalar values such as strings or integers (`"2"` or 2), or references to other entities such as `{"@id", "_:1"}` (where the referenced entity may or may not be described in the crate, see the point above about having a `getEntity()` method).

- **Read the *whole* specification**. The RO-Crate specification addresses  common use cases individually, introducing aspects of the specification as in a progressive manner. Some key points, such as _entities may have more than one value for `@type`_, may not be apparent from a quick reading.


## Combining with other packaging schemes

RO-Crates may co-exist with other packaging schemes, such as [BagIt] or [ELN] (Electronic Lab Notebook) using two general approaches; either (a) _adding_ RO-Crate into a package as part of the payload or (b) _wrapping_ another kind of package.

### ELN examples

An "ELN" archive (with file extension `.eln`, see [IANA assignment](https://www.iana.org/assignments/media-types/application/vnd.eln+zip) and [specification](https://github.com/TheELNConsortium/TheELNFileFormat/blob/master/SPECIFICATION.md)), is a valid RO-Crate packaged in a certain way. It is a ZIP file that contains a folder, and this folder is the _RO-Crate Root_ containing the `ro-crate-metadata.json` file. See [Structure of the archive](https://github.com/TheELNConsortium/TheELNFileFormat/blob/master/SPECIFICATION.md#structure-of-the-archive) from the specification.

As such, when processing a `.eln` file, one needs to extract the ZIP archive, look for the only folder present at root directory of the ZIP archive, and process its content as a normal RO-Crate.

### BagIt examples

BagIt is described in [RFC 8493]:

> [BagIt is] ... a set of hierarchical file layout conventions
> for storage and transfer of arbitrary digital content. A "bag" has just enough
> structure to enclose descriptive metadata "tags" and a file "payload" but does
> not require knowledge of the payload's internal semantics. This BagIt format
> is suitable for reliable storage and transfer.

BagIt and RO-Crate have largely separate concerns - RO-Crate is focussed on rich
metadata, the semantics of data, while BagIt is about reliable transfer.

#### Adding RO-Crate to Bagit

RO-Crate can be combined with BagIt simply by placing the RO-Crate files 
within the BagIt payload (`data/`) directory.

```
<BagIt base directory>/
  |   bagit.txt                 # As per BagIt specification
  |   bag-info.txt              # As per BagIt specification
  |   manifest-<algorithm>.txt  # As per BagIt specification
  |   fetch.txt                 # Optional, per BagIt Specification
  |   data/                     # Payload: RO-Crate root directory
      |   ro-crate-metadata.json           # RO-Crate Metadata File MUST be present
      |   ro-crate-preview.html            # RO-Crate Website homepage MAY be present
      |   ro-crate-preview_files/          # MAY be present
      |   [payload files and directories]  # 1 or more SHOULD be present
```

The [Bag declaration](https://www.rfc-editor.org/rfc/rfc8493.html#section-2.1.1) `bagit.txt` MUST be present, the main role of this file is to mark the folder as a bag according to [RFC8493](https://www.rfc-editor.org/rfc/rfc8493.html). The file SHOULD have this fixed content in UTF-8:

```
BagIt-version: 1.0
Tag-File-Character-Encoding: UTF-8
```

The _BagIt base directory_ containing `bagit.txt` can have any name, and can be archived/transferred in any way, e.g.  within a ZIP archive, SFTP or even be exposed on the web.

The manifest file contains file checksums; the BagIt specifications [recommends SHA-512](https://www.rfc-editor.org/rfc/rfc8493.html#section-2.4) as default algorithm, that is `manifest-sha512.txt` SHOULD be present. 

The BagIt manifest file MUST list the checksum of _all_ payload files in `data/` and its subdirectories. Where `data/` is also the [RO-Crate Root](../structure) the manifest therefore MUST include `ro-crate-metadata.json`:

```
41846747…ee71  data/ro-crate-metadata.json
e1105ed0…5e13  data/chipseq_20200910.json
37fd3a02…bb95  data/results/pipeline_info/design_reads.csv
```

{% include callout.html type="note" content="The SHA-512 checksums have been shortened in the above example." %}

Creating the manifest file without using BagIt tools/libraries can be done using the equivalent of:

```sh
$ find data -type f -print0 | xargs -0 sha512sum > manifest-sha512.txt
```

Similarly checking the payload directory:

```sh
$ sha512sum --quiet -c manifest-sha512.txt
data/chipseq_20200910.json: FAILED
data/ro-crate-metadata.json: FAILED
sha512sum: WARNING: 2 computed checksums did NOT match
```

The BagIt manifest complements the [RO-Crate structure](../structure) as 
it provide a complete listing of all payload files with
cryptographically strong checksums, ensuring the crate has been fully 
archived/transferred, which the weak CRC-32 checksum (TCP/IP,
ZIP, gzip) is insufficient to guarantee, particularly for large crates. 

To ensure the manifest file itself is complete, it is RECOMMENDED to include its 
checksum in `tagmanifest-sha512.txt`:

```
b0556450…8802  bag-info.txt
000b27e3…c52e  manifest-sha512.txt
```

{% include callout.html type="warning" content="The BagIt manifest is intended to detect \"bit rot\" and accidental damage,
it does not provide proof the RO-Crate has not been deliberately tampered with, as a malicious actor can also update the checksums."
%}

Guarding against such scenarious would require additional cryptographic
measures, e.g.  
`gpg --detach-sign --armor --output tagmanifest-sha512.txt.asc tagmanifest-sha512.txt`
in combination with a secure PGP key exchange or equivalent trust network.

##### Base URI in BagIt

The arcp specification suggests how [BagIt UUID identifiers] can be used to calculate the base URI of a bag, see section [Establishing a base URI inside a ZIP file](relative-uris#establishing-a-base-uri-inside-a-zip-file).  For this purpose it is RECOMMENDED that `bag-info.txt` includes a fresh UUID like:

    External-Identifier: urn:uuid:24e51ca2-5067-4598-935a-dac4e327d05a


##### Referencing external files

The [BagIt fetch file](https://www.rfc-editor.org/rfc/rfc8493.html#section-2.2.3) MAY
be used to reference files to be downloaded into particular `data/` paths
to _complete_ the bag.  These files may be large, require authentication or otherwise
inconvenient to transfer within the BagIt folder.

Example `fetch.txt` using [Git LFS](https://git-lfs.github.com/):

```
https://media.githubusercontent.com/…/SPT5_INPUT_R1.bigWig 963489 data/results/SPT5_INPUT_R1.bigWig
```

BagIt tools can help complete the bag and verify the checksum of the downloaded
files according to the manifest.

The RO-Crate contained in `data/` MAY describe the bag with 
[data entities](../data-entities#data-entities-in-an-attached-ro-crate-that-are-also-on-the-web)
as if the bag was _complete_, even if the large file is not (yet) present:

```json
  {
    "@id": "results/SPT5_INPUT_R1.bigWig",
    "@type": "File",
    "name": "Normalized SPT5_INPUT_R1 bigWig for genome browsers",
    "encodingFormat": {"@id": "http://edamontology.org/format_3006"},
    "url": "https://media.githubusercontent.com/media/biocompute-objects/bco-ro-example-chipseq/main/data/results/bwa/mergedLibrary/bigwig/SPT5_INPUT_R1.bigWig"}
  }
```

It is RECOMMENDED that the `url` is provided in the data entity
and consistent with the line in `fetch.txt` in case the RO-Crate 
is transferred outside its BagIt container.

The `fetch.txt` approach can also be useful where other files in the RO-Crate
reference a downloadable file by relative paths within `data/`, even if 
this file is not itself described in the RO-Crate metadata.


##### Snapshots of external files

As an alternative to the above, [web-based data entities](../data-entities#web-based-data-entities)
can be used in the RO-Crate:

```json
  {
    "@id": "https://media.githubusercontent.com/media/biocompute-objects/bco-ro-example-chipseq/main/data/results/bwa/mergedLibrary/bigwig/SPT5_INPUT_R1.bigWig",
    "@type": "File",
    "name": "Normalized SPT5_INPUT_R1 bigWig for genome browsers",
    "encodingFormat": {"@id": "http://edamontology.org/format_3006"}
  }
```

The above data entity MAY be combined with `fetch.txt` in the BagIt base directory:

```
https://media.githubusercontent.com/…/SPT5_INPUT_R1.bigWig 963489 data/snapshots/SPT5_INPUT_R1.bigWig
```

In this case the file `data/snapshots/SPT5_INPUT_R1.bigWig` may be present,
but unknown by RO-Crate; BagIt contains a checksummed snapshot of the 
web resource. Compared with the first approach, the RO-Crate is here 
primarily pointing at a web resource which is allowed to change
without causing a BagIt checksum error.


#### Example of wrapping a BagIt bag in an RO-Crate

Alternatively, an RO-Crate can _wrap_ a BagIt bag, so that the RO-Crate metadata
is outside of the bag directory and can be changed without changing the payload's checksums. 

```
<RO-Crate root directory>/
  |   ro-crate-metadata.json    # RO-Crate Metadata File MUST be present
  |   ro-crate-preview.html     # RO-Crate Website homepage MAY be present
  |   ro-crate-preview_files/   # MAY be present
  |   bag1/                     # "Wrapped" bag - could have any name
  |      bagit.txt                 # As per BagIt specification
  |      bag-info.txt              # As per BagIt specification
  |      manifest-<algorithm>.txt  # As per BagIt specification
  |      fetch.txt                 # Optional, per BagIt Specification
  |      data/
  |         [payload files and directories]  # 1 or more SHOULD be present
  |         example.txt 
```

A [Data Entity](../data-entities) describing `example.txt` in this scenario would have an `@id` of `bag1/data/example.txt`:

```json
{
  "@id": "bag1/data/example.txt",
  "name": "Example file"
}
```


## Repository-specific identifiers

_Root Data Entities_ MAY include repository-specific identifiers, described using [Contextual Entities](../contextual-entities) using a [PropertyValue], with a [name] that identifies the repository and the [identifier] as a value. The _same_ identifier MAY be used in multiple different repositories and effectively namespaced using the `name` of the `ProperyValue`.

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
