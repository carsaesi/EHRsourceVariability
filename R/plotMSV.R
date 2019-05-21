# Copyright 2019 Biomedical Data Science Lab, Universitat Polit?cnica de Val?ncia (Spain)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Plots a Multi-Source Variability plot based on the results of estimateMSVmetrics.
#'
#' @name plotMSV
#' @rdname plotMSV-methods
#' @param msvMetrics the output of estimateMSVmetrics
#' @param nBySource number of individuals for each source
#' @param idSource identifier for each source (character array)
#' @return a plotly plot object
#' @examples
#' \dontrun{
#'
#' library("PCAmixdata")
#'
#' # We are going to estimate the MSV metrics and plot an MSV plot of the three first PCA coordinates of a dataset containing both numerical and categorical data
#' # We assume 'data' is a data.frame including numerical and categorical variables
#'
#' # We get the indices of numerical and categorical data
#'
#' quantidx = sapply(data,class) %in% c("numeric","integer")
#' qualiidx = sapply(data,class) %in% c("factor","character")
#'
#' # We estimate a PCA projection using PCAmix for both numerical and categorical data
#' mca = PCAmix(X.quanti = NULL, X.quali = datasetVarsC2, ndim = 3, rename.level = TRUE, graph = FALSE)
#' coords = mca$ind$coord
#'
#' # 'ID_SOURCE' contains the data source tag for each row in the data
#' # We get a kernel density estimation for the distributions of each source, removing those NULL estimations next
#'
#' kdeData = by(coords[,1],ID_SOURCE, density, n = 100, from = min(coords[,1]), to = max(coords[,1]))
#' kdeData = lapply(kdeData,function(x) x$y)
#' kdeNull = sapply(kdeData,is.null)
#' kdeNotNull = kdeData[!kdeNull]
#' kdeDataNotNull = matrix(unlist(kdeNotNull), ncol = length(kdeNotNull), byrow = FALSE)
#' probMatrix = sweep(kdeDataNotNull, 2, colSums(kdeDataNotNull), FUN="/")
#'
#' # We estimate the MSV metrics
#'
#' msvMetrics = estimateMSVmetrics(probMatrix)
#' idSource = levels(ID_SOURCE)
#'
#' nBySource = table(ID_SOURCE)
#'
#' plotMSV(msvMetrics, nBySource, idSource)
#'
#' }
#' @export
plotMSV <- function(msvMetrics, nBySource, idSource) {
p <- plotly::plot_ly(x = msvMetrics$Vertices[,1], y = msvMetrics$Vertices[,2], z = msvMetrics$Vertices[,3],
        color = msvMetrics$SPOs,
        size = as.integer(nBySource),
        marker = list(sizemode = 'diameter'),
        text = idSource
) %>%  plotly::layout(title = sprintf("Multi-Source Variability plot")) %>%
  plotly::add_markers()
return(p)
}
