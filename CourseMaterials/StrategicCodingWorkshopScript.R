# Goiania Coding Workshop
# Strategic coding tools
# 3 June 2025 
# NJG

# load libraries ----
library(pracma)
library(pryr)
library(devtools)
install_github("ngotelli/upscaler")
help(package="upscaler")
library(upscaler)
# 1 Code Folding
## subheader A ----

## subheader B----

# 2 Code Snippets
# demonstrating snippets
# NJG
# 20 March 2025
#

# Script description
# 2025-03-20
# Nicholas J. Gotelli

# 3 Organize Project
add_folder()
add_folder(c("specialfolder1","specialfolder2"))

# 3.1 Original Data
# 3.11 Embed your metadata in Your datafile
metadata_template(file="OriginalData/MyData.csv")
# real-world example. Ash-Ellis amphibian research

# 3.2 CleanedData
  # copy everything from Original Data folder and only do editing here
  # “dirty” data cannot be opened or read
  # not all data cleaning can be easily documented
  # additional cleaning and wrangling after texts are created


# 3.3 Scripts
# 
# contains standard R scripts
# may contain only a single MainScript.R with global variables and function calls
# 
# 3.4 Functions

# contains scripts for user-defined functions
# these functions may be contained in a single script
# more portability and ease of programming to create a single script for each function

# 3.5 Plots

  # contains .jpg, .tiff, other image files created with code
  # do not save images by using RStudio GUI interface
  # learn to use ggsave() command in ggplot2 for saving graphical output
  # use letters, not numbers, to name consecutive images or tables
  # figure_a, figure_b, table_a, table_b
  # these will be later converted to numbered tables and figures in your final manuscript

# 3.6 Outputs
  # should be used only to create and store summary .csv files that contain contents of final tables or stats numbers to be used in manuscript
  # do not use .csv files to “pass data” to other parts of project
  # first set up output as a data frame before passing to function

# 3.6.1 Store summary results in table: data_table_template()
data_table_template(data_frame=NULL,file_name="Outputs/TableA.csv")

# 3.6.2 Pad zeroes in file names or variable names: create_padded_labels()
create_padded_labels(n=10,string="Species",suffix=".txt")

# 3.7 DataObjects
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


# 3.8 Markdown
  # Use this folder to store .Rmd markdown scripts, local image files they may call, and markdown outputs (.html, .pdf files)

# 4 Use Logging System

  # Creates a logfile.txt plain text file in project root
  # Store meta-data about your system
  # Organize and decorate output
  # Use consecutive logs to probe errors


# 4.1 Create Log File
set_up_log()
# set_up_log(my_logfile='logfile.txt',
#            user_seed=NULL,
#            console_echo=FALSE,
#            overwrite_log=TRUE)
# inspect initial log for system information and seed

# 4.2 Supply user-defined random number seed
set_up_log(user_seed=100)
# inspect log then restore default set-up
set_up_log()




# 4.3 Toggle the log console to echo log messages to screen
echo_log_console(TRUE)

# 4.4. Basic log function l()
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

# 5 Add an ‘old school’ progress bar to your for loop: show_progress(bar)
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

# 5.1 Use the Log Message to Interrogate Objects for Debugging
# pass parameter values to a log message
library(pryr)
set_up_log(overwrite=FALSE)
for (i in 1:100) {
  show_progress_bar()
  l(paste('memory_used=',trunc(mem_used()/10^6),
          " MB;"," i=",i,sep=''))
  z <- runif(n=10^i)
}
set_up_log()
# 6 Coding with User-Defined Functions
# 6.1 A template for user-defined functions:build_function()
build_function("fit_regression") # creates an R script template for the function
source("Functions/FitRegression.R")

# 6.2 Punctuation conventions for names
# snake_case
# camelCase
# PascalCase
# kebab-case
# SCREAMING_SNAKE_CASE

# use snake case for function and object names in r
fit_regression()
# show coding example in fit regression

# 6.3 Anatomy of A User-Defined Function
# 
# function name
# named input parameters
# function body
# function output (optional return() statement)
# 
# 6.4 Features of a Good Function
# 
# Has a verb-based descriptive name
# Has few inputs (< 3)
# Does one thing in isolation
# Is short (no scrolling)
# Returns one thing (could be a list)
# Uses only data from input parameters and/or locally created variables
# Does not use global variables
# Does not (usually) create or change global variables ->>
#   Sets up default values, ideally based on random number generator
# 
# 6.5 Functional Programming
# 
# Step 1: Create Pseudocode: describe project with a list of major steps (<6)
# Select Recipes
# Write Shopping List
# Buy Groceries
# Cook Meal
# Serve Meal
# Clean Up

# Step 2: Each list item becomes a function
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

