# Cmo_Atf3_Zfp711_Bcl6b

Bioinformatics analysis code and supporting resources for:

**Cetin R, Picco G, van Staalduinen J, et al. (2025)**  
**Distinct roles of Atf3, Zfp711 and Bcl6b in early embryonic hematopoietic and endothelial lineage specification.** *Development* **152**(23): dev204792. https://doi.org/10.1242/dev.204792

## Key links

- **Published article (Development):** https://journals.biologists.com/dev/article/152/23/dev204792/370054/Distinct-roles-of-Atf3-Zfp711-and-Bcl6b-in-early  
  DOI: https://doi.org/10.1242/dev.204792

- **Preprint (bioRxiv):** https://www.biorxiv.org/content/10.1101/2025.02.23.639715v1  
  DOI: https://doi.org/10.1101/2025.02.23.639715

- **Project website (GitHub Pages):** https://ridvan-cetin.github.io/CMO_Atf3_Zfp711_Bcl6b/

- **Interactive single-cell explorer (Shiny):** https://ridvan.shinyapps.io/shinyapp/

## What is in this repository

This repository contains the analysis notebooks/scripts used to process and analyze multiplexed single-cell RNA-seq and flow cytometry data generated from in vitro differentiating mouse ESCs, including KO vs WT comparisons for **Atf3**, **Zfp711**, and **Bcl6b**.

Primary analysis “entry points” (linked files are in `Analysis_Codes/`):


Primary analysis “entry points” (linked files are in `Analysis_Codes/`):

1. **Demultiplexing:** [`Analysis_Codes/1_demultiplexing.Rmd`](Analysis_Codes/1_demultiplexing.Rmd)  
2. **Preprocessing:** [`Analysis_Codes/2_preprocessing.Rmd`](Analysis_Codes/2_preprocessing.Rmd)  
3. **Differential abundance (propeller/speckle):** [`Analysis_Codes/3_DAA_speckle.Rmd`](Analysis_Codes/3_DAA_speckle.Rmd)  
4. **Differential abundance (miloR):** [`Analysis_Codes/4_DAA_miloR.Rmd`](Analysis_Codes/4_DAA_miloR.Rmd)  
5. **Differential gene expression (pseudobulk / DESeq2):** [`Analysis_Codes/5_DGEA_DESeq2.Rmd`](Analysis_Codes/5_DGEA_DESeq2.Rmd)  
6. **Gene set enrichment analysis:** [`Analysis_Codes/7_GSEA.Rmd`](Analysis_Codes/7_GSEA.Rmd)  
7. **Statistics for flow cytometry results:** [`Analysis_Codes/8_FCA_Statistics.Rmd`](Analysis_Codes/8_FCA_Statistics.Rmd)  
8. **Categorization of DEGs:** [`Analysis_Codes/9_DEGs_categorization.Rmd`](Analysis_Codes/9_DEGs_categorization.Rmd)

Additional notebooks in the repository include mapping/renaming steps and trajectory/pseudotime analyses (e.g., Slingshot/Palantir) used for figure generation.

## Data availability

- **scRNA-seq data:** BioStudies / ArrayExpress accession **E-MTAB-14678**  
  https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-14678

- **UCSC browser sessions (as referenced in the manuscript):**
  - https://genome.ucsc.edu/s/mdrcetin/hg38_ATF3
  - https://genome.ucsc.edu/s/mdrcetin/mm10_Atf3
  - https://genome.ucsc.edu/s/mdrcetin/mm10_Zfp711
  - https://genome.ucsc.edu/s/mdrcetin/hg19_ZNF711
  - https://genome.ucsc.edu/s/mdrcetin/hg38_ZNF711
  
## How to use

### Option A — Browse results without running code
- Start with the manuscript-support website: https://ridvan-cetin.github.io/CMO_Atf3_Zfp711_Bcl6b/
- Explore the processed single-cell data via Shiny: https://ridvan.shinyapps.io/shinyapp/

### Option B — Re-run analyses locally
1. Clone the repository:
   ```bash
   git clone https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b.git
   cd CMO_Atf3_Zfp711_Bcl6b

2. Open the R Markdown files in Analysis_Codes/ and run them in order (1 → 9).

3. Some scripts/notebooks assume local paths and/or large intermediate files (e.g., Cell Ranger outputs) that are not stored in GitHub. Update paths at the top of each notebook/script to match your system.

How to cite
Published article

Cetin R, Picco G, van Staalduinen J, Bindels E, Hoogenboezem R, van Beek G, Sanders MA, Fidan Y, Korkmaz A, Gribnau J, van Haren J, Huylebroeck D, Mulugeta E, Grosveld F.
Distinct roles of Atf3, Zfp711 and Bcl6b in early embryonic hematopoietic and endothelial lineage specification. Development (2025) 152(23): dev204792. https://doi.org/10.1242/dev.204792

Preprint

Cetin R, Picco G, van Staalduinen J, Bindels E, Hoogenboezem R, van Beek G, Sanders MA, Fidan Y, Korkmaz A, Gribnau J, van Haren J, Huylebroeck D, Mulugeta E, Grosveld F.
Single-Cell Roadmap of Early Hemato-Endothelial Development: Functions of Atf3, Zfp711 and Bcl6b. bioRxiv (2025). https://doi.org/10.1101/2025.02.23.639715


Publication metadata (journal/volume/article ID/DOIs) verified against the journal page and PubMed record. :contentReference[oaicite:0]{index=0}  
Preprint metadata (title/authors/DOI) verified via DOI-indexed record and the project website. :contentReference[oaicite:1]{index=1}  
Data accession link verified via the BioStudies/ArrayExpress landing page. :contentReference[oaicite:2]{index=2}
::contentReference[oaicite:3]{index=3}
