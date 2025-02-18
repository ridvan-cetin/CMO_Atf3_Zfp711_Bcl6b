## Single-Cell Roadmap of Early Hemato-Endothelial Development: Functions of Atf3, Zfp711 and Bcl6b

**Ridvan Cetin<sup>1</sup>, Giulia Picco<sup>1</sup>, Jente van Staalduinen<sup>1</sup>, Eric Bindels<sup>2</sup>, Remco Hoogenboezem<sup>2</sup>, Gregory van Beek<sup>2</sup>, Mathijs Sanders<sup>2</sup>, Yaren Fidan<sup>1</sup>, Ahmet Korkmaz<sup>3</sup>, Joost Gribnau<sup>1,4</sup>, Jeffrey van Haren<sup>1</sup>, Danny Huylebroeck<sup>1</sup>, Eskeatnaf Mulugeta<sup>1</sup>, Frank Grosveld<sup>1,\±</sup>**

### Table of Contents

1. [Paper abstract and highlights](#Abstract)
2. [Data availability](#data)
3. [Explore the data](#explore)
4. [Code availability](#code)
5. [Contact](#contact)
6. [Supporting data](#supportdata)
7. [Workflow and Cell Types]

### Abstract & Highlights<a name="Abstract" />

#### Abstract
Hematopoiesis is the process of producing blood cells. In mammalian embryos, hematopoiesis occurs in three consecutive overlapping waves (Neo et al. 2021; Dzierzak and Bigas 2018) that are regulated by transcription factors (TFs) and signaling proteins. We investigated the functions of three relatively poorly studied TFs in early embryonic hematopoietic development at single-cell resolution: Activating transcription factor 3 (Atf3), Zinc finger protein 711 (Zfp711), and B cell CLL/lymphoma 6, member B (Bcl6b). These TFs are upregulated early in development when hematopoietic and endothelial lineages separate from cardiac and other mesodermal lineages. We combined multiplexed single-cell RNA sequencing (scRNA-seq) and cell identity analysis using Flow Cytometric Analysis (FCA) with TF knockouts (KO) in in-vitro differentiating mouse embryonic stem cells (mESCs) to dissect the function of these TFs in lineage induction, specification, and separation. The Atf3-KO showed an increase of distinct mesodermal subpopulations, but a decrease of endothelial and erythro-myeloid progenitors (EMPs) by downregulation of important genes ( i.e. Runx1, Mafb, Egr1, Jun, Jund, Fos, Batf3, and Zf608) that likely explains the effects on EMPs and the increased expression of interferon-related genes. In Zfp711-KO cells, the number of blood progenitor cells and erythroid cells increased, while the number of endothelial cells decreased. Furthermore, Hoxa expressing mesoderm decreased, while Hoxb expressing mesoderm increased. In contrast, the Bcl6b-KO had no observable effects on early hematopoiesis. In conclusion, we report the function of these three TFs function at different stages of hemato-endothelial lineage specification. 

#### Highlights
HIGHLIGHTS
•	Combined scRNA-seq and FCA on KO mESCs in vitro differentiation enabled unbiased identification of the respective TF functions during specific stages of hematoendothelial lineage specification.
•	Atf3-KO: Increased abundance of mesodermal lineages and decreased endothelial lineages and EMPs.
   o	Downregulation of key TF-encoding genes (e.g., Runx1, Mafb, Egr1, Jun, Jund, Fos, Batf3, Zf608) explain the effects on EMPs.
   o	Generation of a distinct mesodermal subpopulation with high expression of sets of interferon and anti-viral-related genes.
   o	Upregulation of interferon and anti-viral-related genes, indicating Atf3 acts as a negative regulator of these genes.
•	Zfp711-KO: Increased numbers of blood progenitor and erythroid cells. Decreased numbers of endothelial cells.
   o	Shift in mesodermal populations: Hoxa expressing mesoderm decreased, and Hoxb expressing mesoderm increased.
   o	Hoxa9, Hoxa10, Hoxa13, Jun, Jund and Atf3 amongst the downregulated genes. The Atf3 promoter has a potential Zfp711-binding site. 
   o	Increased expression in a given Endothelium subtype in endocardium in vivo and in vitro.
•	Bcl6b-KO: No observable impact on early hematopoiesis.

### Data availability<a name="data" />
scRNA-Seq data generated in this study have been deposited in the European Nucleotide Archive (ENA) database under the accession number PRJEB82953.  ATAC-seq data used in this study is a separate project and will be deposited in the ENA database upon completion of the manuscript preparation. UCSC browser sessions can be accessible with the following links https://genome.ucsc.edu/s/mdrcetin/hg38_ATF3, https://genome.ucsc.edu/s/mdrcetin/mm10_Atf3, https://genome.ucsc.edu/s/mdrcetin/mm10_Zfp711, https://genome.ucsc.edu/s/mdrcetin/hg19_ZNF711, and https://genome.ucsc.edu/s/mdrcetin/hg38_ZNF711  The data supporting the findings of this study are available from the corresponding author upon reasonable request.

### Explore the data<a name="explore" />

#### Shiny app 

The data can be explored after logging into [shiny app](https://ridvan.shinyapps.io/shinyapp/).
![Shinnyapp Example](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Shiny_example.png)

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


### Contact<a name="contact" />
Ridvan Cetin: [r.cetin@erasmusmc.n](r.cetin@erasmusmc.nl) or [mdrcetin@gmail.com](mdrcetin@gmail.com)

### Supporting Data (a name="supportdata" />

1. [Flow Cytometric Analysis Data](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/tree/main/FlowCytometricAnalysis)

### Workflow and Celltypes

##### Workflow

![Workflow](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Figure_s1_v1.png)

##### Cell Types

![Cell Types](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Cetin_Fig_2.png)

###### Affiliations

<sup>1</sup>Department of Cell Biology, Erasmus University Medical Center Rotterdam, Rotterdam, The Netherlands

<sup>2</sup>Department of Hematology, Erasmus University Medical Center Rotterdam, Rotterdam, The Netherlands

<sup>3</sup>Medical Faculty, Institute of Physiology, RWTH Aachen University, Aachen, Germany

<sup>4</sup>Department of Developmental Biology, Erasmus University Medical Center Rotterdam, Rotterdam, the Netherlands

<sup>*</sup>Corresponding author
   
-----
The design of this page was inspired by https://marionilab.github.io/ExtendedMouseAtlas/ .
