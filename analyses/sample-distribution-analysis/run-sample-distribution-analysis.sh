#!/bin/bash

set -e
set -o pipefail

# set up running directory
cd "$(dirname "${BASH_SOURCE[0]}")" 

# Run Rmd script to process data
Rscript -e "rmarkdown::render('01-tumor-descriptor-and-assay-count.Rmd', clean = TRUE)"
Rscript -e "rmarkdown::render('02-genomic-paired.Rmd', clean = TRUE)"
