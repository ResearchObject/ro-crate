---
layout: default
title: Introduction
sort: 2
excerpt: |
  ...
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

# Introduction

This document specifies a method, known as _RO-Crate_ (Research Object Crate), of aggregating and describing research data with associated metadata. RO-Crates can aggregate and describe any resource including files, URI-addressable resources, or use other addressing schemes to locate digital or physical data. RO-Crates can describe data in aggregate and at the individual resource level, with metadata to aid in discovery, re-use and long term management of data. Metadata includes the ability to describe the context of data and the entities involved in its production, use and reuse. For example: who created it, using which equipment, software and workflows, under what licenses can it be re-used, where was it collected, and/or where is it *about*.

RO-Crate uses JSON-LD to to express this metadata using linked data, describing data resources as well as contextual entities such as people, organizations, software and equipment as a series of linked JSON-LD objects - using common published vocabularies, chiefly schema.org. 

The core of RO-Crate is a JSON-LD file, the _RO-Crate Metadata File_, named `ro-crate-metadata.json`. This file contains structured metadata about the dataset as a whole (the _Root Data Entity_) and, optionally, about some or all of its files. This provides a simple way to, for example, assert the authors (e.g. people, organizations) of the RO-Crate or one its files, or to capture more complex provenance for files, such as how they were created using software and equipment. 

While providing the formal specification for RO-Crate, this document also aims to be a practical guide for software authors to create tools for generating and consuming research data packages, with explanation by examples. 

{% include references.liquid %}
