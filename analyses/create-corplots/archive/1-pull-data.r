
# Load libraries
suppressPackageStartupMessages({
  library(tidyverse)
  library(ggplot2)
  library(flextable)
})


# Detect the ".git" folder -- this will be in the project root directory.
# Use this as the root directory to ensure proper sourcing of functions no
# matter where this is called from
root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))
# root_dir <- "/Users/chronia/CHOP/GitHub/pbta-tumor-evolution"
setwd(root_dir)

analysis_dir <- file.path(root_dir, "analyses", "create-pptc-pdx-corplots")

# File path to input directory
input_dir <-
  file.path(analysis_dir, "input")

# Inputs
input_snv <- file.path(root_dir, "data/snv-consensus-plus-hotspots.maf.tsv.gz")

# The following files were generated from the add-sample-distribution analysis
# to source files from there - TO FIX THIS LATER
input_genomic_df_filter <- file.path(input_dir, "genomic_df_filter.tsv")

# File path to results directory
results_dir <-
  file.path(analysis_dir, "results")
if (!dir.exists(results_dir)) {
  dir.create(results_dir)
}


# File path to plots directory
plots_dir <-
  file.path(analysis_dir, "plots")
if (!dir.exists(plots_dir)) {
  dir.create(plots_dir)
}









# Pulling out Dx-Relapse or any other matches from MAF file
root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))
setwd(root_dir)

analysis_dir <- file.path(root_dir, "analyses", "create-pptc-pdx-corplots")

# File path to input directory
input_dir <-
  file.path(analysis_dir, "input")

# Inputs
input_snv <- file.path(root_dir, "data/snv-consensus-plus-hotspots.maf.tsv.gz")

inData <- pptc.merge
#colnames(inData)


info_1 <- readLines("all_models.txt")
for(x in info_1)
{
  line = strsplit(x,"\t")[[1]]
  #print(line)
  
  file_name = paste0(line[1],"_",line[4],".txt")
  
  new <- subset(inData,TSB == line[3] | TSB == line[6] ,c(TSB,Hugo_Symbol,Variant_Classification,cDNA_Change,Protein_Change,VAF))
  write.table(new,file_name,sep="\t",row.names=FALSE)
  
  tmp <- read.table(file_name,sep="\t", header = TRUE)
  gsub("","0.0",tmp$Protein_Change)
  
  tmp$Phase <- ifelse(tmp$TSB == line[3],"Diagnosis","Relapse")
  write.table(tmp,file_name,sep="\t",row.names=FALSE)
  
}

# For Same Phase Samples
info <- readLines("same_phase_all_models.txt")
for(x in info)
{
  line = strsplit(x,"\t")[[1]]
  #print(line)
  
  file_name = paste0(line[1],"_",line[4],".txt")
  
  new <- subset(inData,TSB == line[3] | TSB == line[6] ,c(TSB,Hugo_Symbol,Variant_Classification,cDNA_Change,Protein_Change,VAF))
  write.table(new,file_name,sep="\t",row.names=FALSE)
  
  tmp <- read.table(file_name,sep="\t", header = TRUE)
  
  tmp$Phase <- ifelse(tmp$TSB == line[3],"Tumor Sample 1","Tumor Sample 2")
  write.table(tmp,file_name,sep="\t",row.names=FALSE)
  
  
}

# for ALL-105/115 
new <- subset(inData,TSB == "PPTC-AF03-XTP1-A-1-0-D-human" | TSB == "PPTC-AF08-XTP1-A-1-0-D-human" ,c(TSB,Hugo_Symbol,Variant_Classification,cDNA_Change,Protein_Change,VAF))
write.table(new,"ALL-105_ALL-115.txt",sep="\t",row.names=FALSE)

tmp <- read.table("ALL-105_ALL-115.txt",sep="\t", header = TRUE)

tmp$Phase <- ifelse(tmp$TSB == "PPTC-AF03-XTP1-A-1-0-D-human","Relapse 1","Relapse 3")
write.table(tmp,"ALL-105_ALL-115.txt",sep="\t",row.names=FALSE)
