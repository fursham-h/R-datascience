# Workshop 2: Data Visualisation using R

# Load essential packages for this section
library(ggplot2)
library(dplyr)

# import dge_data.tsv
dge <- read.delim("~/Downloads/dge_data.tsv")  #this assumes that dge_data.tsv is in Downloads folder
dge <- read.delim(file.choose())    # file.choose() will open a nav window for you to select your file


# plotting univariate graph
# data: your desired data-frame
# mapping: specifies the columns to use for the axes, and groupings
# geom_*: this is the desired geometry or type of plot you wish to create
ggplot(data = dge, mapping = aes(x = A_vs_B.log2FC)) +
    geom_density()

# Common ggplot geometry functions
# - geom_point()
# - geom_bar()
# - geom_boxplot()
# - geom_density()
# - geom_jitter()
# - geom_histogram()
# - geom_violin()
# - stat_ecdf()

# the look of your graph can be configured by adding arguments to
# geom_*
ggplot(dge, aes(x = A_vs_B.log2FC)) + 
    geom_density(colour = "darkred", fill = "purple4", size = 5) 

# reference to R's colour palette
# http://sape.inf.usi.ch/quick-reference/ggplot2/colour

# common arguments to modify plot aesthetics
# colour
# fill
# size
# alpha
# shape

# Below is the link to various shapes that comes with R
# http://www.sthda.com/english/wiki/ggplot2-point-shapes

# axis names and plot titles can be changed using labs() 
ggplot(dge, aes(x = A_vs_B.log2FC)) + 
    geom_density(colour = "darkred", fill = "purple4", size = 5)  +
    labs(x = "Log2 fold change [A vs B]",
         title = "Density plot of log2 fold change")

# plot can be saved to a variable
## Note: by saving a plot to a variable, it will not automatically
## be printed in your 'Plots' window. You would need to type
## the variable name in console to view the plot
densplot <- ggplot(dge, aes(x = A_vs_B.log2FC)) + 
    geom_density(colour = "darkred", fill = "purple4", size = 5)  +
    labs(x = "Log2 fold change [A vs B]",
         title = "Density plot of log2 fold change")


# saving plots
ggsave("density_plot.png", plot = densplot, device = "png")

## plotting bivariate scatter plot of gene expression
## in the two samples
ggplot(dge, aes(x = A.TpM, y = B.TpM)) +
    geom_point(shape = 22) +
    labs(x = "Gene expression in sample A",
         y = "Gene expression in sample B")

# In the above plot, the highly expressing genes are segregated
# from the other datapoints. We can improve this by converting
# both axes to a log10 scale
ggplot(dge, aes(x = A.TpM, y = B.TpM)) +
    geom_point() +
    labs(x = "Gene expression in sample A",
         y = "Gene expression in sample B")
    scale_x_continuous(trans = "log10") + 
    scale_y_continuous(trans = "log10") 


# Activity 3:
# Modify the code below to change the color and size of the points on the point layer
ggplot(dge, aes(x = A.TpM, y = B.TpM)) +
    geom_point() +
    labs(x = "Gene expression in sample A",
         y = "Gene expression in sample B")
    scale_x_continuous(trans = "log10") + 
    scale_y_continuous(trans = "log10") 

# Possible answer:
ggplot(dge, aes(x = A.TpM, y = B.TpM)) +
    geom_point(colour = "navyblue", size = 3) +
    labs(x = "Gene expression in sample A",
         y = "Gene expression in sample B")
    scale_x_continuous(trans = "log10") + 
    scale_y_continuous(trans = "log10") 


## Adding a grouping variable to our plot

# We can distinguish each datapoint by a grouping variable.
# Here, we will group the data into regulated and non-regulated group
# The code below will create a new column 'group' in dge dataframe
# with the groupings for each gene
dge <- dge %>% 
    mutate(group = 
        ifelse(A_vs_B.FDR < 0.05 & abs(A_vs_B.log2FC) > log2(1.5),      # your test
        "Regulated",                                                    # output if test is true
        "Non-regulated"))                                               # output if test is false

# to distinguish the datapoints from these group by colour, specify the name of this column (group) 
# to the 'colour' argument within the aes() function
ggplot(dge, aes(x = A.TpM, y = B.TpM, colour = group)) +
    geom_point() +
    scale_x_continuous(trans = "log10") + 
    scale_y_continuous(trans = "log10") +
    labs(x = "Gene expression in sample A",
         y = "Gene expression in sample B")

# the datapoints are printed in the order it appears 
# in the data-frame (top to bottom)
# to make regulated genes pop out, we have to sort the data-frame
# by the 'group' column
dge <- dge %>% 
    arrange(group)

# to sort in the descending order, do this:
#dge <- dge %>% 
#    arrange(desc(group))

# replot 
ggplot(dge, aes(x = A.TpM, y = B.TpM, colour = group)) +
    geom_point() +
    scale_x_continuous(trans = "log10") + 
    scale_y_continuous(trans = "log10") +
    labs(x = "Gene expression in sample A",
         y = "Gene expression in sample B")


# the colour of the datapoints can be configured using scale_colour_manual()
ggplot(dge, aes(x = A.TpM, y = B.TpM, colour = group)) +
    geom_point() +
    scale_x_continuous(trans = "log10") + 
    scale_y_continuous(trans = "log10") +
    labs(x = "Gene expression in sample A",
         y = "Gene expression in sample B") +
    scale_colour_manual(values = c("grey80", "navyblue"))


# We will test out ggpubr to compare expression of transcripts
# in the two samples and print out the statistics of the
# comparison

# load packages
library(ggpubr)
library(tidyr)

tpm <- read.delim("~/Downloads/tpm_matrix.tsv")
#or
tpm <- read.delim(file.choose())

# We wish to plot a boxplot.
# Because our data is a matrix, we need to convert it to 
# a data-frame by converting the sample names to a single 
# column and collate the expression values to a single, separate column
# gather() does this easily. you need to:
# 1) specify the names of the 2 new columns. 
# the first is the column for sample names, the second is for expression values
tpm <- tpm %>% 
    gather(key = "Sample", value = "TpM", A_1:B_3)

# the code below will create another column that drops the last two characters
# of the sample names
tpm <- tpm %>% 
    mutate(Group = substr(Sample, start =0, stop = 1))

# ggpubr is be more intuitive to use.
# unlike ggplot2, ggpubr comes with specific functions to
# directly plot the geometry
# Below is an example of how to plot boxplots
ggboxplot(tpm, x = "Group", y = "TpM")

# we can add datapoints on top of the boxplot layer as such:
ggboxplot(tpm, x = "Group", y = "TpM", add = "jitter")

# Other things we can do is to rename the axis, changing the 
# colour of the boxplots, and faceting the data
# by a grouping variable
ggboxplot(tpm, x = "Group", y = "TpM", xlab = "", add = "jitter", 
    facet.by = "Isoform", fill = "Group", palette = "Paired")

# to statistically compare the expression between A and B, we have to create
# a comparisons list as such:
my_comparisons <- list(c("A", "B"))


# and use the function stat_compare_means with method "t.test".
ggboxplot(tpm, x = "Group", y = "TpM", xlab = "", add = "jitter", 
    facet.by = "Isoform", fill = "Group", palette = "Paired") +
    stat_compare_means(comparisons = my_comparisons, method = "t.test")

# A gallery of ggplot graphs
# https://www.r-graph-gallery.com/


# Home activity (optional):
# Generate a Volcano Plot with log2FC as the x-axis and -log(FDR) as the y-axis.
# You may modify the colour, shape and/or size of each datapoint to best
# represent your data. As a bonus, you may attempt to label some differentially
# expressed genes (top 10 up- and down-regulated genes). 
# hint: use ggrepel to label plots

# Send your graphs to me via email if would like me to comment on your plot




