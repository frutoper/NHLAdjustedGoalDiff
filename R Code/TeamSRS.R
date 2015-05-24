library(gridExtra)
library(R2HTML)
library(xtable)

setwd("E:\\Hockey\\nhlTeamSRS")

df <- read.csv("Data\\nhlGameSRSData.csv")

head(df)

df$Visitor <- gsub(" ", "_", df$Visitor)
df$Home <- gsub(" ", "_", df$Home)

TeamList <- unique(df[,1])

TeamList <- TeamList[order(TeamList)]
##### Goals For ########################################################
VGoalsFor <- aggregate(Scr ~ Visitor, df, FUN = sum)
HGoalsFor <- aggregate(Scr.1 ~ Home, df, FUN = sum)

colnames(VGoalsFor)[1] <- "Team"
colnames(HGoalsFor)[1] <- "Team"

GoalsFor <- merge(VGoalsFor, HGoalsFor)
GoalsFor$GoalsFor <- GoalsFor$Scr + GoalsFor$Scr.1

GoalsFor <- GoalsFor[,c(1,4)]


##### Goals Against ####################################################
VGoalsAg <- aggregate(Scr.1 ~ Visitor, df, FUN = sum)
HGoalsAg <- aggregate(Scr ~ Home, df, FUN = sum)

colnames(VGoalsAg)[1] <- "Team"
colnames(HGoalsAg)[1] <- "Team"

GoalsAg <- merge(VGoalsAg, HGoalsAg)
GoalsAg$GoalsAg <- GoalsAg$Scr + GoalsAg$Scr.1

GoalsAg <- GoalsAg[,c(1,4)]

##### Initial Rank####################################################

Int <- merge(GoalsFor, GoalsAg)
Int$GoalDiff <- Int$GoalsFor - Int$GoalsAg

InitialRank <- Int[,c(1,4)]

#############################################################################
# Opponents
#############################################################################
team <- df[,c(1,3)]
dim(team)
#a <- TeamList[1]

for(j in 3:30){
InitialRank[,j] <- NULL

for(i in seq_along(TeamList)){                
        
        VOp <- subset(team, Visitor == TeamList[i])
        colnames(VOp)[2] <- "Team"
        colnames(VOp)[1] <- "Base"
        
        HOp <- subset(team, Home ==TeamList[i])
        colnames(HOp)[2] <- "Base"
        colnames(HOp)[1] <- "Team"
        
        allgames <- rbind(HOp, VOp)
        
        #dim(allgames)
        
        Games_Rank <- merge(allgames, InitialRank, by = "Team")
        
        OpAvgGoalRank <- mean(Games_Rank$GoalDiff)
        OpAvgGoalRank <- mean(Games_Rank[,(j)])
        
        InitialRank[InitialRank$Team == TeamList[i],j] <- InitialRank[InitialRank$Team == TeamList[i],"GoalDiff"] + OpAvgGoalRank

}
}

FinalRank <- InitialRank[,c(1:2,30)]

colnames(FinalRank)[3] <- "Adj GoalDiff"
FinalRank[,3] <- round(FinalRank[,3],2)
FinalRank$Sched.Adj. <- round(FinalRank[,3] - FinalRank[,2],2)

FinalRank <- FinalRank[order(-FinalRank[,4]),]

FinalRank <- FinalRank[order(-FinalRank[,3]),]

###########################################################################
# Add W, L, OT, P
##########################################################################
st <- read.csv("Data\\nhlTeamStandings.csv")
st$Team <- gsub(" ", "_", st$Team)
st <- st[,1:6]

FinalTable <- merge(st, FinalRank)

FinalTable <- FinalTable[order(-FinalTable[,8]),]
rownames(FinalTable) <- 1:nrow(FinalTable)


png("Output//EndOfSeasonTableRow.png", width = 470, height = 662)
grid.table(FinalTable)
dev.off()

write.csv(FinalTable, "Output//EndOfSeasonTable.csv",row.names=FALSE)

HTML("Output//EndOfSeasonTable.HTML", width = 436, height = 662)
grid.table(FinalTable, rows = NULL)
dev.off()

#########################################################################
# HTML Output
########################################################################


HTMLStart(outdir="Output//", file="myreport",
          extension="html", echo=FALSE, HTMLframe=TRUE)

print(FinalTable)
HTMLhr()

HTMLStop()



