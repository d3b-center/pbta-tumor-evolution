# Create barplots 
# This is a function to create correlation plots using VAFs 
# between "Deceased" time point and any other "timepoint" (variable)
# while considering multiple bs_id samples per each timepoint
create_barplot_sample <- function(tmb, timepoints_other_plot, timepoints_deceased_plot, sid) {

  # Split tmb, create df, and rename mutation_count column based on time point
  timepoint_df <- tmb[which(tmb$timepoints_other == timepoints_other_plot), ] %>% 
       dplyr::select(Kids_First_Participant_ID, match_id_bs, mutation_count)
  colnames(timepoint_df)[colnames(timepoint_df) == "mutation_count"] <- timepoints_other_plot

  deceased_df <- tmb[which(tmb$timepoints_deceased == timepoints_deceased_plot), ] %>% 
       dplyr::select(Kids_First_Participant_ID, match_id_bs, mutation_count)
  colnames(deceased_df)[colnames(deceased_df) == "mutation_count"] <- timepoints_deceased_plot
   
  tmb_join <- deceased_df %>%
   dplyr:::full_join(timepoint_df, by = c("Kids_First_Participant_ID", "match_id_bs"), relationship = "many-to-many") %>%
   data.frame()

  tmb_join[is.na(tmb_join)] <- 0

  melt_tmb_join <- melt(tmb_join, id = c("Kids_First_Participant_ID", "match_id_bs")) %>% 
                        filter (!value == 0) %>% 
                        mutate(label = str_extract(variable, "[^_]+"))
  
 # Reorder time points
  melt_tmb_join$label <- factor(x = melt_tmb_join$label, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased"))

  # Plot stacked barplot 
    p <- ggplot(melt_tmb_join, aes(x = Kids_First_Participant_ID, y = value, fill = label))+  
      geom_col(position = position_stack(reverse = TRUE)) +
        scale_fill_manual(values = c("Diagnosis" = "dodgerblue3", "Progressive" = "gray", "Recurrence" = "#800080", "Deceased" = "firebrick3")) +
          geom_bar( stat="identity", width = 0.9) + 
            theme_Publication() + 
                labs(title = paste(sid, "Stacked barplot", sep = " ")) + 
                  labs(x = "Kids_First_Participant_ID", y = "Total Mutations") +
                    ylim(0, 400)
                      return(p)
                   
  }
