# ~ Obtain and attach data set cats ~
# Use library MASS
library(MASS)
# Get cats data
data(cats)
# Attach cats data
attach(cats)
# Display cats
cats
# Get information on cats
?cats

# ~ Plot cats Data ~
# Get plot on cats data
plot(Hwt~Bwt)
# Draw a average line through the plot
abline(lm(Hwt~Bwt))

# ~ Boxplot cats Data ~
# Create box plot on cats
boxplot(Hwt~Sex, xlab='Gender', ylab='Heart weight')
# Same box plot, but horizontal
boxplot(Hwt~Sex, xlab='Gender', ylab='Heart weight', horizontal=T)

# ~ Plot cats data with customization ~
# Plot cats with labels and without data
plot(Hwt~Bwt, xlab='Body weight (kg)', ylab='Heart weight (g)', type='n')
# Customize and add male points
points(Hwt[Sex=='M']~Bwt[Sex=='M'], col = "blue")
# Customize and add female points
points(Hwt[Sex=='F']~Bwt[Sex=='F'], col = "red", pch=3)

# ~ Visualizing curves ~
# Create a sin wave
curve(sin(x),from =0, to =2*pi)
# Create a more complex curve
curve(2*x^3+x^2-2*x+10,from =-2, to =2)
# Create another curve with color
curve(log(x),from =0, to =10,col="magenta")
# Create a red line
curve(5-x,from =0, to =10,col="red", add=T)

# ~ Obtain and attach cfb library ~
# Install packages
install.packages("UsingR")
install.packages("Hmisc")
install.packages("ggplot2")
install.packages("Rcpp")
# Use packages
library(UsingR)
library(Hmisc)
library(ggplot2)
library(Rcpp)
# Set data to cfb
data(cfb)
# Attach cfb
attach(cfb)

# ~ Visualizing cfb data ~
# Draw histograms for cfb
hist(cfb)
# Draw histogram for income
hist(cfb$INCOME)
# Find mean of income
mean(INCOME)
# Get help on mean command
?mean
# Get mean with 10% trimmed off each end
mean(INCOME, trim = .1)
# Get median of income
median(INCOME)

# ~ Load custom data sets ~
# Load data sets into variables
phoneChargingHours=scan()
tvViewingHours=scan()
milesTravled=scan()

# ~ Get statistics on phoneChargingHours data set ~
mean(phoneChargingHours)
median(phoneChargingHours)
sd(phoneChargingHours)
quantile(phoneChargingHours)
IQR(phoneChargingHours)
summary(phoneChargingHours)

# ~ Get statistics on tvViewingHours data set ~
mean(tvViewingHours)
median(tvViewingHours)
sd(tvViewingHours)
quantile(tvViewingHours)
IQR(tvViewingHours)
summary(tvViewingHours)

# ~ Get statistics on milesTravled data set ~
mean(milesTravled)
median(milesTravled)
sd(milesTravled)
quantile(milesTravled)
IQR(milesTravled)
summary(milesTravled)

# ~ Get boxplots on each data set ~
boxplot(phoneChargingHours)
boxplot(tvViewingHours)
boxplot(milesTravled)

# ~ Get histograms on each data set ~
hist(phoneChargingHours)
hist(tvViewingHours)
hist(milesTravled)

# ~ Get histograms with curve on each data set ~
# Histogram of phoneChargingHours with curve
hist(phoneChargingHours,freq=F)
lines(density(phoneChargingHours))
# Histogram of tvViewingHours with curve
hist(tvViewingHours,freq=F)
lines(density(tvViewingHours))
# Histogram of milesTravled with curve
hist(milesTravled,freq=F)
lines(density(milesTravled))