
#Loading in a TidyDataset from this link: https://github.com/rfordatascience/tidytuesday/blob/main/data/2021/2021-09-14/readme.md
library(tidyverse)
library(lubridate)
library(ggbeeswarm)
library(ggridges)
library(tidytuesdayR)

tuesdata <- tidytuesdayR::tt_load('2021-09-14') #Use tidytuesdayR::tt_load() to find the correct weeks dataset that you want to use

#This dataset has two csv's that we're going to use-Top 100 Billboard Chart songs from 1965-2017, and song features/characteristics of each one
billboard<- tuesdata$billboard 
song_features<-tuesdata$audio_features

#So there are two datasets-one for the actual billboard list from 1965-2017, with weekly data, and then one for the audio features, with descriptions and characteristics of each song that can be joined/tracked. So immediately, one of the first things I notice is that we should probably join the song features to each song


#Beeswarm Plot-typically used to present individual data points without overlap. Used when you want to show the overall distribution of a variable and the individual data points.
#Ex. Plot of "Danceability/Energy/Speechiness", maybe the color is separated by decades?
decades<-billboard%>% #First create a new dataframe called decades
  mutate(Date=mdy(week_id), Year=year(Date))%>% #Using lubridate, we'll convert the week_id class into a date object. We'll also use the year() function to extract year from that subsequent Date column.
  mutate(Decade=round(Year/10)*10)%>% #Using the round function, we can floor the years to each relevant decade 
  left_join(song_features, by="song_id")%>% #Combining the billboard df to the song features dataframe
  filter(!is.na(danceability)) #Then a quick cleaning for any NA's in the metric we're concerned with-let's say danceability for our purposes.


song_features<-song_features%>% #Same thing here, we're going to clean song_features for danceability
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


#Dendrogram-To visualize this and still be readable, let's first filter songs by decades and get songs that have 


decades_dendro<-decades%>% #Creating a new df
  group_by(Decade)%>%  #group by Decade first
  filter(peak_position<2)%>% #Filter the songs for the ones that have had top 3 listings at some point in that decade 
  select(-c(url,week_id, week_position, Date, previous_week_position, weeks_on_chart,Year, peak_position))%>% #Select out the columns that we don't want/need
  distinct()%>%
  ungroup()%>%
  slice(1:10)



distance_matrix <- dist(decades_dendro$danceability)  # Euclidean distance to calculate the distances between songs for danceability
hc <- hclust(distance_matrix, method = "complete") #Clustering algorithm using distance_matrix to group the songs together

dendro<-as.dendrogram(hc)

plot(dendro, main = "Dendrogram of Top Songs by Danceability",
     xlab = "Songs", ylab = "Distance", sub = "Complete Linkage")


