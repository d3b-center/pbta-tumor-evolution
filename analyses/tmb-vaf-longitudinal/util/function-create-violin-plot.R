# Create barplots 
# This is a function to create correlation plots using VAFs 
# between "Deceased" time point and any other "timepoint" (variable)
# while considering multiple bs_id samples per each timepoint
create_barplot <- function(tmb) {

 # Reorder time points
  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased"))

# Reorder timepoints model
  tmb$timepoints_model <- factor(x = tmb$timepoints_model, levels = c("dx", "pro", "rec", "dx_pro", "dx_rec", "pro_rec"))

  # Plot stacked barplot 
    p <- ggplot(tmb, aes(x = Kids_First_Participant_ID, y = mutation_count, fill = tumor_descriptor))+  
      geom_col(position = position_stack(reverse = TRUE)) +
        scale_fill_manual(values = c("Diagnosis" = "dodgerblue3", "Progressive" = "gray", "Recurrence" = "#800080", "Deceased" = "firebrick3")) +
          geom_bar( stat="identity", width = 0.9) + 
            theme_Publication() + 
              theme(axis.text.x = element_text(angle = 85, hjust = 1, vjust =1)) + 
                labs(title = paste("Stacked barplot", sep = " ")) + 
                  labs(x = "Kids_First_Participant_ID", y = "Total Mutations") +
                    ylim(0, 13000)
                      return(p)
                   
  }
