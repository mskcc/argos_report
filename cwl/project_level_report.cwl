#!/usr/bin/env cwl-runner

# concatenate tables; keep the header from the first file, then all lines minus header from all files
#  strip the header comments that start with '#'
cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: mskcc/argos_report:1.1.1

inputs:
  request_id:
    type: string
  normal_ids:
    type: string[]
  tumor_ids:
    type: string[]
  portal_dir:
    type: Directory
  analysis_dir:
    type: Directory
  oncokb_file:
    type: File

steps:
  generate_project_report:
    run: report.cwl
    in:
      request_id: request_id
      normal_id: normal_ids
      tumor_id: tumor_ids
      portal_dir: portal_dir
      analysis_dir: analysis_dir
      oncokb_file: oncokb_file

    scatter: [normal_id,tumor_id]
    scatterMethod: dotproduct
    out: [output_file]


outputs:
  output_file:
    type: File[]
    outputSource: generate_project_report/output_file



