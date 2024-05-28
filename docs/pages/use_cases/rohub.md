---
page_id: rohub
title: ROHub
description: ROHub is a solution for the storage, lifecycle management and preservation of scientific work and operational processes via research objects. It makes these resources available to others, allows to publish and release them through a DOI, and allows to discover and reuse pre-existing scientific knowledge.
url: https://www.rohub.org/
image: ro_hub.svg
domains: [climate_science, ecology]
tasks: [conduct_research, manage_data]
roles: [information_architect, managerial, researcher, repository_manager]
---

[![ROHub logo](assets/img/ro_hub.svg)](https://reliance.rohub.org/)

[ROHub](https://reliance.rohub.org/) (Research Object Hub), one of [EOSC](https://eosc.eu/) research enabling services, is a holistic solution for the storage, lifecycle management and preservation of scientific work and operational processes via research objects. It makes these resources available to others, allows to publish and release them through a DOI, and allows to discover and reuse pre-existing scientific knowledge. 

ROHub is a reference platform implementing natively the full [Research Object (RO) model](https://www.researchobject.org/specs/) and paradigm, which provides the backbone to a wealth of RO-centric applications and interfaces across different scientific communities.

ROHub imports and exports RO-Crates, using it as an exchange format, and is integrated with or leverages other EOSC services (e.g., EOSC AAI ([EGI Check-In](https://www.egi.eu/services/check-in/)) to enable SSO across different EOSC services, export and dissemination of research objects in other EOSC repositories/services ([Zenodo](https://zenodo.org/), [B2Share](https://b2share.eudat.eu/)), use of storage systems/services provided by EOSC to enable larger scalability ([B2drop](https://www.eudat.eu/services/b2drop)), and connection with computational services ([EGI Notebooks](https://www.egi.eu/services/notebooks/)). 

Additionally, as part of [RELIANCE project](https://www.reliance-project.eu/), ROHub is being integrated with [data cubes](https://reliance-eosc.github.io/reliance-ro-crate/) services to facilitate access and reuse of large geospatial data.

ROHub functionalities can be used via the [Web portal](https://reliance.rohub.org/) and via the provided [Python library](https://reliance-eosc.github.io/ROHUB-API_documentation/html/).

{% include image.html src="assets/img/rohub-screenshot.png" caption="ROHub screenshot, export to publication service B2SHare with DOI" alt="The ROHub interface, showing steps for research object quality at the top with 'Basic information' step selected. A form shows the research object title, description, and choices for which publication service to use and whether to create a DOI" %}


## RO-Crate in ROHub API

The [ROHub API](https://api.rohub.org/api/) provides support for [upload](https://api.rohub.org/api/redoc/#operation/ros_upload), [export](https://api.rohub.org/api/redoc/#operation/ros_crate_export_to_crate) and [customized download](https://api.rohub.org/api/redoc/#operation/ros_crate_download_read). 

In addition, publication of an RO to Zenodo/B2Share ([evolution](https://api.rohub.org/api/redoc/#operation/ros_evolution) to `ARCHIVE`) uses RO-Crate for archival purposes.

The API uses [content-negotiation](https://datatracker.ietf.org/doc/html/rfc7231#section-3.4) for different content types.

Example, for `application/ld+json` gives the RO-Crate Metadata file:

```
curl -H "Accept: application/ld+json" https://api.rohub.org/api/ros/b83a814a-27e6-499c-a6b2-61a0a921e53b/crate/download/

{
  "@context": { … },
  "@graph": [
   …
    {
      "@id": "./",
      "identifier": "https://w3id.org/ro-id/b83a814a-27e6-499c-a6b2-61a0a921e53b",
      "hasPart": […],
      "@type": [
        "Dataset",
        "http://w3id.org/ro/earth-scienceExecutableResearchObject",
        "http://purl.org/wf4ever/ro#ResearchObject",
        "http://purl.org/wf4ever/roevo#ArchiveRO"
      ],
   …
}
```

For `application/zip` as a zipped RO-Crate:

```
$ curl -f -o crate.zip -H "Accept: application/zip" https://api.rohub.org/api/ros/b83a814a-27e6-499c-a6b2-61a0a921e53b/crate/download/
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  402k  100  402k    0     0  40897      0  0:00:10  0:00:10 --:--:--  104k

$ unzip -t crate.zip
Archive:  crate.zip
    testing: tool/                    OK
    testing: output/                  OK
    testing: input/                   OK
    testing: biblio/                  OK
    testing: ro-crate-preview.html    OK
    testing: ro-crate-metadata.json   OK
    testing: tool/VSM_logo.gif        OK
    testing: output/VSM_res_sar2.png   OK
    testing: output/VSM.log           OK
    testing: output/VSM_best.csv      OK
    testing: output/VSM_res_sar1.png   OK
    testing: output/VSM_res_sar3.png   OK
```

## Resources

* [ROHub Portal](https://reliance.rohub.org/)
* [Portal documentation](https://reliance-eosc.github.io/rohub-portal-documentation/)
* [ROHub library](https://reliance-eosc.github.io/ROHUB-API_documentation/html/) ([pypi](https://pypi.org/project/rohub/), [git](https://git.man.poznan.pl/stash/projects/ROHUB/repos/rohub-api/))
* [ROHub Tutorials](https://reliance-eosc.github.io/ROHUB-API_documentation/html/tutorials.html)
* [Materials for adopters](https://www.reliance-project.eu/adopters/)
* [RELIANCE RO-Crate profile](https://reliance-eosc.github.io/reliance-ro-crate/)
* [ROHub screencasts](https://www.youtube.com/playlist?list=PLuFbwYmIXrVfSol_iD9dKpuJ5uHD40C4i)

## Publications

Andres Garcia-Silva, Jose Manuel Gomez-Perez, Raul Palma, Marcin Krystek, Simone Mantovani, Federica Foglini, Valentina Grande, Francesco De Leo, Stefano Salvi, Elisa Trasatti, Vito Romaniello, Mirko Albani, Cristiano Silvagni, Rosemarie Leone, Fulvio Marelli, Sergio Albani, Michele Lazzarini, Hazel J. Napier, Helen M. Glaves, Timothy Aldridge, Charles Meertens, Fran Boler, Henry W. Loescher, Christine Laney, Melissa  A. Genazzio, Daniel Crawl, Ilkay Altintas (2019):  
**Enabling FAIR research in Earth Science through research objects**.
_Future Generation Computing Systems_ **98**  
<https://doi.org/10.1016/j.future.2019.03.046> [[preprint](https://arxiv.org/abs/1809.10617)]

Raul Palma, Andrés García-Silva, Jose Manuel Gomez-Perez, Marcin Krystek (2018):  
**A Research Object-based Toolkit to Support the Earth Science Research Lifecycle**.  
_2018 IEEE 14th International Conference on e-Science (e-Science)_  
<https://doi.org/10.1109/eScience.2018.00020> [[preprint](https://doi.org/10.24424/ro-id.DBIMALEDRQ)] [[pdf](http://sandbox.rohub.org/rodl/ROs/ROToolkit_ro2018-published/ROToolkit-ES-CR.pdf)] [[html .zip](http://sandbox.rohub.org/rodl/ROs/ROToolkit_ro2018-published/ROToolkit-ES-CR.zip)] [[research object](http://sandbox.rohub.org/rodl/ROs/ROToolkit_ro2018-published/)]  
