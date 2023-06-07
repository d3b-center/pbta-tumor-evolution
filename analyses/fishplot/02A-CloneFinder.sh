# CloneFinderAPI for PBTA Tumor evolution
# https://github.com/gstecher/CloneFinderAPI
# Antonia Chroni
#
# install Python
brew install python
# If pip is not installed, you can run:
# python3 get-pip.py

# Dependencies
# python3 -m pip install SciPy NumPy Biopython pandas networkx matplotlib logbook fire pydot
python3 -m pip install SciPy NumPy Biopython

# User needs to have meca-cc installed locally
# the appropriate version can be found here:
# https://www.megasoftware.net/active_download

# Then download the last version of Clonefinder
# set directory
# clone git repo in there
git clone https://github.com/gstecher/CloneFinderAPI.git

# Adding alias for python to your profile, if you encounter the following issue:
# bash: - : invalid option
# https://github.com/mxe/mxe/issues/2659
alias python=python3

# CloneFinderAPI requires input files to be located where the software lives 
# So, we will copy input files folder into CloneFinder directory
cp -r /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/CloneFinder_input_read_count /Users/chronia/CHOP/software/CloneFinderAPI/clonefinder_py3

# Let's define input and output files location 
# $1 path to input files for CloneFinder: generated in the "01-process-data.Rmd"
# $1 path to input files for CloneFinder: /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/distinct_samples_list.csv

# $2 out_path: /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/distinct_samples_list.csv

sample=( $( awk -F"," 'FNR>1{print $1}' /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/distinct_samples_list.csv ) )
outs=( $( awk -F"," 'FNR>1{print $2}'  /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot/results/distinct_samples_list.csv ) )
out_path=/Users/chronia/CHOP/software/CloneFinderAPI/clonefinder_py3/results-pbta-tumor-evolution/

# array length
echo ${#sample[@]}
echo ${#outs[@]}

#bash script with serial port input
#run from command line

cd /Users/chronia/CHOP/projects/pbta-tumor-evolution/pbta-tumor-evolution-analysis/analyses/fishplot

for (( i=1; i<${#outs[@]}; i++ )); 
    do
    /bin/bash --job-name=CloneFinder_"${sample[$i]}" \
        ./02B-CloneFinder-run.sh \
        ${outs[$i]} \
        $out_path \
        ${sample[$i]} 
done