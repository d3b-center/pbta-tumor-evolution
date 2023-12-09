#!/bin/bash
# FastClone for PBTA Tumor evolution
# Antonia Chroni <chronia@chop.edu> for D3B
#
# Set this so the whole loop stops if there is an error
set -e
set -o pipefail


# Download the last version of FastClone
# set directory
# clone git repo in there
git clone https://github.com/GuanLab/FastClone_GuanLab.git
mkdir ./FastClone_GuanLab

# cd "$(dirname "${BASH_SOURCE[0]}")"
cd ./FastClone_GuanLab

# We use information from the read_counts input directory 
# generated in the first step of the module while processing the data
# and we will save the clone ohylogenies in a new directory within the results folder

# $1 path to input files for FastClone_GuanLab: /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/distinct_samples_list.csv
# $2 out_path: /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/distinct_samples_list.csv


############################ Run FastClone ######################################################################
#python clonefinder.py snv ./CloneFinder_input/"$1".txt

fastclone load-pyclone prop ./fastclone-input/PT_KTRJ8TFY.tsv None solve ./fastclone-output/PT_KTRJ8TFY

# PT_KZ56XHJT.tsv
fastclone load-pyclone prop ./fastclone-input/PT_KZ56XHJT.tsv None solve ./fastclone-output/PT_KZ56XHJT

# PT_Z4BF2NSB.tsv
fastclone load-pyclone prop ./fastclone-input/PT_Z4BF2NSB.tsv None solve ./fastclone-output/PT_Z4BF2NSB

############################ Remove input files from `FastClone_GuanLab`` dir ###################################################

# rm files 


############################ Move output files to results directory of the module ##########################################

# move output files to results directory of the module
