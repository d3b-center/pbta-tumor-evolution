# README

install.packages(c("tidyverse", "writexl", "ggplot2", "magrittr", "ggthemes",
                     "scales", "ggpubr", "broom", "viridis", "hrbrthemes", "stringi",
                     "rstatix", "dplyr", "RColorBrewer", "purrr", "reshape2", "reshape", "furrr"))
                     
# Rscript -e "rmarkdown::render('01_data-longitudinal_DGD.rmd')"
rmarkdown::render('01_data-longitudinal_DGD.rmd')


# data_all <- data_all %>% filter(cohort %in% c("DGD")) # DGD (only contains Targeted Sequencing data), GMKF, GTEx, PBTA, TARGET, TCGA

### TO-DO-LIST ######
# add pandoc so i can run rmarkdonw in visual studio code
# Work on the loop
# summarize tumor_descriptor
# create age_group
age_at_diagnosis_days
age_last_update_days
# information bout chemo, radiation in terms of start_age
age_at_chemo_start
age_at_radiation_start
# summarize primary_site so i can plot this - i couldn't do for DGD cohort, PBTA, TARGET
Multiple sites therein







# Figure 1f - age_at_diagnosis_days
print(ggplot(count1, aes(x=short_histology))+
        geom_bar()+
        scale_fill_manual() +
        theme_classic()+
        ylab("Count age_at_diagnosis_days") +
       # facet_wrap("cohort", nrow=6)+
        guides(color=guide_legend(override.aes=list(size=3))) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) )
ggsave(filename = "Barplot_short_histology_age_at_diagnosis_days_GMKF.pdf", path = out_path,, width=10 ,height =7 ,device = "pdf", useDingbats=F)


# Figure 1g - age_last_update_days
print(ggplot(count1, aes(x=short_histology))+
        geom_bar()+
        scale_fill_manual() +
        theme_classic()+
        ylab("Count age_last_update_days") +
       # facet_wrap("cohort", nrow=6)+
        guides(color=guide_legend(override.aes=list(size=3))) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) )
ggsave(filename = "Barplot_short_histology_age_last_update_days_GMKF.pdf", path = out_path,, width=10 ,height =7 ,device = "pdf", useDingbats=F)


# Figure 1h - age_at_chemo_start
print(ggplot(count1, aes(x=short_histology))+
        geom_bar()+
        scale_fill_manual() +
        theme_classic()+
        ylab("Count age_at_chemo_start") +
       # facet_wrap("cohort", nrow=6)+
        guides(color=guide_legend(override.aes=list(size=3))) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) )
ggsave(filename = "Barplot_short_histology_age_at_chemo_start_GMKF.pdf", path = out_path,, width=10 ,height =7 ,device = "pdf", useDingbats=F)


# Figure 1i - age_at_radiation_start
print(ggplot(count1, aes(x=short_histology))+
        geom_bar()+
        scale_fill_manual() +
        theme_classic()+
        ylab("Count age_at_radiation_start") +
       # facet_wrap("cohort", nrow=6)+
        guides(color=guide_legend(override.aes=list(size=3))) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) )
ggsave(filename = "Barplot_short_histology_age_at_radiation_start_GMKF.pdf", path = out_path,, width=10 ,height =7 ,device = "pdf", useDingbats=F)
