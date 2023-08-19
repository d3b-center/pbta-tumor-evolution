###--------------------------------------------------------------
#' Create Dumbbell plot for TMB across timepoints and cancer types per Patient case
#'
#' @param tmb_df 
#' @param ylim 
#' @param ct_id 
#'
#' @return
#' @export
#'
#' @examples
create_dumbbell_ct <- function(tmb_df, ylim, ct_id) {
  
  # Rename legend for timepoints
  Timepoints <- factor(tmb_df$tumor_descriptor)
  
  # Define and order palette
  palette <- tumor_descriptor_color_palette$hex_codes
  names(palette) <- tumor_descriptor_color_palette$color_names
  
  # Plot  
  p <- print(ggplot(tmb_df, aes(x = patient_id, y = tmb)) +
               coord_flip() +
               geom_line() +
               geom_point(aes(color = Timepoints), size = 3) +
               scale_color_manual(values = palette, breaks = sort(names(palette)), labels = sort(names(palette))) +
               theme(legend.position = "bottom") +
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               labs(title = paste(ct_id)) + 
               labs(x = "Patient case", y = "TMB") +
               ylim(0, ylim))
  
  return(p)
}

###--------------------------------------------------------------
#' Create Dumbbell plot for Total number of mutations across timepoints and cancer types per Patient case
#'
#' @param tmb_df 
#' @param ylim 
#' @param ct_id 
#'
#' @return
#' @export
#'
#' @examples
create_dumbbell_ct_mut <- function(tmb_df, ylim, ct_id) {
  
  # Rename legend for timepoints
  Timepoints <- factor(tmb_df$tumor_descriptor)
  
  # Define and order palette
  palette <- tumor_descriptor_color_palette$hex_codes
  names(palette) <- tumor_descriptor_color_palette$color_names
  
  # Plot 
  p <- print(ggplot(tmb_df, aes(x = patient_id, y = mutation_count)) +
               coord_flip() +
               geom_line() +
               geom_point(aes(color = Timepoints), size = 3) +
               scale_color_manual(values = palette, breaks = sort(names(palette)), labels = sort(names(palette))) +
               theme(legend.position = "bottom") +
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               labs(title = paste(ct_id)) + 
               labs(x = "Patient case", y = "Total mutations") +
               ylim(0, ylim))
  
  return(p)
}
