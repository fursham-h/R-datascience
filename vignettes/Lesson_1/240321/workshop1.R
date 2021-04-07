# CDN-workshop 1: R basics for data analysis

# R as a calculator
1 + 100

1 + 105

3 + 5 * 2
(3 + 5) * 2



# Using mathematical functions
sin(1)

log(1)

?log


# Comparing objects
1 == 1

1 != 2

1 < 0

# Variables and assignment
x <- 1

x <- x/40

y <- x * 2

## Strings/characters can also be assigned to variables
text <- "I love this workshop"

# installing packages
install.packages("dplyr")

# Reading data into R

## The code below ill save the data into your current working directory as a filename "gapminder"
download.file(url = "bit.ly/cdndata", destfile = "gapminder")

## As "gapminder" contain comma-separated-values (CSV), we can use read.csv function to impor this file.
## The more generic function, read.delim, can also be used but requires the `sep` parameter to be set to ","
gapminder <- read.csv("gapminder")
gapminder <- read.delim("gapminder", sep = ",")

## Below is the package and function commonly used to import excel file.
## Type ?read_excel for help on the function
install.packages("readxl")
read_excel()

## Viewing the imported data-frame in a table format
View(gapminder)

## Previewing the first 6 rows (default) of a data-frame
head(gapminder)
head(gapminder, 10)

## preview the structure of dataframes
str(gapminder)

## Print out the dimensions of the data.frame
dim(gapminder)

## Print out the dimensions of the data.frame individually
nrow(gapminder)
ncol(gapminder)

## Print out the column names of a dataframe
names(gapminder)

## Exporting data.frame as a .txt file
write.table(x = gapminder, file = "gapminder.txt", sep = ",")

## Exporting data.frame as a .txt file with proper formatting
write.table(x = gapminder, file = "gapminder.txt", sep = ",", quote = FALSE, row.names = FALSE)


# Part2: Data manipulation with dplyr

## Loading packages
library(dplyr)

# Selecting desired variables/columns
select(gapminder, year, country, gdpPercap)
head(select(gapminder, year, country, gdpPercap))

## using pipe (%>%)
gapminder %>% 
    select(year, country, gdpPercap) %>% 
    head()

year_country_gdp <- gapminder %>% 
    select(year, country, gdpPercap)

## renaming a column
tidy_gdp <- year_country_gdp %>% 
    rename(gdp_per_capita = gdpPercap)

## renaming multiple columns at once
tidy_country_gdp <- year_country_gdp %>% 
    rename(gdp_per_capita = gdpPercap, place = country)

## Filter rows by desired value(s)
tidy_euro <- gapminder %>% 
    filter(continent == "Europe")

tidy_euro_2002 <- gapminder %>% 
    filter(continent == "Europe", year == 2002)


## Exercise answer
gapminder %>% 
    filter(continent == "Africa") %>% 
    select(lifeExp, country, year) %>% 
    nrow()
##

# Grouping rows in a data-frame and summarising the data within each group

## The code below shows the change in the data-frame structure after grouping
gapminder %>% str()
gapminder %>% group_by(continent) %>% str()

## Grouping and calculating mean values from a column
### Note: Summarise is designed to create a NEW data-frame containing
### column(s) that we have created within the function. It works best
### after grouping the data-frame (group_by), but will also output a
### data-frame if the data is not grouped. In the latter case, the data-frame
### will have a single row summarising all observations in the input
gdp_bycontinents <- gapminder %>% 
    group_by(continent) %>% 
    summarize(mean_gdpPercap = mean(gdpPercap))

gapminder %>% 
    filter(year == 2002) %>% 
    group_by(continent) %>% 
    count()


# Create new columns using mutate()
gdp_per_billion <- gapminder %>% 
    mutate(gdp_billion = gdpPercap*pop/10^9)

# Create new columns with conditional values
gdp_per_billion_above40 <- gapminder %>% 
    mutate(gdp_billion = ifelse(lifeExp > 40, gdpPercap*pop/10^9, NA))





