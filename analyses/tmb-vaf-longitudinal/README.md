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
This pipeline investigates VAFs and TMB across matched samples. It produces pdf files containing the correlation of VAFs (with labeled genes of interest), as well as violin plots and stacked barplots for TMB of paired longitudinal samples: Diagnosis-Deceased, Progressive-Deceased, Recurrence-Deceased, Diagnosis-Progressive-Deceased, Diagnosis-Recurrence-Deceased, and Progressive-Recurrence-Deceased.

To generate corplots, we need to create timepoint models that will account for the following conditions: 
(1) We are interested in how VAF values change over the time and specifically for the autopsy samples. 
(2) We will create corplots by keeping Deceased timepoint as constant and any other timepoint paired with it will be the variable. 
(3) There are patient cases with more than one time points in addition to Deceased, e.g. Diagnosis and Progressive. 
(4) There are multiple `Kids_First_Biospecimen_ID` samples per `tumor_descriptor` and `Kids_First_Participant_ID`.

First, we create unique identifiers for each of those cases `match_id_bs`.
Then, we will leverage this information to create one column for the constant variable (`timepoints_deceased`) and one column for the variable (`timepoints_other`). We will replace with numbers any timpoint not relevant to those columns, e.g., there should be only deceased samples in the `timepoints_deceased` so we will replace with numeric values (1-3). Same logic applies for `timepoints_other` only there, we have one value to replace (used 4 for continuity). This system allows us to build a timepoint model to be used for loops that will iterate and create graphs based on any possible combination between timepoints and biospecimen samples per `Kids_First_Participant_ID`.

`01-preprocess-data.Rmd` is a script written to process and generate the data to create corplots. (1) Calculate VAFs per each Kids_First_Biospecimen_ID, (2) Select paired longitudinal samples for the autopsy samples, and (3) Add information of number of timepoints and number of biospecimen samples per each patient case. This script generates `maf_autopsy.tsv` and `tmb_genomic.tsv` files for the next steps and are placed in `../../scratch`.

`03-explore-TMB-mut.Rmd` is a script written to plot stacked barplots for mutation count per patient case and per biospecimen sample and timepoint.

`function-create-barplot.R` is a script containing the functions to create (1) stacked barplots for all samples, and (2) barplots for each `Kids_First_Biospecimen_ID` in `Kids_First_Participant_ID`

`function-create-dumbbell-plot.R` is a script containing the functions to create dumbbell plots for TMB and total number of mutations across timepoints and cancer types per patient case.


## Results

There are 29 autopsy samples out of the total 119 patient cases (with genomic assays) with maf information. There are 117 (out of the 118) patient samples with TMB information. There are 44 biospecimen samples missing from both TMB and VAF files. 


Moreover, we explored TMB and the number of mutations across longitudinal samples with genomic assays. 

Generally, Hypermutant TMB defined as >=10 Mb, and Ultrahypermutant TMB defined as >100 mutations/Mb (https://pubmed.ncbi.nlm.nih.gov/29056344/). There are hyper mutant samples in the PBTA cohort. We excluded samples with >= 10 from downstream analysis. Attention is needed in cases with high number of mutations in only one timepoint as this will lead to un-matched longitudinal samples. We also remove those so we always have matched longitudinal samples.

Overall, TMB patterns across timepoints seem to be idiosyncratic, but we notice a higher overall TMB for Progressive and Recurrence compared to other timepoints. We don’t see any patterns driven by cancer type.

We also explored the total number of mutations per biospecimen sample and per timepoint in each patient case. This is to showcase the importance of the number of samples per timepoint and how each biopsy might be capturing a different number of mutations (and potentially of driver genes). 


## Folder structure 

The structure of this folder is as follows:

```
├── 01-preprocess-data.Rmd
├── 01-preprocess-data.nb.html
├── 03-explore-TMB-mut.Rmd
├── 03-explore-TMB-mut.nb.html
├── input
│   └── snv-mutation-tmb-coding.tsv
├── plots
│   ├── Atypical Teratoid Rhabdoid Tumor-TMB-dumbbell.pdf
│   ├── Diffuse midline glioma-TMB-dumbbell.pdf
│   ├── Ependymoma-TMB-dumbbell.pdf
│   ├── High-grade glioma-TMB-dumbbell.pdf
│   ├── Low-grade glioma-TMB-dumbbell.pdf
│   ├── Medulloblastoma-TMB-dumbbell.pdf
│   ├── Meningioma-TMB-dumbbell.pdf
│   ├── Other-TMB-dumbbell.pdf
│   ├── TMB-genomic-no-hypermutants.pdf
│   └── TMB-genomic-total.pdf
├── README.md
├── results
│   ├── bs_missing_tmb_vaf.tsv
│   └── bs_missing_tmb.tsv
├── run-tmb-vaf-longitudinal.sh
├── util
    ├── function-create-barplot.R
    └── function-create-dumbbell-plot.R
```
