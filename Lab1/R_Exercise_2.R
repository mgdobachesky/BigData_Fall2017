# ~ Installing Required Packages ~
# dplyr is a powerful package for managing and transforming datasets
# dplyr commands: filter, select, arrange, mutate, and summarize
install.packages("dplyr")
# ggplot2 is a comprehensive package used to visualize data
install.packages("ggplot2")
# Use the required packages
library("dplyr")
library("ggplot2")

# ~ Basic Query and Aggregate Functions ~
# Put a dataframe into the data varible with rows name and value
data <- data.frame(name = c("Alan", "Joe", "Tina", "Alan", "Suzan"), value = 1:5)
# Get records from data where name is filtered to equal Alan
filter(data, name == "Alan")
# Get all data values in name vector
select(data, name)
# Get all data values excluding name vector
select(data, -name)
# Get all data values sorted by name ascending
arrange(data, name)
# Get all data values sorted by name descending
arrange(data, desc(value))
# Get all data with an additional computed vector defined as double
mutate(data, double = 2 * value)
# Get all data with additional computed vectors defined as double and quadruple
mutate(data, double = 2 * value, quadruple = 2 * double)
# Get the total of all values in value vector defined as total
summarise(data, total=sum(value))
# Load data grouped by name into variable by_name
by_name <- group_by(data, name)
# Get the total of all groupings of values in value vectors defined as total
summarise(by_name, total=sum(value))

# ~ Working with Flat File Data ~
# Define df.engineSpecs as the values in the Aircraft_EnginesSpecs.csv file 
df.engineSpecs <- read.csv("Aircraft_EnginesSpecs.csv", header = TRUE, sep = ";")
# Explore the data in df.engineSpecs
head(df.engineSpecs)
# Define df.PassengerFeaturesSpecs as the values in the Aircraft_PassengerFeaturesSpecs.csv file 
df.PassengerFeaturesSpecs <- read.csv("Aircraft_PassengerFeaturesSpecs.csv", header = TRUE, sep = ";")
# Explore the data in df.PassengerFeaturesSpecs
head(df.PassengerFeaturesSpecs)
# Define df.SpeedAndAltitudeSpecs as the values in the Aircraft_SpeedAndAltitudeSpecs.csv file 
df.SpeedAndAltitudeSpecs <- read.csv("Aircraft_SpeedAndAltitudeSpecs.csv", header = TRUE, sep = ";")
# Explore the data in df.SpeedAndAltitudeSpecs
head(df.SpeedAndAltitudeSpecs)
# Define df.WeightAndFuelSpecs as the values in the Aircraft_WeightAndFuelSpecs.csv file 
df.WeightAndFuelSpecs <- read.csv("Aircraft_WeightAndFuelSpecs.csv", header = TRUE, sep = ";")
# Explore the data in df.WeightAndFuelSpecs
head(df.WeightAndFuelSpecs)

# ~ Examining the Data ~
# Pipe output of df.engineSpecs to a command that filters the dataframe 
# by Manufacturers named "GE"
df.engineSpecs %>% filter(Engine.Manufacturer == "GE")
# Get the column names in the df.engineSpecs dataframe
colnames(df.engineSpecs)
# Pipe output of df.engineSpecs to a command that filters the dataframe 
# by Manufacturers named "GE" who also have two engines
df.engineSpecs %>% filter(Engine.Manufacturer == "GE" & No..of.engines == "2")
# Pipe output of df.engineSpecs to a command that filters the dataframe
# by Engine Manufacturers that are in the vector containing the values of "GE" and "PW"
df.engineSpecs %>% filter(Engine.Manufacturer %in% c( "GE", "PW"))
# Pipe output of df.engineSpecs to a command that filters the dataframe
# by Engine Manufacturers that are not in the vector containing the values of "GE" and "PW"
# and then pipe that output to count how many times those manufacturers show up in the Engine.Manufacturer vector
df.engineSpecs %>% filter(!Engine.Manufacturer %in% c("GE", "PW")) %>% count(Engine.Manufacturer)

# ~ Examining the Data (Data Scientist Way) ~
# Filter df.engineSpecs dataframe where Engine.Manufacturer 
# is "GE" and No..of.engines is "2"
filter(df.engineSpecs, Engine.Manufacturer == "GE" & No..of.engines == "2")
# Filter df.engineSpecs dataframe where Engine.Manufacturer 
# is not in the vector containing the values of "GE" and "PW"
# and store the result in the variable df
df <- filter(df.engineSpecs, !Engine.Manufacturer == c("GE", "PW"))
# Group records by Engine.Manufacturer and then 
# summarize them by the count of each group
summarize(group_by(df, Engine.Manufacturer), count = n())

# ~ Identify Duplicate Data ~
# Group df.engineSpecs by Aircraft.model 
# and then summarize by the count of each group
# and store the results in the variable engineSpecs.summ
engineSpecs.summ <- summarize(group_by(df.engineSpecs, Aircraft.Model), count = n())
# Filter the engineSpecs.summ dataframe where count is not equal to one
filter(engineSpecs.summ, count != 1)
# Group df.engineSpecs by Aircraft.model 
# and then summarize by the count of each group
# and store the results in the variable PassengerFeaturesSpecs.summ
PassengerFeaturesSpecs.summ <- summarize(group_by(df.engineSpecs, Aircraft.Model), count = n())
# Filter PassengerFeaturesSpecs.summ dataframe where cound is not equal to 1
filter(PassengerFeaturesSpecs.summ, count != 1)
# Pipe the output of df.SpeedAndAltitudeSpecs
# to be grouped by Aircraft.Model
# then pipe the output of that to be summarized by the count of each group
# and pipe the output to be filtered where the count is not one
df.SpeedAndAltitudeSpecs %>% group_by(Aircraft.Model) %>% summarise(count=n()) %>% filter(count != 1)
# Pipe the output of df.WeightAndFuelSpecs
# to be grouped by Aircraft.Model
# then pipe the output of that to be summarized by the count of each group
# and pipe the output to be filtered where the count is not one
df.WeightAndFuelSpecs %>% group_by(Aircraft.Model) %>% summarise(count=n()) %>% filter(count!=1)

# ~ Removing Duplicate Data ~
# Store in the df.engineSpecs dataframe only uniue Aircraft.Model rows
df.engineSpecs <- distinct(df.engineSpecs, Aircraft.Model)
# Store in the df.PassengerFeaturesSpecs dataframe only uniue Aircraft.Model rows
df.PassengerFeaturesSpecs <- distinct(df.PassengerFeaturesSpecs, Aircraft.Model)
# Store in the df.SpeedAndAltitudeSpecs dataframe only uniue Aircraft.Model rows
df.SpeedAndAltitudeSpecs <- distinct(df.SpeedAndAltitudeSpecs, Aircraft.Model)
# Store in the df.WeightAndFuelSpecs dataframe only uniue Aircraft.Model rows
df.WeightAndFuelSpecs <- distinct(df.WeightAndFuelSpecs, Aircraft.Model)

# ~ Dealing with N/A ~
# Install and use hflights package
install.packages("hflights")
library(hflights)
# Store hflights table dataframe in hflights_df variable
hflights_df <- tbl_df(hflights)
# Return classes of hflights_df
class(hflights_df)
# Pipe hflights_df to be grouped first by UniqueCarrier and then by FlightNum
# then pipe that output to be filtered where Dest vector is not available
hflights_df %>% group_by(UniqueCarrier, FlightNum) %>% filter(is.na(Dest))

# ~ Grouping by Multiple Variables ~
# Group hflights_df by first by Year, then Month, then DayofMonth
# and store in daily variable
daily <- group_by(hflights_df, Year, Month, DayofMonth)
# To get the number of flights per day
per_day = summarize(daily, number_flights = n())
# Group per_day by Year then Month
# and pipe that to be summarized by the summarized with the sum of the number of flights per day
group_by(per_day, Year, Month) %>% summarize(number_flights = sum(number_flights))

# ~ Aggregate Functions ~
# Employ with summarize on grouped data
# mean()
# max()
# n()
# distinct()
# first()
# last()
# nth()

# ~ Chaining ~
# Group hflights by Year, then Month, then DayofMonth
# and store in a1 variable
a1 <- group_by(hflights, Year, Month, DayofMonth)
# Select the vectors from a1 from Year to DayofMonth, ArrDelay, and DepDelay
a2 <- select(a1, Year:DayofMonth, ArrDelay, DepDelay) 
# Summarize a2 where arr is the mean of ArrDelay without N/A fields
# and dep is the mean of DepDelay without N/A fields
a3 <- summarise(a2, arr = mean(ArrDelay, na.rm = TRUE), dep = mean(DepDelay, na.rm = TRUE)) 
# Filter a3 where either arr or dep is greater than 30
# and store the results in a4
a4 <- filter(a3, arr > 30 | dep > 30) 