# open class

## what will we be doing today 
### 1. Process scRNA-seq data using Seurat
### 2. Perform QC
### 3. Regress cell-cycle genes
### 4. Normalize and scale count matrix
### 5. Reduce dimensionality using PCA and UMAP
### 6. Identify clusters
### 7. Perform differential expression

#>>>>>>>> NEED NOT PASTE
### Check if everyone have Seurat and Tidyverse installed
### Check if everyone have data in ~
### Lesson materials https://fursham-h.github.io/R-datascience/articles/4_scRNAseq_seurat/Overview.html
## use etherpad for checkin https://etherpad.wikimedia.org/p/CDN-scRNAseq-online
## screen management and zoom reactions
## recording 

## Recap on previous lesson and how this lesson is a continuation
#>>>>>>>> 

## Overview of seurat pipeline 
https://raw.githubusercontent.com/fursham-h/R-datascience/077e0f6da54d13153aa2c88ae615a1efaa913294/vignettes/4_scRNAseq_seurat/cropped_seurat_workflow.png

## Inputs for scRNA-seq analysis
### 1. A count matrix (most basic)
### 2. Output files from cellranger software (10x genomics)

# References 
## Data used in this lesson:
### Childhood Cerebellar Tumors Mirror Conserved Fetal Transcriptional Programs
### https://www.nature.com/articles/s41586-019-1158-7
### Find information on downloading datasets from "Data availability" section
### https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE118068

## Workflow used
# https://satijalab.org/seurat/articles/pbmc3k_tutorial.html

## Useful Seurat commands
# https://satijalab.org/seurat/articles/essential_commands.html



#### PART 1: Creating Seurat Object

## Open a new R script in RStudio

# Load R libraries
library(Seurat)
library(tidyverse)

# To import 10x data
## The files have to be named:
### 1. barcodes.tsv.gz
### 2. features.tsv.gz
### 3. matrix.mtx.gz
### If your 10x files are not named this way, use ReadMtx()
e14.crblm <- Read10X(data.dir = "~/GSE118068_embryo/E14/")

## 10x may also provide h5 file format
## use Read10X_h5() to import this

# To import countmatrix
# data <- ReadMtx(mtx = "path/to/countmatrix")


# To create a Seurat Object
e14.seurat.crblm <- CreateSeuratObject(counts = e14.crblm, project = "e14")










#### PART 2: Inspecting Seurat Objects

## typing out variable name gives a description of the Seurat Object
e14.seurat.crblm

# get cell barcodes (ID)
colnames(e14.seurat.crblm) %>% head()

# get features (genes)
## IMPORTANT. Try to have gene_names as features, rather than gene_id
rownames(e14.seurat.crblm) %>% head()

# View default assay
DefaultAssay(e14.seurat.crblm)

# View count data
e14.seurat.crblm[["RNA"]]@counts %>% head()

# View dataset metadata
e14.seurat.crblm[[]] %>% head()

## or
e14.seurat.crblm@meta.data %>% head()

# to view specific columns from metadata
e14.seurat.crblm$nCount_RNA %>% head()
e14.seurat.crblm[[c("nCount_RNA", "orig.ident")]] %>% head()

# To add new metadata column
e14.seurat.crblm$region <- "Cerebellum"
## same as 
## e14.seurat.crblm[["region"]] <- "Cerebellum"







#### Activity 1 ####

# import E16 and E18 datasets into R and create Seurat Objects for each 
# datasets (name them e16.seurat.crblm & e18.seurat.crblm)

# Ans:
e16.crblm <- Read10X(data.dir = "~/GSE118068_embryo/E16/")
e16.seurat.crblm <- CreateSeuratObject(counts = e16.crblm, project = "e16")

e18.crblm <- Read10X(data.dir = "~/GSE118068_embryo/E18/")
e18.seurat.crblm <- CreateSeuratObject(counts = e18.crblm, project = "e18")
###################











# PART 3: Combining Seurat Objects

# simple merging of 3 objects
seurat.merged <- merge(e14.seurat.crblm, y = c(e16.seurat.crblm, e18.seurat.crblm), add.cell.ids = c("e14", "e16", "e18")) 

#### Activity 2 ####

# What is the total number of cells?

## a) 27998
## b) 6068
## c) 19401
## d) 7383

######>>>> PASTE ANSWERs LATER
# Ans: c

# check by typing:
seurat.merged
######>>>> 


# What is the highest number of genes detected in a cell?

## a) 7168
## b) 10288
## c) 3986
## d) 4508

######>>>> PASTE ANSWERs LATER
# Ans: a

# check by typing:
seurat.merged$nFeature_RNA %>% max()

## PRO TIP:
To identify which cell has the highest number of genes, type:
seurat.merged[[]][which(seurat.merged$nFeature_RNA == max(seurat.merged$nFeature_RNA)),]
######>>>> 

###################









# check cell names
colnames(seurat.merged) %>% head()
colnames(seurat.merged) %>% tail()

# check metadata
seurat.merged[[]] %>% head()
seurat.merged[[]] %>% tail()

# Create region metadata for all samples
seurat.merged$region <- "Cerebellum"






# PART 4: QC of scRNAseq dataset

## Check if Seurat objects contain mitochondrial genes
str_subset(rownames(seurat.merged), "^mt-")

## to calculate the percentage of reads that mapped to mitochondrial genome
seurat.merged$"percent.mt" <- PercentageFeatureSet(seurat.merged, pattern = "^mt-")

# To create violin plot contain continuous values
VlnPlot(seurat.merged, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"))


#### Activity 3 ####

# change the Identity of cells back to "region"

Idents(seurat.merged) <- seurat.merged$region
###################



VlnPlot(seurat.merged, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"))



## Plot two-way scatter graph
FeatureScatter(seurat.merged, feature1 = "nCount_RNA", feature2 = "percent.mt")
FeatureScatter(seurat.merged, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")


## Plot these side by side
plot1 <- FeatureScatter(seurat.merged, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(seurat.merged, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
plot1 + plot2

# Drawing lines on plot to visualize thresholds
## TIP: these are ggplots, so you can amend them using ggplot functions
plot2 + geom_hline(yintercept = 300)

plot2 + geom_hline(yintercept = 500) + geom_vline(xintercept = 21000)

plot1 + geom_hline(yintercept = 5)

## Filtering out poor quality cells 
### !!This will overwrite the imported data
seurat.merged <- subset(seurat.merged, subset = nFeature_RNA > 500 & nCount_RNA < 21000 & percent.mt < 5)

# check plot again
plot1 <- FeatureScatter(seurat.merged, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(seurat.merged, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
plot1 + plot2







# PART 5: Normalizing data, scaling data and identifying Highly Variable Features
## https://satijalab.org/seurat/articles/sctransform_vignette.html

seurat.merged <- SCTransform(seurat.merged, verbose = TRUE)





############### BREAK #################






## Part 6: Perform Linear dimensional reduction
### PCA vs UMAP
# https://towardsdatascience.com/dimensionality-reduction-for-data-visualization-pca-vs-tsne-vs-umap-be4aa7b1cb29



seurat.merged <- RunPCA(seurat.merged, features = VariableFeatures(object = seurat.merged))

DimPlot(seurat.merged)
DimPlot(seurat.merged, group.by = "orig.ident")






# Part 7: Regressing cell cycle genes
cc.genes %>% head()
s.genes <- str_to_title(cc.genes$s.genes)
g2m.genes <- str_to_title(cc.genes$g2m.genes)

seurat.merged <- CellCycleScoring(seurat.merged, s.features = s.genes, g2m.features = g2m.genes, set.ident = TRUE)

seurat.merged <- RunPCA(seurat.merged, features = c(s.genes, g2m.genes))
pca.before <- DimPlot(seurat.merged, group.by = "Phase")

# Regressing cell cycle genes
seurat.merged <- SCTransform(seurat.merged, vars.to.regress = c("S.Score", "G2M.Score"), verbose = TRUE)
seurat.merged <- RunPCA(seurat.merged, features = c(s.genes, g2m.genes))
DimPlot(seurat.merged, group.by = "Phase")

seurat.merged <- RunPCA(seurat.merged, features = VariableFeatures(object = seurat.merged))
pca.after <- DimPlot(seurat.merged, group.by = "Phase")





# OPTIONAL: Determine dataset dimensionality
# https://satijalab.org/seurat/articles/pbmc3k_tutorial.html#determine-the-dimensionality-of-the-dataset-1






# PART 8: Perform non-linear dimensional reduction (UMAP/TSNE)
seurat.merged <- RunUMAP(seurat.merged, dims = 1:30, verbose = TRUE)
## seurat.merged <- RunTSNE(seurat.merged, dims = 1:30)
DimPlot(seurat.merged)
#DimPlot(seurat.merged, reduction = "tsne", group.by = "orig.ident")

# DimPlot modifications
DimPlot(seurat.merged, group.by = "orig.ident")
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T)
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T) + NoLegend()
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T, pt.size = 1) + NoLegend()
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T, label.size = 10) + NoLegend()
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T, cols = c("Black", "Grey", "Red")) + NoLegend()
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T, cols = "Set2")

## ADVANCE mod
DimPlot(seurat.merged, group.by = "orig.ident", 
        cells.highlight = rownames(seurat.merged@meta.data[seurat.merged$orig.ident == "e14",]), 
        cols.highlight = "cornflowerblue", sizes.highlight = 1)





# Plot gene expressions on UMAP
FeaturePlot(seurat.merged, "Rora")
FeaturePlot(seurat.merged, c("Rora", "Pax2", "Pax3", "Atoh1", "Pax6", "Lhx9"))
## Same plot modifications can be done as DimPlot

# Visualize gene expression as violin plot
VlnPlot(seurat.merged, "Rora")
VlnPlot(seurat.merged, c("Rora", "Pax2", "Pax3", "Atoh1", "Pax6", "Lhx9"))

# PART 9: Cell clustering

seurat.merged <- FindNeighbors(seurat.merged, dims = 1:30)
seurat.merged <- FindClusters(seurat.merged, resolution = 0.2)
DimPlot(seurat.merged, label = T) + NoLegend()

cluster.markers <- FindAllMarkers(seurat.merged, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)

# Inspecting data
cluster.markers %>% head()

top3 <- cluster.markers %>% 
    group_by(cluster) %>% 
    top_n(n = 3, wt = avg_log2FC)
View(top3)

# 0: Granule cells (Atoh1, Mfap4, )
# 1: Glial progenitors (Slc1a3)
# 2: Granule cells (Neurod1)
# 3: ?
# 4: Purkinje (Foxp2)
# 5: Granule cells
# 6: 
# 7: Purkinje ()
# 8: Meninges (Vtn)
# 9: Endothelial (Cldn5)
# 10: 

top5 <- cluster.markers %>%
    group_by(cluster) %>%
    top_n(n = 5, wt = avg_log2FC)
DoHeatmap(seurat.merged, features = top5$gene) + NoLegend()







# PART 9: Differential gene expression
purkinje.e14_16.vs.e17 <- FindMarkers(seurat.merged, ident.1 = 4, ident.2 = 7, min.pct = 0.2)


VlnPlot(seurat.merged, "Id2",idents = c(4,7))




## Same workflow can be used for scATAC-seq data
## More specific tools have been developed:
### 1. chromVar: https://github.com/GreenleafLab/chromVAR
### 2. archR: https://www.archrproject.com/


## Other tools:
# monocle3: https://cole-trapnell-lab.github.io/monocle3/
# scanpy: https://scanpy.readthedocs.io/en/stable/
# URD: https://github.com/farrellja/URD


### Other analyses:
# Trajectory analyses: https://satijalab.org/signac/articles/monocle.html
# Probabilistic assigning of cell identity: https://github.com/Irrationone/cellassign
# Identifying gene programs: https://github.com/dylkot/cNMF
# covariates. 


# Closing activity 
#1) What is the one thing you learn today?

#2) What is the one thing this workshop can improve on?




















