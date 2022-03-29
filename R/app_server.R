#' The application server-side
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom magrittr %>%
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  mod_peptide_maker_server("peptide_maker_1")
  mod_plot_aa_occurrences_server("plot_aa_occurrences_1")
}
