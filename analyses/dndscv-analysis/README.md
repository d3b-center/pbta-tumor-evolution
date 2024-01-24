## Build the reference file for 

### To run the module
```
bash run_module.sh
```

The module is designed to generate reference file for [dndscv](https://github.com/im3sanger/dndscv). The script is based on this [tutorial](http://htmlpreview.github.io/?http://github.com/im3sanger/dndscv/blob/master/vignettes/buildref.html). 

### Input files
* mart_export.txt.gz: download from [BioMart website](https://www.ensembl.org/biomart/martview/) with ten columns, containing Gene stable ID, Protein stable ID, Chromosome/scaffold name, Strand, Gene name, CDS Length, Genomic coding start, Genomic coding end, CDS start, and CDS end.

* hgnc_complete_set.txt: File to liftover gene symbol from hg19 to hg38. 

* hg38.fa.gz: Fasta file for GRCh38 genome.



