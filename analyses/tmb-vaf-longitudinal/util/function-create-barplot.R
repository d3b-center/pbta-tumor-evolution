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

  # Rename legend for timepoints
  Timepoint <- factor(tmb_df$tumor_descriptor)
  
  # Define and order palette
  palette <- palette_df$hex_codes
  names(palette) <- palette_df$color_names
  
  # Plot stacked barplot 
  p <- print(ggplot(tmb_df, aes(x = Kids_First_Participant_ID, 
                                y = tmb, 
                                fill = Timepoint)) +  
               geom_col(position = position_stack(reverse = TRUE), col = "black", size = 0.4) +
               scale_fill_manual(values = palette, breaks = sort(names(palette))) + 
               geom_bar(stat = "identity", width = 0.9) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               labs(title = paste("TMB in PBTA cohort", sep = " ")) + 
               labs(x = "Patient case", y = "TMB") +
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
  
  # Rename legend for timepoints
  Timepoints <- factor(tmb_df$tumor_descriptor)
  
  # Define and order palette
  palette <- tumor_descriptor_color_palette$hex_codes
  names(palette) <- tumor_descriptor_color_palette$color_names
  
  # Plot stacked barplot 
  p <- print(ggplot(tmb_df, aes(x = Kids_First_Biospecimen_ID, 
                                y = mutation_count, 
                                fill = Timepoints)) +  
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
  return(p)
}

###--------------------------------------------------------------
#' Create barplot panel for each biospecimen sample in `Kids_First_Participant_ID` in the df
#'
#' @param tmb_df 
#' @param ylim
#'
#' @return
#' @export
#'
#' @examples
create_barplot_sample_panel <- function(tmb_df, ylim) {
  
  # Rename legend for timepoints
  Timepoint <- factor(tmb_df$tumor_descriptor)
  
  # Define and order palette
  palette <- palette_df$hex_codes
  names(palette) <- palette_df$color_names
  
  # Plot stacked barplot 
  p <- print(ggplot(tmb_df, aes(x = Timepoint, 
                                y = mutation_count, 
                                fill = Timepoint)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               geom_bar(stat = "identity", width = 0.5) + 
               scale_fill_manual(values = palette, breaks = sort(names(palette))) +
               facet_wrap(~Kids_First_Participant_ID, nrow = 8) +
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               labs(title = "Total number of mutations per biospecimen and Kids ID across Timepoints") + 
               labs(x = "Timepoint samples", y = "Total Mutations") +
               ylim(0, ylim)) 
  return(p)
}
