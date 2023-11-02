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
  
  p <- ggplot(df, aes(x = hallmark_name, 
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
               ylim(0, 1)
  
  return(p)
  
}





#' Create diverging barplot
#'
#' @param df
#' @param y_value 
#' @param rna_library 
#' @param td_model_id
#' @param cgGFAC
#' 
#'
#' @return
#' @export
#'
#' @examples
create_diverging_barplot <- function(df, y_value, rna_library, td_model_id, cgGFAC) {
  
  
  # make corplot reproducible when using the geom_text_repel function
  set.seed(2023)
  
  #labels_colors = c("bottom_ranked_data" = "#00AFBB", "Not significant" = "grey", "top_ranked_data" = "#bb0c00")
  
  p <- print(ggplot(df, aes(x = reorder(hallmark_name, y_value), 
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
    geom_text(aes(#label = round(path_signif, 1),
                 label = path_signif,
                 #hjust = ifelse(y_value < 0, 1.5, -1),
                 hjust = ifelse(y_value < 0, 1.25, -1), # https://r-charts.com/part-whole/diverging-bar-chart-ggplot2/
                 vjust = 0.5),
              size = 5) +
    labs(title = paste0(cgGFAC, " ", td_model_id, " diverging plot for ", rna_library)) + 
    labs(x = "", y = "Pathway score"))
  
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
  
  p <- ggplot(df, mapping = aes(x = reorder(x_value, y_value), y_value)) +  
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
               ylim(0, 1)
  
  return(p)
  
}



