#' Create stacked barplots for all samples in the df
#'
#' @param tmb 
#' @param ylim 
#'
#' @return
#' @export
#'
#' @examples
create_stacked_barplot <- function(tmb, ylim) {

  # Reorder time points
  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased", "Second Malignancy", "Unavailable"))

  # Plot stacked barplot 
  p <- print(ggplot(tmb, aes(x = Kids_First_Participant_ID, y = mutation_count, fill = tumor_descriptor)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               scale_fill_manual(values = tumor_descriptor_color_palette$hex_codes) +
               geom_bar(stat ="identity", width = 0.9) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, hjust = 1, vjust = 1)) + 
               labs(title = paste("Stacked barplot", sep = " ")) + 
               labs(x = "Kids_First_Participant_ID", y = "Total Mutations") +
               ylim(0, ylim))
  return(p)
}


###--------------------------------------------------------------
#' Create stacked barplots for all samples and by cancer_group_sum
#'
#' @param tmb 
#' @param ylim 
#' @param ct_id 

#'
#' @return
#' @export
#'
#' @examples
create_stacked_barplot_cancer_group_sum <- function(tmb, ylim, ct_id) {
  
  # Reorder time points
  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased", "Second Malignancy", "Unavailable"))
  
  # Plot stacked barplot 
  p <- print(ggplot(tmb, aes(x = Kids_First_Participant_ID, y = mutation_count, fill = tumor_descriptor)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               scale_fill_manual(values = tumor_descriptor_color_palette$hex_codes) +
               geom_bar(stat ="identity", width = 0.9) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, hjust = 1, vjust = 1)) + 
               labs(title = paste(ct_id, "Stacked barplot", sep = " ")) + 
               labs(x = "Kids_First_Participant_ID", y = "Total Mutations") +
               ylim(0, ylim))
  return(p)
}


###--------------------------------------------------------------
#' Create barplot for each `Kids_First_Participant_ID` and per `Kids_First_Biospecimen_ID` in the df
#'
#' @param tmb 
#' @param ylim 
#' @param sid
#'
#' @return
#' @export
#'
#' @examples
create_barplot_sample <- function(tmb, ylim, sid) {
  
  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased", "Second Malignancy", "Unavailable"))
  
  # Plot stacked barplot 
  p <- print(ggplot(tmb, aes(x = Kids_First_Biospecimen_ID, y = mutation_count, fill = tumor_descriptor)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               scale_fill_manual(values = tumor_descriptor_color_palette$hex_codes) +
               geom_bar(stat ="identity", width = 0.9) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, hjust = 1, vjust = 1)) + 
               labs(title = paste(sid, "Barplot", sep = " ")) + 
               labs(x = "Kids_First_Biospecimen_ID", y = "Total Mutations") +
               ylim(0, ylim))
  return(p)
}
