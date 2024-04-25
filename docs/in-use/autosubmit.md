---
title: Autosubmit
parent: RO-Crate In Use
---
<!--
   Copyright 2023-2024 RO-Crate contributors
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

## Autosubmit

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
