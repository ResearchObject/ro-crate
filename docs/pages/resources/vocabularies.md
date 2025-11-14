---
title: Vocabularies
description: Useful vocabularies for extending RO-Crates, and tips on how to use them
sidebar: resources
---

# Vocabularies

The RO-Crate specification uses <http://schema.org/> as the [base vocabulary](https://www.researchobject.org/ro-crate/specification/1.2/metadata.html#base-metadata-standard-schemaorg) for describing entities, with a handful of additions from other vocabularies.  These are brought into a particular [RO-Crate metadata document](https://www.researchobject.org/ro-crate/specification/1.2/structure.html#ro-crate-metadata-document-ro-crate-metadatajson) using the JSON-LD key `@context`.

The main principle when [extending RO-Crate](https://www.researchobject.org/ro-crate/specification/1.2/appendix/jsonld#extending-ro-crate) is to identify potential matching types and properties in schema.org and re-use these, allowing for a liberal interpretation. The [schema.org type hierarchy](https://schema.org/docs/full.html) may be helpful for exploring the existing types.  

This is particularly the case when defining a new [profile](https://www.researchobject.org/ro-crate/specification/1.2/profiles.html) for a set of RO-Crates. For instance, the [Workflow Run Crate profiles](https://www.researchobject.org/workflow-run-crate/) uses multipe [`Action`](https://schema.org/Action) subclasses to describe workflow execution. Another advantage of this is that the `@context` do not need to be modified as most schema.org terms are part of the RO-Crate context.

**Note**: The RO-Crate context is based on a released version of schema.org, for instance <https://w3id.org/ro/crate/1.2/context> is based on [schema.org v22.0](https://schema.org/docs/releases.html#v22.0) meaning terms added to schema.org after this date needs to be defined explicitly in `@context`.

In some cases, your crates can benefit from additional vocabularies which might offer extra precision when describing specific domains. [Extending RO-Crate](https://www.researchobject.org/ro-crate/specification/1.2/appendix/jsonld#extending-ro-crate) can be done with [ad-hoc terms](https://www.researchobject.org/ro-crate/specification/1.2/appendix/jsonld#adding-new-or-ad-hoc-vocabulary-terms) or by using an existing RDF vocabulary. Such vocabularies should be noted in the RO-Crate profile [as a `DefinedTermSet` entity](https://www.researchobject.org/ro-crate/specification/1.2/profiles.html#extension-vocabularies). This page suggests how such vocabularies can be identified.

## Vocabulary Sources

Below are some helpful links that might be helpful in finding a vocabulary or ontology that is RO-Crate compatible.
Some vocabularies are indexed in multiple databases.

* [W3C](https://www.w3.org/TR/?filter-tr-name=&tags%5B%5D=data) publishes standards, drafts and notes relating to linked data. Some of these are themselves vocabularies:
    * [`PROV-O`](https://www.w3.org/TR/2013/REC-prov-o-20130430/#prov-o-at-a-glance) which describes provenance
    * [`time`](https://www.w3.org/TR/owl-time/#summary) for describing temporal concepts
    * [`csvw`](https://www.w3.org/TR/tabular-data-primer/) describes how to describe CSV files using linked data
* [DBO (DBpedia Ontology)](https://dbpedia.org/ontology/) is a general purpose ontology for describing Wikipedia data
* [awesome-ontology](https://github.com/ozekik/awesome-ontology?tab=readme-ov-file#ontologies-and-vocabularies) links to other useful databases and ontologies

### Life Sciences

* [BioPortal](https://bioportal.bioontology.org/) indexes some 17 million classes relating to the life sciences
    * [`SNOMED CT`](https://bioportal.bioontology.org/ontologies/SNOMEDCT) provides a medical ontology
    * [`NCIT`](https://bioportal.bioontology.org/ontologies/NCIT) describes a variety of medical concepts, especially relating to cancer
* [EBISPOT (EMBL-EBI Samples, Phenotypes, and Ontologies Team)](https://github.com/orgs/EBISPOT/repositories?language=&q=ontology&sort=&type=all)
    * [EFO (Experimental Factor Ontology)](https://www.ebi.ac.uk/efo/) describes experimental variables
    * [DUO (Data Use Ontology)](http://www.ontobee.org/ontology/DUO) can be used to describe data use and patient consent
* [OBO (Open Biological and Biomedical Ontology Foundry)](https://obofoundry.org/)
    * [OBI (Ontology for Biomedical Investigations)](https://obofoundry.org/ontology/obi.html) describes research projects in the life sciences
    * [GO (Gene Ontology)](https://geneontology.org/) describes the function of genes
    * [CL (Cell Ontology)](https://obofoundry.org/ontology/cl.html) describes cell types
* [Bioschemas](https://bioschemas.org/) extends the schema.org model to include concepts in the life sciences


## General Advice

### IRI Requirement

Not all vocabularies are RO-Crate compatible.
At a minimum, an RO-Crate compatible vocabulary needs to have IRIs for each class and property you want to use.
For example, the [REMBI schema for biological imaging](https://www.ebi.ac.uk/bioimage-archive/rembi-model-reference/) defines some useful types and properties.
However, none of these have IRIs, so how could they fit into RO-Crate?

On the other hand, something like [`EDAM-BIOIMAGING`](https://bioportal.bioontology.org/ontologies/EDAM-BIOIMAGING?p=classes) can be readily used in RO-Crate because, for example, the `Image` class has the IRI of `http://edamontology.org/data_Image`.

### Adapting Vocabularies

If a vocabulary you want to use doesn't have IRIs, you can try to solve this in a few ways:

* Request canonical IRIs from the author of the vocabulary
* Assign IRIs yourself, and publish your IRIs for others to re-use. Some of the [guidance in the specification](https://www.researchobject.org/ro-crate/specification/1.2/appendix/jsonld.html#adding-new-or-ad-hoc-vocabulary-terms) can be helpful here.
* Choose a different vocabulary with IRIs that captures a similar domain

### Making JSON-LD Contexts

If you just want to use one term from a vocabulary, you can just add a new context entry with the ID and term name (e.g. the class's name).
For example, if I wanted to use the `wasInformedBy` property in the PROV-O vocabulary, we could go to [the documentation on that property](https://www.w3.org/TR/prov-o/#wasInformedBy), find the IRI, and then add it to our context:
```json
{
    "@context": [
        "https://w3id.org/ro/crate/1.2/context",
        {
            "wasInformedBy": "http://www.w3.org/ns/prov#wasInformedBy"
        }
    ]
}
```

Some vocabularies publish JSON-LD contexts that you can copy into your crates in order to "import" the vocabulary.
For example, the OME imaging vocabulary has an official context [available here](https://gist.github.com/stefanches7/5b3402331d901bb3c3384bac047c4ac2).

### OWL

If you want to use an entire OWL vocabulary, you can consider using the [`owl2jsonld`](https://github.com/stain/owl2jsonld) tool, for example:

```bash
wget https://github.com/stain/owl2jsonld/releases/download/0.2.1/owl2jsonld-0.2.1-standalone.jar
java -jar owl2jsonld-0.2.1-standalone.jar https://github.com/EBISPOT/efo/releases/download/current/efo.owl
```

Unfortunately this may output uninformative term names like "OBA_0002423".
It is recommended that you instead use the class or property name in this case, e.g.
```json
{
    "@context": [
        "https://w3id.org/ro/crate/1.2/context",
        {
            "CholesterolEsterificationRate ": "http://purl.obolibrary.org/obo/OBA_0002423"
        }
    ]
}
```

### LinkML

You can generate a JSON-LD context from any LinkML schema using the `linkml` Python package

```bash
pip install linkml
linkml generate jsonld-context some-schema.yml
```

### Searching the Web

Different domains describe their vocabularies differently.
You might have more luck by varying these search terms: "vocabulary", "ontology", "schema", "data model".
Then, to make sure the vocabulary uses IRIs and is therefore RO-Crate compatible, you might want to add "RDF", "OWL" or "IRI" to your search.
