## Single-Cell Roadmap of Early Hemato-Endothelial Development: Roles of Atf3, Zfp711, And Bcl6b

**Ridvan Cetin<sup>1</sup>, Giulia Picco<sup>1</sup>, Jente van Staalduinen<sup>1</sup>, Eric Bindels<sup>2</sup>, Remco Hoogenboezem<sup>2</sup>, Gregory van Beek<sup>2</sup>, Mathijs Sanders<sup>2</sup>, Yaren Fidan<sup>1</sup>, Ahmet Korkmaz<sup>3</sup>, Joost Gribnau<sup>1,4</sup>, Jeffrey van Haren<sup>1</sup>, Danny Huylebroeck<sup>1</sup>, Eskeatnaf Mulugeta<sup>1</sup>, Frank Grosveld<sup>1,\±</sup>**

### Table of Contents

1. [Paper abstract](#Abstract)
2. [Data availability](#data)
3. [Explore the data](#explore)
4. [Code availability](#code)
5. [Contact](#contact)
6. [Other links](#links)

   

### Abstract

a
b
s
t
r
a
c
t

### Data availability<a name="data" />

e.g., 

e.g.,  Various forms of the transcriptomics data such as raw counts, normalised counts, dimensionality reductions and metadata are available [here] for loading into R and python. 


| File name                                                    | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `embryo_complete.h5ad`                                                 | AnnData object with log normalised UMI counts and raw counts the .raw layer, metadata, batch corrected PCA and other layouts (eg., UMAP). Function scanpy.read(filename, ...) is recommended. |
| `embryo_sce.rds`                                                  | Contains a `SingleCellExperiment` object with counts, metadata and batch corrected layouts for processing in R. Pre-computed library size factors can be accessed to normalise the data. |
| `embryo_counts.tar.gz`                                               | Counts matrix in sparse format (`mtx`) with cell and gene metadata files. |
| `metadata_cells.csv`                                               | Cell metadata. |
| `metadata_genes.csv`                                               | Gene metadata, ensemble id and gene symbols. |
| `umap_layout.csv`                                               | UMAP layout. |
| `pca_batch_corrected.csv`                                               | Batch corrected PCA with MNN. |

Raw scRNA-seq files have been deposited in arrayexpress under the accession number [E-MTAB-11763](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-11763?query=E-MTAB-11763). For details of the other, externally generated datasets used in our analysis, see the methods section of the paper. 

Note: Smart-Seq2 data generated in this project will be soon made public.

### Explore the data<a name="explore" />

#### Shiny app 

The data can be explored after logging into [shiny app](https://ridvan.shinyapps.io/shinyapp/).
 
IMPORTANT: This webpage is currently under development.

#### UCSC Cell browser



### Code availability<a name="code" />

1. [Demultiplexing](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Analysis_Codes/1_demultiplexing.Rmd)
2. [Preprocessing](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Analysis_Codes/2_preprocessing.Rmd)
3. [Differential Abundance Analysis 1 (propeller/speckle)](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Analysis_Codes/3_DAA_speckle.Rmd)
4. [Differential Abundance Analysis 2 (miloR)](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Analysis_Codes/4_DAA_miloR.Rmd)
5. [Differential Gene Expression Analysis (Pseudobulk with DESeq2)](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Analysis_Codes/5_DGEA_DESeq2.Rmd)
6. [Markers for Small Clusters](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Analysis_Codes/7_GSEA.Rmd)
7. [Gene Set Enrichment Analysis](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Analysis_Codes/7_GSEA.Rmd)
8. [Statistical Analysis of Flow Cytometric Analysis Results](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Analysis_Codes/8_FCA_Statistics.Rmd)
9. [Categorization of Differentially Expressed Genes](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Analysis_Codes/9_DEGs_categorization.Rmd)



### Support or Contact<a name="contact" />
Ridvan Cetin: r.cetin@erasmusmc.nl 

### Other links<a name="links" />



###### Affiliations

<sup>1</sup>Department of Cell Biology, Erasmus University Medical Center Rotterdam, Rotterdam, The Netherlands

<sup>2</sup>Department of Hematology, Erasmus University Medical Center Rotterdam, Rotterdam, The Netherlands

<sup>3</sup>Medical Faculty, Institute of Physiology, RWTH Aachen University, Aachen, Germany

<sup>4</sup>Department of Developmental Biology, Erasmus University Medical Center Rotterdam, Rotterdam, the Netherlands

<sup>*</sup>Corresponding author
   
-----
Design of this page inspired from https://marionilab.github.io/ExtendedMouseAtlas/ .
