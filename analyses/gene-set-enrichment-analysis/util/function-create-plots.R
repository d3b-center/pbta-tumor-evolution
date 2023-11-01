#' Create barplot
#'
#' @param df
#' @param y_value 
#' @param title_value 
#' @param rna_library 
#' @param td_model_id
#' @param cgGFAC
#' 
#'
#' @return
#' @export
#'
#' @examples
create_barplot <- function(df, y_value, title_value, rna_library, td_model_id, cgGFAC) {
  
  p <- print(ggplot(df, aes(x = hallmark_name, 
                            y = y_value,
                            fill = y_value)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               rotate() +
               geom_bar(stat = "identity", width = 0.5) + 
               scale_fill_gradient(low = "blue", high = "red") +
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               # ggplot2::facet_wrap(~comparison, ncol = 3) +
               labs(title = paste0(cgGFAC, " ", td_model_id, " Barplot for ", rna_library, " using ", title_value)) + 
               labs(x = "", y = "Count") +
               ylim(0, 1)) 
  
  return(p)
  
}





#' Create diverging barplot
#'
#' @param df
#' @param y_value 
#' @param title_value 
#' @param rna_library 
#' @param td_model_id
#' @param cgGFAC
#' 
#'
#' @return
#' @export
#'
#' @examples
create_diverging_barplot <- function(df, y_value, title_value, rna_library, td_model_id, cgGFAC) {
  
  
  # make corplot reproducible when using the geom_text_repel function
  set.seed(2023)
  
  labels_colors = c("bottom_ranked_data" = "#00AFBB", "Not significant" = "grey", "top_ranked_data" = "#bb0c00")
  
  p <- ggplot(df, aes(x = reorder(hallmark_name, y_value), 
                      y = y_value,
                      fill = y_value)) +  
    geom_col(position = position_stack(reverse = TRUE)) +
    rotate() +
    geom_bar(stat = "identity", width = 0.5) + 
    scale_fill_gradient(low = "blue", high = "red") +
    theme_Publication() + 
    theme(axis.text.x = element_text(angle = 85, 
                                     hjust = 1, 
                                     vjust = 1)) + 
    # ggplot2::facet_wrap(~comparison, ncol = 3) +
    labs(title = paste0(cgGFAC, " ", td_model_id, " diverging plot for ", rna_library, " using ", title_value)) + 
    labs(x = "", y = "Pathway score") 
  
  return(p)
  
}




#' Create dotplot
#'
#' @param df
#' @param x_value 
#' @param y_value 
#' @param title_value 
#' @param rna_library 
#' @param td_model_id
#' @param cgGFAC

#' 
#'
#' @return
#' @export
#'
#' @examples
create_dotplot <- function(df, x_value, y_value, title_value, rna_library, td_model_id, cgGFAC) {
  
  p <- print(ggplot(df, mapping = aes(x = reorder(x_value, y_value), y_value)) +  
               # geom_dotplot(binwidth = 1.5)  +
               geom_line(aes(group = x_value)) +
               geom_point(aes(color = y_value, size = y_value)) +
               rotate() +
               scale_color_gradient(low = "blue", high = "red") +
               #scale_fill_manual(values = palette, breaks = sort(names(palette))) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               #ggplot2::facet_wrap(~comparison, ncol = 3) +
               labs(title = paste0(cgGFAC, " ", td_model_id, " Dotplot for ", rna_library, " using ", title_value)) + 
               labs(x = "", y = "p_value") +
               ylim(0, 1)) 
  
  return(p)
  
}


#' Create volcano plot
#'
#' @param df
#' @param title_value 
#' @param rna_library 
#' @param td_model_id
#' @param cgGFAC

#' 
#'
#' @return
#' @export
#'
#' @examples
create_volcano_plot <- function(df, title_value, rna_library, td_model_id, cgGFAC) {
  
  # make corplot reproducible when using the geom_text_repel function
  set.seed(2023)
  
  labels_colors = c("bottom_ranked_data" = "#00AFBB", "Not significant" = "grey", "top_ranked_data" = "#bb0c00")
  
  # plot adding up all layers we have seen so far
  p <- ggplot(data = df, aes(x  = pathway_score_difference, y = tukey_p_value, col = path_diff, label = labels)) +
    geom_point(size = 6, fill = 4, alpha = 1 / 2) + 
    theme_Publication() + 
    geom_text_repel(point.padding = 0.2, # additional padding around each point
                    box.padding = 0.5) +
    scale_color_manual(values = labels_colors) + # to set the colours of our variable
    # labels = c("bottom_ranked_data", "Not significant", "top_ranked_data")) + # to set the labels in case we want to overwrite the categories from the dataframe (UP, DOWN, NO)
    #geom_vline(xintercept=c(-0.6, 0.6), col = "red", col = "gray", linetype = "dashed") +
    geom_hline(yintercept = 0.05, col = "black", linetype = "dashed") +
    #coord_cartesian(ylim = c(0, 250), xlim = c(-10, 10)) + # since some genes can have minuslog10padj of inf, we set these limits
    # # Note. with coord_cartesian() even if we have genes with p-values or log2FC ourside our limits, they will still be plotted.
    # labs(color = "path_diff")  #legend_title
    labs(title = paste0(cgGFAC, " ", td_model_id, " plot for ", rna_library, " using ", title_value)) + 
    labs(x = "Pathway score", y = "tukey_p_value")
  
  return(p)
  
}



