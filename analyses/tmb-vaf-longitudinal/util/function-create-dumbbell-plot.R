###--------------------------------------------------------------
#' Create Dumbbell plot for TMB across timepoints and cancer types per Patient case
#'
#' @param tmb_df 
#' @param ylim 
#' @param ct_id
#' @param palette 
#'
#' @return
#' @export
#'
#' @examples
create_dumbbell_ct <- function(tmb_df, ylim, ct_id, palette) {
  
  # Rename legend for timepoints
  Timepoint <- factor(tmb_df$tumor_descriptor)
  
  # Plot  
  p <- print(ggplot(tmb_df, aes(x = Kids_First_Participant_ID, y = tmb)) +
               coord_flip() +
               geom_line() +
               geom_point(aes(color = Timepoint), size = 3) +
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
