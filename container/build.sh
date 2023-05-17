#!/bin/bash
# script to build the R container because it needs the scripts from the bin dir
[ -e report ] && rm -rf report
mkdir report
cp -r ../* report/
docker build -t "mskcc/argos_report:1.0" .
