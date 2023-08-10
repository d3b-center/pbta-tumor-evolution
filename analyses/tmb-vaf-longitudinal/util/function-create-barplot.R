# Create barplot by sample
create_barplot_sample <- function(tmb, sid, ylim) {

  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased"))

  # Plot stacked barplot 
  p <- print(ggplot(tmb, aes(x = Kids_First_Biospecimen_ID, y = mutation_count, fill = tumor_descriptor)) +  
               scale_fill_manual(values = tumor_descriptor_color_palette) +
               geom_bar(stat = "identity") + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, hjust = 0.25, vjust = 0.25)) + 
               labs(title = paste(sid, "Barplot", sep = " ")) + 
               labs(x = "Biospecimen sample", y = "Total Mutations") +
               ylim(0, ylim))
  return(p)
}

# Create stacked barplots for all samples
create_stacked_barplot <- function(tmb, ylim) {

  # Reorder time points
  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased"))

  # Plot stacked barplot 
  p <- print(ggplot(tmb, aes(x = Kids_First_Participant_ID, y = mutation_count, fill = tumor_descriptor)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               scale_fill_manual(values = tumor_descriptor_color_palette) +
               geom_bar(stat ="identity", width = 0.9) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, hjust = 1, vjust = 1)) + 
               labs(title = paste("Stacked barplot", sep = " ")) + 
               labs(x = "Kids_First_Participant_ID", y = "Total Mutations") +
               ylim(0, ylim))
  return(p)
}

# Create stacked barplots for all samples and by broad_histology
create_stacked_barplot_broad_histology <- function(tmb, ylim) {

  # Reorder time points
  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased"))

  # Plot stacked barplot 
  p <- print(ggplot(tmb, aes(x = Kids_First_Participant_ID, y = mutation_count, fill = tumor_descriptor)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               scale_fill_manual(values = tumor_descriptor_color_palette) +
               geom_bar(stat ="identity", width = 0.9) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, hjust = 1, vjust = 1)) + 
               facet_wrap(~broad_histology, ncol = 3) +
               labs(title = paste("Stacked barplot", sep = " ")) + 
               labs(x = "Kids_First_Participant_ID", y = "Total Mutations") +
               ylim(0, ylim))
  return(p)
}
