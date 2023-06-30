#!/bin/bash
# Following files needs to be present in the same folder as this script:
# 1. 2019-01-03-allpdx-clean-maf-241.rda
# 2. all_models.txt
# 3. same_phase_all_models.txt
# 4. barplot_OS-36-SJ-36.txt (for total mutations for OS - barplot)
# 5. total_Mutations-All-Dx-Relapse-Models.csv (for total mutations across all samples - stacked barplot)
# 6. barplot_ALL-102-105-115.csv (for total mutations for ALL-105/115 - barplot)
# 6. A folder named final-gene-lists containing all final gene lists
# 7. Scripts 1-5 in the same folder

# NOTE: change .libPaths() in the 5-plots.r script to the respective libPath of the terminal
# Requirement: Python 3.6
# Usage: ./pipeline.sh

# Checking the python version

PYV=`python -c "import sys;t='{v[0]}{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";`
if [[ "$PYV" -lt "36" ]]
then 
    echo "No compatible python version found. Requires python 3.6!"
    exit 1
else
    echo "Using $(python -V 2>&1)"
fi


echo "Pulling the data from MAF file..."

Rscript 1-pull-data.r

echo "Organizing files into Dx-Relapse and Same-phase folders..."

python 2-organize-files.py

echo "Restructuring Data..."

python 3-restructure-data.py

echo "Labelling genes..."

python 4-labelling-genes.py

echo "Plotting samples..."

Rscript 5-plots.r

echo "Finished!"