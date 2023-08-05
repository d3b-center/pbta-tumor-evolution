# Create barplots 

create_barplot_sample <- function(tmb, sid, ylim) {

  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased"))

  # Plot stacked barplot 
  p <- print(ggplot(tmb, aes(x = Kids_First_Biospecimen_ID, y = mutation_count, fill = tumor_descriptor)) +  
               scale_fill_manual(values = c("Diagnosis" = "dodgerblue3", "Progressive" = "gray", "Recurrence" = "#800080", "Deceased" = "firebrick3")) +
               geom_bar(stat = "identity") + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, hjust = 0.25, vjust = 0.25)) + 
               labs(title = paste(sid, "Barplot", sep = " ")) + 
               labs(x = "Biospecimen sample", y = "Total Mutations") +
               ylim(0, ylim))
  return(p)
}
