# Use the required packages
library("dplyr")
library("ggplot2")

# ~ Loading Required Data ~
# Define df.engineSpecs as the values in the Aircraft_EnginesSpecs.csv file 
df.engineSpecs <- read.csv("Aircraft_EnginesSpecs.csv", header = TRUE, sep = ";")
# Define df.PassengerFeaturesSpecs as the values in the Aircraft_PassengerFeaturesSpecs.csv file 
df.PassengerFeaturesSpecs <- read.csv("Aircraft_PassengerFeaturesSpecs.csv", header = TRUE, sep = ";")
# Define df.SpeedAndAltitudeSpecs as the values in the Aircraft_SpeedAndAltitudeSpecs.csv file 
df.SpeedAndAltitudeSpecs <- read.csv("Aircraft_SpeedAndAltitudeSpecs.csv", header = TRUE, sep = ";")
# Define df.WeightAndFuelSpecs as the values in the Aircraft_WeightAndFuelSpecs.csv file 
df.WeightAndFuelSpecs <- read.csv("Aircraft_WeightAndFuelSpecs.csv", header = TRUE, sep = ";")

# ~ Start Lab 2 ~
# Join df.engineSpecs with df.PassengerFeaturesSpecs on the column Aircraft.Model
df.aircraft_specs <- left_join(df.engineSpecs, df.PassengerFeaturesSpecs, by="Aircraft.Model")  
# Summarise count of the newly joined table
summarise(df.aircraft_specs, count=n())
# Join df.aircraft_specs with df.SpeedAndAltitudeSpecs on the column Aircraft.Model
df.aircraft_specs <- left_join(df.aircraft_specs, df.SpeedAndAltitudeSpecs, by="Aircraft.Model")
# Summarise count of the newly joined table
summarise(df.aircraft_specs, count=n())
# Join df.aircraft_specs with df.WeightAndFuelSpecs on the column Aircraft.Model
df.aircraft_specs <- left_join(df.aircraft_specs, df.WeightAndFuelSpecs, by="Aircraft.Model") 
# Summarise count of the newly joined table
summarise(df.aircraft_specs, count=n())

# Using sub()
x <- "r tutorial"
sub("r ","HTML ", x)
# Regular expression substitution
sub("t.*r","BBBBB", x) 
# Not regular expression
sub("t.*r","BBBBB", x, fixed=TRUE) 
# Sub can be used for vector replacement. Following example replaces one digit of all elements in the vector:
x <- c("line 435", "good weather", "89 pigs")
y <- sub("[[:digit:]]","",x)
#Replace all digits of the vector elements:
x <- c("line 435", "good weather", "89 pigs") 
y <- sub("[[:digit:]]+","",x)

# Create year column in df.aircraft_specs using the [year] part of the Aircraft.Model column
df.aircraft_specs <- mutate(df.aircraft_specs, year=sub(".*\\[([0-9]{4})\\]","\\1", Aircraft.Model))

# Use the year column to find out what decade the aircraft is from,
# and then make a new column based on that decade
df.aircraft_specs <- mutate(df.aircraft_specs, decade = as.factor(
  ifelse(substring(df.aircraft_specs$year,1,3)=='193','1930s',
    ifelse(substring(df.aircraft_specs$year,1,3)=='194','1940s',
      ifelse(substring(df.aircraft_specs$year,1,3)=='195','1950s',
        ifelse(substring(df.aircraft_specs$year,1,3)=='196','1960s',
          ifelse(substring(df.aircraft_specs$year,1,3)=='197','1970s',
            ifelse(substring(df.aircraft_specs$year,1,3)=='198','1980s',
              ifelse(substring(df.aircraft_specs$year,1,3)=='199','1990s',
                ifelse(substring(df.aircraft_specs$year,1,3)=='200','2000s',
                  ifelse(substring(df.aircraft_specs$year,1,3)=='201','2010s',"ERROR"
                  )))))))))
  )
)

# Get the count of each group of aircraft_specs by decade, and summarize the results 
summarize(group_by(df.aircraft_specs,decade), count = n())

# Select decade and model from aircraft_specs,
# and filter the results to only include those from the decade "1950s"
filter(select(df.aircraft_specs, decade, Aircraft.Model), decade=="1950s")

# ~ Create a ggplot ~
# Filter aircraft_specs where max_takeoff_weight does not equal 0, 
# and static_thrus does not equal 0,
# then pipe it to ggplot
filter(df.aircraft_specs,Max..take.off.weight.kg!=0,Static.thrust..kN.!=0) %>%
# Create a ggplot with x of max_takeoff_weight divided by 1,000,
# and y of static_thrust
ggplot( aes(x=Max..take.off.weight.kg/1000, y=as.numeric(as.character(Static.thrust..kN.)))) +
# Customize and display the points of the ggplot
geom_point(alpha=.4, size=4, color="#112277") +
# Set the title of the ggplot
ggtitle("Thrust vs. weight") +
# Label the axis of the ggplot
labs(x="Max Takeoff weight kg*1000", y="Static Thrust")

# ~ Create a ggplot #2 ~
# Filter aircraft_specs where max_takeoff_weight does not equal 0, 
# and static_thrus does not equal 0,
# then pipe it to ggplot
filter(df.aircraft_specs,Max..take.off.weight.kg!=0,Static.thrust..kN.!=0,No..of.engines!=0) %>%
# Create a ggplot with x of max_takeoff_weight divided by 1,000,
# and y of static_thrust multiplied by the number of engines
ggplot( aes(x=Max..take.off.weight.kg/1000, y=Static.thrust..kN.*No..of.engines)) +
# Customize and display the points of the ggplot
geom_point(alpha=.4, size=4, color="#112277") +
# Set the title of the ggplot
ggtitle("Thrust vs. weight and number of engines") +
# Label the axis of the ggplot
labs(x="Max Takeoff weight kg*1000", y="Static Thrust")

# Filter aircraft_specs where max speed is not 0,
# and static thrust is not 0,
# then pipe the results to ggplot
filter(df.aircraft_specs,Max.Speed..kt.!=0,Static.thrust..kN.!=0) %>%
# Create a ggplot with x as static_thrust multiplied by number_of_engines,
# and with y as max_speed
ggplot( aes(x=Static.thrust..kN.*No..of.engines, y=Max.Speed..kt.)) +
# Customize and display the points of the ggplot
geom_point(alpha=.4, size=4, color="#112277") +
# Set the title of the ggplot
ggtitle("Thrust vs. speed") +
# Label the axis of the ggplot
labs(x="Static Thrust kN", y="Max speed kt")

# Filter aircraft_specs where static thrust is not 0,
# and number_of_engines is not 0,
# then pipe the results to ggplot
filter(df.aircraft_specs,Static.thrust..kN.!=0,No..of.engines!=0) %>%
# Create a ggplot with x as static_thrust multiplied by number_of_engines
ggplot(aes(x=Static.thrust..kN.*No..of.engines)) +
# Display the ggplot histogram with specific widths and colors
geom_histogram(binwidth = 30,fill="#112277") +
# Set the title of the ggplot
ggtitle("Total thrust by decade") +
# Label the axis of the ggplot
labs(x="Thrust, kN", y="Count of Records") +
# Display one histogram for each decade
facet_wrap(~decade)

# Filter aircraft_specs where max_speed is not 0,
# and static_thrust is not 0,
# then pipe the results to ggplot
filter(df.aircraft_specs,Max.Speed..kt.!=0,Static.thrust..kN.!=0) %>%
# Create a ggplot with x as max_speed,
# and with y as static_thrust multiplied by the number of engines
ggplot(aes(x=Max.Speed..kt., y=Static.thrust..kN.*No..of.engines)) +
# Customize and display the points of the ggplot
geom_point(alpha=.9,color="#112277") +
# Display one histogram for each decade
facet_wrap(~decade) +
# Set the title of the ggplot
ggtitle("Speed vs thrust by decade") +
# Label the axis of the ggplot
labs(x="Speed, kt", y="Thrust, kN")

# Filter aircraft_specs where max_speed is not 0,
# and static_thrust is not 0,
# and max_speed is less than 700
# then pipe the results to ggplot
filter(df.aircraft_specs,Max.Speed..kt.!=0,Static.thrust..kN.!=0,Max.Speed..kt. < 700) %>%
# Create a ggplot with x as max_speed,
# and with y as static_thrust multiplied by the number of engines
ggplot(aes(x=Max.Speed..kt., y=Static.thrust..kN.*No..of.engines)) +
# Customize and display the points of the ggplot
geom_point(alpha=.9,color="#112277") +
# Display one histogram for each decade
facet_wrap(~decade) +
# Set the title of the ggplot
ggtitle("Speed vs thrust by decade") +
# Label the axis of the ggplot
labs(x="Speed, kt", y="Thrust, kN")

# ~ Working with Databases ~
# Create an sqlite3 database in my_db
my_db <- src_sqlite("my_db.sqlite3", create = T)

# Copy to my_db the hflights data with indexes,
# and store it in hflights_sqlite
hflights_sqlite <- copy_to(my_db, hflights, temporary = FALSE,  indexes = list(c("Year", "Month", "DayofMonth"), "UniqueCarrier", "TailNum"))
# Display classes of the hflights_sqlite database
class(hflights_sqlite)
# Display the database data
hflights_sqlite

# Filter hflights_sqlite where DepDelay is greater than 0
c1 <- filter(hflights_sqlite, DepDelay > 0)
# Select from c1 the listed columns
c2 <- select(c1, Year, Month, DayofMonth, UniqueCarrier, DepDelay, AirTime, Distance)
# Add a column from the c2 dataset called speed, composed of distance divided by airtime multiplied by 60
c3 <- mutate(c2, Speed = Distance/AirTime * 60)
# Sort the listed columns and store in c4
c4 <- arrange(c3, Year, Month, DayofMonth, UniqueCarrier)

# List the classes of the c4 dataset
class(c4)
# List the names of the c4 dataset
names(c4)
# Display information on the src attribute of the c4 dataset
c4$src
# Display information on the query attribute of the c4 dataset
c4$query

# Complete call to database and download all rows, stored in subtbl
subtbl <- collect(c4)
# List the classes of subtbl
class(subtbl)