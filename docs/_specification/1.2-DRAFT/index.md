---
title: RO-Crate 1.2-DRAFT
redirect_from:
  - /1.2-DRAFT/index
  - /1.2-DRAFT/about
has_children: true
nav_order: 1
excerpt: |
  This document specifies a method, known as RO-Crate (Research Object Crate), of organizing file-based data with associated metadata, using Linked Data principles, in both human and machine readable formats, with the ability to include additional domain-specific metadata.

  The core of RO-Crate is a JSON-LD document, the RO-Crate Metadata Document. This document contains structured metadata about the dataset as a whole and, optionally, about some or all of its data, which may be present as local files or references to data online. The RO-Crate conventions provide a way to, for example, assert the authors (e.g. people, organizations) of the RO-Crate or one its files, or to capture more complex provenance for files, such as how they were created using software and equipment. 

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



{% include_relative _metadata.liquid  %}


{% include references.liquid %}
