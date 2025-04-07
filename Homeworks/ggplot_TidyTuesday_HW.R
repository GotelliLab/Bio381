
#Loading in a TidyDataset from this link: https://github.com/rfordatascience/tidytuesday/blob/main/data/2021/2021-09-14/readme.md
library(tidyverse)
library(lubridate)
library(ggbeeswarm)
library(ggridges)


tuesdata <- tidytuesdayR::tt_load('2021-09-14') #Use tidytuesdayR::tt_load() to find the correct weeks dataset that you want to use

#This dataset has two csv's that we're going to use-Top 100 Billboard Chart songs from 1965-2017, and song features/characteristics of each one
billboard<- tuesdata$billboard 
song_features<-tuesdata$audio_features

#So there are two datasets-one for the actual billboard list from 1965-2017, with weekly data, and then one for the audio features, with descriptions and characteristics of each song that can be joined/tracked. So immediately, one of the first things I notice is that we should probably join the song features to each song


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


#Dendrogram-To visualize this and still be readable, let's first filter songs by decades and get the top 3 songs from each decade. Then we'll cluster it by danceability

#So first group by decades
#Filter the dataset for peak_position < 3 
#Go ahead and only remove columns (url,week_id, week_position, Date, previous_week_position, weeks_on_chart,Year, peak_position) from the dataset
#Get the distinct songs from the dataset
#Slice for just the first 10 songs 

decades_dendro<-decades%>%
  group_by(Decade)%>%
  filter(peak_position<3)%>%
  group_by(song.x)%>%
  mutate(Instance=instance)%>%
  select(-c(url,week_id, week_position, Date, previous_week_position, weeks_on_chart,Year, peak_position))%>%
  distinct()%>%
  ungroup()%>%
  slice(1:10)



distance_matrix <- dist(decades_dendro$danceability)  # Euclidean distance to calculate the distances between songs for danceability
hc <- hclust(distance_matrix, method = "complete") #Clustering algorithm using distance_matrix to group the songs together

dendro<-as.dendrogram(hc)

plot(dendro, main = "Dendrogram of Top Songs by Danceability",
     xlab = "Songs", ylab = "Distance", sub = "Complete Linkage")


