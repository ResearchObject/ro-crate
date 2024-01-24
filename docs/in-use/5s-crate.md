---
title: Five Safes Crate
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

# Five Safes Crate

The [Five Safes RO-Crate](https://w3id.org/5s-crate) profile extend the [Workflow Run RO-Crate](https://www.researchobject.org/workflow-run-crate/) profile for use in _Trusted Research Environments_ (TRE). 

The intention is to follow the [Five Safes Framework](https://econpapers.repec.org/RePEc:uwe:wpaper:20161601) to process sensitive health data in federated workflow execution across TREs in the UK.

In Five Safes, a crate with a workflow run request references a pre-approved workflow and project details for manual and automated assessment according to the TRE’s agreement policy for the sensitive dataset.

The crate goes through multiple phases internal to the TRE, including validation, sign-off, workflow execution and disclosure control.  These checks are recorded as schema.org `Action`s, e.g. a [AssessAction signs off execution](https://trefx.uk/5s-crate/0.4/example-result/data/ro-crate-preview.html#%23signoff-3b741265-cfef-49ea-8138-a2fa149bf2f0).

At this stage the crate describes the workflow run and thus conform to the Workflow Run Crate profile.  The final crate is then safe to be made public.  This extension of Workflow Run Crate documents and supports the human review process – important for transparency on TRE data usage. 

The initial implementation of this profile used [WfExS](https://github.com/inab/WfExS-backend) as the workflow execution backend, and this approach will form the basis for further work on implementing [federated workflow execution](https://www.hdruk.ac.uk/research/research-data-infrastructure/federated-analytics/) in the British initiatives DARE UK and HDR UK and in the European [EOSC-ENTRUST](https://esciencelab.org.uk/projects/eosc-entrust/) project for Trusted Research Environments.

_This text has been adapted from <https://doi.org/10.48550/arXiv.2312.07852>_

## Resources

* Profile releases: https://w3id.org/5s-crate
* TRE-FX report: https://doi.org/10.5281/zenodo.10055354
* Profile report https://doi.org/10.5281/zenodo.10376350
* Workflow Run Crate paper: https://doi.org/10.48550/arXiv.2312.07852
* https://esciencelab.org.uk/projects/federated-analytics/
* Example: [example-result.bagit.zip](https://trefx.uk/5s-crate/0.4/example-result.bagit.zip) [ro-crate-metadata.json](https://trefx.uk/5s-crate/0.4/example-hutch/data/ro-crate-metadata.json) [ro-crate-preview.html](https://trefx.uk/5s-crate/0.4/example-result/data/ro-crate-preview.html)

