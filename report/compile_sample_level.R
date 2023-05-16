#!/usr/bin/env Rscript
# script to compile report from pipeline data
library("argparse")

VERSION="1.0.1"


# start arg parser
parser <- ArgumentParser()
parser$add_argument("--sample_id", help="Sample id")
parser$add_argument("--analysis_dir", help="analysis_dir path")
parser$add_argument("--portal_dir", help="portal_dir path")
parser$add_argument("--output_dir", help="Output directory") # ToDo: make default current working dir. default=default_output_dir, 

# parser$add_argument("--geneAnnotation_path", help="Gene annotation file")


args <- parser$parse_args()

projectNo=stringi::stri_match(args$argosDir,regex="argos/([^/]+)/")[2]
output_file_name=paste0("rpt_",projectNo,"-",args$sample_id,"__",VERSION,".html")

# compile the HTML report
rmarkdown::render(
    input = "report_sample_level.Rmd", 
    params = list(
        analysis_dir = args$analysis_dir,
        portal_dir = args$portal_dir,
        sample_id=args$sample_id
        # geneAnnotation_path = args$geneAnnotation_path,

    ),
    output_file = output_file_name,
    output_dir = args$output_dir,
    intermediates_dir=tempdir(),
    clean=T
)