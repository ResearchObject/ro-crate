---
page_id: survey-ontology
redirect_from:
    - /in-use/survey-ontology
title: Survey Ontology
description: The Survey Ontology is an open vocabulary that allows representing, annotating and sharing a representation of the survey structure and the gathered responses.
url: https://w3id.org/survey-ontology
image: 
domains: [informatics, social_science]
tasks: [conduct_research, manage_data]
roles: [data_analyst, researcher]
---
## Survey Ontology
The [Survey Ontology](https://w3id.org/survey-ontology) is an open vocabulary that allows representing, annotating and sharing a representation of the survey structure and the gathered responses ([Scrocca et al., 2021](https://doi.org/10.4126/FRL01-006429412)).

The Survey Ontology leverages and extends the _Research Object Suite of Ontologies_ ([Belhajjame et al., 2015](https://doi.org/10.1016/j.websem.2015.01.003)) to address the research object principles of identity, aggregation and provenance. 

The Survey Ontology models:

* a complete survey research study as a research object, 
* the survey procedure as a scientific workflow ([_wfdesc_ module](http://purl.org/wf4ever/wfdesc)), and 
* the survey’s collected answers as provenance traces of its execution ([_wfprov_ module](http://purl.org/wf4ever/wfprov)).

A _survey research object_ aggregates two main resources identified in the ontology: (i) a _survey procedure_, describing the survey structure (questions, answers, etc.), and (ii) a _survey dataset_, containing the collected answers. 

Moreover, a survey research object can aggregate _any other additional resource_, e.g., representing study hypotheses, investigated variables, models produced from the result analysis, related publications, etc.

Considering a _survey procedure_, all the questions can be annotated with the respective latent variable investigated. Moreover, closed answers can be associated with both a qualitative value, a textual label to be displayed in the chat, and a quantitative value, the numerical coding for results analysis.

[Coney](https://coney.cefriel.com/), the conversational survey tool, allows to automatically export data of surveys designed and administered through it using the Survey Ontology.


### Use case: Survey Study about Motivation for Participants in Citizen Science Projects

This section describes the research objects defined and published to share a survey study of motivation for citizen scientists performed within the [ACTION project](https://actionproject.eu/). The research objects leverage the RO-Crate specification and the Survey Ontology to describe the relevant resources and their relations.

{% include image.html src="assets/img/survey-ontology-example.png" alt="RO-Crate preview of Survey Ontology." caption="RO-Crate preview of Survey Ontology. Link to dataset: https://doi.org/10.5281/zenodo.5753092" %}

Survey data exported from Coney and modelled using the Survey Ontology, are packaged in comprehensive RO-Crate research objects including:

* the representation of the survey procedure,
* the collected answers with provenance information, 
* the script and results of the analysis, and
* related publications.

Resources made available within each research object are:

* _Survey Procedure_ (`*-procedure.ttl`): contains the RDF representation of the structure of the conversational survey (questions, answers, etc.) using the Survey Ontology
* _Survey Results_ (`*-results.ttl`): contains the RDF representation of the answers collected using the Survey Ontology
* _Survey_ (`*-survey.ttl`): contains a comprehensive RDF representation of the survey data using the Survey Ontology
* _CSV Survey Results _(`*-results.csv`): contains the CSV of the collected answers
* _Analysis Script_ (`*-script.R`): is the R script developed to analyse the collected answers
* _Mean-Var-Questions_ (`*-mean-var-motivating-questions.csv`): contains the computed mean and average for each question considered (observable variables)
* _Mean-Var-Factor_ (`*-mean-var-motivating-factor.csv`): contains the computed mean and average for each motivation factor considered (latent variables)
* _Correlation-Global-Motivation_ (`*-correlation-factors-global-motivation.csv`): contains the correlation analysis between each motivation factor and the global motivation

Each RO-Crate also defines two `CreateAction` entities to describe [provenance information](https://www.researchobject.org/ro-crate/1.1/provenance.html):

* _Export Survey Data_: specifies which files, representing survey data, were extracted using Coney;
* _Run survey results analysis_: specifies (i) which file, representing the CSV results of the survey, was used to run the analysis, (ii) which file, representing the R script, was used to run the analysis, and (iii) specifies which files, representing the results of the analysis, were generated.

The defined research objects are publicly available on Zenodo within the ACTION community. The RO-Crates for each administered survey have the following identifiers:

* Walk Up Aniene Motivation Survey <https://doi.org/10.5281/zenodo.5753229>
* TESS Network Motivation Survey <https://doi.org/10.5281/zenodo.575376>
* Restart Data Workbench Motivation Survey <https://doi.org/10.5281/zenodo.5753123>
* Open Soil Atlas Motivation Survey <https://doi.org/10.5281/zenodo.5752354>
* Mapping Mobility Motivation Survey <https://doi.org/10.5281/zenodo.5727476>
* Wow Nature Motivation Survey <https://doi.org/10.5281/zenodo.5770198>
* Water Sentinels Motivation Survey <https://doi.org/10.5281/zenodo.5770164>

The research object for the overall study _“Survey Study about Motivation for Participants in Citizen Science Projects”_ is identified with <https://doi.org/10.5281/zenodo.5753092> and references all the others.

The survey research data made available in the RO-Crates using the Survey Ontology, have been also published as [Linked Open Data](https://www.w3.org/standards/semanticweb/data). 

Each RO-Crate on Zenodo lists as a _related_ _identifier_ the IRI assigned to the _survey research object_ entity described in RDF. For example, <https://coney.cefriel.com/lod/Survey_626734392-1569918565818> identifies the one for the _TESS Network Motivation Study_.

Exploiting a customisation of the [LodView](https://github.com/LodLive/LodView) framework, the data can be easily navigated through a user interface and downloaded in different formats. The interface is also enriched with the ontology documentation and offers information on the entities and properties used for the data. A [SPARQL](https://www.w3.org/TR/sparql11-query/) endpoint is available at <https://coney.cefriel.com/sparql> to semantically query and discover the available data.


## Resources

* Survey Ontology: <https://w3id.org/survey-ontology>
* Example RO-Crate: <https://doi.org/10.5281/zenodo.5753092>
* Coney Toolkit: <https://coneytoolkit.cefriel.it/>
* Slides: https://repository.publisso.de/resource/frl:6430057/data


## Publications

Mario Scrocca, Damiano Scandolari, Gloria Re Calegari, Ilaria Baroni, Irene Celino (2021):  
[**The Survey Ontology: Packaging Survey Research as Research Objects**](https://repository.publisso.de/resource/frl:6430056/data).  
_2nd Workshop on Data and Research Objects Management for Linked Open Science_
<https://doi.org/10.4126/FRL01-006429412>

Esteban Gonzalez, Mario Scrocca, Oscar Corcho (2022):  
**D4.7 - Research Objects Catalogue v2**.
Project Deliverable, ACTION, _Zenodo_  
<https://doi.org/10.5281/zenodo.6346392>

Esteban Gonzalez, Oscar Corcho. (2022):  
**D4.5 - Open Data Portal v2**.  
Project Deliverable, ACTION, _Zenodo_  
<https://doi.org/10.5281/zenodo.6346406>
