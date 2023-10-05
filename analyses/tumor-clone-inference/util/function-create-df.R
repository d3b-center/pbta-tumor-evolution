#' Create df
#'
#' @param df 
#' @param samples 
#' @param cg_kids
#' 
#'
#' @return
#' @export
#'
#' @examples
create_df <- function(df, samples, cg_kids) {
  
  # Reference df
  ref_df <- df_sub %>%
    filter(td_bs_id == samples) %>%
    mutate(td_bs_id = paste(samples, "ref", sep = ":")) %>% 
    pivot_wider(names_from = "td_bs_id", values_from = "XX:ref") %>% 
    select(-c("XX:alt"))
  
  # Alteration df
  alt_df <- df_sub %>%
    filter(td_bs_id == samples) %>%
    mutate(td_bs_id = paste(samples, "alt", sep = ":")) %>% 
    pivot_wider(names_from = "td_bs_id", values_from = "XX:alt") %>% 
    select(-c("XX:ref"))
  
  # Merge df
  merge_df <- ref_df %>% 
    full_join(alt_df, by = c("cg_id_kids", "mut_id", "Chr", "Position", "Wild", "Mut")) %>% 
    as.data.frame() 
  
  return(merge_df)
}

