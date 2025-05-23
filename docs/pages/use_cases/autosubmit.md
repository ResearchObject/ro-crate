---
page_id: autosubmit
redirect_from:
    - /in-use/autosubmit
title: Autosubmit
description: Autosubmit is an open source Python experiment and workflow manager used to manage complex workflows on Cloud and HPC platforms. Autosubmit uses RO-Crate to package the configuration, traces (logs, metrics, databases, etc.), and data of experiments and workflows.
url: https://autosubmit.readthedocs.io/
image: autosubmit.svg
domains: [climate_science]
tasks: [conduct_research, data_handling]
roles: [data_analyst, information_architect, managerial, researcher]
---

# Autosubmit

[Autosubmit](https://autosubmit.readthedocs.io/en/master/) is an
experiment and workflow manager that is able to produce Workflow
Run RO-Crate files. Before Autosubmit adopted RO-Crate, the
provenance of workflow runs was available but was it was not
standardized, consisting of configuration and trace files
compressed into a single archive file.

Now, Autosubmit produces a ZIP file with the same content as before,
but it also includes the top level RO-Crate JSON-LD file. In this file
users can find data annotated with persistent identifiers (PID),
and following a pre-defined schema, which makes it not only human-
but also machine-actionable.

The most common use cases for Autosubmit are climate and weather
workflows executed in HPC environments, like
[BSC's MareNostrum](https://www.bsc.es/marenostrum/marenostrum).
The execution logs include metrics from models, Slurm jobs, energy usage,
dependency versions, and more. Now more accessible through RO-Crate.

## Publications

Bruno de Paula Kinoshita, Edgar Garriga Nogales, Manuel Giménez de Castro Marciani, Miguel Castrillo Melguizo (2025):  
**FAIR Digital Objects in Autosubmit Workflows**  
_International FAIR Digital Objects Implementation Summit 2024_, Berlin, Germany, 2024-03-20/--21.  
_Open Conference Proceedings_ **5**  
<https://doi.org/10.52825/ocp.v5i.1416>
