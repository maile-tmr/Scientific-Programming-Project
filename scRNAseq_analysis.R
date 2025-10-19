#=============================================================================#
# Course: Scientific Programming 
# Research Project 
# Section 1: Cell type cluster and annotation for single-cell RNA sqc data
#																	                                       		   															                                #
# Date: October 19, 2025											                                
# Author: Mai Le, ID: i6375777
# Maastricht University                                                       #
#=============================================================================#

setwd("D:/UM/Scientific programming")

#Load required packages
library(Seurat)
library(SeuratData)
library(ggplot2)
library(patchwork)
library(dplyr)
library(remotes)
library(cowplot)
library(harmony)
library(ggthemes)
library(ggalluvial)
library(tidyverse)
library(ggthemes)
library(ggpubr)

###--------------------------------------------------------------------------###
## Part 1: Upload data, create Seurat object for scRNA-seq data of embryonic, 
# mouse heart at the day 12.5 of development, and perform quality control.

# The dataset is uploaded here: 
# https://drive.google.com/file/d/18FvglCVXvVpGjcXPlhxLWISqkpD92WYS/view?usp=sharing 

# Load the dataset
orig_data <- readRDS("filtered_sqc_data.rds")

# Extract the raw RNA count data from the original Seurat object
counts_matrix <- GetAssayData(orig_data, assay = "RNA", layer = "counts")

# Create a new Seurat object with these counts
data <- CreateSeuratObject(counts = counts_matrix, assay = "RNA")

# Transfer the mitochondrial percentage metadata (percent.mt) from 
# the original object to the new one
data@meta.data$percent.mt <- orig_data@meta.data$percent.mt

#Run additional command if you are using Seurat v5

data <- SeuratObject::UpdateSeuratObject(data) 
