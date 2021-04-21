
## save the script FIRST
## Move the right pane abit more

## Talk about the console prompt

# R as a calculator
1 + 100

1 +
# finish up the code above
    
3 + 5 * 2

(3 + 5) * 2

# Mathematical functions

sin(1)

log(1)

?log()

# Don't worry if you don't remember all functions


# Comparing things

1 == 1

1 != 2

1 < 0

 
# Variables and assignments

x <- 1
x

x <- x/40
x

y <- x * 2
y

text <- "I love this course"
text


#### Challenge 1

# Installing packages
install.packages("dplyr")

### DO NOT RUN THIS CODE ON CDN-BC

# Read data in R

download.file(url = "bit.ly/cdndata", destfile = "gapminder")
gapminder <- read.csv("gapminder")
gapminder <- read.delim("gapminder", sep = ",")

# MAKE SURE EVERYONE HAVE SUCCESSFULLY DOWNLOADED THIS

# READING EXCEL FILES
install.packages("readxl")
library(readxl)
read_excel()

## LINK TO READ UP ON PATH TO DATA
# https://www.howtogeek.com/670447/how-to-copy-the-full-path-of-a-file-on-windows-10/
# https://www.switchingtomac.com/tutorials/osx/5-ways-to-reveal-the-path-of-a-file-on-macos/


# preview data-frame

View(gapminder)

head(gapminder)
head(gapminder, 10)

str(gapminder)

dim(gapminder)

nrow(gapminder)

names(gapminder)

# write data using R
write.table(x = gapminder, file = "gapminder.txt", sep =",")
write.table(x = gapminder, file = "gapminder.txt", quote = F, row.names = F, sep = "\t")

### SUMMARIZE

####### BREAK

### Data frame Manipulation with dplyr
library("dplyr")


# Selecting desired variables/columns
select(gapminder, year, country, gdpPercap)

head(select(gapminder, year, country, gdpPercap))

# pipe (%>%) 
gapminder %>% 
    select(year, country, gdpPercap) %>% 
    head()

year_country_gdp <- gapminder %>% 
    select(year, country, gdpPercap) 

year_country_gdp

# Renaming columns/variables
tidy_gdp <- year_country_gdp %>% 
    rename(gdp_per_capita = gdpPercap)

# Filter desired rows

####### How to know what a column contain
# go to View() df
########

year_country_gdp_euro <- gapminder %>%
    filter(continent == "Europe")


## CHALLENGEEEE 2

## grouping rows of data-frames by common variable values and summarising data

### Show an image of how a group_by looks like
#http://swcarpentry.github.io/r-novice-gapminder/fig/13-dplyr-fig2.png

gapminder %>% 
    str()
gapminder %>% 
    group_by(continent) %>% 
    str()

gdp_bycontinents <- gapminder %>%
    group_by(continent) %>%
    summarize(mean_gdpPercap = mean(gdpPercap))

gdp_bycontinents

# Counting number of rows by groupings using count() and n()
gapminder %>% 
    filter(year == 2002) %>% 
    group_by(continent) %>% 
    tally(sort = TRUE)

# gapminder %>%
#     group_by(continent) %>%
#     summarize(se_le = sd(lifeExp)/sqrt(n()))


# gapminder %>%
#     group_by(continent) %>%
#     summarize(
#         mean_le = mean(lifeExp),
#         se_le = sd(lifeExp)/sqrt(n()))

## Adding new variables/columns
gdp_per_billion <- gapminder %>%
    mutate(gdp_billion = gdpPercap*pop/10^9) 


## Adding new variables/columns with logical filtering
gdp_per_billion_above40 <- gapminder %>% 
    mutate(gdp_billion = ifelse(lifeExp > 40, gdpPercap*pop/10^9, NA))


gdp_per_billion_above40 %>% head()
gdp_per_billion_above40 %>% head(10)


###### KEY TAKEAWAYS
###### LINK TO READ MORE

# write data using R
write.table(x = gapminder, file = "gapminder.txt", sep =",")
write.table(x = gapminder, file = "gapminder.txt", quote = F, row.names = F, sep = "\t")

# More examples on using dplyr
# https://dplyr.tidyverse.org/articles/programming.html

# dplyr cheatsheet
# https://github.com/rstudio/cheatsheets/blob/master/data-transformation.pdf


#### PRACTICE.....