# Create corplots 
# This is a function to create correlation plots using VAFs 
# between "Deceased" time point and any other "timepoint" (variable)
# while considering multiple bs_id samples per each timepoint
create_corplot <- function(maf, timepoints_other_plot, timepoints_deceased_plot, sid) {

  # Split maf, create df, and rename VAF column based on time point
  timepoint_df <- maf[which(maf$timepoints_other == timepoints_other_plot), ] %>%
    select(gene_protein, Hugo_Symbol, VAF) 
  colnames(timepoint_df)[colnames(timepoint_df) == "VAF"] <- timepoints_other_plot

  deceased_df <- maf[which(maf$timepoints_deceased == timepoints_deceased_plot), ] %>%
    select(gene_protein, Hugo_Symbol, VAF)
  colnames(deceased_df)[colnames(deceased_df) == "VAF"] <- timepoints_deceased_plot
   
  maf.join <- deceased_df %>%
    full_join(timepoint_df, by = c("gene_protein", "Hugo_Symbol"), relationship = "many-to-many") %>%
    mutate(sym = ifelse(Hugo_Symbol %in% oncoprint_goi$oncoprint_goi, TRUE, FALSE)) 
  
  maf.join[is.na(maf.join)] <- 0

  # Create timepoint to use for labeling group column 
  # only for timepoints = Diagnosis, Progressive, Recurrence
  timepoint <- colnames(timepoint_df)
  timepoint <- timepoint[ !timepoint %in% c("gene_protein", "Hugo_Symbol")]
  timepoint <- str_extract(timepoint, "[^_]+")

  # Create group column
  maf.join$group <-  ifelse(maf.join[, timepoints_other_plot] > 0 & maf.join[, timepoints_deceased_plot] > 0, "Common",
                       ifelse(maf.join[, timepoints_other_plot] > 0, timepoint,
                              ifelse(maf.join[, timepoints_deceased_plot] > 0, "Deceased", 
                                     ifelse(maf.join[, timepoints_other_plot] == 0 & maf.join[, timepoints_deceased_plot] == 0, "Remove", "Other"))))
  
  maf.join <- maf.join %>%
    filter(!group %in% c("Remove", "Other"))
  
  # Convert labels to display on the plot only the ones in the goi list
  maf.join$gene_protein <- ifelse(maf.join$sym == TRUE, maf.join$gene_protein, "")
  
  # Reorder time points
  maf.join$group <- factor(x = maf.join$group, levels = c(timepoint, "Deceased", "Common"))
                    
  # Plot corplot 
  p <- print(ggplot(maf.join, aes_string(x = timepoints_other_plot, y = timepoints_deceased_plot, color = "group")) +
               geom_point(size = 10, fill = 4, alpha = 1 / 6) +
               scale_colour_manual(values = c("firebrick3", "dodgerblue3", "gray34")) + 
               labs(title = paste(sid, "VAF Corplot of", timepoint, "vs Deceased", sep = " ")) + 
               geom_vline(xintercept = 0.1, linetype = "dashed") + # Add vertical intercept
               geom_hline(yintercept = 0.1, linetype = "dashed") + # Add horizontal intercept line
               geom_text_repel(aes(label = paste("", gene_protein, "")), 
                               size = 3.5, hjust = 0, vjust = 0, nudge_x = 0.005, 
                               point.padding = NA, segment.color = NA, show.legend = FALSE, 
                               xlim = c(0.02, NA), ylim = c(0.025, 0.96)) +
               theme_Publication() +
               xlim(0, 1) +
               ylim(0, 1))
  return(p)

}
