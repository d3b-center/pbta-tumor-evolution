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
This pipeline produces pdf files containing the correlation of VAFs (with label genes of interest), as well as violin plots and stacked barplots for TMB of paired longitudinal samples under various timepoints models, e.g., Diagnosis-Deceased, Progressive-Deceased.

To generate corplots, we need to create timepoint models that will account for the following conditions: 
(1) We are interested in how VAF values change over the time and specifically for the autopsy samples. 
(2) We will create corplots by keeping Deceased timepoint as constant and any other timepoint paired with it will be the variable. 
(3) There are patient cases with more than one time points in addition to Deceased, e.g. Diagnosis and Progressive. 
(4) There are multiple `Kids_First_Biospecimen_ID` samples per `tumor_descriptor` and `Kids_First_Participant_ID`.

First, we create unique identifiers for each of those cases `match_id_bs`.
Then, we will leverage this information to create one column for the constant variable (`timepoints_deceased`) and one column for the variable (`timepoints_other`). We will replace with numbers any timpoint not relevant to those columns, e.g., there should be only deceased samples in the `timepoints_deceased` so we will replace with numeric values (1-3). Same logic applies for `timepoints_other` only there, we have one value to replace (used 4 for continuity). This system allows us to build a timepoint model to be used for loops that will iterate and create graphs based on any possible combination between timepoints and biospecimen samples per `Kids_First_Participant_ID`.

`01-preprocess-data.Rmd` is a script written to process and generate the data to create corplots. (1) Calculate VAFs per each Kids_First_Biospecimen_ID, (2) Select paired longitudinal samples for the autopsy samples, and (3) Add information of number of timepoints and number of biospecimen samples per each patient case. This script generates `maf_autopsy.tsv` and `tmb_genomic.tsv` files for the next steps and are placed in `../../scratch`.

`02-create-corplots.Rmd` is a script written to create corplots for patient cases with multiple biospecimen samples and matched time points. 

`function-create-corplot.R` is a script written for the function to create corplots.


## Results

There are 29 autopsy samples out of the total 119 patient cases (with genomic assays) with maf information. There are 117 (out of the 118) patient samples with TMB information. There are 44 biospecimen samples missing from both TMB and VAF files. 


- Genes shown in the plots are based on the oncoprint goi list from OpenPedCan.
- Multiple plots are generated based on the number of biospecimen samples per tumor descriptor.
- Be aware of differences between plots with the same biospecimen samples. These might show in one as tumor descriptor-specific and in another as common.
- Multiple biospecimen samples/tumor descriptor capture a variety of heterogeneity. We should consider including all biospecimen samples/tumor descriptor and merge that information into one.
- Deceased samples have higher VAFs overall compared to their counterparts in other timepoints.
- Biospecimen samples are from different tumor locations. We will obtain that information after the Nautilus harmonization (primary_site column in histologies). If so, that would allow us to perform spatial heterogeneity analysis ([ticket #19](https://github.com/d3b-center/pbta-tumor-evolution/issues/19)).
- "PT_3CHB9PK5", "PT_6N825561": These samples are hyper-mutant compared to the rest of the samples (VAF corplot).


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
├── results
│   ├── bs_missing_tmb_vaf.tsv
│   └── bs_missing_tmb.tsv
├── README.md
├── run-tmb-vaf-longitudinal.sh
├── util
    └── function-create-corplot.R
```
