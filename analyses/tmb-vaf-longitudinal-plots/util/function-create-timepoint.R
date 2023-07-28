# Create timepoint
# This is a function to create dataframes for number of timepoints more than one
create_timepoint <- function(timepoint_df, timepoint) {
  
  # Duplicate rows
  timepoint_df <- timepoint_df[rep(seq_len(nrow(timepoint_df)), each = timepoint), ]  
  
  # Rename duplicate rows to distinguish between duplicates
  timepoint_df <- timepoint_df %>% 
    group_by(match_id) %>%
    dplyr::mutate(tumor_descriptor = paste("Deceased", row_number(), sep = "_")) 
  
}