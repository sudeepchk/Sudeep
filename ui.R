

library(shiny)
library(plotly)
library(ggplot2)
library(DT)

navbarPage(
  title = 'Interpol Criminal Data Interpretation',
  tabPanel('Criminal Records',  fluidRow(
    column(4,
           selectInput("ct",
                       "Crime Count:",
                       c("All",
                         unique(as.character(crim_bind$count))))
    ),
    column(4,
           selectInput("wanted_by",
                       "Wanted_By:",
                       c("All",
                         unique(as.character(crim_bind$wanted_by))))
    ),
    column(4,
           selectInput("sex",
                       "Sex:",
                       c("All",
                         unique(as.character(crim_bind$sex))))
    ),
    column(4, selectInput("age_bin",
                          "Age",
                          c("All",
                            unique(as.character(crim_bind$age_bin))))
    )
   
     ),
  # Create a new row for the table.
  fluidRow(
    DT::dataTableOutput("ex1")
  )
),
  tabPanel('Criminal Records By Crime Nature',  fluidRow(
    column(4, selectInput("Nature",
                          "Crime Nature",
                            c("All",
                              unique(as.character(crim_gather$Nature))))
  ),
  column(4, selectInput("Status",
                        "Status",
                        c("All",
                          unique(as.character(crim_gather$Status))))
  )
  ),
  fluidRow(DT::dataTableOutput("ex2"))),
  tabPanel('Gender Metrics', mainPanel(plotlyOutput('plot1'))),
  tabPanel('Nature of Crime Vs. Criminals Count', mainPanel(plotlyOutput('plot2'))),
  tabPanel('Individual Crime Count', mainPanel(plotlyOutput('plot3'))),
  tabPanel('Wanted By Country Vs. Criminals Count', mainPanel(plotlyOutput('plot4'))),
  tabPanel('Interpol Age Metrics', mainPanel(plotlyOutput('plot5'))),
  tabPanel('Interpol Crime Vs. Gender Metrics', mainPanel(plotlyOutput('plot6'))),
  tabPanel('Interpol Crime Vs. Age Metrics', mainPanel(plotlyOutput('plot7')))
)