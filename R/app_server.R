#' The application server-side
#' @importFrom magrittr %>%
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  mod_Peptide_Maker_server("Peptide_Maker_1")
  mod_plot_aa_occurrences_server("plot_aa_occurrences_1")
}
