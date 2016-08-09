library(shiny)
library(plotly)
library(leaflet)

## begin server file

# read data
stationdata <- read.csv(file="./Muller-Karger_05-17_report.csv",head=TRUE,sep=",")
attributes(stationdata)




shinyServer( function(input, output){
  
  # station map
  output$map <- renderLeaflet({
    leaflet(data = stationdata) %>%
      addProviderTiles("Esri.WorldImagery") %>%
      addMarkers(lng=~Longitude, lat=~Latitude, layerId = 1:58, popup = ~Station)
  })
  
  
  
  observe({ # update the map markers and view on map clicks
    p <- input$map_marker_click
    if(is.null(p)){
      return()
    }
    
    ds <- data.frame(labels = colnames(stationdata)[27:36],
                     values = as.numeric(stationdata[p$id ,27:36]))
    
    output$trendPlot <- renderPlotly({
      p <- plot_ly(ds, labels = labels, values = values, type = "pie") %>%
        layout(paper_bgcolor = "rgb(255,255,255,255)", plot_bgcolor="rgb(100,0,0,100)") 
    })
    
    text2<-paste("You've selected point ", p$id)
    output$Click_text<-renderText({
      text2
    })
    
  })
  
  
})