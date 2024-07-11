---
page_id: datalake
redirect_from:
    - /in-use/datalake
title: KEDO Data Lake
description: Knowledge Enhanced Digital Objects (KEDO) is an experimental approach of building a data lake using a combination of knowledge graphs, RO-Crate and PID records.
url: https://github.com/luoyu357/KEDODataLake
domains: []
tasks: [curation]
roles: [information_architect]
---

# KEDO Data Lake


Knowledge Enhanced Digital Objects ([KEDO](https://github.com/luoyu357/KEDODataLake)) is an experimental approach of building a data lake using a combination of knowledge graphs, RO-Crate and PID records. 

A KEDO PID is a Handle that identifies a KEDO Object, described using a KEDO RO-Crate. This crate again has _internal RO-Crate_s as parts, which records a combination of _Features_ and _Insights_. The distinction is that features are mainly fixed at digital object creation and considered directly describing the object's nature, while insights can be discovered later from further processing and linkage.

Files in a KEDO RO-Crate are stored locally, and each recorded with a Handle PID within the crate. In this KEOD setup of multiple graphs then form a single knowledge unit.

## Resources

* Yu Luo (2022): [Knowledge enhanced digital objects](https://www.proquest.com/docview/2763290077) (Doctoral dissertation, Indiana University)
* Conference paper: <https://doi.org/10.1109/CCGridW59191.2023.00064>
* Source: <https://github.com/luoyu357/KEDODataLake>
