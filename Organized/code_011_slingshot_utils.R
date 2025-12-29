# ==============================================================================
# SLINGSHOT UTILITY FUNCTIONS
# ==============================================================================
# Custom visualization functions for Slingshot trajectory analysis
# Used with Seurat objects for single-cell trajectory inference
#
# Dependencies: Matrix, ggplot2, ggrastr, slingshot, viridis, fields
# ==============================================================================

## Some functions




# ==============================================================================
# FUNCTION: plot_umap_lineages_with_centroids
# ==============================================================================
# Purpose: Visualize Slingshot lineages overlaid on UMAP with cluster centroids
#
# Parameters:
#   seurat_obj    : Seurat object with dimensionality reduction
#   reduction     : Name of reduction to use (default: "umap2d")
#   cluster_col   : Metadata column containing cluster identities
#   color_vector  : Named color vector for clusters
#   lineages      : SlingshotDataSet object from getLineages()
#   point_cex     : Point size for cells
#   line_lwd      : Line width for lineage curves
#   label_cex     : Label size for cluster names
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
  
  # Extract UMAP coordinates from Seurat reduction
  umap_coords <- seurat_obj@reductions[[reduction]]@cell.embeddings
  # Get cluster assignments as factor
  clusters <- as.factor(seurat_obj[[cluster_col]][, 1])
  colnames_umap <- levels(clusters)
  # Subset and name color vector to match clusters
  color_vector <- color_vector[seq_along(colnames_umap)]
  names(color_vector) <- colnames_umap
  
  # Calculate cluster centroids using sparse matrix multiplication
  # sparse.model.matrix creates indicator matrix for cluster membership
  mm <- sparse.model.matrix(~ 0 + clusters)
  colnames(mm) <- levels(clusters)
  # Weighted average of coordinates per cluster
  centroids2d <- as.matrix(t(t(umap_coords) %*% mm) / Matrix::colSums(mm))
  
  # Set lineage embedding to match UMAP coordinates
  lineages@reducedDim <- umap_coords
  
  # Generate plot with cells colored by cluster
  plot(
    umap_coords,
    col = color_vector[clusters],
    cex = point_cex,
    pch = 16,
    xlab = "UMAP 1", ylab = "UMAP 2",
    main = "UMAP with Slingshot Lineages & Cluster Centroids"
  )
  # Overlay lineage curves
  lines(lineages, lwd = line_lwd, col = "black", cex = 2)
  # Add cluster labels at centroid positions
  text(centroids2d, labels = rownames(centroids2d), cex = label_cex, font = 2, col = "black")
}


# ==============================================================================
# FUNCTION: plot_umap_with_curves
# ==============================================================================
# Purpose: Visualize smooth principal curves from Slingshot on UMAP
#
# Parameters:
#   seurat_obj    : Seurat object with dimensionality reduction
#   reduction     : Name of reduction to use (default: "umap2d")
#   cluster_col   : Metadata column containing cluster identities
#   color_vector  : Named color vector for clusters
#   curves        : SlingshotDataSet object from getCurves()
#   label_cex     : Label size for cluster names
#   point_pch     : Point character (default: 16 = filled circle)
#   point_cex     : Point size for cells
#   line_lwd      : Line width for curves
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
  
  # Calculate cluster centroids using sparse matrix multiplication
  mm <- Matrix::sparse.model.matrix(~ 0 + clusters)
  colnames(mm) <- levels(clusters)
  centroids2d <- as.matrix(t(t(umap_coords) %*% mm) / Matrix::colSums(mm))
  
  # Generate plot
  plot(
    umap_coords,
    col = color_vector[clusters],
    pch = point_pch,
    cex = point_cex,
    xlab = "UMAP 1", ylab = "UMAP 2",
    main = "UMAP with Lineages and Cluster Labels"
  )
  # Overlay smooth curves from getCurves()
  lines(curves, lwd = line_lwd, col = "black")
  # Add cluster labels at centroids
  text(
    centroids2d,
    labels = levels(clusters),
    cex = label_cex,
    font = 2
  )
}


# ==============================================================================
# FUNCTION: plot_umap_pseudotime_and_centroids
# ==============================================================================
# Purpose: Visualize pseudotime values on UMAP with viridis color scale
#
# Parameters:
#   seurat_obj    : Seurat object with dimensionality reduction
#   curves        : SlingshotDataSet object from getCurves()
#   embedding     : Name of reduction to use (default: "UMAP")
#   cluster_col   : Metadata column containing cluster identities
#   color_vector  : Named color vector for centroid points
#   point_cex     : Point size for cells
#   label_cex     : Label size for cluster names
#   legend_title  : Title for color bar legend
#   legend_mar    : Margin for legend placement
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
  
  # 1. Extract pseudotime values from curves object
  # slingPseudotime returns matrix: cells x lineages
  pseudotime <- slingPseudotime(curves, na = FALSE)
  # Create viridis color palette
  pal_viridis <- viridis(100, end = 0.95)
  
  # 2. Calculate average pseudotime per cell across all lineages
  # Normalize to 0-1 range for color mapping
  x <- rowMeans(pseudotime)
  x <- x / max(x, na.rm = TRUE)
  # Sort cells by pseudotime for proper overplotting
  o <- order(x)
  # Map normalized values to color palette indices
  col_idx <- as.integer(x[o] * (length(pal_viridis) - 1)) + 1
  
  # 3. Get embedding coordinates and cluster info
  umap_coords <- seurat_obj@reductions[[embedding]]@cell.embeddings
  clusters <- as.factor(seurat_obj[[cluster_col]][, 1])
  cluster_levels <- levels(clusters)
  
  # 4. Prepare color vector for cluster centroids
  color_vector <- color_vector[seq_along(cluster_levels)]
  names(color_vector) <- cluster_levels
  
  # 5. Calculate cluster centroids
  mm <- Matrix::sparse.model.matrix(~ 0 + clusters)
  colnames(mm) <- cluster_levels
  centroids2d <- as.matrix(t(t(umap_coords) %*% mm) / Matrix::colSums(mm))
  
  # 6. Plot cells colored by pseudotime (ordered so late cells on top)
  plot(
    umap_coords[o, , drop = FALSE],
    main = legend_title, pch = 16, cex = point_cex, axes = FALSE, xlab = "", ylab = "",
    col = pal_viridis[col_idx]
  )
  
  # 7. Overlay cluster centroids with cluster-specific colors
  points(centroids2d, cex = 2.5, pch = 16, col = color_vector)
  text(centroids2d, labels = cluster_levels, cex = label_cex, font = 2)
  
  # 8. Add pseudotime color bar legend using fields package
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
# FUNCTION: plot_gene_specific_lineage_nozeros
# ==============================================================================
# Purpose: Plot gene expression along pseudotime for a specific lineage
#          Excludes cells with zero expression from visualization
#
# Parameters:
#   atlas         : Seurat object with expression data
#   curves        : SlingshotDataSet object from getCurves()
#   gene          : Gene name to plot
#   lineage       : Lineage name (e.g., "Lineage1")
#   lineages      : SlingshotDataSet object from getLineages()
#   vertical_shift: Shift for loess curve (default: 0)
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


# Get cluster levels (order is important for color mapping)
cluster_levels <- levels(atlas$cell_type_subclusters)

# Assign color palette to cluster names
cluster_colors <- c(r3dcol$cols_94)
names(cluster_colors) <- cluster_levels

  # Extract pseudotime and cell weights from curves
  pseudotime <- slingPseudotime(curves, na = FALSE)
  cell_weights <- slingCurveWeights(curves)
  # Get weights for this specific lineage
  weights <- cell_weights[, lineage]
  # Select cells with weight > 0 and valid pseudotime
  cells <- names(weights)[weights > 0 & !is.na(pseudotime[, lineage])]
  if (length(cells) == 0) stop("No cells with high confidence in this lineage.")
  
  # Build data frame with pseudotime, expression, and cluster info
  df <- data.frame(
    pseudotime = pseudotime[cells, lineage],
    expr = FetchData(atlas, vars = gene)[cells, 1],
    cluster = as.character(atlas$cell_type_subclusters[cells]),
    cell = cells
  )
  df$cluster <- factor(df$cluster, levels = names(cluster_colors))
  
  # Filter to only clusters in this lineage
  clusters_of_interest <- lineages@lineages[[lineage]]
  df_sub <- df[df$cluster %in% clusters_of_interest, ]
  
  # REMOVE cells with zero expression for cleaner visualization
  df_sub <- df_sub[df_sub$expr != 0, ]
  
  # Get endpoint cluster for title
  endpoint_cluster <- tail(clusters_of_interest, 1)
  main_title <- paste0(endpoint_cluster, " Trajectory")
  
  # Fit loess smooth on nonzero expression values
  loess_fit <- loess(expr ~ pseudotime, data = df_sub, span = 0.5)
  loess_df <- data.frame(
    pseudotime = df_sub$pseudotime,
    expr_smooth = predict(loess_fit) + vertical_shift
  )
  loess_df <- loess_df[order(loess_df$pseudotime), ]

  # Create ggplot with rasterized points and loess line
  ggplot(df_sub, aes(x = pseudotime, y = expr, color = cluster)) +
    ggrastr::geom_point_rast(size = 2, alpha = 1) +
    geom_line(data = loess_df, aes(x = pseudotime, y = expr_smooth),
              inherit.aes = FALSE, color = "black", size = 1.2) +
    scale_color_manual(values = cluster_colors, name = "Cluster") +
    guides(color = guide_legend(override.aes = list(size = 5))) +
    labs(
      title = main_title,
      x = "pseudotime",
      y = paste(gene, "expression")
    ) +
    theme_classic(base_size = 16) +
    theme(
      plot.title = element_text(size = 22, face = "plain", hjust = 0.5, vjust = 1),
      legend.text = element_text(size = 17),
      legend.title = element_text(size = 20,  vjust = 0.5)
    )
}


