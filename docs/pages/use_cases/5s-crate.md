---
page_id: 5s-crate
redirect_from:
    - /in-use/5s-crate
title: Five Safes Crate
description: The Five Safes RO-Crate profile extend the Workflow Run RO-Crate profile for use in Trusted Research Environments (TRE).
url: https://trefx.uk/5s-crate/
domains: [medicine]
tasks: [compliance, data_handling, manage_data]
roles: [compliance_officer, data_steward, information_architect]
---

# Five Safes Crate

The [Five Safes RO-Crate](https://w3id.org/5s-crate) profile extend the [Workflow Run RO-Crate](https://www.researchobject.org/workflow-run-crate/) profile for use in _Trusted Research Environments_ (TRE). 

The intention is to follow the [Five Safes Framework](https://econpapers.repec.org/RePEc:uwe:wpaper:20161601) to process sensitive health data in federated workflow execution across TREs in the UK.

In Five Safes, a crate with a workflow run request references a pre-approved workflow and project details for manual and automated assessment according to the TRE’s agreement policy for the sensitive dataset.

The crate goes through [multiple phases](https://trefx.uk/5s-crate/0.4/#review-process) internal to the TRE, including validation, sign-off, workflow execution and disclosure control.  These checks are recorded as schema.org `Action`s, e.g. a [AssessAction signs off execution](https://trefx.uk/5s-crate/0.4/example-result/data/ro-crate-preview.html#%23signoff-3b741265-cfef-49ea-8138-a2fa149bf2f0).

At this stage the crate describes the workflow run and thus conform to the Workflow Run Crate profile.  The final crate is then safe to be made public.  This extension of Workflow Run Crate documents and supports the human review process – important for transparency on TRE data usage. 

The initial implementation of this profile used [WfExS](https://github.com/inab/WfExS-backend) as the workflow execution backend, and this approach will form the basis for further work on implementing [federated workflow execution](https://www.hdruk.ac.uk/research/research-data-infrastructure/federated-analytics/) in the British initiatives DARE UK and HDR UK and in the European [EOSC-ENTRUST](https://esciencelab.org.uk/projects/eosc-entrust/) project for Trusted Research Environments.

_This text has been adapted from <https://doi.org/10.48550/arXiv.2312.07852>_


## RO-Crate details

The profile uses the [BagIt](https://www.researchobject.org/ro-crate/1.1/appendix/implementation-notes.html#combining-with-other-packaging-schemes) wrapping of an RO-Crate inside a ZIP file. Internally the TRE is free to , see [TRE-FX implementation reports](https://trefx.uk/implementation)


## Resources

* Profile releases: <https://w3id.org/5s-crate>:
* TRE-FX report: <https://doi.org/10.5281/zenodo.10055354>:
* Profile report <https://doi.org/10.5281/zenodo.10376350>:
* Workflow Run Crate paper: <https://doi.org/10.48550/arXiv.2312.07852>:
* Example: [example-result.bagit.zip](https://trefx.uk/5s-crate/0.4/example-result.bagit.zip) [ro-crate-metadata.json](https://trefx.uk/5s-crate/0.4/example-hutch/data/ro-crate-metadata.json) [ro-crate-preview.html](https://trefx.uk/5s-crate/0.4/example-result/data/ro-crate-preview.html)

## Publications

Stian Soiland-Reyes, Stuart Wheater, Thomas Giles, Jonathan Couldridge, Philip Quinlan, Carole Goble (2025):  
**The Five Safes RO-Crate: FAIR Digital Objects for Trusted Research Environments for Health Data Research**  
_International FAIR Digital Objects Implementation Summit 2024_, Berlin, Germany, 2024-03-20/--21.  
_Open Conference Proceedings_ **5**  
<https://doi.org/10.52825/ocp.v5i.1419>
