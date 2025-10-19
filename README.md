Part 1: Single-cell RNA sequencing data analysis.

Left ventricular non-compaction (LVNC) is a rare form of cardiomyopathy characterized by an abnormal heart muscle structure. Cyp26b1 is a key gene in regulating retinoic acid for the normal development of the heart, and a mutation in this gene is known to be associated with LVNC pathology. However, molecular mechanisms underlying LVNC governed by Cyp26b1 mutation are still lacking, thus limiting the discovery of the potential target for treating LVNC. Recent studies have applied scRNA-seq to study abnormal cardiogenesis, focusing on the changes of the composition of cell populations and transcriptional signature caused by deletion of Cyp26b1. 

Therefore, this project aim to analyse scRNA deq data from the embryonic mouse heart at day 12.5 of development to answer the question how Cyp26b1 modulates the cell states in the developing heart and then perform network analysis (co-expression networks and PPI networks)t to identify potential therapeutic targets for this disease's treatment.

The dataset for this project is available here: https://drive.google.com/file/d/18FvglCVXvVpGjcXPlhxLWISqkpD92WYS/view?usp=drive_link.

This dataset was already pre-filtered to ensure high quality data by retaining only:

+/ Singlet cells, excluding doublets and multiplets for accurate single-cell resolution.

+/ Cells with mitochondrial gene expression ≤ 25% to minimize the inclusion of stressed or damaged cells.

+/ Cells with more than 500 detected gene to have enough transcriptome complexity for accurate cell type annotation.

There are 10 cell types in this dataset, including: EC: endothelial cells; vCM: ventricular cardiomyocytes; EndMT: endothelial to mesenchymal transition cells; aCM: atrial cardiomyocytes; Epi: epithelial cells; VSMC: vascular smooth muscle cells; EPDC: epicardium derived cells; SHF: second heart field cells; Ery: erythrocytes; and Mac: macrophages.

The flowchart of this project includes:

Step 1: Log Normalization adjusta raw count data to account for the differences in sequencing depth across cells. 

Step 2: Variable Gene Selection selects the top 2,000 most variable genes to reduce noise from genes with little or no expression variation.

Step 3: Scaling centers and standardizes the expression of each gene. This is important because downstream algorithms—like PCA—assume all variables have similar means and variances.

Step 4: Dimensional Reduction (PCA) helps reduce this complexity in sc data while capturing most of the variation.

Step 5: Batch Correction (Harmony) minimizes batch effects and ensures that clusters are not driven by technical artifacts.

Step 6: kNN-based Clustering clusters cells by building a graph of a k-nearest neighbor (kNN) and then use Louvain algorithm to find clusters. I use the first 50 principal components, setting neighbors to 40, and resolution to 0.2 to strike a balance between cluster granularity and stability. 

Step 7: Cluster Visualization by UMAP preserves local and global structures of the data in two dimensions.

Step 8: Cell Type Annotation annotates clusters based on marker genes—genes characteristic of known cell types. This step translates clusters into biologically meaningful cell identities

These steps were conduced using Seurat package. Code for step 1 to step 8 is stored in scRNAseqDataAnalyis file

Step 9: Network Analysis
#----------------------------------------------------------------------------------------------------------------------------#
Part 2: Cell-type-specific co-expression network construction and visualization

The result from the single-cell sequencing helped me identify which cell type should be my main focus. I chose the SHF cell type because it shows the most differences in gene exp between the knockout and wild-type groups, and is more relevant to heart biology than erythrocytes or macrophages. This project constructed co-expression network specific to SHF using hdWGCNA package which is compatible to single-cell transcriptomics data and Seurat package. 

Before constructing network, it is critical to determine a proper value for the soft power threshold. This is the lowest soft power threshold  that makes the network have a Scale Free Topology and Model Fit greater than or equal to 0.8. 

The network analysis found 22 different co-expression modules for second heart field cells, as represented in the dendrogram plot. But I didnot contruct co-expression networks for all of them, I selected somes hub modules to build the network.

To identify hub modules, Differential module eigengene” (DME) analysis was performed to identify which modules have high effect size with significance (p-value). They were selected as hub modules to construct the co-expression networks.

Afterwards, I visualized co-expression networks for these modules using network visualization functions specific to hdWGCNA.
Code for constructing anf visualizing co-expression networks is stored in scNetworkAnalysis file. 

#----------------------------------------------------------------------------------------------------------------------------#
Part 3: Integrating co-expression networks with PPI network to identify overlapping hub genes

Although Co-expression networks are a powerful tool for uncovering biological patterns in transcriptomic data in an unsupervised manner. However, interpreting these networks can be challenging. To improve interpretability—especially regarding hub genes—I intergrated the co-expression network with a protein-protein interaction network using STRINGdb package. Finally, the overlapping hub genes between original co-expression networks and PPI networks of hub modules were determined as potential target for treating LVNC disease. 

Code for integrating co-expression networks with PPI network of mouse is stored in IntegratedPPI file.

#end 
