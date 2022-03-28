#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      h1("centraldogmaapp"),
      tabsetPanel(
        tabPanel(title = "Peptide Maker",
                 mod_Peptide_Maker_ui("Peptide_Maker_1")),
        tabPanel(title = "panel2",
                 "module2"),
        tabPanel(title = "panel1",
                 "module1"),
        tabPanel(title = "Plot Amino acid occurrences",
                 mod_plot_aa_occurrences_ui("plot_aa_occurrences_1"))
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "centraldogmaapp"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
