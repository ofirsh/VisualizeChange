library(data.table)
library(plyr)

data.full <- data.frame(fread("./data/WHSMasterConsultationData-TAB.txt"))

data.full <- read.delim("./data/WHSMasterConsultationData-TAB.txt")

data.full <- read.delim(file = "./data/WHSMasterConsultationData-TAB.txt",
                            # sep = "\t", 
                            # quote = "\"",
                            # dec = ".", 
                            # fill = TRUE, 
                            # comment.char = "",
                            stringsAsFactors = FALSE )