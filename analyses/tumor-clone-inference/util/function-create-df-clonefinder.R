#' Create df
#'
#' @param df 
#' @param sample 
#' @param cg_kid
#' 
#'
#' @return
#' @export
#'
#' @examples
create_df <- function(df, sample_id, cg_kid) {
  
  # Reference df
  ref_df <- df %>%
    filter(td_bs_id == sample_id) %>%
    mutate(td_bs_id = paste(sample_id, "ref", sep = ":")) %>% 
    pivot_wider(names_from = "td_bs_id", values_from = "XX:ref") %>% 
    select(-c("XX:alt"))
  
  # Alteration df
  alt_df <- df %>%
    filter(td_bs_id == sample_id) %>%
    mutate(td_bs_id = paste(sample_id, "alt", sep = ":")) %>% 
    pivot_wider(names_from = "td_bs_id", values_from = "XX:alt") %>% 
    select(-c("XX:ref"))
  
  # Merge df
  merge_df <- ref_df %>% 
    full_join(alt_df, by = c("cg_id_kids", "mut_id", "Chr", "Position", "Wild", "Mut")) %>% 
    as.data.frame() 
  
  return(merge_df)
}

