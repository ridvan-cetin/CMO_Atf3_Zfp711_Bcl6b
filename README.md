# CMO_Atf3_Zfp711_Bcl6b

Bioinformatics analysis code and supporting resources for:

**Cetin R, Picco G, van Staalduinen J, et al. (2025)**  
**Distinct roles of Atf3, Zfp711 and Bcl6b in early embryonic hematopoietic and endothelial lineage specification.** *Development* **152**(23): dev204792. https://doi.org/10.1242/dev.204792

## Key Links

- **Published article (Development):**
  - https://journals.biologists.com/dev/article/152/23/dev204792/370054/Distinct-roles-of-Atf3-Zfp711-and-Bcl6b-in-early
  - DOI: https://doi.org/10.1242/dev.204792

- **Preprint (bioRxiv):**
  - https://www.biorxiv.org/content/10.1101/2025.02.23.639715v1
  - DOI: https://doi.org/10.1101/2025.02.23.639715

- **Project website (GitHub Pages):**
  - https://ridvan-cetin.github.io/CMO_Atf3_Zfp711_Bcl6b/

- **Interactive single-cell explorer (Shiny):**
  - https://ridvan.shinyapps.io/shinyapp/

## Repository Structure

```
CMO_Atf3_Zfp711_Bcl6b/
├── Organized/                    # Annotated analysis scripts (recommended)
├── Original_code/                # Original unmodified scripts
├── FlowCytometricAnalysis_data/  # FACS analysis input data
└── support_site/                 # GitHub Pages website files
```

## Analysis Codes

All analysis scripts are available in two versions:
- **`Organized/`** — Annotated scripts with detailed documentation (recommended)
- **`Original_code/`** — Original scripts as used during analysis

### Code Summary

| File | Description |
|------|-------------|
| **Step 1: Demultiplexing** |
| `code_001_demultiplexing.Rmd` | Demultiplexes pooled scRNA-seq samples using Cell Multiplexing Oligos (CMO) with deMULTIplex2 and assigns cells to experimental conditions (Control, Atf3-KO, Zfp711-KO, Bcl6b-KO). |
| **Step 2: Preprocessing** |
| `code_002_preprocessing.Rmd` | Performs quality control filtering, normalization, dimensionality reduction (PCA/UMAP), and Leiden clustering on the demultiplexed CMO dataset. |
| **Step 3-4: Differential Abundance Analysis** |
| `code_003_DAA_speckle.Rmd` | Conducts differential abundance analysis using speckle to identify cell type proportion changes between KO conditions and control using beta-binomial regression. |
| `code_004_DAA_miloR.Rmd` | Performs neighborhood-based differential abundance analysis using MiloR to detect local composition changes in the single-cell manifold between conditions. |
| **Step 5: Differential Gene Expression** |
| `code_005_DGEA_DESeq2.Rmd` | Executes differential gene expression analysis using DESeq2 with pseudobulk aggregation to identify genes dysregulated in each KO condition. |
| **Step 6: Cluster Markers** |
| `code_006_unique_clustermarkers.Rmd` | Identifies cluster-specific marker genes using Seurat's FindAllMarkers to characterize cell type identities across the dataset. |
| **Step 7: Pathway Analysis** |
| `code_007_GSEA.Rmd` | Performs Gene Set Enrichment Analysis using clusterProfiler to identify enriched biological pathways in differentially expressed genes from each KO condition. |
| **Step 8: Flow Cytometry Statistics** |
| `code_008_FCA_Statistics.Rmd` | Analyzes flow cytometry data with mixed-effects models to quantify cell population differences between KO and control conditions across biological replicates. |
| **Step 9: DEG Categorization** |
| `code_009_DEGs_categorization.Rmd` | Categorizes differentially expressed genes by direction (up/down) and identifies shared vs unique DEGs across the three KO conditions. |
| **Step 10: Cell Type Mapping** |
| `code_010_CMO_mapping_1.ipynb` | Maps CMO cells to the Mouse Gastrulation Atlas using Seurat's TransferData to assign in vivo cell type identities to in vitro differentiated cells. |
| `code_010_CMO_renaming_2.ipynb` | Refines cell type annotations by consolidating mapped labels into biologically meaningful cluster names at multiple resolution levels. |
| `code_010_CMO_renaming_3.ipynb` | Further refines annotations with consensus voting across multiple mapping parameter combinations (variable features × PCA dimensions). |
| `code_010_CMO_renaming_4.ipynb` | Finalizes cell type nomenclature and creates publication-ready annotation columns for the CMO dataset. |
| `code_010_-11_everything_mapping_slingshot_crushed.ipynb` | Comprehensive visualization notebook generating publication figures for cell type mapping and Slingshot trajectory analysis results. |
| **Step 11: Slingshot Trajectory (Atlas)** |
| `code_011_Slingshot_atlas_1.ipynb` | Performs Slingshot trajectory inference on the Mouse Gastrulation Atlas to define reference developmental lineages from epiblast to terminal cell types. |
| `code_011_slingshot_utils.R` | Utility functions for Slingshot visualization including UMAP overlays, pseudotime coloring, and gene expression along trajectories. |
| **Step 12: FACS Visualization** |
| `code_012_Atf3_FACS.ipynb` | Visualizes flow cytometry results for Atf3-KO vs Control with publication-quality boxplots and mixed-effects statistical annotations. |
| `code_012_Bcl6b_FACS_Figures.ipynb` | Generates FACS visualization figures for Bcl6b-KO vs NT-WT comparison across 28 cell surface marker populations. |
| `code_012_Zfp711_FACS_new_plots.ipynb` | Creates FACS visualization figures for Zfp711-KO vs NT-WT comparison with identical workflow to Atf3 and Bcl6b notebooks. |
| **Step 13: Pseudotime Analysis** |
| `code_013_Prepfor_pseudotime.ipynb` | Prepares data for pseudotime analysis by defining trajectory endpoints, subsetting conditions, and exporting Seurat objects to H5AD format for Python tools. |
| `code_013_Prepfor_pseudotime_part2.Rmd` | Interactively selects specific endpoint cells in the Atlas using CellSelector for precise Slingshot trajectory inference. |
| `code_013_Palantir_Part1.ipynb` | Runs Palantir pseudotime analysis on the Mouse Gastrulation Atlas with diffusion maps, MAGIC imputation, and gene trend computation. |
| `code_013_Palantor_Part2.ipynb` | Applies Palantir trajectory inference to the CMO in vitro dataset to compare developmental dynamics with the in vivo Atlas reference. |
| `code_013_slingshot_1_ipynb.ipynb` | Performs Slingshot trajectory analysis on CMO data with lineage inference, curve fitting, and gene expression visualization along pseudotime. |
| `code_013_slingshot_utils.R` | Utility functions for CMO-specific Slingshot analysis including pseudotime visualization and lineage-specific gene expression plotting. |
| **Step 14: Transcription Factor Analysis** |
| `code_014_EMP_TFs_.ipynb` | Identifies EMP-specific transcription factors by cross-referencing marker genes from three datasets (CMO, Multiome, Atlas) with the AnimalTFDB4 database. |
| **Step 15: Publication Figures** |
| `code_015_figs.Rmd` | Generates publication-quality figures including Hox gene DotPlots, marker gene heatmaps, and annotated UMAP visualizations for the manuscript. |

## Data Availability

- **scRNA-seq data:** BioStudies / ArrayExpress accession **E-MTAB-14678**  
  https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-14678

- **UCSC browser sessions (as referenced in the manuscript):**
  - https://genome.ucsc.edu/s/mdrcetin/hg38_ATF3
  - https://genome.ucsc.edu/s/mdrcetin/mm10_Atf3
  - https://genome.ucsc.edu/s/mdrcetin/mm10_Zfp711
  - https://genome.ucsc.edu/s/mdrcetin/hg19_ZNF711
  - https://genome.ucsc.edu/s/mdrcetin/hg38_ZNF711

## How to Use

### Option A — Browse results without running code
- Start with the manuscript-support website: https://ridvan-cetin.github.io/CMO_Atf3_Zfp711_Bcl6b/
- Explore the processed single-cell data via Shiny: https://ridvan.shinyapps.io/shinyapp/

### Option B — Re-run analyses locally
1. Clone the repository:
   ```bash
   git clone https://github.com/ridvan-cetin/CMO_Atf3_Zfp711_Bcl6b.git
   cd CMO_Atf3_Zfp711_Bcl6b
   ```

2. Open the scripts in `Organized/` and run them in order (001 → 015).

3. Some scripts assume local paths and/or large intermediate files (e.g., Cell Ranger outputs) that are not stored in GitHub. Update paths at the top of each notebook/script to match your system.

## How to Cite

### Published Article

Cetin R, Picco G, van Staalduinen J, Bindels E, Hoogenboezem R, van Beek G, Sanders MA, Fidan Y, Korkmaz A, Gribnau J, van Haren J, Huylebroeck D, Mulugeta E, Grosveld F.
Distinct roles of Atf3, Zfp711 and Bcl6b in early embryonic hematopoietic and endothelial lineage specification. *Development* (2025) 152(23): dev204792. https://doi.org/10.1242/dev.204792

### Preprint

Cetin R, Picco G, van Staalduinen J, Bindels E, Hoogenboezem R, van Beek G, Sanders MA, Fidan Y, Korkmaz A, Gribnau J, van Haren J, Huylebroeck D, Mulugeta E, Grosveld F.
Single-Cell Roadmap of Early Hemato-Endothelial Development: Functions of Atf3, Zfp711 and Bcl6b. *bioRxiv* (2025). https://doi.org/10.1101/2025.02.23.639715
