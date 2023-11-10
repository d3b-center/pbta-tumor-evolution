#' Create heatmap
#'
#' @param df
#' @param cg
#' 
#'
#' @return
#' @export
#'
#' @examples
create_heatmap <- function(df, cg) {
  
  palette_mapping_df <- df %>%
    # Add in hex codes & display grouping
    left_join(histology_label_mapping,
              by = c("broad_histology", "cancer_group", "cg")) %>%
    select(Kids_First_Biospecimen_ID,
           Kids_First_Participant_ID,
           
           # Keep both broad_histology for the UMAP legend, and cancer_group for the GSVA legend
           broad_histology_display,
           broad_histology_hex,
           broad_histology_order,
           cg,
           cancer_group,
           molecular_subtype,
           plot_group_hex) %>%
   # mutate(cg = forcats::fct_reorder(cg,
   #                                  broad_histology_order))
    arrange(cg)
  
  #### Data prep for column heatmap annotation -----------------------------------
  
  # We will construct an annotation bar for display_group - this is used in the
  # GSVA heatmap. In this section, we prep the data frame and color palette
  # required for that.
  
  # Get a distinct version of the color keys
  # This has already in essence been filtered to exclude categories that are
  # irrelevant to the samples being plotted
  # We do this for _both_ cancer group and broad histology colors, 
  # since each is used in a different plot
  
  timepoint_color_df <- timepoint_label_mapping %>%
    dplyr::select(tumor_descriptor, hex_codes) %>%
    #dplyr::rename(tumor_descriptor = color_names) %>% 
    dplyr::distinct() 
  
  # Make color key specific to these samples
  annotation_colors_time <- timepoint_color_df$hex_codes
  names(annotation_colors_time) <- timepoint_color_df$tumor_descriptor
  
  
  # Get the `tumor_descriptor` color mappings for the samples being
  # plotted here
  timepoint_mapping_df <- df %>%
    # Add in hex codes & display grouping
    left_join(timepoint_color_df,
              by = c("tumor_descriptor")) %>%
    select(Kids_First_Biospecimen_ID,
           tumor_descriptor,
           cg,
           hex_codes,
           Kids_First_Participant_ID,
           cancer_group,
           molecular_subtype) %>%
    #dplyr:::mutate(tumor_descriptor = factor(tumor_descriptor),
    #               tumor_descriptor = fct_relevel(tumor_descriptor, f),
    #               cg = factor(cg),
     #              cg = fct_relevel(cg, cg_f)) %>% 
    arrange(cg, tumor_descriptor)
  
  
  # And now for cancer group:
  cancer_group_color_df <- palette_mapping_df %>%
    dplyr::select(cg, plot_group_hex) %>%
    dplyr::distinct() %>%
    # remove NA and "Other" displays
    tidyr::drop_na() %>%
    filter(cg != "Other") %>% 
    #mutate(cg = factor(cg),
    #       cg = fct_relevel(cg, cg_f)) %>% 
    arrange(cg)
  
  # Make color key specific to these samples
  annotation_colors_cg <- cancer_group_color_df$plot_group_hex
  names(annotation_colors_cg) <- cancer_group_color_df$cg
  
  # Will no longer need these
  #rm(timepoint_color_df)
  #rm(cancer_group_color_df)
  
  
  
  # What gene sets are we going to include in our heatmap?
  # We'll filter based on whether the ANOVA has a significant p-value
  
  included_genesets <- included_genesets_df %>% 
    filter(significant_anova) %>%
    pull(hallmark_name)
  
  gsva_scores_mat <- gsva_scores_df %>%
    dplyr::mutate(data_type = case_when(grepl("exome_capture|polya|polya_stranded", data_type) ~ "merged", 
                                 TRUE ~ data_type)) %>%
    dplyr::filter(data_type == "stranded") %>%
    select(- data_type) %>% 
    tidyr::spread(Kids_First_Biospecimen_ID, gsea_score) %>%
    # Only include the significant gene sets from above
    filter(hallmark_name %in% included_genesets) %>%
    # Clean up gene set names for display
    mutate(hallmark_name = stringr::str_replace_all(
      stringr::str_remove(hallmark_name, "HALLMARK_"), "_", " ")
    ) %>%
    tibble::column_to_rownames("hallmark_name") %>%
    as.matrix()
  
  
  # Let's deal with the color palette for the heatmap we will make - the values
  # for the palette will be based on the scores themselves
  divergent_col_val <- seq(from = min(gsva_scores_mat),
                           to = max(gsva_scores_mat),
                           length.out = nrow(divergent_palette))
  gsva_col_fun <- circlize::colorRamp2(divergent_col_val,
                                       divergent_palette$hex_codes)
  
  
  # Determine timepoint counts so we can have a variable to order rows by
  palette_mapping_df_ordered <- timepoint_mapping_df %>%
    # Remove NA and "Other" display groups
    #drop_na(cg) %>%
    #filter(cg != "Other") %>%
    # Arrange in reverse order of counts and make that the cancer_group_order
    dplyr::count(tumor_descriptor) %>%
    # force "Other" to be zero so we can arrange by `n` and it's at the bottom
    arrange(-n) %>%
    # Now add the proper order.
    dplyr::mutate(tumor_descriptor_order = 1:n()) %>%
    # Not needed
    select(-n) %>%
    # Join back up
    inner_join(timepoint_mapping_df)
  
  
  # Determine timepoint counts so we can have a variable to order rows by
  cg_palette_mapping_df_ordered <- timepoint_mapping_df %>%
    # Remove NA and "Other" display groups
    #drop_na(cg) %>%
    #filter(cg != "Other") %>%
    # Arrange in reverse order of counts and make that the cancer_group_order
    dplyr::count(cg) %>%
    # force "Other" to be zero so we can arrange by `n` and it's at the bottom
    arrange(-n) %>%
    # Now add the proper order.
    dplyr::mutate(cg_order = 1:n()) %>%
    # Not needed
    select(-n) %>%
    # Join back up
    inner_join(palette_mapping_df_ordered)
  
  
  # Make sure it is ordered by cancer_group order, which is based on number of samples
  # Note: NA/"Other" groups are already removed above, so do not need to drop here
  gsva_ordered_bsids <- cg_palette_mapping_df_ordered %>%
    arrange(tumor_descriptor_order) %>%
    pull(Kids_First_Biospecimen_ID)
  
  # Use the vector of biospecimen IDs to select and order samples for GSVA display
  gsva_scores_mat <- gsva_scores_mat[, gsva_ordered_bsids]
  
  
  # Create a data frame just for setting up the heatmap annotation
  gsva_annotation_df <- cg_palette_mapping_df_ordered %>%
    select(Kids_First_Biospecimen_ID,
           cg,
           cg_order,
           tumor_descriptor,
           Kids_First_Participant_ID,
           cancer_group,
           molecular_subtype) %>%
    filter(Kids_First_Biospecimen_ID %in% gsva_ordered_bsids) %>%
    unique() %>% 
    column_to_rownames("Kids_First_Biospecimen_ID")
  
  #gsva_annotation_df = gsva_annotation_df[!duplicated(gsva_annotation_df$Kids_First_Biospecimen_ID),]
  #rownames(gsva_annotation_df) = gsva_annotation_df$Kids_First_Biospecimen_ID
  
  
  gsva_annotation_df_timepoint <- gsva_annotation_df[gsva_ordered_bsids, ] %>%
    select(#-contains("broad_histology"),  # Drop extraneous columns
      #-tumor_descriptor_order,
      -cg_order,
      #-Kids_First_Biospecimen_ID,
      #-cg, 
      # Rename for display purposes
      Cancer_group = cg,
      Timepoint = tumor_descriptor) 
  
  # Annotation bar intended for the top of the heatmap
  column_heatmap_annotation <- HeatmapAnnotation(
    df = as.data.frame(gsva_annotation_df_timepoint),
    name = c("Cancer Group", "Timepoint"),
    col = list("Cancer_group" = annotation_colors_cg,
               "Timepoint" = annotation_colors_time),
    na_col = na_color$hex_codes,
    show_legend = TRUE,
    show_annotation_name =TRUE
  )
  
  ## Heatmap itself!
  gsva_heatmap <- print(Heatmap(
    gsva_scores_mat,
    col = gsva_col_fun,
    name = "GSVA Scores",
    na_col = na_color$hex_codes,
    show_column_names = FALSE,
    cluster_columns = FALSE,
    row_names_gp = grid::gpar(fontsize = 5.8),
    top_annotation = column_heatmap_annotation,
    heatmap_legend_param = list(direction = "vertical")
  ))
  
  return(gsva_heatmap)
  
}

