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
             numericInput(inputId = ns("dna_length"),
                          label = "Input the DNA length",
                          value = 6000,
                          min = 3,
                          step = 3),
             actionButton(inputId = ns("generate_dna"),
                          label ="Generate DNA",
                          style = "margin-top: 18px;")
             )
    ),
    tags$strong("The Peptide Sequence"),
    verbatimTextOutput(outputId = ns("peptide"),
                       placeholder = TRUE) %>%
      tagAppendAttributes(style = "white-space: pre-wrap;")
)}

#' peptide_maker Server Functions
#'
#' @noRd

mod_peptide_maker_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    observeEvent(input$generate_dna, {
      updateTextAreaInput(inputId = "dna_sequence",
                          value = centraldogma::generate_dna(input$dna_length))
      })

     output$peptide <- renderText({
       if(nchar(input$dna_sequence) < 3){
         NULL
       } else {
         input$dna_sequence %>%
           toupper() %>%
           centraldogma::transcribe() %>%
           centraldogma::split_codons() %>%
           centraldogma::translate()
       }
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
