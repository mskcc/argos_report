#!/usr/bin/env cwl-runner
# CWL for compiling report
cwlVersion: v1.0
class: CommandLineTool
baseCommand: [ "compile_sample_level.R" ]
requirements:
  DockerRequirement:
    dockerPull: argos_report-1.0:latest

inputs:
  sample_id:
    type: string
    inputBinding:
      position: 1
      prefix: '--sample_id'
  portal_dir:
    type: Directory
    inputBinding:
      position: 2
      prefix: '--portal_dir'
  analysis_dir:
    type: Directory
    inputBinding:
      position: 3
      prefix: '--analysis_dir'



outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.html"
