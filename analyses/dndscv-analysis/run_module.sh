#!/bin/bash

set -e
set -o pipefail

## download hg38 fasta file if the file does not exist
if [ -e "input/genome-files/hg38.fa"]; then
  echo "HG38 fasta file is already there"
else
  wget -P ./input/genome-files https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
  gunzip ./input/genome-files/hg38.fa.gz
fi
  
## run the script to build reference RData
Rscript --vanilla 01_dndscv_ref.R
Rscript -e "rmarkdown::render('02_run_dNdScv.Rmd', clean = TRUE)"
