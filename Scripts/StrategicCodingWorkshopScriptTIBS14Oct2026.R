# Strategic Coding Workshop
# The International Biogeography Society
# Strategic coding tools
# 14 15 October 2026
# Nick Gotelli
# Department of Biology | University of Vermont
# Burlington VT 05405 | USA
# ngotelli@uvm.edu
# https://www.uvm.edu/~ngotelli/homepage.html

# 1 Introduction
#   My background
#   Goals of workshop
#     Modular coding for open-ended projects
#     Reproducible research
#   Powerpoint Presentation

# 2 RStudio Set-Up
# create new project StrategicCodingTIBS
# go to Tools -> Global Options
# set panels, cobalt screen, font size

# 3 Preliminaries 

# first...
# install libraries ----
install.packages("pracma")
install.packages("lobstr")
install.packages("devtools")
install.packages("pak")

# load libraries ----
library(pracma)
library(lobstr)
library(devtools)
library(pak)
pak("ngotelli/upscaler")
help(package="upscaler")
library(upscaler)

# set up a new project on desktop StrategicCodingTIBS
# use menu prompts
# insert this script at root of project
# open the new project

# 1 Four keyboard shortcuts to use inside of a script
#   <Control><c> toggle and untoggle commented code
#   <Control><Return> execute a single line of code in script
#   <Control><Shift><Return> execute script as if from console 
#      equivalent to: source(<filename>,echo=TRUE)
#   <Control><Shift><s> execute script without console echo
#      equivalent to: source(<filename>)

# 2 Code Folding
## subheader A ----
# x <- 3 + 5
# y = pi

## subheader B----

# 3 Code Snippets
# demonstrating snippets
# NJG
# 20 March 2025
# go to tools -> edit code snippets
# be sure to use tab for indentation to build snippet
# use back ticks to fence R code that will be executed `r <code>`

# build snippet m.first_snippet
# open a new script an try it out

# 3 Organize Project
add_folder()
add_folder(c("specialfolder1","specialfolder2"))
# safety features for over-writing and use with github

# 4.1 Original Data
# 4.11 Embed your metadata in Your datafile
metadata_template(file="OriginalData/MyData.csv")
# real-world example. Ash-Ellis amphibian research

# 4.2 CleanedData
  # copy everything from Original Data folder and only do editing here
  # “dirty” data cannot be opened or read
  # not all data cleaning can be easily documented
  # additional cleaning and wrangling after texts are created


# 4.3 Scripts
# 
# contains standard R scripts
# suggest creating a single MainScript.R with global variables and function calls for cascading command of all pieces in a project
# keep MainScript.R in the root of the project
# all additional scripts should be placed in the script folder
# 
# 4.4 Functions

# contains scripts for user-defined functions
# these functions may be contained in a single script
# more portability and ease of programming to create a single script for each function

# 4.5 Plots

  # contains .jpg, .tiff, other image files created with code
  # do not save images by using RStudio GUI interface
  # learn to use ggsave() command in ggplot2 for saving graphical output
  # use letters, not numbers, to name consecutive images or tables
  # figure_a, figure_b, table_a, table_b
  # these will be later converted to numbered tables and figures in your final manuscript

# 4.6 Outputs
  # should be used only to create and store summary .csv files that contain contents of final tables or stats numbers to be used in manuscript
  # do not use .csv files to “pass data” to other parts of project
  # first set up output as a data frame before passing to function

# 4.6.1 Store summary results in table: data_table_template()
data_table_template(data_frame=NULL,file_name="Outputs/TableA.csv")

# 4.6.2 Pad zeroes in file names or variable names: create_padded_labels()
create_padded_labels(n=10,string="Species",suffix=".txt")

# 4.7 DataObjects
  # Folder to hold a serialized data object
  # Use to store intermediate results that may be difficult or time-consuming to repeat
  # Do not use .csv files for this purpose
  # Do not use save() or load() for this purpose

x <- runif(10) # an object to save
saveRDS(object=x,
        file="DataObjects/x.rds") # save to disk
restored_x <- readRDS(file="DataObjects/x.rds") # reopen to new name

y <- rnorm(3)
z <- pi
bundle <- list(x=x,y=y,z=z) # save multiple objects in a single list
saveRDS(object=bundle,
        file="DataObjects/bundle.rds") 
restored_bundle <- readRDS(file="DataObjects/bundle.rds")
restored_bundle$y # reference named list items
restored_bundle[[3]] # reference content of item number in a list


# 4.8 Markdown
  # Use this folder to store .Rmd markdown scripts, local image files they may call, and markdown outputs (.html, .pdf files)

# 5 Use Logging System

  # Creates a logfile.txt plain text file in project root
  # Store meta-data about your system
  # Organize and decorate output
  # Use consecutive logs to probe errors


# 5.1 Create Log File
set_up_log()
# set_up_log(my_logfile='logfile.txt',
#            user_seed=NULL,
#            console_echo=FALSE,
#            overwrite_log=TRUE)
# inspect initial log for system information and seed

# 5.2 Supply user-defined random number seed
set_up_log(user_seed=100)
# inspect log then restore default set-up
set_up_log()




# 5.3 Toggle the log console to echo log messages to screen
echo_log_console(TRUE)

# 5.4 Basic log function l()
l() # plain log entry
l('log message that is echoed to the screen')
echo_log_console(FALSE)
l('this message only shows in the log file')
l() # now inspect log contents


set_up_log(overwrite_log=FALSE)
l()
# show file list of logs 6 digit prefix with day-minute-second
l('add a text message for this run')
set_up_log(overwrite_log=FALSE)
set_up_log()
# reset to overwrite logs in default state

# 6 Add an ‘old school’ progress bar to your for loop: show_progress(bar)
for (k in 1:100) {
  show_progress_bar(k)
  Sys.sleep(0.075)
}
l('end of loop')

# Note that the progress bar also pinpoints errors
for (k in 1:100) {
  show_progress_bar(k)
  Sys.sleep(0.075)
   if(k==52)print(ghost) # this throws an error!
}
l('end of loop with error')

# Adjust parameters of progress bar for longer loops
for (k in 1:1000) {
  show_progress_bar(index=k,counter=50,dot=5)
  Sys.sleep(0.0075)
}
l('end of long loop')

# Add a timer for long loops (from pracma package)
tic()
for (k in 1:10) {
  show_progress_bar(k)
  Sys.sleep(1)
}
toc()
l('end of timed loop')

# 6.1 Use the Log Message to Interrogate Objects for Debugging
# pass parameter values to a log message
library(lobstr)
set_up_log(overwrite=FALSE)
for (i in 1:100) {
  show_progress_bar()
  l(paste('memory_used=',trunc(mem_used()/10^6),
          " MB;"," i=",i,sep=''))
  z <- runif(n=10^i)
}
set_up_log()
# 6 Coding with User-Defined Functions
# 7.1 A template for user-defined functions:build_function()
build_function("fit_regression") # creates an R script template for the function
source("Functions/FitRegression.R")

# 7.2 Punctuation conventions for names
# snake_case
# camelCase
# PascalCase
# kebab-case
# SCREAMING_SNAKE_CASE

# use snake case for function and object names in r
fit_regression()
# 7.3 show coding example in fit regression

# my_model <- summary(lm(y~x))
# slope <- my_model$coefficients[2,1]
# slope_p <- my_model$coefficients[2,4]
# int <- my_model$coefficients[1,1]
# int_p <- my_model$coefficients[1,4]
# output <- list(slope=slope,slope_p=slope_p,int=int,int_p=int_p)
# return(output)

# to make later updates to the output
# resids <- my_model$residuals
# output <- list(slope=slope,slope_p=slope_p,int=int,int_p=int_p,resids=resids)
#
# 7.4 iterative workflow with upscaler function scripts
# unmask final line to call function: function_name()
# modify code in body of function
# use <Control><Shift><S> to save script, compile function, AND
# run the function in a single operation(!)
# once function is working, disable the final line so that the function is 
# compiled, but not run until it is called somewhere else in the code
# 7.5 Anatomy of A User-Defined Function
# 
# function name
# named input parameters
# function body
# function output (optional return() statement)
# 
# 7.6 Features of a Good Function
# 
# Has a verb-based descriptive name
# Has few inputs (< 3)
# Does one thing in isolation
# Is short (little or no scrolling)
# Returns one thing (should be a list)
# Uses only data from input parameters and/or locally created variables
# Should not directly use global variables
# Should not create or change global variables <<-
#   Sets up default values, ideally based on random number generator
#   so that the function can be run and tested in isolation from rest of code

# 8 Functional Programming
# 
# Step 1: Create Pseudocode: describe project with a list of major steps (<6)
# Select Recipes
# Write Shopping List
# Buy Groceries
# Cook Meal
# Serve Meal
# Clean Up

# Step 2: Each list item becomes a function (use snake_case)
# select_recipes()
# write_shopping_list()
# cook_meal()
# serve_meal()
# clean_up()

# Step 3: Create function templates as a batch operation
build_function(c("select_recipes",
                 "write_shopping_list",
                 "buy_groceries",
                 "cook_meal",
                 "serve_meal",
                 "clean_up"))
build_function("serve_cocktails") # add any others

# Step 4: Source all function templates as a batch operation
source_batch("Functions")

# Step 5: Run each function template
select_recipes()
write_shopping_list()
buy_groceries()
cook_meal()
serve_meal()
clean_up()

# Step 6: Create inputs and outputs for each function
# Step 7: Code and test functions separately
# Step 8: Link functions through shared inputs and outputs
# Step 9: In main program call functions, create outputs, pass inputs

