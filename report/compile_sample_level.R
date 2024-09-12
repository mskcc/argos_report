#!/usr/bin/env Rscript
# script to compile report from pipeline data

suppressPackageStartupMessages({
    library(readr)
    library(dplyr)
    library("argparse")
})

VERSION="1.0.3"
default_output_dir <- normalizePath(getwd())

# start arg parser
parser <- ArgumentParser()
parser$add_argument("--request_id", help="Request id")
parser$add_argument("--sample_id", help="Sample id")
parser$add_argument("--analysis_dir", help="analysis_dir path")
parser$add_argument("--portal_dir", help="portal_dir path")
parser$add_argument("--oncokb_file", help="oncokb file path")
parser$add_argument("--output_dir", default=default_output_dir, help="Output dirname")


# parser$add_argument("--geneAnnotation_path", help="Gene annotation file")


args <- parser$parse_args()

#temporary solution to get normal id. if a sample has zero mutations Goliath code can not identify the normal id causeing the report to fail
#ideal solution would be getting the normal id and matching type (matched or POOLED) from the input but that requires the input.json to be updated
#until we get the change in the operator to create the input.json as needed, we place a temporary solution.

sample_pairing_file <- read_tsv(
            file.path(args$portal_dir,"../sample_pairing.txt"),
            col_names = c("Normal", "Tumor"),
            progress=F
            )

args$tumor_id <- args$sample_id
args$normal_id  <- sample_pairing_file[sample_pairing_file$Tumor == args$tumor_id, ]$Normal

output_file_name=paste0("rpt_",args$request_id,"-",args$tumor_id,"__",VERSION,".html")

# compile the HTML report
rmarkdown::render(
    input = "report_sample_level.Rmd",
    params = list(
        analysis_dir = args$analysis_dir,
        portal_dir = args$portal_dir,
        tumor_id = args$tumor_id,
        normal_id = args$normal_id,
        oncokb_file = args$oncokb_file
        # geneAnnotation_path = args$geneAnnotation_path,

    ),
    output_file = output_file_name,
    output_dir = args$output_dir,
    intermediates_dir=tempdir(),
    clean=T
)
