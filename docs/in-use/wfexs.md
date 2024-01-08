---
title: Workflow Execution Service (WfExS)
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

# Workflow Execution Service (WfExS)

[WfExS-backend](https://github.com/inab/WfExS-backend) is a high-level workflow execution command line program that consumes and creates RO-Crates, focusing on
the interconnection of content-sensitive research infrastructures for handling sensitive human data analysis scenarios.
WfExS-backend delegates workflow execution of existing workflow engines, and it is designed to facilitate more secure
and reproducible workflow executions to promote analysis reproducibility and replicability. Secure executions are
achieved using FUSE encrypted directories for non-disclosable inputs, intermediate workflow execution results and output
files.

RO-Crates are, indeed, an element of knowledge transfer between repeated workflow executions. WfExS-backend stores all
the gathered details, output metadata and execution provenance in the output RO-Crate to achieve future reproducible
executions. Final execution results can be encrypted with crypt4gh GA4GH standard using the public keys of the target
researchers or destination, so the results can be safely moved outside the execution environments through unsecured
networks and storages.

<!--
[![wfexs logo](../assets/img/wfexs.svg)](https://wfexs.org/)

[wfexs](https://reliance.rohub.org/) (EXAMPLE-ACRONYM), is a...

wfexs uses RO-Crate for ... as ....

wfexs works with Project X, .....

![wfexs screenshot with RO-Crate(../assets/img/wfexs-screenshot.png)


## RO-Crate in wfexs

(Show practically how RO-Crate is used, link to profile of RO-Crate, etc.)

The wfexs API supports [RO-Crate export](http://wfexs.org/docs/ro-crate) as...

wfexs also plans to do...

wfexs:
```
curl -H "Accept: application/ld+json" https://wfexs.com/ro-crate/a72f314d

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

* [wfexs Homepage](https://wfexs.org/)
* [wfexs documentation](https://wfexs.org/docs/)
* [RO-Crate profile for wfexs](https://wfexs.org/crate-profile)
* [wfexs Tutorials](https://wfexs.org/docs/tutorial)
* [wfexs presentation](http://wfexs.org/)

## Publications

Alice Land, Bob Bunny (2020):  
**wfexs and RO-Crate**.  
_wfexs Journal_ **0**(1)
<https://doi.org/10.1234/wfexs>  
[[preprint](http://wfexs.com/preprint.pdf)]

-->
