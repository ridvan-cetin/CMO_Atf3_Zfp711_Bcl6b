# ==============================================================================
# SLINGSHOT UTILITY FUNCTIONS FOR CMO TRAJECTORY ANALYSIS
# ==============================================================================
# Purpose: Custom visualization functions for Slingshot trajectory analysis
# Dependencies: Matrix, ggplot2, ggrastr, slingshot, viridis, fields
# ==============================================================================


# ==============================================================================
# FUNCTION 1: plot_umap_lineages_with_centroids
# ==============================================================================
# Purpose: Visualize Slingshot lineages overlaid on UMAP with cluster centroids
# 
# Parameters:
#   seurat_obj  - Seurat object with dimensional reduction
#   reduction   - Name of reduction to use (default: "umap2d")
#   cluster_col - Metadata column with cluster labels
#   color_vector - Named vector of colors for clusters
#   lineages    - SlingshotDataSet object from getLineages()
#   point_cex   - Point size (default: 0.5)
#   line_lwd    - Lineage line width (default: 1)
#   label_cex   - Label text size (default: 0.8)
#
# Returns: Base R plot with UMAP, lineages, and cluster centroids
# ==============================================================================

plot_umap_lineages_with_centroids <- function(
  seurat_obj,
  reduction = "umap2d",
  cluster_col = "cell_type_subclusters",
  color_vector = r3dcol$cols_94,
  lineages,
  point_cex = 0.5,
  line_lwd = 1,
  label_cex = 0.8
) {
  require(Matrix)
  
  # Extract UMAP coordinates from specified reduction
  umap_coords <- seurat_obj@reductions[[reduction]]@cell.embeddings
  
  # Get cluster labels as factor
  clusters <- as.factor(seurat_obj[[cluster_col]][, 1])
  colnames_umap <- levels(clusters)
  
  # Subset color vector to match cluster levels
  color_vector <- color_vector[seq_along(colnames_umap)]
  names(color_vector) <- colnames_umap
  
  # ------------------------------------------------------------------------------
  # Calculate cluster centroids using sparse matrix multiplication
  # ------------------------------------------------------------------------------
  # sparse.model.matrix(): Create design matrix (cells x clusters)
  # t(umap_coords) %*% mm: Sum coordinates per cluster
  # / Matrix::colSums(mm): Divide by cluster size for mean
  mm <- sparse.model.matrix(~ 0 + clusters)
  colnames(mm) <- levels(clusters)
  centroids2d <- as.matrix(t(t(umap_coords) %*% mm) / Matrix::colSums(mm))
  
  # Set lineage embedding to match UMAP coordinates for visualization
  lineages@reducedDim <- umap_coords
  
  # ------------------------------------------------------------------------------
  # Generate plot
  # ------------------------------------------------------------------------------
  plot(
    umap_coords,
    col = color_vector[clusters],
    cex = point_cex,
    pch = 16,
    xlab = "UMAP 1", ylab = "UMAP 2",
    main = "UMAP with Slingshot Lineages & Cluster Centroids"
  )
  
  # Overlay lineage paths (black lines)
  lines(lineages, lwd = line_lwd, col = "black", cex = 2)
  
  # Add cluster labels at centroid positions
  text(centroids2d, labels = rownames(centroids2d), cex = label_cex, font = 2, col = "black")
}


# ==============================================================================
# FUNCTION 2: plot_umap_with_curves
# ==============================================================================
# Purpose: Visualize smooth principal curves from Slingshot on UMAP
#
# Parameters:
#   seurat_obj  - Seurat object with dimensional reduction
#   reduction   - Name of reduction to use (default: "umap2d")
#   cluster_col - Metadata column with cluster labels
#   color_vector - Named vector of colors for clusters
#   curves      - SlingshotDataSet object from getCurves()
#   label_cex   - Label text size (default: 1)
#   point_pch   - Point shape (default: 16)
#   point_cex   - Point size (default: 1)
#   line_lwd    - Curve line width (default: 2)
#
# Returns: Base R plot with UMAP, smooth curves, and cluster labels
# ==============================================================================

plot_umap_with_curves <- function(
  seurat_obj,
  reduction = "umap2d",
  cluster_col = "cell_type_subclusters",
  color_vector = r3dcol$cols_94,
  curves,
  label_cex = 1,
  point_pch = 16,
  point_cex = 1,
  line_lwd = 2
) {
  # Get UMAP coordinates
  umap_coords <- seurat_obj@reductions[[reduction]]@cell.embeddings
  clusters <- as.factor(seurat_obj[[cluster_col]][, 1])
  
  # Calculate cluster centroids (same method as Function 1)
  mm <- Matrix::sparse.model.matrix(~ 0 + clusters)
  colnames(mm) <- levels(clusters)
  centroids2d <- as.matrix(t(t(umap_coords) %*% mm) / Matrix::colSums(mm))
  
  # Generate plot with cells colored by cluster
  plot(
    umap_coords,
    col = color_vector[clusters],
    pch = point_pch,
    cex = point_cex,
    xlab = "UMAP 1", ylab = "UMAP 2",
    main = "UMAP with Lineages and Cluster Labels"
  )
  
  # Overlay smooth curves (black lines)
  lines(curves, lwd = line_lwd, col = "black")
  
  # Add cluster labels at centroid positions
  text(
    centroids2d,
    labels = levels(clusters),
    cex = label_cex,
    font = 2
  )
}


# ==============================================================================
# FUNCTION 3: plot_umap_pseudotime_and_centroids
# ==============================================================================
# Purpose: Visualize pseudotime values on UMAP with viridis color scale
#
# Parameters:
#   seurat_obj   - Seurat object with dimensional reduction
#   curves       - SlingshotDataSet object from getCurves()
#   embedding    - Name of reduction to use (default: "UMAP")
#   cluster_col  - Metadata column with cluster labels
#   color_vector - Named vector of colors for clusters (for centroids)
#   point_cex    - Point size (default: 0.4)
#   label_cex    - Label text size (default: 1)
#   legend_title - Title for pseudotime colorbar (default: "Pseudotime")
#   legend_mar   - Legend margin (default: 7)
#
# Returns: Base R plot with pseudotime coloring and cluster centroids
# ==============================================================================

plot_umap_pseudotime_and_centroids <- function(
  seurat_obj,
  curves,
  embedding = "UMAP",
  cluster_col = "cell_type_subclusters",
  color_vector = r3dcol$cols_94,
  point_cex = 0.4,
  label_cex = 1,
  legend_title = "Pseudotime",
  legend_mar = 7
) {
  require(viridis)
  require(fields)
  require(slingshot)
  require(Matrix)
  
  # ------------------------------------------------------------------------------
  # Extract pseudotime from curves object
  # ------------------------------------------------------------------------------
  # slingPseudotime(): Returns cells x lineages matrix of pseudotime values
  # na = FALSE: Include cells with NA pseudotime
  pseudotime <- slingPseudotime(curves, na = FALSE)
  pal_viridis <- viridis(100, end = 0.95)
  
  # ------------------------------------------------------------------------------
  # Calculate average pseudotime per cell and normalize to 0-1
  # ------------------------------------------------------------------------------
  x <- rowMeans(pseudotime)         # Average across all lineages
  x <- x / max(x, na.rm = TRUE)     # Normalize to 0-1 range
  
  # Sort cells by pseudotime for proper overplotting
  # (cells with higher pseudotime plotted last)
  o <- order(x)
  
  # Map normalized pseudotime to color palette index
  col_idx <- as.integer(x[o] * (length(pal_viridis) - 1)) + 1
  
  # ------------------------------------------------------------------------------
  # Get embedding coordinates and cluster info
  # ------------------------------------------------------------------------------
  umap_coords <- seurat_obj@reductions[[embedding]]@cell.embeddings
  clusters <- as.factor(seurat_obj[[cluster_col]][, 1])
  cluster_levels <- levels(clusters)
  
  # Ensure colors are named and in order
  color_vector <- color_vector[seq_along(cluster_levels)]
  names(color_vector) <- cluster_levels
  
  # Calculate cluster centroids
  mm <- Matrix::sparse.model.matrix(~ 0 + clusters)
  colnames(mm) <- cluster_levels
  centroids2d <- as.matrix(t(t(umap_coords) %*% mm) / Matrix::colSums(mm))
  
  # ------------------------------------------------------------------------------
  # Generate pseudotime scatter plot
  # ------------------------------------------------------------------------------
  # Plot cells ordered by pseudotime (colored by viridis palette)
  plot(
    umap_coords[o, , drop = FALSE],
    main = legend_title, pch = 16, cex = point_cex, axes = FALSE, xlab = "", ylab = "",
    col = pal_viridis[col_idx]
  )
  
  # Overlay cluster centroids with cluster-specific colors
  points(centroids2d, cex = 2.5, pch = 16, col = color_vector)
  text(centroids2d, labels = cluster_levels, cex = label_cex, font = 2)
  
  # ------------------------------------------------------------------------------
  # Add pseudotime color bar legend
  # ------------------------------------------------------------------------------
  # fields::image.plot(): Creates colorbar legend
  fields::image.plot(
    legend.only = TRUE,
    zlim = range(x, na.rm = TRUE),
    col = pal_viridis,
    legend.args = list(text = legend_title, side = 1, font = 2, line = 2),
    legend.mar = legend_mar,
    legend.width = 1
  )
}


# ==============================================================================
# FUNCTION 4: plot_gene_specific_lineage_nozeros
# ==============================================================================
# Purpose: Plot gene expression along pseudotime for a specific lineage,
#          excluding zero-expression cells
#
# Parameters:
#   atlas          - Seurat object (named 'atlas' for consistency)
#   curves         - SlingshotDataSet object from getCurves()
#   gene           - Gene name to plot
#   lineage        - Lineage name (e.g., "Lineage1")
#   lineages       - SlingshotDataSet object from getLineages()
#   vertical_shift - Y-axis shift for loess fit (default: 0)
#
# Returns: ggplot object with expression vs pseudotime scatter + loess fit
# ==============================================================================

plot_gene_specific_lineage_nozeros <- function(
  atlas, curves,  gene, lineage, lineages, 
  vertical_shift = 0
) {
  library(ggplot2)
  library(ggrastr)
  require(slingshot)

  # ------------------------------------------------------------------------------
  # Set up cluster colors
  # ------------------------------------------------------------------------------
  cluster_levels <- levels(atlas$cell_type_subclusters)
  cluster_colors <- c(r3dcol$cols_94)
  names(cluster_colors) <- cluster_levels

  # ------------------------------------------------------------------------------
  # Extract pseudotime and cell weights
  # ------------------------------------------------------------------------------
  pseudotime <- slingPseudotime(curves, na = FALSE)
  cell_weights <- slingCurveWeights(curves)
  
  # Get weights for the specified lineage
  weights <- cell_weights[, lineage]
  
  # Select cells with positive weight and valid pseudotime
  cells <- names(weights)[weights > 0 & !is.na(pseudotime[, lineage])]
  if (length(cells) == 0) stop("No cells with high confidence in this lineage.")
  
  # ------------------------------------------------------------------------------
  # Build data frame for plotting
  # ------------------------------------------------------------------------------
  df <- data.frame(
    pseudotime = pseudotime[cells, lineage],
    expr = FetchData(atlas, vars = gene)[cells, 1],  # Get expression values
    cluster = as.character(atlas$cell_type_subclusters[cells]),
    cell = cells
  )
  df$cluster <- factor(df$cluster, levels = names(cluster_colors))
  
  # Filter to clusters that are part of this lineage
  clusters_of_interest <- lineages@lineages[[lineage]]
  df_sub <- df[df$cluster %in% clusters_of_interest, ]
  
  # ------------------------------------------------------------------------------
  # REMOVE zero expression cells
  # ------------------------------------------------------------------------------
  # Key step: excludes cells with no detectable expression
  df_sub <- df_sub[df_sub$expr != 0, ]
  
  # Get endpoint cluster for plot title
  endpoint_cluster <- tail(clusters_of_interest, 1)
  main_title <- paste0(endpoint_cluster, " Trajectory")
  
  # ------------------------------------------------------------------------------
  # Fit loess smooth on non-zero expression values
  # ------------------------------------------------------------------------------
  # loess(): Local polynomial regression for smoothing
  # span = 0.5: Moderate smoothing (0-1 range)
  loess_fit <- loess(expr ~ pseudotime, data = df_sub, span = 0.5)
  loess_df <- data.frame(
    pseudotime = df_sub$pseudotime,
    expr_smooth = predict(loess_fit) + vertical_shift
  )
  loess_df <- loess_df[order(loess_df$pseudotime), ]

  # ------------------------------------------------------------------------------
  # Generate ggplot
  # ------------------------------------------------------------------------------
  ggplot(df_sub, aes(x = pseudotime, y = expr, color = cluster)) +
    # Rasterized points for efficient rendering
    ggrastr::geom_point_rast(size = 2, alpha = 1) +
    
    # Loess smooth line (black)
    geom_line(data = loess_df, aes(x = pseudotime, y = expr_smooth),
              inherit.aes = FALSE, color = "black", size = 1.2) +
    
    # Cluster-specific colors
    scale_color_manual(values = cluster_colors, name = "Cluster") +
    
    # Larger legend points
    guides(color = guide_legend(override.aes = list(size = 5))) +
    
    # Labels
    labs(
      title = main_title,
      x = "pseudotime",
      y = paste(gene, "expression")
    ) +
    
    # Theme
    theme_classic(base_size = 16) +
    theme(
      plot.title = element_text(size = 22, face = "plain", hjust = 0.5, vjust = 1),
      legend.text = element_text(size = 17),
      legend.title = element_text(size = 20,  vjust = 0.5)
    )
}

