## NHL 2014-2015 Adjusted Goal Differential

Below are power ranking for the 2014-2015 NHL regular season.  The method I used was based on the Simple Ranking System outlined [HERE](http://www.pro-football-reference.com/blog/?p=37) by Football Reference.  The ranking system is based on goal differential and the goal differential of your opponents.  The New York Ranger have the best goal differential (60), but lose 3 “Goals” due to their relatively weak schedule.  The St. Louis Blues have a goal differential of 47 and gain 1.6 “Goals” for their relatively tough schedule.  Recently fivethirtyeight.com used this system to [rate college basketball teams](http://fivethirtyeight.com/features/this-years-kentucky-team-is-more-dominant-than-indianas-undefeated-1976-squad/).  Just like the NHL scoring system I included a goal for a shootout win. Let me know if you think these goals should be counted or not.

![alt tag](https://github.com/frutoper/NHLAdjustedGoalDiff/blob/master/Output/EndOfSeasonTable.png)

Notes:

* The Central is good.  Both wildcards in the West came out of the Central so it shouldn’t be a surprise to see these teams at the top of the list. 
* LA was the best team to not make the playoffs.  This ranking system had them better than 3 playoff teams.
* Anaheim is the worst playoff team, which is surprising given their 109 points.  The Ducks average 2.78 goals per game and give up 2.70 goals per game.  Look for another early exit for Anaheim.
* Buffalo and Arizona are really bad.  The spread in goal differential is larger than points. This ranking shows how bad these teams really are.  Buffalo did have a tough schedule, but that is partially because they never got to play themselves. 
Technical Notes:
* I used 30 iterations of the system to get to the Adjusted Goal Differential.  This may have been excessive given how little changed after even 5 iterations.  More iterations might be needed in leagues like the NFL or college sports where ever team doesn't play each other

Data: Scraped from http://www.nhl.com/stats/

