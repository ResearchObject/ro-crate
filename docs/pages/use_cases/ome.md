---
page_id: ome
title: Open Microscopy Environment
description: OME is a consortium producing open-source software and format standards for microscopy data. It uses RO-Crate as part of its system for transfering data between OMERO servers, as well as for producing self-documenting data in OME-Zarr, a next-generation file-format (NGFF) standard.
url: https://www.openmicroscopy.org/
image: ome.svg
domains: [biology,biomedical_science,medicine] # should match item(s) in pages/domains
tasks: [data_handling, manage_data] # should match item(s) in pages/tasks
roles: [researcher, repository_manager, data_steward] # should match item(s) in pages/roles
---
<!--
   Copyright 2019-2022 RO-Crate contributors
   <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# Example

[![Open Microscopy Environment logo](../../assets/img/ome.svg)](https://www.openmicroscopy.org/)

The [Open Microscopy Environment](https://www.openmicroscopy.org/) (OME) is a consortium producing open-source software and format standards for microscopy data since 2005. 

OME core [developer teams](https://www.openmicroscopy.org/teams/) at the University of Dundee and German BioImaging e.V., alongside an active community work on multiple parts of the microscopy data ecosystem. The parts include the OME Model, a metadata specification for microscopy data, OMERO, a system to host, organize and share images and Bioformats, a package to convert multiple proprietary microscopy formats into a common, interoperable format. 

More recently, the OME team has been working on a new data standard for n-dimensional arrays called Zarr and its specification for use in microscopy, OME-Zarr. 




It uses RO-Crate as part of its system for transfering data between OMERO servers, as well as for producing self-documenting data in OME-Zarr, a next-generation file-format (NGFF) standard.

Example uses RO-Crate for ... as ....

Example works with Project X, .....

![Example screenshot with RO-Crate](../../assets/img/example-screenshot.png)


## RO-Crate in Example

(Show practically how RO-Crate is used, link to profile of RO-Crate, etc.)

The Example API supports [RO-Crate export](http://example.org/docs/ro-crate) as...

Example also plans to do...

Example:
```
curl -H "Accept: application/ld+json" https://example.com/ro-crate/a72f314d

{
  "@context": { … },
  "@graph": [
   …
    {
      "@id": "./",
      "hasPart": […],
      "@type": "Dataset",
    }
   …
}
```


## Resources

* [Example Homepage](https://example.org/)
* [Example documentation](https://example.org/docs/)
* [RO-Crate profile for Example](https://example.org/crate-profile)
* [Example Tutorials](https://example.org/docs/tutorial)
* [Example presentation](http://example.org/)

## Publications

Alice Land, Bob Bunny (2020):  
**Example and RO-Crate**.  
_Example Journal_ **0**(1)
<https://doi.org/10.1234/example>  
[[preprint](http://example.com/preprint.pdf)]
