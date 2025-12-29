## Some functions




# ------------------------------------------------------------------------------------------------ ###########################################
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
  
  umap_coords <- seurat_obj@reductions[[reduction]]@cell.embeddings
  clusters <- as.factor(seurat_obj[[cluster_col]][, 1])
  colnames_umap <- levels(clusters)
  color_vector <- color_vector[seq_along(colnames_umap)]
  names(color_vector) <- colnames_umap
  
  # Calculate centroids
  mm <- sparse.model.matrix(~ 0 + clusters)
  colnames(mm) <- levels(clusters)
  centroids2d <- as.matrix(t(t(umap_coords) %*% mm) / Matrix::colSums(mm))
  
  # Set lineage embedding to match
  lineages@reducedDim <- umap_coords
  
  # Plot
  plot(
    umap_coords,
    col = color_vector[clusters],
    cex = point_cex,
    pch = 16,
    xlab = "UMAP 1", ylab = "UMAP 2",
    main = "UMAP with Slingshot Lineages & Cluster Centroids"
  )
  lines(lineages, lwd = line_lwd, col = "black", cex = 2)
  text(centroids2d, labels = rownames(centroids2d), cex = label_cex, font = 2, col = "black")
}


#######################################################################################################################

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
  
  # Calculate centroids
  mm <- Matrix::sparse.model.matrix(~ 0 + clusters)
  colnames(mm) <- levels(clusters)
  centroids2d <- as.matrix(t(t(umap_coords) %*% mm) / Matrix::colSums(mm))
  
  # Plot
  plot(
    umap_coords,
    col = color_vector[clusters],
    pch = point_pch,
    cex = point_cex,
    xlab = "UMAP 1", ylab = "UMAP 2",
    main = "UMAP with Lineages and Cluster Labels"
  )
  lines(curves, lwd = line_lwd, col = "black")
  text(
    centroids2d,
    labels = levels(clusters),
    cex = label_cex,
    font = 2
  )
}


#------------------------------------------------------------------------------------------------##########################
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
  
  # 1. Extract pseudotime and cell weights
  pseudotime <- slingPseudotime(curves, na = FALSE)
  pal_viridis <- viridis(100, end = 0.95)
  
  # 2. Calculate average pseudotime per cell, normalize 0-1
  x <- rowMeans(pseudotime)
  x <- x / max(x, na.rm = TRUE)
  o <- order(x)
  col_idx <- as.integer(x[o] * (length(pal_viridis) - 1)) + 1
  
  # 3. UMAP/embedding and cluster info
  umap_coords <- seurat_obj@reductions[[embedding]]@cell.embeddings
  clusters <- as.factor(seurat_obj[[cluster_col]][, 1])
  cluster_levels <- levels(clusters)
  
  # 4. Make sure colors are named and in order
  color_vector <- color_vector[seq_along(cluster_levels)]
  names(color_vector) <- cluster_levels
  
  # 5. Calculate centroids
  mm <- Matrix::sparse.model.matrix(~ 0 + clusters)
  colnames(mm) <- cluster_levels
  centroids2d <- as.matrix(t(t(umap_coords) %*% mm) / Matrix::colSums(mm))
  
  # 6. Plot pseudotime color scatter
  plot(
    umap_coords[o, , drop = FALSE],
    main = legend_title, pch = 16, cex = point_cex, axes = FALSE, xlab = "", ylab = "",
    col = pal_viridis[col_idx]
  )
  
  # 7. Overlay centroids and cluster labels (with cluster colors)
  points(centroids2d, cex = 2.5, pch = 16, col = color_vector)
  text(centroids2d, labels = cluster_levels, cex = label_cex, font = 2)
  
  # 8. Add pseudotime colorbar legend
  fields::image.plot(
    legend.only = TRUE,
    zlim = range(x, na.rm = TRUE),
    col = pal_viridis,
    legend.args = list(text = legend_title, side = 1, font = 2, line = 2),
    legend.mar = legend_mar,
    legend.width = 1
  )
}

########################################################################################
plot_gene_specific_lineage_nozeros <- function(
  atlas, curves,  gene, lineage, lineages, 
  vertical_shift = 0
) {
  library(ggplot2)
  library(ggrastr)
  require(slingshot)


# Get your cluster levels (order is important)
cluster_levels <- levels(atlas$cell_type_subclusters)

cluster_colors <- c(r3dcol$cols_94)
# Assign these as names to your color vector
names(cluster_colors) <- cluster_levels

  pseudotime <- slingPseudotime(curves, na = FALSE)
  cell_weights <- slingCurveWeights(curves)
  weights <- cell_weights[, lineage]
  cells <- names(weights)[weights > 0 & !is.na(pseudotime[, lineage])]
  if (length(cells) == 0) stop("No cells with high confidence in this lineage.")
  
  df <- data.frame(
    pseudotime = pseudotime[cells, lineage],
    expr = FetchData(atlas, vars = gene)[cells, 1],
    cluster = as.character(atlas$cell_type_subclusters[cells]),
    cell = cells
  )
  df$cluster <- factor(df$cluster, levels = names(cluster_colors))
  
  clusters_of_interest <- lineages@lineages[[lineage]]
  df_sub <- df[df$cluster %in% clusters_of_interest, ]
  
  # REMOVE zero expression cells
  df_sub <- df_sub[df_sub$expr != 0, ]
  
  endpoint_cluster <- tail(clusters_of_interest, 1)
  main_title <- paste0(endpoint_cluster, " Trajectory")
  
  # Fit loess on nonzero values only
  loess_fit <- loess(expr ~ pseudotime, data = df_sub, span = 0.5)
  loess_df <- data.frame(
    pseudotime = df_sub$pseudotime,
    expr_smooth = predict(loess_fit) + vertical_shift
  )
  loess_df <- loess_df[order(loess_df$pseudotime), ]

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


