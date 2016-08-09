library(shiny)
library(plotly)
library(leaflet)

shinyUI( bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                
                plotlyOutput("trendPlot", width = 400, height = 300)
  ),
  verbatimTextOutput("Click_text")
))