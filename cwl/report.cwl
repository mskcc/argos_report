#!/usr/bin/env cwl-runner
# CWL for compiling report
cwlVersion: v1.0
class: CommandLineTool
baseCommand: [ "compile_sample_level.R" ]
requirements:
  DockerRequirement:
    dockerPull: mskcc/argos_report:1.1.0

inputs:
  request_id:
    type: string
    inputBinding:
      position: 1
      prefix: '--request_id'
  normal_id:
    type: string
    inputBinding:
      position: 2
      prefix: '--normal_id'
  tumor_id:
    type: string
    inputBinding:
      position: 2
      prefix: '--tumor_id'
  portal_dir:
    type: Directory
    inputBinding:
      position: 3
      prefix: '--portal_dir'
  analysis_dir:
    type: Directory
    inputBinding:
      position: 4
      prefix: '--analysis_dir'
  oncokb_file:
      type: File
      inputBinding:
        position: 5
        prefix: '--oncokb_file'


outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.html"
