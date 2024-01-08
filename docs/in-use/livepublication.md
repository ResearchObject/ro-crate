---
title: LivePublication
parent: RO-Crate In Use
---
<!--
   Copyright 2019-2024 RO-Crate contributors
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

# LivePublication: Executable Paper

[LivePublication](https://livepublication.github.io/LP_Pub_LID/) is a proof of concept of an _executable paper_, which interactive visualization and statistical calculations can be regenerated on the fly taking into consideration data sources updated after the paper's publication date. 

A [corresponding RO-Crate](https://livepublication.github.io/LP_Pub_OrchestrationCrate/) is the mechanism to enable this execution on the Globus infrastructure through an innovative use of individual RO-Crates and containers for each computable element of the paper, nested within a top-level Crate for the paper.

This novel approach shows how it is possible to use RO-Crate as an machine-actionable object, which do not rely on bundling an underlying workflow representation in an existing workflow language.


## Resources

* Conference paper: https://doi.org/10.1109/e-Science58273.2023.10254857 (not open access)
* Example LivePublication: <https://livepublication.github.io/LP_Pub_LID/>
* Example crate: <https://livepublication.github.io/LP_Pub_OrchestrationCrate/>

<!--
[![executablepaper logo](../assets/img/executablepaper.svg)](https://executablepaper.org/)

[executablepaper](https://reliance.rohub.org/) (EXAMPLE-ACRONYM), is a...

executablepaper uses RO-Crate for ... as ....

executablepaper works with Project X, .....

![executablepaper screenshot with RO-Crate(../assets/img/executablepaper-screenshot.png)


## RO-Crate in executablepaper

(Show practically how RO-Crate is used, link to profile of RO-Crate, etc.)

The executablepaper API supports [RO-Crate export](http://executablepaper.org/docs/ro-crate) as...

executablepaper also plans to do...

executablepaper:
```
curl -H "Accept: application/ld+json" https://executablepaper.com/ro-crate/a72f314d

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

* [executablepaper Homepage](https://executablepaper.org/)
* [executablepaper documentation](https://executablepaper.org/docs/)
* [RO-Crate profile for executablepaper](https://executablepaper.org/crate-profile)
* [executablepaper Tutorials](https://executablepaper.org/docs/tutorial)
* [executablepaper presentation](http://executablepaper.org/)

## Publications

Alice Land, Bob Bunny (2020):  
**executablepaper and RO-Crate**.  
_executablepaper Journal_ **0**(1)
<https://doi.org/10.1234/executablepaper>  
[[preprint](http://executablepaper.com/preprint.pdf)]

-->
