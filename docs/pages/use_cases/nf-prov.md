---
page_id: nf-prov
title: nf-prov Nextflow plugin
description: nf-prov is a Nextflow plugin to generate provenance information for pipeline runs. It includes support for the Workflow Run RO-Crate format.
url: https://github.com/nextflow-io/nf-prov
domains: []
tasks: [conduct_research, software_development]
roles: [researcher, software_developer]
---


# The nf-prov Nextflow plugin

[Nextflow](https://www.nextflow.io/) is a computational workflow manager that enables the development of complex pipelines by composing many simple processes. [nf-prov](https://github.com/nextflow-io/nf-prov) is a Nextflow plugin to generate provenance information for pipeline runs. It supports serialization in the [BioCompute Object](https://biocomputeobject.org/) and [Workflow Run RO-Crate](https://www.researchobject.org/workflow-run-crate/) (WRROC) formats. WRROC support is available since version 1.4.0 of the plugin.

To enable RO-Crate generation, add the following to the Nextflow configuration:

```groovy
plugins {
    id 'nf-prov@1.4.0'
}

prov {
    enabled = true
    formats {
        wrroc {
            file = "${params.outdir}/ro-crate-metadata.json"
            overwrite = true
            agent {
                name = "Jane Doe"
                orcid = "https://orcid.org/0000-0000-0000-0000"
            }
            license = "https://spdx.org/licenses/MIT"
        }
    }
}
```

The above snippet is just an example. To get an overview of the available configuration options, check out the [documentation for the WRROC format](https://github.com/nextflow-io/nf-prov/blob/main/docs/WRROC.md).

To try the plugin, move to an empty directory and save the above snippet to a file called `nextflow.config`. Then run:

```
nextflow run rnaseq-nf -profile docker --outdir results
```

The `results` directory will contain the pipeline output and an `ro-crate-metadata.json` file with the RO-Crate metadata.


## Resources

* [nf-prov GitHub repository](https://github.com/nextflow-io/nf-prov)
* [Workflow Run RO-Crate](https://www.researchobject.org/workflow-run-crate/)
