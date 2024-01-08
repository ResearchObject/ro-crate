---
title: EGI AppDB
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

## EGI AppDB

EGI's Application Database ([AppDB](https://appdb.egi.eu/)) has [support for RO-Crate](https://wiki.appdb.egi.eu/docs/integration/ro-crate/) download, either as a JSON-LD metadata file or a ZIP archive.

The AppDB RO-Crates describe the software as `SoftwareApplication` entities, similar to [CodeMeta](https://codemeta.github.io/), including link to virtual machine iamges etc. 

* [RO-Crate integration in AppDB](https://wiki.appdb.egi.eu/docs/integration/ro-crate/)
* [Example RO-Crate](https://appdb.egi.eu/store/vappliance/egi.ubuntu.20.04#) for appliance [EGI Ubuntu 20.04](https://appdb.egi.eu/store/vappliance/egi.ubuntu.20.04)


<!--
[![appdb logo](../assets/img/appdb.svg)](https://appdb.org/)

[appdb](https://reliance.rohub.org/) (EXAMPLE-ACRONYM), is a...

appdb uses RO-Crate for ... as ....

appdb works with Project X, .....

![appdb screenshot with RO-Crate(../assets/img/appdb-screenshot.png)


## RO-Crate in appdb

(Show practically how RO-Crate is used, link to profile of RO-Crate, etc.)

The appdb API supports [RO-Crate export](http://appdb.org/docs/ro-crate) as...

appdb also plans to do...

appdb:
```
curl -H "Accept: application/ld+json" https://appdb.com/ro-crate/a72f314d

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

* [appdb Homepage](https://appdb.org/)
* [appdb documentation](https://appdb.org/docs/)
* [RO-Crate profile for appdb](https://appdb.org/crate-profile)
* [appdb Tutorials](https://appdb.org/docs/tutorial)
* [appdb presentation](http://appdb.org/)

## Publications

Alice Land, Bob Bunny (2020):  
**appdb and RO-Crate**.  
_appdb Journal_ **0**(1)
<https://doi.org/10.1234/appdb>  
[[preprint](http://appdb.com/preprint.pdf)]

-->
