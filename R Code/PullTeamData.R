library(XML)
library(RCurl)

setwd("E:\\Hockey\\nhlTeamSRS")

Url <- NULL
doc <- NULL
all <- NULL
for(i in 1:41){
        Url <- paste("http://www.nhl.com/stats/game?fetchKey=20152ALLSATAll&viewName=summary&sort=gameDate&gp=1&pg=", i, sep="")
        doc <- readHTMLTable(Url, which=3)
        all <- rbind(all, doc)
}                
 
##############################################################################################################################
str(all)
head(all)
colnames(all) <- gsub("[\r\n]", "", colnames(all))
colnames(all) <- sub("^\\s+", "", colnames(all))
all <- all[-1:-2,] #Remove current games in progress

SRS <- all[,c(2,3,4,5,6,9,13)]
str(SRS)
mean(as.numeric(as.character(SRS[,6])))
mean(as.numeric(as.character(SRS[,7])))
#############################################################################################################################

write.csv(SRS, file = "Data\\nhlGameSRSData.csv",row.names=FALSE)

#############################################################################
# Team Data
#############################################################################

Url <- "http://www.nhl.com/stats/team?fetchKey=20152ALLSAAAll&ord=desc&sort=points&viewName=summary"
Standings <- readHTMLTable(Url, which=3)

colnames(Standings) <- gsub("[\r\n]", "", colnames(Standings))
colnames(Standings) <- sub("^\\s+", "", colnames(Standings))

write.csv(Standings[,-1], file = "Data\\nhlTeamStandings.csv",row.names=FALSE)





