# Pipeline for creating VAF Correlation and TMB stacked barplots and violin plots

## Usage

To run all of the Rscripts in this module from the command line sequentially, use:

```
bash run-tmb-vaf-longitudinal.sh
```

`run-tmb-vaf-longitudinal.sh` is designed to be run as if it was called from this module directory even when called from outside of this directory.

## Folder content

This folder contains scripts tasked to investigate VAFs and TMB across paired longitudinal samples for the autopsy samples in the PBTA cohort.

## Summary 
This pipeline investigates VAFs and TMB across matched samples. It produces pdf files containing the correlation of VAFs (with label genes of interest), as well as violin plots and stacked barplots for TMB of paired longitudinal samples: Diagnosis-Deceased, Progressive-Deceased, Recurrence-Deceased, Diagnosis-Progressive-Deceased, Diagnosis-Recurrence-Deceased, and Progressive-Recurrence-Deceased.

`01-preprocess-data.Rmd` is a script written to process and generate the data to create corplots. (1) Calculate VAFs per each Kids_First_Biospecimen_ID, (2) Select paired longitudinal samples for the autopsy samples, and (3) Add information of number of timepoints and number of biospecimen samples per each patient case. This script generates `maf_autopsy.tsv` and `tmb_autopsy.tsv` files for the next steps and are placed in `../../scratch`.

`02-create-corplots.Rmd` is a script written to create corplots for patient cases with multiple biospecimen samples and matched time points. 

`function-create-corplot.R` is a script written for the function to create corplots.

## Folder structure 

The structure of this folder is as follows:

```
├── 01-preprocess-data.Rmd
├── 01-preprocess-data.nb.html
├── 02-create-corplots.nb.html
├── 02-create-corplots.Rmd
├── input
│   ├── oncoprint-goi-lists-OpenPedCan-gencode-v39.csv
│   └── snv-mutation-tmb-coding.tsv
├── plots
├── README.md
├── run-tmb-vaf-longitudinal.sh
├── util
    └── function-create-corplot.R
```
