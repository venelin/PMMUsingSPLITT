
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis build status](https://travis-ci.org/venelin/PMMUsingSPLITT.svg?branch=master)](https://travis-ci.org/venelin/PMMUsingSPLITT) [![Coverage status](https://codecov.io/gh/venelin/PMMUsingSPLITT/branch/master/graph/badge.svg)](https://codecov.io/github/venelin/PMMUsingSPLITT?branch=master)

PMMUsingSPLITT
==============

The goal of PMMUsingSPLITT is to provide a minimal example of how to use the SPLITT C++ library in an R-package. See [this guide](https://venelin.github.io/SPLITT/articles/SPLITTRcppModules.html) for a tutorial.

Installation
------------

You can install the released version of PMMUsingSPLITT from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("PMMUsingSPLITT")
```

Examples
--------

-   Calculating the likelihood of the PMM for a given tree, data and model parameters.

``` r
library(ape)
library(PMMUsingSPLITT)
#> Loading required package: Rcpp

set.seed(10)

N <- 1000
x0 <- 0.1
alpha <- 1
theta <- 10
sigma2 <- 0.25
sigmae2 <- 1

tree <- rtree(N)

g <- rTraitCont(tree, model = "OU", root.value = x0,
                alpha = alpha, sigma = sqrt(sigma2),
                ancestor = FALSE)

x <- g + rnorm(n = N, mean = 0, sd = sqrt(sigmae2))

cat("logLikelihood using R:", PMMLogLik(x, tree, x0, sigma2, sigmae2), "\n")
#> logLikelihood using R: -1551.016
cat("logLikelihood using R:", PMMLogLikCpp(x, tree, x0, sigma2, sigmae2), "\n")
#> logLikelihood using R: -1551.016
```

-   Performing a benchmark to measure the likelihood calculation times using different parallelization strategies:

``` r
# N specifies the size of the phylogenetic tree. 
# Ntests specifies the number of executions in one time measurement 
# (the more the better, but also slower).
MiniBenchmark(N = 100, Ntests = 100)
#> Performing a mini-benchmark of the PMM log-likelihood calculation with 
#>       a tree of size N= 100 ;
#> Calling each likelihood calculation Ntests= 100  times ...
#> CPU:  Intel(R) Core(TM) i7-4850HQ CPU @ 2.30GHz 
#> OpenMP version:  201107 
#> Number of threads: 8 
#> Measuring calculation times...
#>    model                                            mode time.ms
#> 1    PMM                                      R (serial)    2.00
#> 2    PMM                                      C++ (AUTO)    0.03
#> 3    PMM              C++ (SINGLE_THREAD_LOOP_POSTORDER)    0.02
#> 4    PMM                 C++ (SINGLE_THREAD_LOOP_PRUNES)    0.02
#> 5    PMM                 C++ (SINGLE_THREAD_LOOP_VISITS)    0.02
#> 6    PMM                  C++ (MULTI_THREAD_LOOP_PRUNES)    0.33
#> 7    PMM                  C++ (MULTI_THREAD_LOOP_VISITS)    0.20
#> 8    PMM C++ (MULTI_THREAD_LOOP_VISITS_THEN_LOOP_PRUNES)    0.39
#> 9    PMM                  C++ (MULTI_THREAD_VISIT_QUEUE)    1.73
#> 10   PMM     C++ (MULTI_THREAD_LOOP_PRUNES_NO_EXCEPTION)    0.25
#> 11   PMM                        C++ (HYBRID_LOOP_PRUNES)    0.26
#> 12   PMM                        C++ (HYBRID_LOOP_VISITS)    0.20
#> 13   PMM       C++ (HYBRID_LOOP_VISITS_THEN_LOOP_PRUNES)    0.22
MiniBenchmark(N = 1000, Ntests = 10)
#> Performing a mini-benchmark of the PMM log-likelihood calculation with 
#>       a tree of size N= 1000 ;
#> Calling each likelihood calculation Ntests= 10  times ...
#> CPU:  Intel(R) Core(TM) i7-4850HQ CPU @ 2.30GHz 
#> OpenMP version:  201107 
#> Number of threads: 8 
#> Measuring calculation times...
#>    model                                            mode time.ms
#> 1    PMM                                      R (serial)    14.0
#> 2    PMM                                      C++ (AUTO)     0.1
#> 3    PMM              C++ (SINGLE_THREAD_LOOP_POSTORDER)     0.1
#> 4    PMM                 C++ (SINGLE_THREAD_LOOP_PRUNES)     0.1
#> 5    PMM                 C++ (SINGLE_THREAD_LOOP_VISITS)     0.0
#> 6    PMM                  C++ (MULTI_THREAD_LOOP_PRUNES)     1.0
#> 7    PMM                  C++ (MULTI_THREAD_LOOP_VISITS)     0.7
#> 8    PMM C++ (MULTI_THREAD_LOOP_VISITS_THEN_LOOP_PRUNES)     2.7
#> 9    PMM                  C++ (MULTI_THREAD_VISIT_QUEUE)    16.3
#> 10   PMM     C++ (MULTI_THREAD_LOOP_PRUNES_NO_EXCEPTION)     0.1
#> 11   PMM                        C++ (HYBRID_LOOP_PRUNES)     0.1
#> 12   PMM                        C++ (HYBRID_LOOP_VISITS)     0.1
#> 13   PMM       C++ (HYBRID_LOOP_VISITS_THEN_LOOP_PRUNES)     0.1
MiniBenchmark(N = 10000, Ntests = 10)
#> Performing a mini-benchmark of the PMM log-likelihood calculation with 
#>       a tree of size N= 10000 ;
#> Calling each likelihood calculation Ntests= 10  times ...
#> CPU:  Intel(R) Core(TM) i7-4850HQ CPU @ 2.30GHz 
#> OpenMP version:  201107 
#> Number of threads: 8 
#> Measuring calculation times...
#>    model                                            mode time.ms
#> 1    PMM                                      R (serial)   176.0
#> 2    PMM                                      C++ (AUTO)     0.5
#> 3    PMM              C++ (SINGLE_THREAD_LOOP_POSTORDER)     1.2
#> 4    PMM                 C++ (SINGLE_THREAD_LOOP_PRUNES)     1.2
#> 5    PMM                 C++ (SINGLE_THREAD_LOOP_VISITS)     1.2
#> 6    PMM                  C++ (MULTI_THREAD_LOOP_PRUNES)     0.3
#> 7    PMM                  C++ (MULTI_THREAD_LOOP_VISITS)     0.3
#> 8    PMM C++ (MULTI_THREAD_LOOP_VISITS_THEN_LOOP_PRUNES)     0.3
#> 9    PMM                  C++ (MULTI_THREAD_VISIT_QUEUE)   153.1
#> 10   PMM     C++ (MULTI_THREAD_LOOP_PRUNES_NO_EXCEPTION)     0.3
#> 11   PMM                        C++ (HYBRID_LOOP_PRUNES)     0.4
#> 12   PMM                        C++ (HYBRID_LOOP_VISITS)     0.5
#> 13   PMM       C++ (HYBRID_LOOP_VISITS_THEN_LOOP_PRUNES)     0.6
```