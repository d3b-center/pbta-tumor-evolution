# VAF Correlation Pipeline

## Summary 
This pipeline plots VAF values across multiple timepoints in the PBTA cohort, label genes of interest and generates plots of total number of mutation across various samples.


`1-process-data_VAF.Rmd` is a script written to investigate VAFs and TMB across matched samples(Violin_plot and stacked barplots). This script also produces pdf files containing the correlation of VAFs of paired longitudinal samples, i.e., Dx-Deceased, Progressive-Deceased, and Recurrence-Deceased.   


## Folder structure 

The structure of this folder is as follows:

```
├── 1-process-data_VAF.Rmd
├── 1-process-data_VAF.nb.html
├── input
│   └── snv-mutation-tmb-coding.tsv
├── README.md
├── plots
│   ├── Dx_Dec
│   │  ├── Corplot_PT_Z4BF2NSB.pdf
│   │  ├── Corplot_PT_RJ1TJ2KH.pdf
│   │  ├── Corplot_PT_PR4YBBH3.pdf
│   │  ├── Corplot_PT_NZ85YSJ1.pdf
│   │  ├── Corplot_PT_NJQ26FHN.pdf
│   │  ├── Corplot_PT_MNSEJCDM.pdf
│   │  ├── Corplot_PT_KZ56XHJT.pdf
│   │  ├── Corplot_PT_KTRJ8TFY.pdf
│   │  ├── Corplot_PT_KBFM551M.pdf
│   │  ├── Corplot_PT_HJMP6PH2.pdf
│   │  ├── Corplot_PT_GTHZF21E.pdf
│   │  ├── Corplot_PT_FA2F3HQG.pdf
│   │  ├── Corplot_PT_DVXE38EX.pdf
│   │  ├── Corplot_PT_CXT81GRM.pdf
│   │  ├── Corplot_PT_75HRTX4S.pdf
│   │  ├── Corplot_PT_5NS35B66.pdf
│   │  ├── Corplot_PT_3KM9W8S8.pdf
│   │  ├── Corplot_PT_3CHB9PK5.pdf
│   │  ├── Corplot_PT_394ZA6P7.pdf
│   │  ├── Corplot_PT_37B5JRP1.pdf
│   │  ├── Corplot_PT_23NZGSRJ.pdf
│   │  └── Corplot_PT_19GCSK2S.pdf
│   ├── Pro_Dec
│   │  ├── Corplot_PT_1H2REHT2.pdf
│   │  ├── Corplot_PT_6N825561.pdf
│   │  └── Corplot_PT_WYXTEG3E.pdf
│   ├── Rec_Dec
│   │   └──Corplot_PT_DNAJYFZT.pdf
│   ├── Stacked_barplot_tumor_descriptor_Deceased_rm_PT_3CHB9PK5.pdf
│   ├── Stacked_barplot_tumor_descriptor_Deceased.pdf
│   └── Violin_plot_tumor_descriptor_Deceased.pdf
├── results
│   └── genomic_df_subset.tsv
└── run-create-corplots.sh
```
