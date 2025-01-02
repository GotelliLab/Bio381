#Using Messy Dataset for students


#Read in Burnham Bombus dataset 

#use the messy function at different levels and take a look 

#Decide on what kind of questions we want to use for the HW-how many more questions? What kind of regular expressions would be useful to learn? Maybe look through the homework and see what kinds of questions we should use. 

library(messy)
setwd("~/OneDrive/Documents/CompBio_Datasets")

burnham<-read.csv("Burnham_field_data_bombus_seasonal_variation_Dataset.csv", comment.char="#" )


set.seed(24)
test<-burnham[1:11]
messy_data<-messy(burnham[1:11,], messiness = 0.2)


#So ideally, we'd have them look at the cleaned version so they can look back on it and see what they have to change-then we'd run the messy function, and have them work on using regular expressions to fix/clean up the dataset.

#First messy lab exercise-small dataset that can be opened with a text file and cleaned. 

#Making a custom "messy" function. Let's just choose a few functions to use. 
#add_special_chars
#add_whitespace
#change_case
#make_missing(choose a specific column to have NA's so they can still figure out what to do with it)

test<-test%>%
  make_missing(cols="pathogen_binary", messiness=0.4)%>%
  add_special_chars(cols=c("bombus_spp", "host_plant"))%>%
  add_whitespace(cols="bee_caste", messiness=0.5)


messy<-test[1:20,] 

write_excel_csv(messy, file = "Messy_Burnham")

