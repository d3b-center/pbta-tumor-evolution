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
mkdir ./CloneFinderAPI/clonefinder_py3/pbta-tumor-evolution-v1

# Adding alias for python to your profile, if you encounter the following issue:
# bash: - : invalid option
# https://github.com/mxe/mxe/issues/2659
alias python=python3

# CloneFinderAPI requires input files to be located where the software lives 
# So, we will copy input files folder into CloneFinder directory
cp -r ./results/CloneFinder_input ./CloneFinderAPI/clonefinder_py3
cp -r ./results/samples_path.tsv ./CloneFinderAPI/clonefinder_py3/CloneFinder_input

# Let's define input and output files location 
# $1 path to input files for CloneFinder: generated in the "01-process-data.Rmd"
# $1 path to input files for CloneFinder: /Users/chronia/CHOP/projects/pbta-tumor-evolution/analyses/tumor-clone-inference/results/CloneFinder_input/samples_path.tsv

# $2 out_path: /Users/chronia/CHOP/software/CloneFinderAPI/clonefinder_py3/pbta-tumor-evolution-v1/

sample=( $( awk -F"," 'FNR>1{print $1}' /Users/chronia/CHOP/projects/pbta-tumor-evolution/analyses/tumor-clone-inference/results/CloneFinder_input/samples_path.tsv ) )
outs=( $( awk -F"," 'FNR>1{print $2}'  /Users/chronia/CHOP/projects/pbta-tumor-evolution/analyses/tumor-clone-inference/results/CloneFinder_input/samples_path.tsv ) )
out_path=/Users/chronia/CHOP/software/CloneFinderAPI/clonefinder_py3/pbta-tumor-evolution-v1/

# array length
echo ${#sample[@]}
echo ${#outs[@]}

#bash script with serial port input
#run from command line

cd /Users/chronia/CHOP/software/CloneFinderAPI/clonefinder_py3/pbta-tumor-evolution-v1

for (( i=1; i<${#outs[@]}; i++ )); 
    do
    /bin/bash --job-name=CloneFinder_"${sample[$i]}" \
        ./02B-CloneFinder-run.sh \
        ${outs[$i]} \
        $out_path \
        ${sample[$i]} 
done