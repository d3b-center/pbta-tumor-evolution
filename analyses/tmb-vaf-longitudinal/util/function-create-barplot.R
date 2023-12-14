#' Create stacked barplots for all samples in the df
#'
#' @param tmb_df 
#' @param ylim 
#' @param x_value 
#' @param palette 
#' 
#'
#' @return
#' @export
#'
#' @examples
create_stacked_barplot <- function(tmb_df, ylim, x_value, palette) {
  
  # Rename legend for timepoints
  Timepoint <- factor(tmb_df$tumor_descriptor)
  
  
  
  # Plot stacked barplot 
  p <- print(ggplot(tmb_df, aes(x = x_value, 
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
#' @param palette 
#'
#' @return
#' @export
#'
#' @examples
create_barplot_sample <- function(tmb_df, ylim, sid, palette) {
  
  # Rename legend for timepoints
  Timepoint <- factor(tmb_df$tumor_descriptor)
  
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



#' Create stacked barplots to explore variant types
#'
#' @param df 
#' @param x_value 
#' @param palette
#' @param title 
#' 
#'
#' @return
#' @export
#'
#' @examples
#' 
#'  
#' 
create_stacked_barplot_variant <- function(df, x_value, palette, title) {
  
  # Plot stacked barplot 
  p <- print(ggplot(df,
               aes(x = x_value,
                   y = n, 
                   fill = Variant_Classification)) +  
          geom_bar(stat = "identity", position = "fill") +
          #scale_fill_manual(values = palette, breaks = sort(names(palette))) + 
          theme_Publication() + 
          theme(axis.text.x = element_text(angle = 85,
                                           hjust = 1,
                                           vjust = 1),
                text = element_text(size = 12)) +
          scale_y_continuous(labels = function(x) paste0(100*x/max(x),'%')) +
          labs(title = title, 
               x = "Timepoint", 
               y = "Count"))

  return(p)
}


#' Create stacked barplots to explore variant types per cancer_group
#'
#' @param df 
#' @param x_value 
#' @param palette 
#' @param title
#' @param rows

#' 
#'
#' @return
#' @export
#'
#' @examples
#' 
#'  
#' 
create_stacked_barplot_variant_cg_id <- function(df, x_value, palette, title, rows) {
  
  # Plot stacked barplot 
  p <- print(ggplot(df,
                    aes(x = x_value,
                        y = n, 
                        fill = Variant_Classification)) + 
               geom_bar(stat = "identity", position = "fill") +
               scale_fill_manual(values = palette, breaks = sort(names(palette))) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85,
                                                hjust = 1,
                                                vjust = 1),
                     text = element_text(size = 12)) +
               scale_y_continuous(labels = function(x) paste0(100*x/max(x),'%')) +
               facet_wrap(~cg_id, scales = "free_x", nrow = rows) +
               labs(title = title, 
                    x = "Timepoint", 
                    y = "Count"))

  return(p)
}


#' Create stacked barplots to explore variant types per molecular_subtype
#'
#' @param df 
#' @param x_value 
#' @param palette 
#' @param title
#' @param rows

#' 
#'
#' @return
#' @export
#'
#' @examples
#' 
#'  
#' 
create_stacked_barplot_variant_molecular_subtype <- function(df, x_value, palette, title, rows) {
  
  # Plot stacked barplot 
  p <- print(ggplot(df,
                    aes(x = x_value,
                        y = n, 
                        fill = Variant_Classification)) + 
               geom_bar(stat = "identity", position = "fill") +
               scale_fill_manual(values = palette, breaks = sort(names(palette))) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85,
                                                hjust = 1,
                                                vjust = 1),
                     text = element_text(size = 12)) +
               scale_y_continuous(labels = function(x) paste0(100*x/max(x),'%')) +
               facet_wrap(~molecular_subtype, scales = "free_x", nrow = rows) +
               labs(title = title, 
                    x = "Timepoint", 
                    y = "Count"))
  
  return(p)
}

#' Create stacked barplots to explore variant types per cancer_group and kids
#'
#' @param df 
#' @param x_value 
#' @param palette 
#' @param title
#' @param rows

#' 
#'
#' @return
#' @export
#'
#' @examples
#' 
#'  
#' 
create_stacked_barplot_variant_kids <- function(df, x_value, palette, title, rows) {
  
  # Plot stacked barplot 
  p <- print(ggplot(df,
                    aes(x = x_value,
                        y = n, 
                        fill = Variant_Classification)) + 
               geom_bar(stat = "identity", position = "fill") +
               scale_fill_manual(values = palette, breaks = sort(names(palette))) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85,
                                                hjust = 1,
                                                vjust = 1),
                     text = element_text(size = 12)) +
               scale_y_continuous(labels = function(x) paste0(100*x/max(x),'%')) +
               facet_wrap(~Kids_First_Participant_ID, scales = "free_x", nrow = rows) +
               labs(title = title, 
                    x = "Timepoint", 
                    y = "Count"))
  
  return(p)
}
