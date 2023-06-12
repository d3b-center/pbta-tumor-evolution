# PBTA sample-distribution-analysis

## Folder content

This folder contains a script tasked to analyze the distribution of samples across cancer types and patients in the PBTA dataset.

`01-tumor-descriptor-and-assay-count-plot.Rmd` is a script written to perform the initial analyses on the PBTA dataset.  
This script produces TSV files containing the PBTA samples wit all and paired gemomic and transcriptomic assays across different time points and cancer types.   


## Folder structure 

The structure of this folder is as follows:

```
├── 01-tumor-descriptor-and-assay-count-plot.Rmd
├── 01-tumor-descriptor-and-assay-count-plot.nb.html
├── input
│   ├── histologies.tsv
│   ├── PBTA-germline-histology-groups-plot-mapping.tsv
├── README.md
├── results
    ├── DML.tsv
    ├── Ependymoma.tsv
    ├── genomic_df_filter.tsv
    ├── genomic_df.tsv
    ├── HGG.tsv
    ├── LGG.tsv
    ├── Medulloblastoma.tsv
    ├── paired_assays_all_filter.tsv
    ├── paired_assays_all.tsv
    ├── pbta.tsv
    └── transcriptomic_df.tsv
```
