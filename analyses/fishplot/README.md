# PBTA fishplot

## Folder content

This folder contains a script tasked to infer and visualize subclones in tumor samples across cancer types and patients in the PBTA dataset.

`01-fishplot.Rmd` is a script written to perform the subclonal inferences on the PBTA dataset.  
This script produces TSV files containing processed input files required for the fishplot analyses and the fishplots per patient sample.   


## Folder structure 

The structure of this folder is as follows:

```
├── 01-fishplot.Rmd
├── 01-fishplot.nb.html
├── input
│   ├── genomic_df.tsv
│   ├── pbta.tsv
├── README.md
├── plots
    ├── fishplot_PT_1H2REHT2.pdf
    ├── fishplot_PT_2MZPGZN1.pdf
    ├── fishplot_PT_962TCBVR.pdf
    ├── fishplot_PT_HXV713W6.pdf
    ├── fishplot_PT_YDFPMXAR.pdf
    ├── fishplot_PT_YGN06RPZ.pdf
├── results
    ├── Kids_First_Participant_ID_keep.tsv
    ├── LGG_filter_pbta.tsv
    ├── pbta_subset.tsv
    └── LGG_filter.tsv
```
