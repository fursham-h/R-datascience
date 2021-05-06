


# Load ggplot2 
library(ggplot2)
library(dplyr)

# import dge_data.tsv into R
dge <- read.delim("dge_data.tsv")
dge <- read.delim(file.choose())

dge %>% head()

# plotting of univariate data
ggplot(data = dge)

ggplot(data = dge, mapping = (aes(x = A_vs_B.log2FC)))

# Remove argument titles
ggplot(dge, (aes(x = A_vs_B.log2FC)))

# specifying the geometry plot
ggplot(dge, aes(x=A_vs_B.log2FC)) +
    geom_density()

## ACTIVITY

# Common ggplot geometry functions
# - geom_point()
# - geom_bar()
# - geom_boxplot()
# - geom_density()
# - geom_jitter()
# - geom_histogram()
# - geom_violin()
# - stat_ecdf()

# modifying plot. ADD TO THE CODE ABOVE
densplot <- ggplot(dge, aes(x=A_vs_B.log2FC)) +
    geom_density(colour = "darkred", fill = "purple4", size = 10) +
    labs(x = "Log2 fold change [A vs B]", 
         title = "Density plot of log2 fold change")

# colour palette
# http://sape.inf.usi.ch/quick-reference/ggplot2/colour

# saveplot
ggsave("density_plot.png", densplot, device = "png", width = 7, height = 5, units = "cm")
## OR BY CLICKING ON EXPORT

# Try plotting bivariate data
dotplot <- ggplot(dge, aes(x=A.TpM, y = B.TpM)) +
    geom_point(shape = 22) +
    labs(x = "Gene expression in sample A [TpM]", 
         y = "Gene expression in sample B [TpM]")

# http://www.sthda.com/english/wiki/ggplot2-point-shapes

# scaling the axes
dotplot <- dotplot +
    scale_x_continuous(trans = "log10") +
    scale_y_continuous(trans = "log10")

##########################
# Exercise 3: Change colour and size of dots
#########################


# Adding a third variable
dge <- dge %>% 
    mutate(group = ifelse(abs(A_vs_B.log2FC) > log2(1.5) & A_vs_B.FDR < 0.05, "Regulated", "Not-regulated"))

dotplot.labelled <- ggplot(dge, aes(x=A.TpM, y= B.TpM, colour = group)) +
    geom_point() +
    scale_x_continuous(trans = "log10") +
    scale_y_continuous(trans = "log10")




# change axis and legend labels differently
dotplot.label <- dotplot.label + 
    labs(x = "Gene expression in sample A [TpM]",
         y = "Gene expression in sample B [TpM]",
         colour = "")

dotplot.label +
    scale_colour_manual(values = c("grey80", "navyblue")) 

dge <- dge %>% 
    arrange(group)

dotplot.label <- ggplot(dge, aes(x=A.TpM, y= B.TpM, colour = group)) +
    geom_point() +
    scale_x_continuous(trans = "log10") +
    scale_y_continuous(trans = "log10") + 
    labs(x = "Gene expression in sample A [TpM]",
         y = "Gene expression in sample B [TpM]",
         colour = "") +
    scale_colour_manual(values = c("grey80", "navyblue")) +
    theme_minimal()



##########################
# Exercise 4: Change shape of datapoints

#########################




## Barplots
dge <- dge %>% 
    mutate(direction = ifelse(A_vs_B.log2FC > 0, "Upregulated", "Downregulated"))


dge %>% 
    ggplot(aes(x=direction)) +
    geom_bar()


dge %>% 
    filter(dge == "Regulated") %>% 
    ggplot(aes(x=direction, fill = direction)) +
    geom_bar() +
    scale_fill_brewer(palette = "Paired")

#stacked bar
dge %>% 
    ggplot(aes(x=dge, fill = direction)) +
    geom_bar() +
    scale_fill_brewer(palette = "Paired")

# side-by-side/fill bar
dge %>% 
    ggplot(aes(x=dge, fill = direction)) +
    geom_bar(position = "dodge") +
    scale_fill_brewer(palette = "Paired")

##########################
# Practice at Home: Volcano plot
# Further exercise: LABELLING
#########################

library(ggpubr)
library(tidyr)

tpm <- read.delim("tpm_matrix.tsv")
tpm <- tpm %>% 
    gather(Sample, TpM, A_1:B_3) %>% 
    mutate(Group = substr(Sample,start = 0, stop = 1))

ggboxplot(tpm, x = "Sample", y = "TpM")
ggboxplot(tpm, x = "Group", y = "TpM")

ggboxplot(tpm, x = "Group", y = "TpM", add = "jitter", facet.by = "Isoform")

my_comparisons <- list( c("A", "B") )
ggboxplot(tpm, x = "Group", y = "TpM", add = "jitter", facet.by = "Isoform",
          fill = "Group", palette = "Paired", shape = "Group") +
    stat_compare_means(comparisons = my_comparisons, method = "t.test", label = "p.signif")


# https://www.r-graph-gallery.com/

































