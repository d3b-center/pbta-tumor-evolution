#' Create stacked barplots for all samples in the df
#'
#' @param tmb_df_df 
#' @param ylim 
#'
#' @return
#' @export
#'
#' @examples
create_stacked_barplot <- function(tmb_df, ylim) {

  # Reorder time points
  timepoint_group <- factor(tmb_df$tumor_descriptor, 
                            levels = c("Second Malignancy", "Unavailable", "Deceased", "Recurrence", "Progressive", "Diagnosis"))
  
  # Define and order palette
  palette <- tumor_descriptor_color_palette$hex_codes
  names(palette) <- tumor_descriptor_color_palette$color_names
  
  # Plot stacked barplot 
  p <- print(ggplot(tmb_df, aes(x = reorder(Kids_First_Participant_ID, plot_order), 
                                y = tmb, 
                                fill = timepoint_group)) +  
               geom_col(position = position_stack(reverse = TRUE), col = "black", size = 0.4) +
               scale_fill_manual(values = palette, breaks = sort(names(palette))) + 
               geom_bar(stat = "identity", width = 0.9) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               labs(title = paste("TMB in PBTA cohort", sep = " ")) + 
               labs(x = "Kids_First_Participant_ID", y = "TMB") +
               ylim(0, ylim))
  return(p)
}


###--------------------------------------------------------------
#' Create stacked barplots for all samples and by cancer type
#'
#' @param tmb_df 
#' @param ylim 
#' @param ct_id 
#'
#' @return
#' @export
#'
#' @examples
create_stacked_barplot_ct <- function(tmb_df, ylim, ct_id) {
  
  # Reorder time points
  timepoint_group <- factor(x = tmb_df$tumor_descriptor, 
                            levels = c("Second Malignancy", "Unavailable", "Deceased", "Recurrence", "Progressive", "Diagnosis"))
  
  # Define and order palette
  palette <- tumor_descriptor_color_palette$hex_codes
  names(palette) <- tumor_descriptor_color_palette$color_names
  
  # Plot stacked barplot 
  p <- print(ggplot(tmb_df, aes(x = reorder(patient_id, plot_order), 
                                y = tmb, 
                                fill = timepoint_group)) +  
               geom_col(position = position_stack(reverse = TRUE), col = "black", size = 0.4) +
               scale_fill_manual(values = palette, breaks = sort(names(palette))) + 
               geom_bar(stat = "identity", width = 0.9) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               labs(title = paste(ct_id)) + 
               labs(x = "Kids_First_Participant_ID", y = "TMB") +
               ylim(0, ylim))
                                  
                                 
  return(p)
}

###--------------------------------------------------------------
#' Create barplot for each `Kids_First_Biospecimen_ID` in `Kids_First_Participant_ID` in the df
#'
#' @param tmb_df 
#' @param ylim
#' @param sid
#'
#' @return
#' @export
#'
#' @examples
create_barplot_sample <- function(tmb_df, ylim, sid) {
  
  # Reorder time points
  timepoint_group <- factor(x = tmb_df$tumor_descriptor, 
                            levels = c("Second Malignancy", "Unavailable", "Deceased", "Recurrence", "Progressive", "Diagnosis"))
  
  # Define and order palette
  palette <- tumor_descriptor_color_palette$hex_codes
  names(palette) <- tumor_descriptor_color_palette$color_names
  
  # Plot stacked barplot 
  p <- print(ggplot(tmb_df, aes(x = Kids_First_Biospecimen_ID, 
                                y = mutation_count, 
                                fill = timepoint_group)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               geom_bar(stat = "identity", width = 0.5) + 
               scale_fill_manual(values = palette, breaks = sort(names(palette))) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               labs(title = paste(sid)) + 
               labs(x = "Kids_First_Biospecimen_ID", y = "Total Mutations") +
               ylim(0, ylim)) 
}
