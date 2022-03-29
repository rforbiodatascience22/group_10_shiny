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
        ),
        actionButton(inputId = ns("generate_plot"), label = "Generate plot")
      ),
      mainPanel(
        plotOutput(
          outputId = ns("abundance_plot")
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
    occurrence_plot <- eventReactive(input$generate_plot, {
      if(input$peptide == ""){
        NULL
      } else {
        centraldogma::plot_aa_occurrence(protein_string = input$peptide)
      }
    })
    output$abundance_plot <- renderPlot(occurrence_plot())

  })
}

if(FALSE){ # Testing
  golem::detach_all_attached
  golem::document_and_reload
  ui <- mod_plot_aa_occurrences_ui("plot_aa_occurrences_1")
  server <- function( input,output,session){
    mod_plot_aa_occurrences_server("plot_aa_occurrences_1")
  }
  shinyApp(ui, server)
}

## To be copied in the UI
# mod_plot_aa_occurrences_ui("plot_aa_occurrences_1")

## To be copied in the server
# mod_plot_aa_occurrences_server("plot_aa_occurrences_1")
