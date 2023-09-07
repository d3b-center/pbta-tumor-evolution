###--------------------------------------------------------------
#' Create jitter plot for TMB across timepoints and cancer types per Patient case
#'
#' @param tmb_df 
#' @param ylim 
#' @param ct_id 
#'
#' @return
#' @export
#'
#' @examples
create_jitter_ct <- function(tmb_df, ylim, ct_id) {
  
  # Rename legend for timepoints
  Timepoint <- factor(tmb_df$tumor_descriptor)
  
  # Define and order palette
  palette <- palette_df$hex_codes
  names(palette) <- palette_df$color_names
  
  # Plot  
  p <- print(tmb_df %>% 
               ggplot2::ggplot() + 
               ggplot2::aes(x = patient_id, 
                            y = tmb,
                            color = Timepoint) + 
               ggplot2::geom_jitter(width = 0.2, alpha = 0.5, size = 1.5) + 
               coord_flip() +
               ggplot2::scale_color_manual(values = palette, 
                                           breaks = sort(names(palette))) +
               labs(title = paste(ct_id)) + 
               ggplot2::labs(x = "Patient case",
                             y = "TMB") +
               theme_Publication() +
               scale_y_continuous(limits = c(0, ylim)))

  return(p)
}
