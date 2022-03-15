##################################
# Bio 381, HW 8: Simulating Data #
# 14 Mar 2022                    #
# E.M. Beasley                   #
##################################

# Why sim data?
# Saves time- write parts of your code before you have data
# Baseline for comparisons: check assumptions in your data
# Test new stats techniques (this is less common)

# Part 1: Normally distributed data ---------------------
# Start with groups of normally distributed data
# For t-tests or ANOVA

# simulate groups of 20 observations
group1 <- rnorm(n = 20, mean = 2, sd = 1)
hist(group1) # look at distribution

# change up some parameters
group2 <- rnorm(n = 20, mean = 5, sd = 1)
group3 <- rnorm(n = 20, mean = 2, sd = 3)

hist(group2)
hist(group3)

# You will work more with grouped data on the homework

# Data sim for simple linear regression
# Assume slope of 0, so y = beta1*x
# where beta1 is your slope
# and x is your environmental covariate

# slope will be constant:
beta1 <- 1
# sim the covariate:
x <- rnorm(n = 20)

# now use the above to create a response variable:
y <- beta1*x
hist(y) 

# you can add complexity by adding intercepts or more covariates:
beta0 <- rgamma(n = 20, shape = 1, rate = 1) #not limited to normal!

# add intercept beta0
y2 <- beta0 + beta1*x
hist(y2)

# You can also play with different slopes
# or different distributions for the itercept/covariates

# Part 2: Abundance/count data ----------------------
# Option 1: data are normal-ish
# use round() to get whole numbers
abund1 <- round(rnorm(n = 20, mean = 50, sd = 10))
hist(abund1)
# this only works if sd is sufficiently large 
# and rnorm unlikely to get negative numbers

# A better way: use Poisson distribution
# Simulate counts from the same distribution
# where lambda = typical abundance
abund2 <- rpois(n = 20, lambda = 3)
barplot(table(abund2))

# Sometimes the environment affects abundance/counts
# When that happens, first generate lambdas
# then use those to get abundances

# use regression to get initial values
pre.lambda <- beta0+beta1*x
# use inverse log to make lambdas positive
lambda <- exp(pre.lambda)

# use these lambda values to get abundances/counts:
abund3 <- rpois(n = 20, lambda = lambda)
hist(abund3)

# Part 3: Occupancy/presence-absence data ---------------------
# Option 1: getting probabilities from a beta distribution
probs <- rbeta(n = 20, shape1 = 1, shape2 = 1)
occ1 <- rbinom(n = 20, size = 1, prob = probs)
print(occ1)

# Occupancy depends on environment too
# We can do something similar to above
# Except we're calculating probabilities, not lambdas

pre.probs <- beta0 + beta1*x
psi <- inv.logit(pre.probs) # inverse logit to put on 0-1 scale
hist(psi) # good distribution of probs

# use rbinom again to get occupancy data
occ2 <- rbinom(n = 20, size = 1, prob = psi)
print(occ2)
