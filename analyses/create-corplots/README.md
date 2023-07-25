# VAF Correlation Pipeline

## Usage

To run all of the Rscripts in this module from the command line sequentially, use:

```
bash run-create-corplots.sh
```

`run-create-corplots.sh` is designed to be run as if it was called from this module directory even when called from outside of this directory.

## Folder content

This folder contains scripts tasked to investigate VAFs and TMB across paired longitudinal samples for the autopsy samples in the PBTA dataset.

## Summary 
This pipeline investigates VAFs and TMB across matched samples. It produces pdf files containing the correlation of VAFs (with label genes of interest), as well as violin plots and stacked barplots for TMB of paired longitudinal samples: Diagnosis-Deceased, Progressive-Deceased, Recurrence-Deceased, Diagnosis-Progressive-Deceased, Diagnosis-Recurrence-Deceased, and Progressive-Recurrence-Deceased.

`01-preprocess-data.Rmd` is a script written to process and generate the data to create corplots. (1) Calculate VAFs per each Kids_First_Biospecimen_ID, (2) Select paired longitudinal samples for the autopsy samples, and (3)  Add information of number of timepoints per each patient case. This script generates `maf_autopsy.tsv` file to beused in the next step and is stored in the `scratch` folder located in the root directory.

 
## Folder structure 

The structure of this folder is as follows:

```
├── 01-preprocess-data.Rmd
├── 01-preprocess-data.nb.html
├── input
│   └── snv-mutation-tmb-coding.tsv
├── README.md
└── run-create-corplots.sh
```
