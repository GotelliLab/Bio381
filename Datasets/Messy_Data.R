#Messy Dataset for Regular Expression Homework

#Read in Burnham Bombus dataset 

library(messy)
library(tidyverse)
setwd("~/R/Bio381/Datasets")
burnham<-read.csv("Burnham_field_data_bombus_seasonal_variation_Dataset.csv", comment.char="#" )

set.seed(24)
#So ideally, we'd have them look at the cleaned version so they can look back on it and see what they have to change-then we'd run the messy function, and have them work on using regular expressions to fix/clean up the dataset.

#First messy lab exercise-small dataset that can be opened with a text file and cleaned. 

#Making a custom "messy" function. Let's just choose a few functions to use. 
#add_special_chars
#add_whitespace
#change_case
#make_missing(choose a specific column to have NA's so they can still figure out what to do with it)

test<-test%>%
  make_missing(cols="pathogen_binary", messiness=0.4)%>%
  add_special_chars(cols=c("bombus_spp", "host_plant", "site_code"))%>%
  add_whitespace(cols=c("bee_caste", "target_name"), messiness=0.5)

messy<-test[1:20,] 

write_excel_csv(messy, file = "Messy_Burnham_Dataset.csv")


#They're reading it using a text editor (Notepad ++, BBEdit, etc), so we just need to make a note of what errors do exist in it for them to look out for. 
# 1. Missing Values in "pathogen_binary"-if the "pathogen_load" column has a value > 0, then "pathogen_binary" is 1, otherwise, 0. Honestly this may not even be a regular expression statement, but easier if you were to use an ifelse statement. 
messy$pathogen_binary<-ifelse(messy$pathogen_load>0, 1, 0)

# 2. Special Characters existing in "bombus_spp" and "host_plant". Regular Expression solve: Either find/replace every special character (!, %, &,, etc), or do a negative match of all of the letters/numbers ("[^\\w\\s]") 

# 3. Additional whitespaces in "bee_caste". \s  

