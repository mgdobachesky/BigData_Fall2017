# ~ Preparing data ~
# Load data into bupa.df variable
bupa.df <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/liver-disorders/bupa.data", header=FALSE)
# Change column names of bupa.df
names(bupa.df) <- c("mcv","alkphos","sgpt", "sgot", "gammagt","drinks", "selector")

# ~ Check and get rid of missing values ~
library(dplyr)
bupa.df <- filter(bupa.df, !is.na("mcv"))
bupa.df <- filter(bupa.df, !is.na("alkphos"))
bupa.df <- filter(bupa.df, !is.na("sgpt"))
bupa.df <- filter(bupa.df, !is.na("sgot"))
bupa.df <- filter(bupa.df, !is.na("gammagt"))
bupa.df <- filter(bupa.df, !is.na("drinks"))
bupa.df <- filter(bupa.df, !is.na("selector"))

# ~ Get dataset summary ~
summary(bupa.df)

# ~ Examine plots and histograms ~
# Load and attach data
data(bupa.df)
attach(bupa.df)
# Plots
plot(bupa.df$mcv, main="Mean Corpuscular Volume")
plot(bupa.df$alkphos, main="Alkaline Phosphotase")
plot(bupa.df$sgpt, main="Alamine Aminotransferase")
plot(bupa.df$sgot, main="Aspartate Aminotransferase")
plot(bupa.df$gammagt, main="Gamma-Glutamyl Transpeptidase")
plot(bupa.df$drinks, main="Drinks Per Day")
plot(bupa.df$selector, main="Liver Disease Selector")
# Histograms
hist(bupa.df$mcv, main="Mean Corpuscular Volume")
hist(bupa.df$alkphos, main="Alkaline Phosphotase")
hist(bupa.df$sgpt, main="Alamine Aminotransferase")
hist(bupa.df$sgot, main="Aspartate Aminotransferase")
hist(bupa.df$gammagt, main="Gamma-Glutamyl Transpeptidase")
hist(bupa.df$drinks, main="Drinks Per Day")
hist(bupa.df$selector, main="Liver Disease Selector")

# ~ Sample data to equally represent both groups ~
# Useing required libraries
library(DMwR)
library(dplyr)
library(ggplot2)
library(scales)
library(reshape2)
# Separate data by selector
sample_size = 100;
bupa.liverDisease <- filter(bupa.df, selector == 1)
bupa.noLiverDisease <- filter(bupa.df, selector == 2)
# Sample each dataframe
bupa.liverDiseaseSample <- sample_n(bupa.liverDisease, size = sample_size)
bupa.noLiverDiseaseSample <- sample_n(bupa.noLiverDisease, size = sample_size)

# ~ Draw Histograms & Boxplots ~
# Function to draw histograms
drawHist <- function(liverDisease, noLiverDisease, name) {
  min=determineMin(liverDisease, noLiverDisease)
  max=determineMax(liverDisease, noLiverDisease)
  hist(liverDisease, col=rgb(1,0,0,0.5), breaks=seq(min,max,l=10), xlim=c(min, max), ylim=c(0, sample_size), main=name, xlab=name)
  hist(noLiverDisease, col=rgb(0,0,1,0.5), breaks=seq(min,max,l=10), xlim=c(min, max), ylim=c(0, sample_size), add=T)
  box()
  legend("topright", c("Liver Disease", "No Liver Disease"), fill=c(rgb(1,0,0,0.5), rgb(0,0,1,0.5)))
}
# Function to draw boxplots
drawBoxplot <- function(liverDisease, selector, name) {
  boxplot(liverDisease~selector, ylab=name, xlab='Liver Disease', ylab=name, names = c("Yes", "No"), main=name)
}
# Helper function to determine min value
determineMin <- function(liverDisease, noLiverDisease) {
  if(min(liverDisease) < min(noLiverDisease)) {
    min <- min(liverDisease)
  } else {
    min <- min(noLiverDisease)
  }
  min
}
# Helper function to determine max values
determineMax <- function(liverDisease, noLiverDisease) {
  if(max(liverDisease) > max(noLiverDisease)) {
    max <- max(liverDisease)
  } else {
    max <- max(noLiverDisease)
  }
  max
}

# Group samples for use in boxplots
bupa.groupedSamples <- rbind(bupa.liverDiseaseSample, bupa.noLiverDiseaseSample)

# Mean Corpuscular Volume
drawHist(bupa.liverDiseaseSample$mcv, bupa.noLiverDiseaseSample$mcv, 'Mean Corpuscular Volume')
drawBoxplot(bupa.groupedSamples$mcv, bupa.groupedSamples$selector, 'Mean Corpuscular Volume')
# Alkaline Phosphotase
drawHist(bupa.liverDiseaseSample$alkphos, bupa.noLiverDiseaseSample$alkphos, 'Alkaline Phosphotase')
drawBoxplot(bupa.groupedSamples$alkphos, bupa.groupedSamples$selector, 'Alkaline Phosphotase')
# Alamine Aminotransferase
drawHist(bupa.liverDiseaseSample$sgpt, bupa.noLiverDiseaseSample$sgpt, 'Alamine Aminotransferase')
drawBoxplot(bupa.groupedSamples$sgpt, bupa.groupedSamples$selector, 'Alamine Aminotransferase')
# Aspartate Aminotransferase
drawHist(bupa.liverDiseaseSample$sgot, bupa.noLiverDiseaseSample$sgot, 'Aspartate Aminotransferase')
drawBoxplot(bupa.groupedSamples$sgot, bupa.groupedSamples$selector, 'Aspartate Aminotransferase')
# Gamma-Glutamyl Transpeptidase
drawHist(bupa.liverDiseaseSample$gammagt, bupa.noLiverDiseaseSample$gammagt, 'Gamma-Glutamyl Transpeptidase')
drawBoxplot(bupa.groupedSamples$gammagt, bupa.groupedSamples$selector, 'Gamma-Glutamyl Transpeptidase')
# Drinks Per Day
drawHist(bupa.liverDiseaseSample$drinks, bupa.noLiverDiseaseSample$drinks, 'Drinks Per Day')
drawBoxplot(bupa.groupedSamples$drinks, bupa.groupedSamples$selector, 'Drinks Per Day')
