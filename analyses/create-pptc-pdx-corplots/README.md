# VAF Correlation Pipeline

## Summary 
This pipeline plots VAF values across multiple timepoints in the PBTA cohort, label genes of interest and generates plots of total number of mutation across various samples.

## How to run
`Rscript DNA-RNA-VAF.R <DNA_MAF.rda> <RNA_MAF.maf> <clinical_file.txt>`







Following files needs to be present in the same folder as pipeline.sh script:
 1. 2018-08-22-allpdx-clean-maf.rda
 2. 2018-12-13-pdx-clinical-final-for-paper.txt
 3. all_models.txt
 4. same_phase_all_models.txt
 5. barplot_OS-36-SJ-36.txt (for total mutations for OS - barplot)
 6. total_Mutations-All-Dx-Relapse-Models.csv (for total mutations across all samples - stacked barplot)
 7. barplot_ALL-102-105-115.csv (for total mutations for ALL-105/115 - barplot)
 8. A folder named final-gene-lists containing all final gene lists
 9. Scripts 1-5 in the same folder


 Usage: ./pipeline.sh

 Requirements: Python/3.6

 # Make sure your all_models.txt and same_phase_all_models.txt follow this format. Each field is tab-separated (Double check your models names are correct)
 Dx-Sample-Model   TSB-for-Dx-Sample    Relapse-Sample-Model   TSB-for-Relapse-Sample