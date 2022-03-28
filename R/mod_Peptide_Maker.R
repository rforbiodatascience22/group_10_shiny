#' Peptide_Maker UI Function
#'
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_Peptide_Maker_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(8,
             textAreaInput(ns("DNA_Sequence"), "DNA Sequence",
                           value = "Enter DNA sequence..."
             ))
             ,
      column(4,
             numericInput(ns("length"), "Input the dna length",
                          value = 0),
             actionButton(ns("generate"), "Generate DNA")
             )
    ),
    "The Peptide Sequence",
    verbatimTextOutput(ns("peptide"))
)}

#' Peptide_Maker Server Functions
#'
#' @noRd

simulation <- function(input){
  input %>%
    centraldogma::transcribe() %>%
    centraldogma::split_codons() %>%
    centraldogma::translate()
}
mod_Peptide_Maker_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    observeEvent(input$generate, {
      updateTextAreaInput(inputId = "DNA_Sequence",
                          value = centraldogma::generate_dna(input$length))
      })

     output$peptide <- renderPrint({
       simulation(input$DNA_Sequence)
       })
     })
  }

## To be copied in the UI
# mod_Peptide_Maker_ui("Peptide_Maker_1")

## To be copied in the server
# mod_Peptide_Maker_server("Peptide_Maker_1")
