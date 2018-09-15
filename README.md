<!-- README.md is generated from README.Rmd. Please edit that file -->
EBMAhelper
==========

EBMAhelper is a wrapper around EBMAforecast that uses conventional R model syntax and methods, e.g. implementing `ebma()` to create and EBMA ensemble.

Example
-------

A EBMA ensemble can be fitted like this:

``` r
suppressMessages({
  library("EBMAforecast")
  library("EBMAhelper")
})


data("presidentialForecast")

head(presidentialForecast)
#>      Campbell Lewis-Beck   EWT2C2     Fair    Hibbs Abramowitz   Actual
#> 1952 46.83648   45.18571 45.70344 45.24491 44.81212   44.29725 44.59477
#> 1956 54.04117   56.77496 56.54709 56.41898 56.51094   59.00480 57.75380
#> 1960 51.15267   48.44678 49.61112 51.08189 48.95051   49.42700 49.91609
#> 1964 61.12062   63.17691 63.48235 61.20933 61.36488   60.85638 61.34263
#> 1968 48.45415   48.65492 51.81968 50.19200 49.25904   50.09237 49.59511
#> 1972 61.17357   59.58035 55.04779 58.42894 59.26387   59.54824 61.78800
str(presidentialForecast)
#> 'data.frame':    15 obs. of  7 variables:
#>  $ Campbell  : num  46.8 54 51.2 61.1 48.5 ...
#>  $ Lewis-Beck: num  45.2 56.8 48.4 63.2 48.7 ...
#>  $ EWT2C2    : num  45.7 56.5 49.6 63.5 51.8 ...
#>  $ Fair      : num  45.2 56.4 51.1 61.2 50.2 ...
#>  $ Hibbs     : num  44.8 56.5 49 61.4 49.3 ...
#>  $ Abramowitz: num  44.3 59 49.4 60.9 50.1 ...
#>  $ Actual    : num  44.6 57.8 49.9 61.3 49.6 ...

fitted_ensemble <- ebma(y = presidentialForecast[ ,7],
                        x = presidentialForecast[ ,c(1:6)],
                        model_type = "normal")
summary(fitted_ensemble)
#>        Length         Class          Mode 
#>             1 FDatFitNormal            S4
```

To do the same with `EBMAforecast` is slightly more verbose and does not follow R's model fitting conventions. The following code is adapted from the package demo:

``` r
data("presidentialForecast")

full.forecasts<-presidentialForecast[,c(1:6)]
full.observed<-presidentialForecast[,7]

this.ForecastData <- makeForecastData(
  .predCalibration=full.forecasts[1:12,],
  .outcomeCalibration=full.observed[1:12],
  .predTest=full.forecasts[13:15,], 
  .outcomeTest=full.observed[13:15], 
  .modelNames=c("Campbell", "Lewis-Beck","EWT2C2","Fair","Hibbs","Abramowitz"))
thisEnsemble<-calibrateEnsemble(this.ForecastData, model="normal", 
                                useModelParams=FALSE, tol = 0.000000001,
                                const = 0)
summary(thisEnsemble)
#>                W Constant Predictor  rmse   mae
#> EBMA                                0.944 0.745
#> Campbell   0.314        0         1 1.597 1.228
#> Lewis-Beck 0.000        0         1 1.705 1.434
#> EWT2C2     0.145        0         1 2.816 2.142
#> Fair       0.000        0         1 2.207 1.755
#> Hibbs      0.321        0         1 1.523 1.103
#> Abramowitz 0.221        0         1 1.266 1.055
```
