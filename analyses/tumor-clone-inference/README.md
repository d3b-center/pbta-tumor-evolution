# PBTA tumor-clone-inference

## Folder content

This folder contains scripts tasked to infer and visualize subclones in tumor samples across cancer types and patients in the PBTA dataset.

`01-process-data.Rmd` is a script written to process and generate input files for inferring (1) clone phylogenies and (2) fishplots per patient sample. This script produces: (i) table with patient samples with at least 2 tumor samples per anatomical site, (ii) CSV/TXT files with Read counts for each patient sample from (i). 

NOTE: The CloneFinder_input_read_count_csv folder should generate multiple CSV files. This was too large to upload to git repo. Instead I kept one generated file as an example (01_Read_count_Per_Patient.PT_KTRJ8TFY.csv).


`02A-CloneFinder.sh` is a bash file with serial port input. This also describes the steps for installing/running CloneFinder. We will use this to deconvolute tumor samples, as well as to infer number of clones, clone frequency table and clone phylogeny. We need to be mindful for cases with low read counts and discard those, if necessary. We will need to decide on a threshold for this and apply for all. -IN PROGRESS-


`02B-CloneFinder-run-v2.sh` is the bash file running CloneFinder. -IN PROGRESS-


`03-fishplot.Rmd` is a script written to perform the subclonal inferences on the PBTA dataset by using fishplot approach. We will define timepoints as indicated in "age_at_event_days_mut" column. Frac.table needs clone frequency (not VAF) as input. 90 indicates that 90% of the cells contain the mutation. We will use clone frequency table generated from `02A-CloneFinder.sh` as frac.table (this might need to be modified). Parents need to be defined by the inferred phylogeny of the tumor (Which subclones are descended from which other clones?). For the parents, NY clones with high frequencies should be the parent clones with the ones with low frequencies BEING their descendants (based on logic and lit.). We will need to decide on a threshold for this and apply for all. -IN PROGRESS-
 

NOTE: If CloneFinder doesn't work, I can also try clonevol for inferring clone frequencies for fishplot.

## Folder structure 

The structure of this folder is as follows:

```
├── 01-process-data.Rmd
├── 01-process-data.nb.html
├── input
│   ├── genomic_df_filter.tsv
│   ├── genomic_df.tsv
│   ├── pbta.tsv
├── README.md
├── results
    ├── 01_Read_count_Per_Patient
    │    └── 01_Read_count_Per_Patient.PT_KTRJ8TFY.csv
    ├── 02_CloneFinder_input_files  
    ├── distinct_samples_list.csv
    ├── genomic_df_subset_keep.tsv
    └── genomic_df_subset.tsv
```