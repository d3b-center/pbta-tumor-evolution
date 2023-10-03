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
                                                vjust = 1),
                     text = element_text(size = 14)) +
               scale_y_continuous(breaks = scales::pretty_breaks(n = 6), 
                                  limits = c(0, ylim)) +
               labs(title = paste("TMB in PBTA cohort", sep = " ")) + 
               labs(x = "Patient case", y = "TMB"))
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
  Timepoint <- factor(tmb_df$tumor_descriptor)
  
  # Define and order palette
  palette <- palette_df$hex_codes
  names(palette) <- palette_df$color_names
  
  # Plot stacked barplot 
  p <- print(ggplot(tmb_df, aes(x = Kids_First_Biospecimen_ID, 
                                y = mutation_count, 
                                fill = Timepoint)) +  
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
