#!/usr/bin/env Rscript
# script to compile report from pipeline data

suppressPackageStartupMessages({
    library(readr)
    library(dplyr)
    library("argparse")
})

VERSION="dev"
default_output_dir <- normalizePath(getwd())

# start arg parser
parser <- ArgumentParser()
parser$add_argument("--request_id", help="Request id")
parser$add_argument("--normal_id", help="Normal sample id")
parser$add_argument("--tumor_id", help="Tumor sample id")
parser$add_argument("--analysis_dir", help="analysis_dir path")
parser$add_argument("--portal_dir", help="portal_dir path")
parser$add_argument("--oncokb_file", help="oncokb file path")
parser$add_argument("--output_dir", default=default_output_dir, help="Output dirname")


# parser$add_argument("--geneAnnotation_path", help="Gene annotation file")


args <- parser$parse_args()

output_file_name=paste0("rpt_",args$request_id,"-",args$normal_id,"__",args$tumor_id,"__",VERSION,".html")

# compile the HTML report
rmarkdown::render(
    input = "/usr/report/report_sample_level.Rmd",
    params = list(
        analysis_dir = args$analysis_dir,
        portal_dir = args$portal_dir,
        normal_id = args$normal_id,
        tumor_id = args$tumor_id,
        oncokb_file = args$oncokb_file
        # geneAnnotation_path = args$geneAnnotation_path,

    ),
    output_file = output_file_name,
    output_dir = args$output_dir,
    intermediates_dir=tempdir(),
    clean=T
)
