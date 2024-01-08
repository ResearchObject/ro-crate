---
title: Arkisto
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


## Arkisto

[Arkisto uses RO-Crate](https://arkisto-platform.github.io/standards/ro-crate/) for packaging data objects in the 3 uses cases described below, **Modern PARADISEC**, **UTS Research Data Repository** and **UTS Cultural Datasets**.

As part of these use-cases they have been developing or enhancing their tooling to facilitate their use of RO-Crate

  * [OCFL-indexer](https://github.com/CoEDL/modpdsc/) is a NodeJS application that walks the [Oxford Common File Layout](https://ocfl.io/) on the file system, validate _RO-Crate Metadata Files_ and parse into objects registered in Elasticsearch. (~ _alpha_) 
  * [ocfl-tools](https://github.com/CoEDL/ocfl-tools) contains tools for managing RO-Crates in an OCFL repository .
  * [ocfl-viewer](https://hub.docker.com/r/coedl/ocfl-viewer)
  * [ONI indexer](https://github.com/UTS-eResearch/oni-indexer)



<!--
[![arkisto logo](../assets/img/arkisto.svg)](https://arkisto.org/)

[arkisto](https://reliance.rohub.org/) (EXAMPLE-ACRONYM), is a...

arkisto uses RO-Crate for ... as ....

arkisto works with Project X, .....

![arkisto screenshot with RO-Crate(../assets/img/arkisto-screenshot.png)


## RO-Crate in arkisto

(Show practically how RO-Crate is used, link to profile of RO-Crate, etc.)

The arkisto API supports [RO-Crate export](http://arkisto.org/docs/ro-crate) as...

arkisto also plans to do...

arkisto:
```
curl -H "Accept: application/ld+json" https://arkisto.com/ro-crate/a72f314d

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

* [arkisto Homepage](https://arkisto.org/)
* [arkisto documentation](https://arkisto.org/docs/)
* [RO-Crate profile for arkisto](https://arkisto.org/crate-profile)
* [arkisto Tutorials](https://arkisto.org/docs/tutorial)
* [arkisto presentation](http://arkisto.org/)

## Publications

Alice Land, Bob Bunny (2020):  
**arkisto and RO-Crate**.  
_arkisto Journal_ **0**(1)
<https://doi.org/10.1234/arkisto>  
[[preprint](http://arkisto.com/preprint.pdf)]

-->
