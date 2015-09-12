
require(reshape2)
library(data.table)
library(plyr)
library(stringr)

set.seed(47)

data.full <- read.delim(file = "./data/WHSMasterConsultationData-TAB.txt",
                            # sep = "\t", 
                            # quote = "\"",
                            # dec = ".", 
                            # fill = TRUE, 
                            # comment.char = "",
                            stringsAsFactors = FALSE )

data.full$Description <- NULL

data.nodesc <- data.full

data.nodesc$NeedTech1 <- paste( data.nodesc$Need1, data.nodesc$Technology1, sep="*")
data.nodesc$NeedTech2 <- paste( data.nodesc$Need2, data.nodesc$Technology2, sep="*")
data.nodesc$NeedTech3 <- paste( data.nodesc$Need3, data.nodesc$Technology3, sep="*")
data.nodesc$NeedTech4 <- paste( data.nodesc$Need4, data.nodesc$Technology4, sep="*")
data.nodesc$NeedTech5 <- paste( data.nodesc$Need5, data.nodesc$Technology5, sep="*")
data.nodesc$NeedTech6 <- paste( data.nodesc$Need6, data.nodesc$Technology6, sep="*")
data.nodesc$NeedTech7 <- paste( data.nodesc$Need7, data.nodesc$Technology7, sep="*")

# remove the orignial columns: e.g. need1, technology1, need2, technology2, ... need7, technology7
data.nodesc.paste <- data.nodesc[, -c(2:15)]

data.melt <- melt(data.nodesc.paste, measure = colnames(data.nodesc.paste)[colnames(data.nodesc.paste) %like% "NeedTech"] )
dim(data.melt)
# [1] 595  36

# keep meaningful value (Online Registration*Mobile, Communication*Mobile) and remove the empty ones - quickest will be filtering by length ...

# less that 5 characters is a variation of " * ", "* " etc, which means an empty entry (no need and notechnology)
nonempty.idx <- ldply(data.melt$value,nchar)$V1 > 5

data.melt.nonempty <- data.melt[ nonempty.idx ,  ]
dim(data.melt.nonempty)
# [1] 210  36

data.melt.nonempty$variable <- NULL
# the column combining the need and the technology e.g. Online Registration*Mobile,Communication*Mobile 
names(data.melt.nonempty)[names(data.melt.nonempty)=="value"] <- "NeedTech"

x <- data.melt.nonempty$NeedTech
splitted <- strsplit(data.melt.nonempty$NeedTech,"*",fixed=TRUE)
splitted.need <- str_trim( ldply( splitted, function(x) { return (x[[1]])  }  )$V1, side="both")
splitted.technology <- str_trim(ldply( splitted, function(x) { return (x[[2]])  }  )$V1, side="both")

data.melt.nonempty$Need <- splitted.need
data.melt.nonempty$Technology <- splitted.technology
data.melt.nonempty$NeedTech <- NULL

# extract the boolean matrix only, and convert the "x" to TRUE and FALSE
data.melt.nonempty.boolean <- subset( data.melt.nonempty , select = -c(Filename,Need,Technology) )
data.melt.nonempty.boolean.TF <-  data.melt.nonempty.boolean == "x"

data.final <- cbind( subset( data.melt.nonempty , select = c(Filename,Need,Technology) ), data.melt.nonempty.boolean.TF )

# merge items (typos) and shorten the names

write.csv(data.final,file="./data/data-final.csv")
