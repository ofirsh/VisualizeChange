require(reshape2)
library(data.table)
library(ggplot2)
library(RColorBrewer)

df <- read.csv(file="./data/data-final.csv")

df.need <- as.data.frame(table(df$Need))
names(df.need)[names(df.need)=="Var1"] <- "Need"
names(df.need)[names(df.need)=="Freq"] <- "Count"
df.need.sorted <- df.need[order(-df.need$Count),]

# sort the factor by the order of Count
df.need.sorted$Need <- factor(df.need.sorted$Need, levels = df.need.sorted$Need)

nNeeds <- nrow(df.need.sorted)
#getPalette = colorRampPalette(brewer.pal(9, "Spectral"))
getPalette = colorRampPalette(brewer.pal(9, "RdYlBu"))

# rainbowcols <- rainbow(nrows)
# fill = getPalette(nNeeds) ,

ggplot(data=df.need.sorted, aes(x=reorder(Need,-Count),fill = Need, y = Count)) +
    theme_grey() +
    scale_fill_manual(values = getPalette(nNeeds)) +
    xlab("Need") +
    ylab("Count") +
    geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) 

df.tech <- as.data.frame(table(df$Technology))
names(df.tech)[names(df.tech)=="Var1"] <- "Technology"
names(df.tech)[names(df.tech)=="Freq"] <- "Count"

df.tech.sorted <- df.tech[order(-df.tech$Count),]

# sort the factor by the order of Count
df.tech.sorted$Technology <- factor(df.tech.sorted$Technology, levels = df.tech.sorted$Technology)

nTech <- nrow(df.tech.sorted)


ggplot(data=df.tech.sorted, aes(x=reorder(Technology,-Count),y = Count, fill = Technology)) +
    scale_fill_manual(values = getPalette(nTech)) +
    theme_grey() +
    xlab("Technology") +
    ylab("Count") +
    geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))  
    # guides(fill=FALSE)


