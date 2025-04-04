
#Find dataset that applies to either all of the plots, or find multiple examples-what kind of data works best for each? 
#Give a brief description of the types of plots we're running, and what kind of dataset works best for them 


#Loading in a TidyDataset from this link: https://github.com/rfordatascience/tidytuesday/blob/main/data/2021/2021-09-14/readme.md
library(tidyverse)
library(lubridate)
library(ggbeeswarm)
library(ggridges)
library(treemap)

tuesdata <- tidytuesdayR::tt_load('2021-09-14')
billboard<- tuesdata$billboard

song_features<-tuesdata$audio_features

#So there are two datasets-one for the actual billboard list from 1965-2017, with weekly data, and then one for the audio features, with descriptions and characteristics of each song that can be joined/tracked. So immediately, one of the first things I notice is that we should probably join the song features to each song-this could lengthen the dataset quite a bit, so maybe we hold off on this for a second. 

#Beeswarm Plot-typically used to present individual data points without overlap. Used when you want to show the overall distribution of a variable and the individual data points.
#Ex. Plot of "Danceability/Energy/Speechiness", maybe the color is separated by decades?
decades<-billboard%>%
  mutate(Date=mdy(week_id), Year=year(Date))%>%
  mutate(Decade=round(Year/10)*10)%>%
  left_join(song_features, by="song_id")%>%
  filter(!is.na(danceability))


song_features<-song_features%>%
  filter(!is.na(danceability))

#Create a beeswarm plot of Danceability for each decade

beeswarm<-ggplot(song_features, aes(x=danceability, y=''))+geom_beeswarm()

beeswarm



#Ridgeline-shows the distribution of a numeric value for several groups. Another way to show density estimates for a number of groups
#Ex. Similar plot as beeswarm plot, but may use another variable this time, still separated by decades 


decades$Decade<-as.factor(decades$Decade)

ridgeline<-ggplot(decades, aes(x=danceability, y=Decade,fill=Decade))+geom_density_ridges()+theme_ridges()+theme(legend.position="none")

ridgeline



#2-D Density-used to visualize the relationship between two numeric variables-So maybe the relationships between song features?

density2d<-ggplot(data=decades,aes(danceability, tempo))+geom_bin_2d()+scale_fill_continuous(type="viridis")+theme_bw()

density2d


#Dendrogram-Maybe group songs based on how many times they have been in the Top 100 charts? So maybe we look at the top 10 list of songs for each decade, and then compare those (should be 50 or so songs), by Danceability to see how they're clustered 



#So first group by decades
#Extract Top 10 songs from each decade
#Join Danceability metric to each song 
#Create dendrogram

decades_dendro<-decades%>%
  group_by(Decade)%>%
  filter(peak_position<3)%>%
  group_by(song.x)%>%
  mutate(Instance=instance)%>%
  select(-c(url,week_id, week_position, Date, previous_week_position, weeks_on_chart,Year, peak_position))%>%
  distinct()%>%
  group_by(Decade)

ex<-decades_dendro[1:20,]
  

distance_matrix <- dist(ex$danceability)  # Euclidean distance
hc <- hclust(distance_matrix, method = "complete")

dendro<-as.dendrogram(hc)

plot(dendro, main = "Dendrogram of Top Songs by Danceability",
     xlab = "Songs", ylab = "Distance", sub = "Complete Linkage")


#Pull 20 songs from the last 5-10 years

