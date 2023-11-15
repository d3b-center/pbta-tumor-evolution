#!/bin/bash

set -e
set -o pipefail

# set up running directory
cd "$(dirname "${BASH_SOURCE[0]}")" 

# Run Rmd script to process data
Rscript -e "rmarkdown::render('01-preprocess-data.Rmd', clean = TRUE)"
Rscript -e "rmarkdown::render('02-create-corplots.Rmd', clean = TRUE)"
Rscript -e "rmarkdown::render('03-explore-TMB-mut.Rmd', clean = TRUE)"
