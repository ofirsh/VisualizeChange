require(reshape2)
library(data.table)
library(ggplot2)
library(RColorBrewer)

source("filterByCheckboxes.R")

# How to deploy the app
# deployApp()

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

print("Loading file")
df <- read.csv(file="./data/data-final.csv")

#getPalette = colorRampPalette(brewer.pal(9, "Spectral"))
getPalette = colorRampPalette(brewer.pal(9, "RdYlBu"))

# df.filtered <- df
# df.need.sorted <- df
# df.tech.sorted <- df
# 
# nNeeds <- -1
# nTech <- -1 

shinyServer( function(input, output) {
    
#     Everything within this function is instantiated separately for each session. 
#     This includes the input and output objects that are passed to it: each session has its own input and output objects, visible within this function.    
#     Other objects inside the function, such as variables and functions, are also instantiated for each session. 

    
  # filterDataFrameByCheckboxes()  
    
  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })
  
  output$needBar <- renderPlot({
      
      # http://shiny.rstudio.com/articles/reactivity-overview.html
      
      df.filtered <- filterDataFrameByCheckboxes(df,input) 
      df.need.sorted <- prepNeedData(df.filtered)
#       df.filtered <- reactive({ filterDataFrameByCheckboxes(df,input) })
#       df.need.sorted <- reactive({ prepNeedData(df.filtered) })
      nNeeds <- nrow(df.need.sorted)
      print(nNeeds)
      
      ggplot(data=df.need.sorted, aes(x=reorder(Need,-Count),fill = Need, y = Count)) +
          theme_grey() +
          scale_fill_manual(values = getPalette(nNeeds)) +
          xlab("Idea") +
          ylab("Count") +
          geom_bar(stat="identity") +
          theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
      
  })
  
  output$technologyBar <- renderPlot({
      
      df.filtered <- filterDataFrameByCheckboxes(df,input) 
      df.tech.sorted <- prepTechData(df.filtered)   
#       df.filtered <- reactive({ filterDataFrameByCheckboxes(df,input) })
#       df.tech.sorted <- reactive({ prepTechData(df.filtered) })
      nTech <- nrow(df.tech.sorted)
      print(nTech)
      
      ggplot(data=df.tech.sorted, aes(x=reorder(Technology,-Count),y = Count, fill = Technology)) +
          scale_fill_manual(values = getPalette(nTech)) +
          theme_grey() +
          xlab("Technology") +
          ylab("Count") +
          geom_bar(stat="identity") +
          theme(axis.text.x = element_text(angle = 90, hjust = 1))      
  })
   
})





