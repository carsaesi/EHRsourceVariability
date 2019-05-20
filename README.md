# EHRsourceVariability (under-development version)

Measuring and visualizing biomedical data heterogeneity across data sources

## What is this repository for?

The `EHRsourceVariability` package contains functions to measure and visualize biomedical data heterogeneity across data sources (such as locations, hospitals, professionals, etc.).  [1-2](https://github.com/carsaesi/EHRsourceVariability#Citation). The multi-source variability measurement methods include two metrics. The first measures the dissimilarity of a data source to a global central tendency of sources, namely the Source Probabilistic Outlyingness (SPO) metric. The second measures the global variability among all the data sources in a repository, namely the Global Probabilistic Deviation (GPD) metric. The metrics are complemented with an exploratory visualization of the variability among data sources, namely the Multi-Source Variability (MSV) plot. These methods serve to highlight anomalous behaviors in the data of specific sources, detect groups of sources with similar data, or provide an indicator of concordance among data sources.

## Package' Status

 * __Version__: 0.0.1
 * __Authors__: Carlos Sáez (UPV), Juan M García-Gómez (UPV)
 * __Maintainer__: Carlos Sáez (UPV)
 
 Copyright: 2019 - Biomedical Data Science Lab, Universitat Politècnica de València, Spain (UPV)

## Documentation

* [Package help](https://github.com/carsaesi/EHRsourceVariability/raw/master/vignettes/EHRsourceVariability.pdf)

## Citation

If you use EHRsourceVariability, please cite:

[1]: Sáez, C., Robles, M. and García-Gómez, J.M., 2017. Stability metrics for multi-source biomedical data based on simplicial projections from probability distribution distances. Statistical methods in medical research. 2017;26(1):312-336. https://doi.org/10.1177/0962280214545122

[2]: Sáez C, Zurriaga O, Pérez-Panadés J, Melchor I, Robles M, García-Gómez JM. Applying probabilistic temporal and multisite data quality control methods to a public health mortality registry in spain: A systematic approach to quality control of repositories. Journal of the American Medical Informatics Association. 2016;23:1085–95. https://doi.org/10.1093/jamia/ocw010

## Download

Download the latest development code of EHRsourceVariability from GitHub using [devtools](https://cran.r-project.org/package=devtools) with

```R
devtools::install_github("carsaesi/EHRsourceVariability")
```
