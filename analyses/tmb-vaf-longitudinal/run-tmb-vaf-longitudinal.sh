#!/bin/bash

set -e
set -o pipefail

# set up running directory
cd "$(dirname "${BASH_SOURCE[0]}")" 

# Run Rmd script to process data
Rscript -e "rmarkdown::render('04-create-violin-plots.Rmd', clean = TRUE)"
