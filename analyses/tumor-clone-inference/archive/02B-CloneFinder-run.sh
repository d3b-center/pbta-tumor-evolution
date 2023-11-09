#!/bin/bash
# CloneFinder for PBTA Tumor evolution
# Antonia Chroni
#
# Set this so the whole loop stops if there is an error
set -e
set -o pipefail

# cd "$(dirname "${BASH_SOURCE[0]}")"
cd ./CloneFinderAPI/clonefinder_py3

# We use information from the read_counts input directory 
# generated in the first step of the module while processing the data
# and we will save the clone ohylogenies in a new directory within the results folder

# $1 path to input files for CloneFinder: /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/distinct_samples_list.csv
# $2 out_path: /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/distinct_samples_list.csv


############################ Run CloneFinder script ######################################################################
python clonefinder.py snv ./CloneFinder_input/"$1".txt

python clonefinder.py snv ./CloneFinder_input/Adamantinomatous Craniopharyngioma_PT_CBTW4E3X.txt

python clonefinder.py snv /Users/chronia/CHOP/GitHub/pbta-tumor-evolution/analyses/tumor-clone-inference/CloneFinderAPI/input/Input.txt


/Users/chronia/CHOP/GitHub/pbta-tumor-evolution/analyses/tumor-clone-inference/CloneFinderAPI/clonefinder_py3


############################ Remove input files from CloneFinderAPI dir ###################################################

# rm input files from CloneFinderAPI dir


############################ Move output files to results directory of the module ##########################################

# move output files to results directory of the module
