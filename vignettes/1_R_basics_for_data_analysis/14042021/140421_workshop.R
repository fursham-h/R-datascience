# CDN-workshop 1: R basics for data analysis

# R as a calculator
1 + 100

1 + 100

3 + 5 * 2
   
(3 + 5) * 2

# Mathematical functions
sin(1)

log(1)

# getting help on function usage
?log

# Comparing things
1 == 1

1 != 1

1 < 0

# Variables and assignments
x <- 1

x <- x / 40

y <- x * 2

## Strings/characters can also be assigned to variables
text <- "I love this workshop"

## installing packages
install.packages("dplyr")

# Reading data into R

## The code below ill save the data into your current working directory as a filename "gapminder"
download.file(url = "http://bit.ly/cdndata", destfile = "gapminder")

## As "gapminder" contain comma-separated-values (CSV), we can use read.csv function to impor this file.
## The more generic function, read.delim, can also be used but requires the `sep` parameter to be set to ","
gapminder <- read.csv("gapminder")

View(gapminder)

head(gapminder)

## Below is the package and function commonly used to import excel file.
## Type ?read_excel for help on the function
install.packages("readxl")
read_excel()

# be back 11:27am

#### Data frame manipulation
library("dplyr")

# selecting column(s) from a data frame
select(gapminder, year, country, gdpPercap)

# A nested function which will perform select() followed by head()
## This code is difficult to read
head(select(gapminder, year, country, gdpPercap))

# %>% (pipe)
## improve code readbility
gapminder %>% 
    select(year, country, gdpPercap) %>% 
    head()

year_country_gdp <- gapminder %>% 
    select(year, country, gdpPercap)

# renaming columns
## Multiple columns can be renamed at once
tidy_gdp <- year_country_gdp %>% 
    rename(gdp_per_capita = gdpPercap, place = country)

# Filter desired columns
## Multiple filtering rules can be used.
## adding a "," between the expressions is equivalent to "AND"
## using a "|" between the expressions is equivalent to "OR"
gapminder_euro <- gapminder %>% 
    filter(continent == "Europe", year == 2007)

# Sort a dataframe by one or more columns.
## desc() will reverse the order
gapminder_euro_sorted <- gapminder_euro %>% 
    arrange(lifeExp)
gapminder_euro_sorted_desc <- gapminder_euro %>% 
    arrange(desc(lifeExp))

# create new columns using mutate
gdp_per_billion <- gapminder %>% 
    mutate(gdp_billion = gdpPercap * pop/ 10^9) %>% 
    arrange(gdp_billion)

# group_by and summarising data
gdp_by_continents <- gapminder %>% 
    group_by(continent) %>% 
    summarise(mean_gdpPercap = mean(gdpPercap))

gdp_filter2007_by_continents <- gapminder %>% 
    filter(year == 2007) %>% 
    group_by(continent) %>% 
    summarise(mean_gdpPercap = mean(gdpPercap))

# exporting data
## The additional arguments will improve the formatting of the output file.
write.table(x = gapminder, file = "gapminder.txt", quote = FALSE, row.names = FALSE, sep = "\t")


# dplyr cheatsheet
# https://github.com/rstudio/cheatsheets/blob/master/data-transformation.pdf

# More examples on using dplyr
# https://dplyr.tidyverse.org/articles/programming.html













