filterDataFrameByCheckboxes <- function(df,input)
{
    df.filtered <- df
    
    publicInput <- input$checkGroupPublicInput
    
    if (!( 1 %in% publicInput ))
        df.filtered <- df.filtered[ df.filtered$Public.Input..Submission.to.WHS == FALSE, ]
    
    if (!( 2 %in% publicInput ))
        df.filtered <- df.filtered[ df.filtered$Public.Input..Survey.Results == FALSE, ]
    
    if (!( 3 %in% publicInput ))
        df.filtered <- df.filtered[ df.filtered$Public.Input..Stakeholder.Consultation.Report == FALSE, ]
    
    if (!( 4 %in% publicInput ))
        df.filtered <- df.filtered[ df.filtered$Public.Input..External.Conference.Report == FALSE, ]
    
    if (!( 5 %in% publicInput ))
        df.filtered <- df.filtered[ df.filtered$Public.Public.Input..Key.document == FALSE, ]
    
    return (data.table(df.filtered))
}

prepNeedData <- function(df)
{
     df.need <- as.data.frame(table(df$Need))
     names(df.need)[names(df.need)=="Var1"] <- "Need"
     names(df.need)[names(df.need)=="Freq"] <- "Count"
     df.need.sorted <- df.need[order(-df.need$Count),]
     # sort the factor by the order of Count
     df.need.sorted$Need <- factor(df.need.sorted$Need, levels = df.need.sorted$Need)
     return(data.table(df.need.sorted))
}

prepTechData <- function(df)
{
     df.tech <- as.data.frame(table(df$Technology))
     names(df.tech)[names(df.tech)=="Var1"] <- "Technology"
     names(df.tech)[names(df.tech)=="Freq"] <- "Count"
     df.tech.sorted <- df.tech[order(-df.tech$Count),]
     # sort the factor by the order of Count
     df.tech.sorted$Technology <- factor(df.tech.sorted$Technology, levels = df.tech.sorted$Technology)
     return(data.table(df.tech.sorted))
}
    
   
    
