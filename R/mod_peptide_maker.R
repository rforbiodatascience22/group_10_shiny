#' peptide_maker UI Function
#'
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_peptide_maker_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(width = 8,
             textAreaInput(
               inputId = ns("dna_sequence"),
               label = "DNA Sequence",
               width = 300,
               height = 100,
               placeholder = "Enter DNA sequence..."
             ))
             ,
      column(width = 4,
             numericInput(ns("length"), "Input the dna length",
                          value = 0),
             actionButton(ns("generate"), "Generate DNA")
             )
    ),
    "The Peptide Sequence",
    verbatimTextOutput(ns("peptide"))
)}

#' peptide_maker Server Functions
#'
#' @noRd

simulation <- function(input){
  input %>%
    centraldogma::transcribe() %>%
    centraldogma::split_codons() %>%
    centraldogma::translate()
}
mod_peptide_maker_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    observeEvent(input$generate, {
      updateTextAreaInput(inputId = "dna_sequence",
                          value = centraldogma::generate_dna(input$length))
      })

     output$peptide <- renderPrint({
       simulation(input$dna_sequence)
       })
     })
  }

if(FALSE){ # Testing
  golem::detach_all_attached
  golem::document_and_reload
  ui <- mod_peptide_maker_ui("peptide_maker_1")
  server <- function( input,output,session){
    mod_peptide_maker_server("peptide_maker_1")
  }
  shinyApp(ui, server)
}

## To be copied in the UI
# mod_peptide_maker_ui("peptide_maker_1")

## To be copied in the server
# mod_peptide_maker_server("peptide_maker_1")
