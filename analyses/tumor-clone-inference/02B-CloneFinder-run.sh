#!/bin/bash
# CloneFinder for PBTA Tumor evolution
# Antonia Chroni
#
# Set this so the whole loop stops if there is an error
set -e
set -o pipefail

# cd "$(dirname "${BASH_SOURCE[0]}")"
cd /Users/chronia/CHOP/software/CloneFinderAPI/clonefinder_py3

# We use information from the read_counts input directory 
# generated in the first step of the module while processing the data
# and we will save the clone ohylogenies in a new directory within the results folder

# $1 path to input files for CloneFinder: /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/distinct_samples_list.csv
# $2 out_path: /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/distinct_samples_list.csv


############################ Run CloneFinder script ######################################################################
python clonefinder.py snv ./input/CloneFinder_input_read_count."$1".txt





############################ Remove input files from CloneFinderAPI dir ###################################################

# rm input files from CloneFinderAPI dir


############################ Move output files to results directory of the module ##########################################

# move output files to results directory of the module
