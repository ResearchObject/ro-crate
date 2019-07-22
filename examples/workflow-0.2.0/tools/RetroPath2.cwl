#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand:
arguments: ["output.dir=$(runtime.outdir)"]
hints:
  DockerRequirement:
    dockerPull: ibisba/retropath2:latest
inputs:
  input.rulesfile:
    type: File
    inputBinding:
      prefix: input.rulesfile=
      separate: false
  input.sourcefile:
    type: File
    inputBinding:
      prefix: input.sourcefile=
      separate: false
  input.sinkfile:
    type: File?
    inputBinding:
      prefix: input.sinkfile=
      separate: false
  input.cofsfile:
    type: File?
    inputBinding:
      prefix: input.cofsfile=
      separate: false

  input.topx:
    type: int?
    inputBinding:
      prefix: input.topx=
      separate: false
  input.max-steps:
    type: int?
    inputBinding:
      prefix: input.max-steps=
      separate: false
  input.dmin:
    type: int?
    inputBinding:
      prefix: input.dmin=
      separate: false
  input.dmax:
    type: int?
    inputBinding:
      prefix: input.dmax=
      separate: false
  input.mwmax-source:
    type: int?
    inputBinding:
      prefix: input.mwmax-source=
      separate: false
  input.mwmax-cof:
    type: int?
    inputBinding:
      prefix: input.mwmax-cof=
      separate: false
  input.stereo_mode:
    type: string?
    inputBinding:
      prefix: input.stereo_mode=
      separate: false
  input.std_mode:
    type: string?
    inputBinding:
      prefix: input.std_mode=
      separate: false
#dev.prefilter-rm-brakets int
#dev.use-py-fire int
#dev.py-fire-timeout int
#dev.source-chunk-size int
#dev.py-fire-procs int
#dev.scope-filter-bootstraps int
#dev.scope-filter-stepback int
#dev.scope-filter-samestep int

outputs:
  solutionfile:
    type: File
    outputBinding:
      glob: results.csv
  sourceinsinkfile:
    type: File?
    outputBinding:
      glob: source-in-sink.csv
  stdout:
    type: stdout

stdout: output.txt

