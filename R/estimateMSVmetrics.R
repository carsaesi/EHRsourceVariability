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

#' Estimates the GPD and SPOmulti-source variability metrics and the corresponding source projection vertices from a matrix of probability distributions of different data sources
#'
#' @name estimateMSVmetrics
#' @rdname estimateMSVmetrics-methods
#' @param probabilities m-by-n matrix containing the probability mass of n data sources on m distribution bins
#' @return A list containing the following results:
#' 	GPD       	the value of the Global Probabilistic Deviation metric, where 0 means equal distributions and 1 means non-overlapping distributions
#' 	SPOs      	the values of Source Probabilistic Outlyingness for each data source, where 0 means equal to central tendency and 1 completely non-overlapping
#' 	Vertices	a n-by-(n-1) matrix containing the coordinates of each data source in the projected probabilistic space conserving their dissimilarities, e.g, for 3D projections the 3 first columns can be used
#' @export
estimateMSVmetrics <- function(probabilities) {

  ns = ncol(probabilities);

  distsM = matrix(data=0,nrow=ns,ns)
  for(i in 1:(ns-1)){
    for(j in (i+1):ns){
      distsM[i,j] = sqrt(jsdiv(probabilities[,i],probabilities[,j]))
      distsM[j,i] = distsM[i,j]
    }
  }

  vertices <- cmdscale(distsM,eig=FALSE, k=ns-1)

  c = colSums(vertices)/ns
  cc = matrix(rep(c, ns),nrow=ns,byrow=TRUE)
  cc2 = vertices-cc
  dc = apply(cc2, 1, norm, type="2")

  gpdmetric = mean(dc)/distc(ns)
  sposmetrics = dc/(1-(1/ns))

  msvMetrics <- list(gpdmetric, sposmetrics, vertices)
  names(msvMetrics) <- c("GPD","SPOs","Vertices")

  return(msvMetrics)
}

jsdiv <- function(p, q){
  m <- log2(0.5 * (p + q))
  jsdiv <- 0.5 * (sum(p * (log2(p) - m),na.rm = TRUE) + sum(q * (log2(q) - m),na.rm = TRUE))
}

distc <- function(D){
  gamma = acos(-1/D)
  temp = sin((pi-gamma)/2)/sin(gamma)
  temp[D==1] = 0.5
  distc = temp
}
