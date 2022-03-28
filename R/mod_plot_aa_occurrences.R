#' plot_aa_occurrences UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_aa_occurrences_ui <- function(id){
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        textAreaInput(
          inputId = ns("peptide"),
          label = "Peptide sequence",
          width = 300,
          height = 100,
          placeholder = "Insert peptide sequence"
        )
      ),
      mainPanel(
        plotOutput(
          outputId = ns("abundance")
        )
      )
    )
  )
}

#' plot_aa_occurrences Server Functions
#'
#' @noRd
mod_plot_aa_occurrences_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_plot_aa_occurrences_ui("plot_aa_occurrences_1")

## To be copied in the server
# mod_plot_aa_occurrences_server("plot_aa_occurrences_1")
