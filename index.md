## Distinct Roles of Atf3, Zfp711, and Bcl6b in Early Embryonic Hematopoietic and Endothelial Lineage Specification

**Ridvan Cetin<sup>1</sup>, Giulia Picco<sup>1</sup>, Jente van Staalduinen<sup>1</sup>, Eric Bindels<sup>2</sup>, Remco Hoogenboezem<sup>2</sup>, Gregory van Beek<sup>2</sup>, Mathijs Sanders<sup>2</sup>, Yaren Fidan<sup>1</sup>, Ahmet Korkmaz<sup>3</sup>, Joost Gribnau<sup>1,4</sup>, Jeffrey van Haren<sup>1</sup>, Danny Huylebroeck<sup>1</sup>, Eskeatnaf Mulugeta<sup>1</sup>, Frank Grosveld<sup>1,\±</sup>**

### Table of Contents

1. [Paper abstract and article references](#Abstract)
2. [Data availability](#data)
3. [Explore the data](#explore)
4. [Code availability](#code)
5. [Contact](#contact)
6. [Supporting data](#supportdata)
7. [Workflow and Cell Types](#workflow)

### Abstract & Highlights<a name="Abstract" />

#### Abstract
Hematopoiesis occurs in three consecutive overlapping waves in mammals, regulated by transcription factors. We investigated the role of three relatively poorly studied transcription factors in early embryonic hematopoietic development at single-cell resolution: Atf3, Zfp711 and Bcl6b. These transcription factors are upregulated early in development when hematopoietic and endothelial lineages separate from cardiac and other mesodermal lineages. We combined multiplexed single-cell RNA sequencing and flow cytometric analysis with knockouts in in vitro differentiating mouse embryonic stem cells to dissect the function of these transcription factors in lineage specification. ▵Atf3 cells showed increased mesodermal differentiation but decreased endothelial cells and erythro-myeloid progenitors, accompanied by aberrant interferon signaling. Mechanistically, loss of Atf3 disrupted key hematopoietic regulators (Runx1, Egr1, Jun, Fos, Mafb, Batf3) required for erythro-myeloid progenitors’ formation. ▵Zfp711 cells exhibited increased blood progenitors and erythroid cells but decreased endothelial cells, with a striking shift from Hoxa+ mesoderm (allantois, limb-mesoderm) to Hoxb+ mesoderm (mesenchyme, epicardium). Notably, Zfp711 binds the Atf3 promoter, suggesting a hierarchical regulation. In contrast, ▵Bcl6b had no observable effects on early hematopoiesis despite specific expression in hemato-endothelial progenitors.

#### Article References
**Development**
Ridvan Cetin, Giulia Picco, Jente van Staalduinen, Eric Bindels, Remco Hoogenboezem, Gregory van Beek, Mathijs A. Sanders, Yaren Fidan, Ahmet Korkmaz, Joost Gribnau, Jeffrey van Haren, Danny Huylebroeck, Eskeatnaf Mulugeta, Frank Grosveld; Distinct Roles of Atf3, Zfp711, and Bcl6b in Early Embryonic Hematopoietic and Endothelial Lineage Specification. Development 2025; dev.204792. doi: https://doi.org/10.1242/dev.204792

**bioRxiv**
Single-Cell Roadmap of Early Hemato-Endothelial Development: Functions of Atf3, Zfp711 and Bcl6b
Ridvan Cetin, Giulia Picco, Jente van Staalduinen, Eric Bindels, Remco Hoogenboezem, Gregory van Beek, Mathijs A Sanders, Yaren Fidan, Ahmet Korkmaz, Joost Gribnau, Jeffrey van Haren, Danny Huylebroeck, Eskeatnaf Mulugeta, Frank Grosveld
bioRxiv 2025.02.23.639715; doi: https://doi.org/10.1101/2025.02.23.639715
Now published in Development doi: 10.1242/dev.204792

### Data availability<a name="data" />
scRNA-Seq data generated in this study have been deposited in the European Nucleotide Archive (ENA) database under the accession number E-MTAB-14678.  UCSC browser sessions can be accessible with the following links:
-   [https://genome.ucsc.edu/s/mdrcetin/hg38_ATF3](https://genome.ucsc.edu/s/mdrcetin/hg38_ATF3),
-   [https://genome.ucsc.edu/s/mdrcetin/mm10_Atf3](https://genome.ucsc.edu/s/mdrcetin/mm10_Atf3),
-   [https://genome.ucsc.edu/s/mdrcetin/mm10_Zfp711](https://genome.ucsc.edu/s/mdrcetin/mm10_Zfp711),
-   [https://genome.ucsc.edu/s/mdrcetin/hg19_ZNF711](https://genome.ucsc.edu/s/mdrcetin/hg19_ZNF711),
-   [https://genome.ucsc.edu/s/mdrcetin/hg38_ZNF711](https://genome.ucsc.edu/s/mdrcetin/hg38_ZNF711).
  The data supporting the findings of this study are available from the corresponding author upon reasonable request.

### Explore the data<a name="explore" />

#### Shiny app 

The data can be explored after logging into [shiny app](https://ridvan.shinyapps.io/shinyapp/).

![Shinnyapp Example](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Shiny_example.png?raw=true)

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
Ridvan Cetin: [r.cetin@erasmusmc.nl](r.cetin@erasmusmc.nl) or [mdrcetin@gmail.com](mdrcetin@gmail.com)

### Supporting Data<a name="supportdata" />

1. [Flow Cytometric Analysis Data](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/tree/main/FlowCytometricAnalysis)

### Workflow and Celltypes<a name="workflow" />

##### Workflow

![Workflow](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Figure_s1_v1.png?raw=true)

##### Cell Types

![Cell Types](https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b/blob/main/Cetin_Fig_2.png?raw=true)

###### Affiliations

<sup>1</sup>Department of Cell Biology, Erasmus University Medical Center Rotterdam, Rotterdam, The Netherlands

<sup>2</sup>Department of Hematology, Erasmus University Medical Center Rotterdam, Rotterdam, The Netherlands

<sup>3</sup>Medical Faculty, Institute of Physiology, RWTH Aachen University, Aachen, Germany

<sup>4</sup>Department of Developmental Biology, Erasmus University Medical Center Rotterdam, Rotterdam, the Netherlands

<sup>*</sup>Corresponding author
   
-----
The design of this page was inspired by https://marionilab.github.io/ExtendedMouseAtlas/ .
