library(tidyverse)
library(dndscv)

## set directories

root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))
analysis_dir <- file.path(root_dir, "analyses", "dndscv-analysis")
input_dir <- file.path(analysis_dir, "input")
output_dir <- file.path(analysis_dir, "output")
if(!dir.exists(output_dir)){
  dir.create(output_dir)
}

## read files
gene_tsv <- read_tsv(file.path(input_dir, "mart_export.txt.gz"))
gene_tsv <- gene_tsv %>% 
  ## take only the autosomal and sex chromosomes
  filter(`Chromosome/scaffold name` %in% c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y")) %>%
  unique()

## lift 
lift_gene_df <- read_tsv(file.path(input_dir, "hgnc_complete_set.txt"))
lift_gene_df <- lift_gene_df %>% 
  separate_rows(prev_symbol, sep = "\\|") %>% 
  filter(!is.na(prev_symbol)) %>% 
  select(symbol, prev_symbol, ensembl_gene_id)

gene_lift <- gene_tsv %>% 
  filter(!is.na(`Gene name`)) %>%
  left_join(lift_gene_df %>% select(symbol, prev_symbol), by = c("Gene name" = "prev_symbol")) %>% 
  mutate(`Gene name` = case_when(`Gene name` != symbol ~ symbol, TRUE ~ `Gene name`), 
         `Chromosome/scaffold name` = paste0("chr", `Chromosome/scaffold name`), 
         `Gene stable ID` = case_when(`Gene stable ID` != ensembl_gene_id ~ ensembl_gene_id, TRUE ~ `Gene stable ID`)) %>%
  select(-symbol) %>%
  select(`Gene stable ID`, `Gene name`, `Protein stable ID`, `Chromosome/scaffold name`, 
         `Genomic coding start`, `Genomic coding end`, `CDS start`, `CDS end`, `CDS Length`, `Strand`) %>% 
  dplyr::rename("gene.id" = "Gene stable ID", 
                "gene.name" = "Gene stable ID",
                "cds.id" = "Protein stable ID", 
                "chr" = "Chromosome/scaffold name", 
                "chr.coding.start" = "Genomic coding start", 
                "chr.coding.end" = "Genomic coding end", 
                "cds.start" = "CDS start", 
                "cds.end" = "CDS end", 
                "length" = "CDS Length", 
                "strand" = "Strand") %>% 
  unique() %>%
  write_tsv(file.path(input_dir, "gene_coding_liftover.tsv")) 
  
## build reference file for dndscv
buildref(cdsfile = file.path(input_dir, "gene_coding_liftover.tsv"), 
         genomefile = file.path(input_dir, "hg38.fa"), 
         outfile = file.path(output_dir, "RefCDS_human_GRCh38_GencodeV39_liftover.rda"),
         excludechrs="MT")

