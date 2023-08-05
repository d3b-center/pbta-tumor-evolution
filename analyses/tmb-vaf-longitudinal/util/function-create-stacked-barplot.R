# Create stacked barplots 

create_stacked_barplot <- function(tmb, ylim) {

  # Reorder time points
  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased"))

  # Plot stacked barplot 
  p <- print(ggplot(tmb, aes(x = Kids_First_Participant_ID, y = mutation_count, fill = tumor_descriptor)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               scale_fill_manual(values = c("Diagnosis" = "dodgerblue3", "Progressive" = "gray", "Recurrence" = "#800080", "Deceased" = "firebrick3")) +
               geom_bar(stat ="identity", width = 0.9) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, hjust = 1, vjust = 1)) + 
               #facet_wrap(~cancer_group, ncol = 4) +
               labs(title = paste("Stacked barplot", sep = " ")) + 
               labs(x = "Kids_First_Participant_ID", y = "Total Mutations") +
               ylim(0, ylim))
  return(p)
}

create_stacked_barplot_cancer_type <- function(tmb, ylim) {

  # Reorder time points
  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased"))

  # Plot stacked barplot 
  p <- print(ggplot(tmb, aes(x = Kids_First_Participant_ID, y = mutation_count, fill = tumor_descriptor)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               scale_fill_manual(values = c("Diagnosis" = "dodgerblue3", "Progressive" = "gray", "Recurrence" = "#800080", "Deceased" = "firebrick3")) +
               geom_bar(stat ="identity", width = 0.9) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, hjust = 1, vjust = 1)) + 
               facet_wrap(~cancer_group, ncol = 4) +
               labs(title = paste("Stacked barplot", sep = " ")) + 
               labs(x = "Kids_First_Participant_ID", y = "Total Mutations") +
               ylim(0, ylim))
  return(p)
}