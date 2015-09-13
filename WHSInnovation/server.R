require(reshape2)
library(data.table)
library(ggplot2)
library(RColorBrewer)

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
    
    df <- read.csv(file="./data/data-final.csv")
    
    # prep the needgraph
    df.need <- as.data.frame(table(df$Need))
    names(df.need)[names(df.need)=="Var1"] <- "Need"
    names(df.need)[names(df.need)=="Freq"] <- "Count"
    df.need.sorted <- df.need[order(-df.need$Count),]
    # sort the factor by the order of Count
    df.need.sorted$Need <- factor(df.need.sorted$Need, levels = df.need.sorted$Need)  
    nNeeds <- nrow(df.need.sorted)
    #getPalette = colorRampPalette(brewer.pal(9, "Spectral"))
    getPalette = colorRampPalette(brewer.pal(9, "RdYlBu"))
    
    # prep the technology data
    df.tech <- as.data.frame(table(df$Technology))
    names(df.tech)[names(df.tech)=="Var1"] <- "Technology"
    names(df.tech)[names(df.tech)=="Freq"] <- "Count"
    
    df.tech.sorted <- df.tech[order(-df.tech$Count),]
    
    # sort the factor by the order of Count
    df.tech.sorted$Technology <- factor(df.tech.sorted$Technology, levels = df.tech.sorted$Technology)
    
    nTech <- nrow(df.tech.sorted)
    
  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })
  
  output$needBar <- renderPlot({
      ggplot(data=df.need.sorted, aes(x=reorder(Need,-Count),fill = Need, y = Count)) +
          theme_grey() +
          scale_fill_manual(values = getPalette(nNeeds)) +
          xlab("Need") +
          ylab("Count") +
          geom_bar(stat="identity") +
          theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
      
  })
  
  output$technologyBar <- renderPlot({
      ggplot(data=df.tech.sorted, aes(x=reorder(Technology,-Count),y = Count, fill = Technology)) +
          scale_fill_manual(values = getPalette(nTech)) +
          theme_grey() +
          xlab("Technology") +
          ylab("Count") +
          geom_bar(stat="identity") +
          theme(axis.text.x = element_text(angle = 90, hjust = 1))      
  })
  


})
