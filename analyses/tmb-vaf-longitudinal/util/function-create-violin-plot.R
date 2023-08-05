# Create violin plots 
create_violin_plot <- function(tmb) {

  # Reorder time points
  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased"))

  my_comparisons <- list(c("Diagnosis", "Progressive"), c("Diagnosis", "Recurrence"), c("Diagnosis", "Deceased"),
                         c("Progressive", "Recurrence"), c("Progressive", "Deceased"),
                         c("Recurrence", "Deceased"))

  # Plot violin plot
  p <- print(ggplot(tmb, aes(x = tumor_descriptor, y = log2_mutation_count, fill = tumor_descriptor),
                    palette = dxrelcol, alpha = 0.8, add = "boxplot",
                    add.params = list(fill = "white")) +
               geom_violin(trim = TRUE) +
               scale_fill_manual(values = c("Diagnosis" = "dodgerblue3", "Progressive" = "gray", "Recurrence" = "#800080", "Deceased" = "firebrick3")) +
               ggpubr::stat_compare_means(comparisons = my_comparisons, label.y = c(15), label = "p.format") + # Add significance levels
               ggpubr::stat_compare_means(label.y.npc = "top") + ##global p
               theme_Publication() + 
               xlab("") + ylab("log2[Total Mutations]") +
               scale_y_continuous(limits = c(0, 15)))
  
  return(p)
}
