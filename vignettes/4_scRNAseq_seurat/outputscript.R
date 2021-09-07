# Loading dependencies
library(Seurat)
library(tidyverse)


e14.crblm <- Read10X("~/GSE118068_embryo/E14/")

e14.crblm <- Read10X(file.choose())

# Read matrices
# ReadMtx()
# Read10x_h5

# to install seurat
##install.packages("Seurat")

# Create a SeuratObject
e14.seurat.crblm <- CreateSeuratObject(counts = e14.crblm, project = "e14")



## Inspect Seurat Object

e14.seurat.crblm

colnames(e14.seurat.crblm) %>% head()

# try to have gene_names as feature names
rownames(e14.seurat.crblm) %>% head()

DefaultAssay(e14.seurat.crblm)

# view count matrix
e14.seurat.crblm[['RNA']]@counts %>% head()

# view metadata
e14.seurat.crblm[[]] %>% head()
# the same
e14.seurat.crblm@meta.data %>% head()
e14.seurat.crblm$region <- "Cerebellum"
e14.seurat.crblm@meta.data %>% head()


### Activity 1

e16.crblm <- Read10X(data.dir = "~/GSE118068_embryo/E16/")
e16.seurat.crblm <- CreateSeuratObject(counts = e16.crblm, project = "e16")

e18.crblm <- Read10X(data.dir = "~/GSE118068_embryo/E18/")
e18.seurat.crblm <- CreateSeuratObject(counts = e18.crblm, project = "e18")


## Combining the 3 Seurat Objects
seurat.merged <- merge(e14.seurat.crblm, y = c(e16.seurat.crblm, e18.seurat.crblm), 
                       add.cell.ids = c("e14", "e16", "e18"))

colnames(seurat.merged) %>% head()
colnames(seurat.merged) %>% tail()


## Activity 2
# Determine 

seurat.merged

# to determine max number of genes
seurat.merged$nFeature_RNA %>% max()


seurat.merged@meta.data %>% head()
seurat.merged@meta.data %>% tail()

## Create region metadata for all samples
seurat.merged$region <- "Cerebellum"
seurat.merged@meta.data %>% tail()

Idents(seurat.merged) %>% levels()



## Part 4: QC of scRNAseq dataset

# Checking if our seurat object contain mitochondrial
str_subset(rownames(seurat.merged), "^mt-")

# if there isn't ^mt- pattern, try
# str_subset(rownames(seurat.merged), "^MT-")


# calculate the percent of mitochondrial genes
seurat.merged$percent.mt <- PercentageFeatureSet(seurat.merged, pattern = "^mt-")

seurat.merged@meta.data %>% head()

# to create violin plots of continuous variable
VlnPlot(seurat.merged, features = c("nCount_RNA", "nFeature_RNA", "percent.mt"))

Idents(seurat.merged) <- seurat.merged$region
VlnPlot(seurat.merged, features = c("nCount_RNA", "nFeature_RNA", "percent.mt"))

plot1 <- FeatureScatter(seurat.merged, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(seurat.merged, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
plot1 + plot2

plot2 + geom_hline(yintercept = 500) + geom_vline(xintercept = 21000)


seurat.merged <- subset(seurat.merged, subset = nFeature_RNA > 500 & 
                            nCount_RNA < 21000 & percent.mt < 5)

plot1 <- FeatureScatter(seurat.merged, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(seurat.merged, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
plot1 + plot2


# Part 5: Normalize, Scale, identify high variable genes
seurat.merged <- SCTransform(seurat.merged, verbose = T)

DefaultAssay(seurat.merged)

## Part 6: Perform Linear dimensional reduction
## PCA vs tSNE vs UMAP


### PCA
seurat.merged <- RunPCA(seurat.merged, features = VariableFeatures(object = seurat.merged))

DimPlot(seurat.merged)
DimPlot(seurat.merged, group.by = "orig.ident")

# Optional parts:
## 1. Regressing of cell cycle genes
## 2. Determine dataset dimensionality


## Part 7: Non-linear dimensional reduction (UMAP/TSNE)
seurat.merged <- RunUMAP(seurat.merged, dims = 1:30, verbose = T)
# seurat.merged <- RunTSNE(seurat.merged, dims = 1:30)

DimPlot(seurat.merged)
# DimPlot(seurat.merged, reduction = "tsne")

DimPlot(seurat.merged, group.by = "orig.ident")
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T)
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T) + NoLegend()
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T, pt.size = 1) + NoLegend()
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T, label.size = 10) + NoLegend()

DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T, 
        cols = c("Black", "Grey", "Red")) + NoLegend()
DimPlot(seurat.merged, group.by = "orig.ident", label = T, repel = T, 
        cols = "Set2") + NoLegend()

## Advanced modification
DimPlot(seurat.merged, group.by = "orig.ident", 
        cells.highlight = rownames(seurat.merged@meta.data[seurat.merged$orig.ident == "e14",]), 
        cols.highlight = "cornflowerblue", sizes.highlight = 1)

## Plot gene expressions
FeaturePlot(seurat.merged, "Rora")
FeaturePlot(seurat.merged, c("Rora", "Pax2", "Pax3", "Atoh1", "Pax6", "Lhx9"), 
            split.by = "orig.ident")
FeaturePlot(seurat.merged, "Rora", 
            split.by = "orig.ident")

VlnPlot(seurat.merged, "Rora")
VlnPlot(seurat.merged, "Rora", group.by = "orig.ident")


## Part 9: Cell clustering
seurat.merged <- FindNeighbors(seurat.merged, dims = 1:30)
seurat.merged <- FindClusters(seurat.merged, resolution = 0.2)

seurat.merged@meta.data %>% head()
DimPlot(seurat.merged)
DimPlot(seurat.merged, label = T, repel = T) + NoLegend() 

## Part 10: Identifying gene markers
cluster.markers <- FindAllMarkers(seurat.merged, 
                                  only.pos = TRUE,
                                  min.pct = 0.25, 
                                  logfc.threshold = 0.25)



## Part 11: Differential expression
clust4_vs_clust7 <- FindMarkers(seurat.merged, ident.1 = 4, ident.2 = 7)

top3 <- cluster.markers %>% 
    group_by(cluster) %>% 
    top_n(n = 3, wt = avg_log2FC)

DoHeatmap(seurat.merged, features = top3$gene) + NoLegend()

DoHeatmap(subset(seurat.merged, subset = seurat_clusters %in% c(4,7)), features = top3$gene)

## Scillus


View(top3)




