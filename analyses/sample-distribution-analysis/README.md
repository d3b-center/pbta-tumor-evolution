# PBTA sample-distribution-analysis

## Usage

To run all the Rscript in this module from the command line sequentially, use:

```
Rscript -e "rmarkdown::render('01-tumor-descriptor-and-assay-count.Rmd', clean = TRUE)"
```

## Folder content

This folder contains a script tasked to analyze the distribution of samples across cancer types and patients in the PBTA dataset.

`01-tumor-descriptor-and-assay-count-plot.Rmd` is a script written to perform the initial analyses on the PBTA dataset. This script produces TSV files containing the PBTA samples with all and paired gemomic and transcriptomic assays across different time points and cancer types.   

## Results

There are 2248 patient cases in total with longitudinal information. In cases with only genomic assays, there are 1997 patient cases with 119 having matched longitudinal samples. In cases with only transcriptomic assays, there are 1839 patient cases with 106 having matched longitudinal samples. In cases with both paired genomic and transcriptomic assays, there are 1541 patient cases with 81 having matched longitudinal samples.

The five cancer types with the highest number of tumor samples (>100) therein are: Low-grade glioma, Medulloblastoma, Diffuse midline glioma, High-grade glioma, and Ependymoma. 



## Folder structure 

The structure of this folder is as follows:

```
├── 01-tumor-descriptor-and-assay-count-plot.Rmd
├── 01-tumor-descriptor-and-assay-count-plot.nb.html
├── input
│   └── PBTA-germline-histology-groups-plot-mapping.tsv
├── README.md
├── results
    ├── genomic_assays_matched_time_points.tsv
    ├── paired_assays_matched_time_points.tsv
    └── transcriptomic_assays_matched_time_points.tsv
```
