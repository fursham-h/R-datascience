# CDN-workshop 1: R basics for data analysis

# Using R as a calculator
1 + 100

1 + 100 # complete code

3 + 5 * 2

(3 + 5) * 2

# Mathematical functions
sin(1)

log(1)

# To get help with usage of functions within R or RStudio
?log

# Comparing things

1 == 1

1 != 2

1 <= 0

# Variables and assignments
x <- 1

x <- x/40

y <- x * 2

# installing packages
install.packages("dplyr")

# Read data into R

## The code below ill save the data into your current working directory as a filename "gapminder"
download.file(url = "bit.ly/cdndata", destfile = "gapminder")

## As "gapminder" contain comma-separated-values (CSV), we can use read.csv function to impor this file.
## The more generic function, read.delim, can also be used but requires the `sep` parameter to be set to ","
gapminder <- read.csv("gapminder")
gapminder <- read.delim("gapminder", sep = ",")

install.packages("readxl")

## Below is the package and function commonly used to import excel file.
## Type ?read_excel for help on the function
read_excel()

getwd() # to get working directory

View(gapminder)
gapminder

head(gapminder)

dim(gapminder)

# 11:02
# be back 11:12

# Dataframe manipulation using dplyr
library("dplyr")

# selecting desired variables/columns
select(gapminder, year, country, gdpPercap)

# an example of a nested function, where the select() function is followed by head()
## This code is difficult to read
head(select(gapminder, year, country, gdpPercap))

# pipe %>% 
## Improves readibility of a complex set of cde
gapminder %>% 
    select(year, country, gdpPercap) %>% 
    head()

# saving the selected data-frame to a variable
year_country_gdp <- gapminder %>% 
    select(year, country, gdpPercap)

# Renaming columns.
## Multiple columns can be named at the same time
tidy_gdp <- year_country_gdp %>% 
    rename(gdp_per_capita = gdpPercap)


# Filtering desired rows
year_country_gdp_euro <- gapminder %>% 
    filter(continent == "Europe" | year == 2002)

## Answer to activity 2
answer <- gapminder %>% 
    filter(continent == "Africa") %>% 
    select(lifeExp, country, year) %>% 
    nrow()


# Creating a new column using mutate()
gpd_billion <- gapminder %>% 
    mutate(gdp_billion = gdpPercap * pop / 10^9)

# Grouping of data by the values from a particular column using group_by() 
# and summarising the data within each group using summarise()
lifeExp_bycontinents <- gapminder %>% 
    group_by(continent) %>% 
    summarize(mean_lifeExp = mean(lifeExp), sum_gdppercap = sum(gdpPercap))
lifeExp_bycontinents

# grouping data by continent and calculating the number of datapoints in each group using tally()
gapminder %>% 
    group_by(continent) %>% 
    tally()

# help on using of specific packages
?dplyr
vignette("dplyr")

# Exporting data-frames to your filesystem.
# note that /home/cdn-bc/ is the path that I wish to save the data to on my computer.
# you may change this path to wherever you wish you want the data to be at
write.table(x = tidy_gdp, file = "/home/cdn-bc/gapminder.txt", quote = FALSE, row.names = FALSE, sep = ",")










