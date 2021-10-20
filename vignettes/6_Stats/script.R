## OPEN
## Make sure u have R and RStudio installed
## CHECK-IN EXERCISE
## ETHERPAD. Code and additional resources will be pasted
## RECORDING


## Exercise 1##
# import axondata.csv into an R dataframe. 
# convert string variables to factors
# name this dataframe variable `dat`

dat <- read.csv("./vignettes/6_Stats/axondata.csv", 
                 stringsAsFactors = T)

head(dat)

# Know your variables
## Continuous vs Discrete vs Categorical
## Is your continuous variable normally distributed?
## Format your data properly

# Know your comparisons
## Predictor vs Outcome
## What is your null and alternate hypothesis?


# Preview and summarise basic statistics
summary(dat)

sd(dat$axon_length)
var(dat$axon_branches)

# summarising variables by group
library(tidyverse)
dat %>% 
    group_by(genotype) %>% 
    summarise(meanlength = mean(axon_length),
              sdlength = sd(axon_length),
              meanbranches = mean(axon_branches),
              sdbranches = sd(axon_branches))

## stargazer

# test for normality
## by plotting
ggplot(dat, aes(x=axon_length, colour = genotype)) +
    geom_density()
ggplot(dat, aes(x=axon_branches, colour = genotype)) +
    geom_density()

# try boxplot, histogram

## by Shapiro testing
A.axonlength <- dat[dat$genotype=="A", "axon_length"]
A.length.shapiro <- shapiro.test(A.axonlength)

dat %>% 
    group_by(genotype) %>% 
    summarise(shapiro.length = shapiro.test(axon_length)$p.value,
              shapiro.branches = shapiro.test(axon_branches)$p.value)


## One sample tests

### Parametric t-test
ttest1 <- t.test(A.axonlength, mu = 300)
# t.test(A.axonlength, mu = 300, alternative = "greater", )

ttest1


### Non-parametric Mann Whitney U test (Wilcoxon signed rank test)
A.axonbranches <- dat[dat$genotype=="A", "axon_branches"]
wilcox.test(A.axonbranches, mu = 3)


## Two sample tests
A.axonlength <- dat[dat$genotype=="A", "axon_length"]
B.axonlength <- dat[dat$genotype=="B", "axon_length"]

### Parametric Welch t-test
t.test(A.axonlength, B.axonlength, paired = T, var.equal = F)



### Non-parametric Mann Whitney U test (Wilcoxon signed rank test)
A.axonbranches <- dat[dat$genotype=="A", "axon_branches"]
B.axonbranches <- dat[dat$genotype=="B", "axon_branches"]
wilcox.test(A.axonbranches, B.axonbranches)

## More than two sample tests

# Parametric one-way ANOVA
### test for equality of variance
## install.packages(car)
car::leveneTest(axon_length ~ genotype, data = dat)

aov.out <- oneway.test(axon_length ~ genotype, data = dat, var.equal = T)

TukeyHSD(aov.out)


## if variance is not equal
oneway.test(axon_length ~ genotype, data = dat, var.equal = F)

# Kruskal Wallis test (kruskal.test)
kruskal.test(axon_branches ~ genotype, data = dat)


# Categorical variables


contingency.mat <- dat %>% 
    mutate(axoncat = ifelse(axon_length < 300, "short","long")) %>% 
    group_by(genotype, axoncat) %>%
    tally() %>% 
    spread(axoncat, n) %>% 
    column_to_rownames("genotype") %>% 
    as.matrix()
    
chisq.test(contingency.mat)



## Chi-sq on arbitray dimension
## Fisher's exact on 2x2 contingency table
contingency.mat2 <- contingency.mat[1:2,]
fisher.test(contingency.mat2)



# Correlation tests
A.dat <- dat[dat$genotype == "A",]
cor(A.dat[-1])
cor.test(A.dat$axon_length, A.dat$axon_branches)

ggplot(A.dat, aes(x=axon_length, y = axon_branches)) +
    geom_point() 


# Additional Links
# Stargazer
# Two-way ANOVA test: http://www.sthda.com/english/wiki/two-way-anova-test-in-r
# MANOVA test: http://www.sthda.com/english/wiki/manova-test-in-r-multivariate-analysis-of-variance






