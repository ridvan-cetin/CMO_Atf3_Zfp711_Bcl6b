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

e.g., This data is an extension of a previously reported scRNA-Seq atlas covering mouse gastrulation and the early initiation of organogenesis through a densely sampled time-course of 6h sampling intervals from E6.5 to E8.5 (Pijuan-Sala B., Griffiths J. A., Guibentif C. et al., 2019) with newly sampled time points (E8.75-E9.5) as well as one overlapping time point (E8.5) to facilitate data integration. Combined, the new ‘extended’ atlas, ranging from E6.5 to E9.5 contains 430,339 cells across 13 time points spanning 3 days of mouse development 

e.g.,  Various forms of the transcriptomics data such as raw counts, normalised counts, dimensionality reductions and metadata are available [here](https://cloud.mrc-lmb.cam.ac.uk/s/yxq7FRtYsLyF3jQ) for loading into R and python. 


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

not gonna work for me. This data can be explored and downloaded from the [UCSC cell browser](https://cells-test.gi.ucsc.edu/?ds=ext-mouse-atlas). 

### Code availability<a name="code" />

To be added soon.


### Support or Contact<a name="contact" />

General queries can be directed to [Bertie Göttgens](mailto:bg200@cam.ac.uk) , [John Marioni](mailto:marioni@ebi.ac.uk). For issues relating to the data or code, you can email Ivan Imaz-Rosshandler at [ivanir@mrc-lmb.cam.ac.uk](mailto:ivanir@mrc-lmb.cam.ac.uk).


### Other links<a name="links" />



###### Affiliations

1. *Department of Haematology, University of Cambridge, Cambridge CB2 0RE, UK*

2. *Wellcome-Medical Research Council Cambridge Stem Cell Institute, University of Cambridge, Cambridge CB2 0AW, UK*

3. *MRC Laboratory of Molecular Biology, Cambridge CB2 0QH, UK*

4. *MRC Molecular Haematology Unit, MRC Weatherall Institute of Molecular Medicine, Radcliffe Department of Medicine, University of Oxford, Oxford OX3 9DS, UK*

5. *Department of Microbiology and Immunology, University of Gothenburg, Gothenburg, Sweden*

6. *Department of Zoology, University of Cambridge, Cambridge CB2 3EJ, UK*

7. *Wellcome Sanger Institute, Wellcome Genome Campus, Saffron Walden CB10 1SA, UK*

8. *European Molecular Biology Laboratory, European Bioinformatics Institute, Saffron Walden CB10 1SA, UK*

9. *Cancer Research UK Cambridge Institute, University of Cambridge, Cambridge CB2 0RE, UK*

10. *Division of Molecular Hematology, Lund Stem Cell Center, Lund University, Sweden*

11. *Epigenetics Programme, Babraham Institute, Cambridge CB22 3AT, UK*

12. *Altos Labs Cambridge Institute, Granta Park, Cambridge, CB21 6GP, UK*



<sup>1</sup>Department of Cell Biology, Erasmus University Medical Center Rotterdam, Rotterdam, The Netherlands 
<sup>2</sup>Department of Hematology, Erasmus University Medical Center Rotterdam, Rotterdam, The Netherlands
<sup>3</sup>Medical Faculty, Institute of Physiology, RWTH Aachen University, Aachen, Germany
<sup>4</sup>Department of Developmental Biology, Erasmus University Medical Center Rotterdam, Rotterdam, the Netherlands
<sup>*</sup>Corresponding author
   
