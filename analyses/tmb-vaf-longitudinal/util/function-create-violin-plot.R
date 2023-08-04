# Create violin plots 
# This is a function to create violin plots using TMB 
# between "Deceased" time point and any other "timepoint" (variable)
# while considering multiple bs_id samples per each timepoint
create_violin_plot <- function(tmb) {

 # Reorder time points
  tmb$tumor_descriptor <- factor(x = tmb$tumor_descriptor, levels = c("Diagnosis", "Progressive", "Recurrence", "Deceased"))

  # Plot violin plot
  p <- ggplot(tmb, aes(x = tumor_descriptor, y = log_tmb, fill = tumor_descriptor),
              palette = dxrelcol, alpha = 0.8,add = "boxplot",
              add.params = list(fill = "white")) +
               geom_violin(trim=TRUE) +
    scale_fill_manual(values = c("Diagnosis" = "dodgerblue3", "Progressive" = "gray", "Recurrence" = "#800080", "Deceased" = "firebrick3")) +
               stat_compare_means(comparisons = list(c("Diagnosis", "Relapse")), label.y = c(15), label = "p.format")+ # Add significance levels
               #ggpubr::stat_compare_means(label.y.npc = "top") + ##global p
               # facet_grid(~facet) +##global p
               theme_Publication() + 
               xlab("timepoints_model") + ylab('log_tmb')+
               scale_y_continuous(limits = c(0, 6))
  return(p)
  
  }