---
layout: default
title: RO-Crate 1.1-DRAFT
sort: 1
excerpt: |
  This document specifies a method, known as RO-Crate (Research Object Crate), of organizing file-based data with associated metadata, using Linked Data principles, in both human and machine readable formats, with the ability to include additional domain-specific metadata.

  The core of RO-Crate is a JSON-LD file, the RO-Crate Metadata File. This file contains structured metadata about the dataset as a whole and, optionally, about some or all of its files. This provides a simple way to, for example, assert the authors (e.g. people, organizations) of the RO-Crate or one its files, or to capture more complex provenance for files, such as how they were created using software and equipment. 

  While providing the formal specification for RO-Crate, this document also aims to be a practical guide for software authors to create tools for generating and consuming research data packages, with explanation by examples.   
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

# RO-Crate Metadata Specification 1.1-DRAFT

<!-- NOTE: Before release, update and uncomment below (permalink, DOI, published, authors)
* Permalink: <https://w3id.org/ro/crate/1.1>
* Status: Recommendation
* Published: 2019-11-15
* Publisher: [researchobject.org](http://researchobject.org/) community
END NOTE -->
* Status: Editor's Draft
* JSON-LD context: <https://w3id.org/ro/crate/1.1-DRAFT/context>
* This version: <https://w3id.org/ro/crate/1.1-DRAFT>
* Previous version: <https://w3id.org/ro/crate/1.0>
* Cite as: <!-- <https://doi.org/10.5281/zenodo.3541888> (this version) -->
  <https://doi.org/10.5281/zenodo.3406497> (any version)
* Editors: [Peter Sefton](https://orcid.org/0000-0002-3545-944X), [Eoghan Ó Carragáin](https://orcid.org/0000-0001-8131-2150),  [Stian Soiland-Reyes](https://orcid.org/0000-0001-9842-9718)
* Authors: [Peter Sefton](https://orcid.org/0000-0002-3545-944X), [Eoghan Ó Carragáin](https://orcid.org/0000-0001-8131-2150),  [Stian Soiland-Reyes](https://orcid.org/0000-0001-9842-9718), [Oscar Corcho](https://orcid.org/0000-0002-9260-0753), [Daniel Garijo](https://orcid.org/0000-0003-0454-7145), [Raul Palma](https://orcid.org/0000-0003-4289-4922), [Frederik Coppens](https://orcid.org/0000-0001-6565-5145), [Carole Goble](https://orcid.org/0000-0003-1219-2137), [José María Fernández](https://orcid.org/0000-0002-4806-5140), [Kyle Chard](https://orcid.org/0000-0002-7370-4805), [Jose Manuel Gomez-Perez](https://orcid.org/0000-0002-5491-6431), [Michael R Crusoe](https://orcid.org/0000-0002-2961-9670), [Ignacio Eguinoa](https://orcid.org/0000-0002-6190-122X), [Nick Juty](https://orcid.org/0000-0002-2036-8350), [Kristi Holmes](https://orcid.org/0000-0001-8420-5254), [Jason A. Clark](https://orcid.org/0000-0002-3588-6257), [Salvador Capella-Gutierrez](https://orcid.org/0000-0002-0309-604X), [Alasdair J. G. Gray](https://orcid.org/0000-0002-5711-4872), [Stuart Owen](https://orcid.org/0000-0003-2130-0865), [Alan R Williams](https://orcid.org/0000-0003-3156-2105), [Giacomo Tartari](https://orcid.org/0000-0003-1130-2154), [Finn Bacall](https://orcid.org/0000-0002-0048-3300), [Thomas Thelen](https://orcid.org/0000-0002-1756-2128), [Hervé Ménager](https://orcid.org/0000-0002-7552-1009), [Laura Rodríguez Navas](https://orcid.org/0000-0003-4929-1219), [Paul Walk](https://orcid.org/0000-0003-1541-5631), [brandon whitehead](https://orcid.org/0000-0002-0337-8610), [Mark Wilkinson](https://orcid.org/0000-0001-6960-357X), [Paul Groth](https://orcid.org/0000-0003-0183-6910), [Erich Bremer](https://orcid.org/0000-0003-0223-1059), [LJ Garcia Castro](https://orcid.org/0000-0003-3986-0510), [Karl Sebby](https://orcid.org/0000-0001-6022-9825), [Alexander Kanitz](https://orcid.org/0000-0002-3468-0652)


<!-- Add new RO-Crate team members at end -->


See <https://w3id.org/ro/crate> for further details about RO-Crate.

<small>
This specification is Copyright 2017-2020 University of Technology Sydney, 
The University of Manchester UK and the RO-Crate contributors.
</small>

<small>
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
</small>

<small>
<http://www.apache.org/licenses/LICENSE-2.0>
</small>

<small>
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
</small>

**Note**: The RO-Crate [JSON-LD context](https://w3id.org/ro/crate/1.1-DRAFT/context) and JSON-LD examples within this specification are distributed under [CC0 1.0 Universal (CC0 1.0) Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/). 


> The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in [RFC 2119].

## Abstract

This document specifies a method, known as _RO-Crate_ (Research Object Crate), of organizing file-based data with associated metadata, using [linked data] principles, in both human and machine readable formats, with the ability to include additional domain-specific metadata.

The core of RO-Crate is a JSON-LD file, the _RO-Crate Metadata File_, named `ro-crate-metadata.json`. This file contains structured metadata about the dataset as a whole (the _Root Data Entity_) and, optionally, about some or all of its files. This provides a simple way to, for example, assert the authors (e.g. people, organizations) of the RO-Crate or one its files, or to capture more complex provenance for files, such as how they were created using software and equipment. 

While providing the formal specification for RO-Crate, this document also aims to be a practical guide for software authors to create tools for generating and consuming research data packages, with explanation by examples. 

## Table of Contents

{% include list.liquid all=true %}

[RFC 2119]: https://tools.ietf.org/html/rfc2119
[linked data]: https://en.wikipedia.org/wiki/Linked_data

