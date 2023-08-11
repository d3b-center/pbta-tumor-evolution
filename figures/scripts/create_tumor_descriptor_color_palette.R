# Create color palettes for each kind of data in PBTA-tumor-evolution-analysis
# Antonia Chroni <chronia@chop.edu> for D3B
#
# Usage:
# Anywhere a plot is being made, source these TSV file and use the color palette for
# each appropriate data type.
#
# Magrittr pipe
`%>%` <- dplyr::`%>%`

# Establish base dir
root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))

# Output to palette directory
output_dir <-
  file.path(root_dir, "figures", "palettes")
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}


### A color scale for tumor_descriptor data
tumor_descriptor_col_palette <- c("#1e90ff", 
                                  "#808080", 
                                  "#800080", 
                                  "#cd2626",
                                  "#FDB863",
                                  "#A6611A")

tumor_descriptor_col_names <- c("Diagnosis",
                                "Progressive",
                                "Recurrence",
                                "Deceased",
                                "Second Malignancy",
                                "Unavailable")

# Format as data.frame
tumor_descriptor_df <- data.frame(color_names = tumor_descriptor_col_names,
                                  hex_codes = tumor_descriptor_col_palette) %>%
  readr::write_tsv(file.path(output_dir, "tumor_descriptor_color_palette.tsv"))


###-----------------------------------------
### A color scale for tumor_descriptor data for creating corplots
# `timepoint' stands for any of the following: "Diagnosis", "Progressive", "Recurrence"
timepoint_col_palette <- c("#1e90ff",
                           "#cd2626",
                           "#575757",
                           "#DFC27D")

timepoint_col_names <- c("timepoint",
                         "Deceased",
                         "Common",
                         "Uncommon")

# Format as data.frame
timepoint_df <- data.frame(color_names = timepoint_col_names,
                                  hex_codes = timepoint_col_palette) %>%
  readr::write_tsv(file.path(output_dir, "timepoint_color_palette.tsv"))
