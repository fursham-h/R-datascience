# R as a calculator 

1 + 100

1 + 100
  
3 + 5 * 2

(3 + 5) * 2

# Mathematical functions

sin(1)

log(1)

?log()


# Comparing things

1 == 1

1 != 2

1 < 0

# Variable and assignment

x <- 1
x

x <- x/40
x

y <- x * 2
y

text <- "I love this course"
text

## Read data 
download.file("bit.ly/cdndata", "gapminder")
gapminder <- read.csv("gapminder")
gapminder <- read.delim("gapminder", sep = ",")

gapminder
head(gapminder)
head(gapminder, 10)

View(gapminder)

str(gapminder)

dim(gapminder)

nrow(gapminder)
ncol(gapminder)

names(gapminder)


## Export data with R
write.table(gapminder, "gapminder_new.csv")
write.table(gapminder, "gapminder_new.csv", sep = ",", quote = FALSE, row.names = FALSE)

## Data frame manipulation with dplyr
install.packages("dplyr")
library(dplyr)

head(gapminder)

select(gapminder, year, country, gdpPercap)
head(select(gapminder, year, country, gdpPercap))

gapminder %>% 
  select(year, country, gdpPercap) %>% 
  head()

year_country_gdp <- gapminder %>% 
  select(year, country, gdpPercap)
year_country_gdp

tidy_gdp <- year_country_gdp %>% 
  rename(gdp_per_capita = gdpPercap)
head(tidy_gdp)

tidy_gdp_country <- year_country_gdp %>% 
  rename(gdp_per_capita = gdpPercap, place = country)
head(tidy_gdp_country)

# Filter for desired rows
head(gapminder)

year_country_gdp_euro <- gapminder %>% 
  filter(continent == "Europe") %>% 
  select(year, country, gdpPercap)
  
head(year_country_gdp_euro)

gapminder %>% 
  filter(continent == "Africa") %>% 
  select(year, country, lifeExp) %>% 
  nrow()

gapminder %>% str()

# group_by

gapminder %>% group_by(continent) %>% str()

# summarize

gdp_bycontinents <- gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap))

gdp_bycontinents

## count()

gapminder %>% 
  filter(year == 2002) %>% 
  group_by(continent) %>% 
  count(sort = TRUE)


## mutate()
gapminder %>% head()

gdp_per_billion <- gapminder %>% 
  mutate(gdp_billion = gdpPercap*pop/10^9)
gdp_per_billion %>% head()

gdp_per_billion_above40 <- gapminder %>% 
  mutate(gdp_billion = ifelse(lifeExp > 40, gdpPercap*pop/10^9, NA))

head(gdp_per_billion_above40)
head(gdp_per_billion_above40, 10)
