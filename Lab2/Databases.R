# ~ Start Lab 2 - Databases ~
# Install required packages
install.packages(c("dbplyr", "RSQLite"))

# Create a directory for data
dir.create("data", showWarnings = FALSE)
# Download SQLite Database
download.file(url = "https://ndownloader.figshare.com/files/2292171", destfile = "data/portal_mammals.sqlite", mode = "wb")

# Use required Databases
library(dplyr)
library(dbplyr)

# Point R to the portal_mammals.sqlite database
mammals <- DBI::dbConnect(RSQLite::SQLite(), "data/portal_mammals.sqlite")

# Get information on the mammals db source
src_dbi(mammals)

# Select year, species_id, and plot_id from the surveys table in the mammals database
tbl(mammals, sql("SELECT year, species_id, plot_id FROM surveys"))

# Store in surveys the surveys table of the mammals database
surveys <- tbl(mammals, "surveys")
# Pipe surverys into a dplyr select statement
surveys %>% select(year, species_id, plot_id)
# Check the first ten rows of the surveys table
head(surveys, n = 10)

# Attempt to check how many rows are in the table
# However, this fails and returns NULL
nrow(tbl)

# Show the SQL command dplyr uses to query the SQLite database
show_query(head(surveys, n = 10))

# Pipe the output of surveys to be filtered where weight is less than five,
# and pipe that result to select the species_id, sex, and weight columns
surveys %>% filter(weight < 5) %>% select(species_id, sex, weight)

# Store in data_subset the surveys column piped to be filtered where weight is less than five,
# and where only the species_id, sex, and weight column are selected
data_subset <- surveys %>% filter(weight < 5) %>% select(species_id, sex, weight)
# Select from the data_subset all columns except sex
data_subset %>% select(-sex)

# Store in data_subset the output of surveys piped to be filtered where weight is less than five,
# and that output piped to select only the species_id, sex, and weight columns,
# and that output piped to the execution of the actual SQL command to be processed
data_subset <- surveys %>% filter(weight < 5) %>% select(species_id, sex, weight) %>% collect()

# Store in plots the plots table from the mammals database
plots <- tbl(mammals, "plots")
# Output plots to standard output
plots

# Output surveys to standard output
surveys

# Pipe output of plots to be filtered where plot_id is equal to one,
# and pipe that output to be inner joined with surveys on plot_id,
# then pipe that SQL command to be executed on the actual SQL database
plots %>% filter(plot_id == 1) %>% inner_join(surveys) %>% collect()

# ~ Challenge One ~
# Store required tables
species <- tbl(mammals, "species")
surveys <- tbl(mammals, "surveys")
# Display data from each table to see what columns are available
species
surveys
# Store in rodents_by_year the output of species piped to be filtered where taxa equals Rodent,
# piped to an inner join with surveys, 
# piped to be grouped by year,
# then run the SQL query on the database
rodents_by_year <- species %>% filter(taxa == "Rodent") %>% inner_join(surveys) %>% group_by(year) %>% collect()
# Summarize the rodents_by_year dataset by the count of each group
summarize(rodents_by_year, count = n())

# ~ Challenge Two ~
# Store required tables
species <- tbl(mammals, "species")
surveys <- tbl(mammals, "surveys")
plots <- tbl(mammals, "plots")
# Display data from each table to see what columns are available
species
surveys
plots
# Store in rodents_by_genus_and_plot the output of species,
# piped to be filtered where taxa is equal to Rodents,
# piped to be joined with surverys,
# piped to be joined with plots,
# piped to be grouped first by genus, then by plot type,
# piped to be executed on the SQL database
rodents_by_genus_and_plot <- species %>% filter(taxa == "Rodent") %>% inner_join(surveys) %>% inner_join(plots) %>% group_by(genus, plot_type) %>% collect()
# Summarize rodents_by_genus_and_plot by the count of each group
summarize(rodents_by_genus_and_plot, count = n())
