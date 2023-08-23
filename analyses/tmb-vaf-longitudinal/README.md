# Pipeline for creating VAF Correlation and TMB plots

## Usage

To run all of the Rscripts in this module from the command line sequentially, use:

```
bash run-tmb-vaf-longitudinal.sh
```

`run-tmb-vaf-longitudinal.sh` is designed to be run as if it was called from this module directory even when called from outside of this directory.

## Folder content

This folder contains scripts tasked to investigate VAFs and TMB across paired longitudinal samples for the autopsy samples in the PBTA cohort.

## Summary 
This pipeline produces pdf files containing the correlation of VAFs (with label genes of interest), as well as violin plots and stacked barplots for TMB of paired longitudinal samples under various timepoints models, e.g., Diagnosis-Deceased, Progressive-Deceased.

To generate corplots, we need to create timepoint models that will account for the following conditions: 
(1) We are interested in how VAF values change over the time and specifically for the autopsy samples. 
(2) We will create corplots by keeping Deceased timepoint as constant and any other timepoint paired with it will be the variable. 
(3) There are patient cases with more than one time points in addition to Deceased, e.g. Diagnosis and Progressive. 
(4) There are multiple `Kids_First_Biospecimen_ID` samples per `tumor_descriptor` and `Kids_First_Participant_ID`.

First, we create unique identifiers for each of those cases `match_id_bs`.
Then, we will leverage this information to create one column for the constant variable (`timepoints_deceased`) and one column for the variable (`timepoints_other`). We will replace with numbers any timpoint not relevant to those columns, e.g., there should be only deceased samples in the `timepoints_deceased` so we will replace with numeric values (1-3). Same logic applies for `timepoints_other` only there, we have one value to replace (used 4 for continuity). This system allows us to build a timepoint model to be used for loops that will iterate and create graphs based on any possible combination between timepoints and biospecimen samples per `Kids_First_Participant_ID`.

`01-preprocess-data.Rmd` is a script written to process and generate the data to create corplots. (1) Calculate VAFs per each Kids_First_Biospecimen_ID, (2) Select paired longitudinal samples for the autopsy samples, and (3) Add information of number of timepoints and number of biospecimen samples per each patient case. This script generates `maf_autopsy.tsv` and `tmb_genomic.tsv` files for the next steps and are placed in `../../scratch`.

`04-tmb-unpaired-samples-plot.Rmd` is a script written to process TMB data, generate summary statistics and plots for unpaired longitudinal samples and across cancer types. 

## Results

Overall, we have more samples for Diagnosis compared to the rest of the timepoints (1556). That makes it hard to draw conclusions. On the other hand, when looking at the cancer types with the most samples (ATRT, HGG, LGG and Medulloblastoma) and compared to the rest of them, there is an indication of increase of TMB for Recurrence and Deceased samples compared to Diagnosis. This is significant only for the `Ependymoma` samples.

## Folder structure 

The structure of this folder is as follows:

```
├── 01-preprocess-data.Rmd
├── 01-preprocess-data.nb.html
├── 04-tmb-unpaired-samples-plot.Rmd
├── 04-tmb-unpaired-samples-plot.nb.html
├── input
│   └── snv-mutation-tmb-coding.tsv
├── plots
    ├── TMB-Bxp-stat-test.pdf
    ├── TMB-jitter-stat-test.pdf
    ├── TMB-unpaired-longitudinal-samples-cancer-type.pdf
│   └── TMB-unpaired-longitudinal-samples.pdf
├── results
│   ├── bs_missing_tmb_vaf.tsv
│   └── bs_missing_tmb.tsv
├── README.md
└── run-tmb-vaf-longitudinal.sh
```
