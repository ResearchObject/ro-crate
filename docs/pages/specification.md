---
title: Specification
sidebar: spec
---
<!--
   Copyright 2019-2025 The University of Manchester and RO Crate contributors 
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

# RO-Crate Specification

The RO-Crate 1.2 specification has been **released**.

{% comment %} 
The links below use the `{{ baseurl }}{% link _specification/<version>/index.md %}` format to avoid problems with using the relative path "specification/<version>" within this page when serving the site locally.
It's something to do with this page being rendered to specification/index.html and Jekyll getting muddled with the relative URIs. 
Other pages are fine and can use the simpler `specification/<version>` path.
{% endcomment %}

* **[RO-Crate 1.2]({{ baseurl }}{% link _specification/1.2/index.md %})** (current long term release)  
* [RO-Crate 1.1]({{ baseurl }}{% link _specification/1.1/index.md %})
* [RO-Crate 1.2-DRAFT]({{ baseurl }}{% link _specification/1.2-DRAFT/index.md %}) (draft for next release)
* [RO-Crate 1.0]({{ baseurl }}{% link _specification/1.0/index.md %}) 
* [RO-Crate 0.2]({{ baseurl }}{% link _specification/0.2/index.md %})
* [DataCrate 1.0](https://github.com/UTS-eResearch/datacrate/blob/ba37cc707d48d3569663ab04f9d4f5c25dac6e34/spec/1.0/data_crate_specification_v1.0.md)
* [ROLite Draft 0.1.0]({{ baseurl }}{% link _specification/0.1.0/index.md %})  
   _Historical note_: After the initial draft, the community decided to base the specification on [DataCrate](https://github.com/UTS-eResearch/datacrate/), and changed the name from _ROLite_ to **RO-Crate**.

[Feedback](https://github.com/researchobject/ro-crate/issues) and improvements are welcome! RO-Crate 1.2 is considered a _stable release_ with only minor fixes expected, current community work is towards RO-Crate 2, focusing on modularisation of the specification.

{% include callout.html type="tip" content="RO-Crate specifications follow backwards compatibility according to [semantic versioning](https://semver.org/spec/v2.0.0.html), e.g. allowing for typo fixes in patch versions, new/deprecated terms in minor versions, and removal of terms in major versions. The JSON-LD context may change term bindings to URIs in minor versions to remain compatible with third-party vocabularies, e.g. to integrate new schema.org terms.
" %}

This specification and documentation is Open Source and licensed as [Apache License, version 2.0](https://github.com/ResearchObject/ro-crate/blob/master/LICENSE), see <https://www.apache.org/licenses/LICENSE-2.0> for details. 

To suggest changes, improvements or issues, use the GitHub repository <https://github.com/ResearchObject/ro-crate> - if you are new to GitHub or Open Source you may appreciate the [GitHub guides](https://guides.github.com/) like [Hello World](https://guides.github.com/activities/hello-world/), [MarkDown](https://guides.github.com/features/mastering-markdown/) and [How to contribute to open source](https://opensource.guide/how-to-contribute/)

Contributors are expected to comply with our [Code of Conduct](https://github.com/ResearchObject/ro-crate/blob/master/CODE_OF_CONDUCT.md) to ensure an open and inclusive environment.

Feel free to [join](https://github.com/ResearchObject/ro-crate/issues/1) our [community](community) and help shape the next version of RO-Crate!

