filterDataFrameByCheckboxes <- function(df,input)
{
    print("filterDataFrameByCheckboxes")
    
    print("df")
    print( dim(df) )
    
    publicInput <- input$checkGroupPublicInput
    
    selectionVector <- logical( length = nrow(df) )
    
    if ( 1 %in% publicInput )
        selectionVector <- selectionVector | df$Public.Input..Submission.to.WHS 
    
    if ( 2 %in% publicInput )
        selectionVector <- selectionVector | df$Public.Input..Survey.Results
    
    if ( 3 %in% publicInput )
        selectionVector <- selectionVector | df$Public.Input..Stakeholder.Consultation.Report
    
    if ( 4 %in% publicInput )
        selectionVector <- selectionVector | df$Public.Input..External.Conference.Report
    
    if  ( 5 %in% publicInput )
        selectionVector <- selectionVector | df$Public.Input..Key.document
    
    if  ( 6 %in% publicInput )
    {
        # TRUE means that there is at least one input method, FALSE means othe 
        
        others <-   df$Public.Input..Submission.to.WHS | 
                    df$Public.Input..Survey.Results |
                    df$Public.Input..Stakeholder.Consultation.Report |
                    df$Public.Input..External.Conference.Report |
                    df$Public.Input..Key.document 
        
        others = !others
        
        selectionVector <- selectionVector | others                 
    }
    
    df.filtered <- df[ selectionVector, ]
    
    print("df.filtered")
    print( dim(df.filtered) )
    return (df.filtered)
}

prepNeedData <- function(df)
{
     df.need <- as.data.frame(table(df$Need))
     names(df.need)[names(df.need)=="Var1"] <- "Need"
     names(df.need)[names(df.need)=="Freq"] <- "Count"
     df.need.sorted <- df.need[order(-df.need$Count),]
     # sort the factor by the order of Count
     df.need.sorted$Need <- factor(df.need.sorted$Need, levels = df.need.sorted$Need)
     return (df.need.sorted)
}

prepTechData <- function(df)
{
     df.tech <- as.data.frame(table(df$Technology))
     names(df.tech)[names(df.tech)=="Var1"] <- "Technology"
     names(df.tech)[names(df.tech)=="Freq"] <- "Count"
     df.tech.sorted <- df.tech[order(-df.tech$Count),]
     # sort the factor by the order of Count
     df.tech.sorted$Technology <- factor(df.tech.sorted$Technology, levels = df.tech.sorted$Technology)
     return (df.tech.sorted)
}
    
   
    
