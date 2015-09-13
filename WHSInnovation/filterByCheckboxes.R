filterDataFrameByCheckboxes <- function(df,input)
{
    print("filterDataFrameByCheckboxes")
    
    print("df")
    print( dim(df) )
    
    # the selection vector that will eventually select the relevant documents per the specific filters
    selectionVector <- logical( length = nrow(df) )
    
    # public input
    # ------------
    publicInput <- input$checkGroupPublicInput 

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
    
    # WHS Output
    # ----------
    whsOutput <- input$checkGroupWHSOutput
    selectionVector2 <- logical( length = nrow(df) )
    
    if ( 1 %in% whsOutput )
        selectionVector2 <- selectionVector2 | df$WHS.Output..Stakeholder.Analysis.Report 
    
    if ( 2 %in% whsOutput )
        selectionVector2 <- selectionVector2 | df$WHS.Output..Co.Chairs.Summary
    
    if ( 3 %in% whsOutput )
        selectionVector2 <- selectionVector2 | df$WHS.Output..Thematic.report
    
    if ( 4 %in% whsOutput )
        selectionVector2 <- selectionVector2 | df$WHS.Output..Online.consultation.report
        
    if  ( 5 %in% whsOutput )
    {
        # TRUE means that there is at least one input method, FALSE means othe 
        
        others <-   df$WHS.Output..Stakeholder.Analysis.Report | 
            df$WHS.Output..Co.Chairs.Summary |
            df$Public.Input..Stakeholder.Consultation.Report |
            df$WHS.Output..Thematic.report |
            df$WHS.Output..Online.consultation.report 
        
        others = !others
        
        selectionVector2 <- selectionVector | others                 
    }
        
    # Stakeholder Group
    # -------------------
    stakeholderGroup <- input$checkGroupStakeholderGroup
    selectionVector3 <- logical( length = nrow(df) ) 
    
    if ( 1 %in% stakeholderGroup )
        selectionVector3 <- selectionVector3 | df$Stakeholder.Group..Affected.communities 
    
    if ( 2 %in% stakeholderGroup )
        selectionVector3 <- selectionVector3 | df$Stakeholder.Group..Civil.society.groups
    
    if ( 3 %in% stakeholderGroup )
        selectionVector3 <- selectionVector3 | df$Stakeholder.Group..Local.NGOs
    
    if ( 4 %in% stakeholderGroup )
        selectionVector3 <- selectionVector3 | df$Stakeholder.Group..Member.States
    
    if  ( 5 %in% stakeholderGroup )
        selectionVector3 <- selectionVector3 | df$Stakeholder.Group..UN.Agency
    
    if  ( 6 %in% stakeholderGroup )
        selectionVector3 <- selectionVector3 | df$Stakeholder.Group..INGOs
    
    if  ( 7 %in% stakeholderGroup )
        selectionVector3 <- selectionVector3 | df$Stakeholder.Group..Regional.bodies
    
    if  ( 8 %in% stakeholderGroup )
        selectionVector3 <- selectionVector3 | df$Stakeholder.Group..Academia
    
    if  ( 9 %in% stakeholderGroup )
        selectionVector3 <- selectionVector3 | df$Stakeholder.Group..Multiple.stakeholders

    if  ( 10 %in% stakeholderGroup )
    {
        # TRUE means that there is at least one input method, FALSE means othe 
        
        others <-   df$Stakeholder.Group..Affected.communities | 
            df$Stakeholder.Group..Civil.society.groups |
            df$Stakeholder.Group..Local.NGOs |
            df$Stakeholder.Group..Member.States |
            df$Stakeholder.Group..UN.Agency | 
            df$Stakeholder.Group..INGOs | 
            df$Stakeholder.Group..Regional.bodies | 
            df$Stakeholder.Group..Academia | 
            df$Stakeholder.Group..Multiple.stakeholders  
        
        others = !others
        
        selectionVector3 <- selectionVector3 | others                 
    }
    
    # Regional Context 
    # -------------------
    regionalContext <- input$checkGroupRegionalContext
    selectionVector4 <- logical( length = nrow(df) ) 
    
    if ( 1 %in% regionalContext )
        selectionVector4 <- selectionVector4 | df$WCA.Documents 
    
    if ( 2 %in% regionalContext )
        selectionVector4 <- selectionVector4 | df$NSEA.Documents
    
    if ( 3 %in% regionalContext )
        selectionVector4 <- selectionVector4 | df$EOG.Documents
    
    if ( 4 %in% regionalContext )
        selectionVector4 <- selectionVector4 | df$MENA.Documents
    
    if  ( 5 %in% regionalContext )
        selectionVector4 <- selectionVector4 | df$LAC.Documents
    
    if  ( 6 %in% regionalContext )
        selectionVector4 <- selectionVector4 | df$Pacific.Region
    
    if  ( 7 %in% regionalContext )
        selectionVector4 <- selectionVector4 | df$Global.Documents
    
    if  ( 8 %in% regionalContext )
    {
        # TRUE means that there is at least one input method, FALSE means othe 
        
        others <-   df$WCA.Documents | 
            df$NSEA.Documents |
            df$EOG.Documents |
            df$MENA.Documents | 
            df$LAC.Documents | 
            df$Pacific.Region | 
            df$Global.Documents
        
        others = !others
        
        selectionVector4 <- selectionVector4 | others                 
    }
    
    
    # National Context
    # ----------------
    
    nationalContext <- input$checkGroupNationalContext
    selectionVector5 <- logical( length = nrow(df) ) 
    
    if ( 1 %in% nationalContext )
        selectionVector5 <- selectionVector5 | df$National.Context..Bahrain 
    
    if ( 2 %in% nationalContext )
        selectionVector5 <- selectionVector5 | df$National.Context..Barbados
    
    if ( 3 %in% nationalContext )
        selectionVector5 <- selectionVector5 | df$National.Context..Trinidad.and.Tobago
    
    if ( 4 %in% nationalContext )
        selectionVector5 <- selectionVector5 | df$National.Context..Congo
    
    if  ( 5 %in% nationalContext )
        selectionVector5 <- selectionVector5 | df$National.Context..Japan
    
    if  ( 6 %in% nationalContext )
        selectionVector5 <- selectionVector5 | df$National.Context..New.Zealand
    
    if  ( 7 %in% nationalContext )
        selectionVector5 <- selectionVector5 | df$National.Context..Samoa
    
    if  ( 8 %in% nationalContext )
        selectionVector5 <- selectionVector5 | df$National.Context..Solomon.Islands
    
    if  ( 9 %in% nationalContext )
    {
        # TRUE means that there is at least one input method, FALSE means othe 
        
        others <-   df$National.Context..Bahrain | 
            df$National.Context..Barbados |
            df$National.Context..Trinidad.and.Tobago |
            df$National.Context..Congo | 
            df$National.Context..Japan | 
            df$National.Context..New.Zealand | 
            df$National.Context..Samoa |
            df$National.Context..Solomon.Islands
        
        others = !others
        
        selectionVector5 <- selectionVector5 | others                 
    }
    
    
    # ---------------------------------------
    
    selectionVector <- selectionVector & selectionVector2 & selectionVector3 & selectionVector4 & selectionVector5
    
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
    
   
    
