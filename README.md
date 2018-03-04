---
title: "calcCidadao"
output: github_document
---

`calcCidadao` is an R package created to automate the process of using [**Calculadora do Cidadão**](https://www3.bcb.gov.br/CALCIDADAO/publico/exibirFormCorrecaoValores.do?method=exibirFormCorrecaoValores&aba=1), an online tool offered by the Central Bank of Brazil to adjust a given value according to an inflation index (such as IGP-M), savings rate (Poupança) or interest rates (Selic or CDI).

# Instalation

```r
devtools::install_github("sillasgonzaga/calcCidadao")
```

# Usage

`calcCidadao` is easy to use: you just have to pass a start and an end date and the corresponding function will return the adjustment return value for the given period. Examples: 

```r
d0 = as.Date("2010-01-01")
df = as.Date("2017-01-01")
return_inflation("IGP-M", d0, df)
return_cdi(d0, df)
return_poupanca(d0, df)
return_selic(d0, df)
return_tr(d0, df)
```

If you would like to know, for example, how much R$200,000.00 5 years ago is worth today, it is as easy as:

```r
200000 * return_inflation("IGP-M", as.Date("2013-02-01"), as.Date("2018-02-01"))
```

Please note that for `calcCidadao::return_inflation()` you must also provide the inflation index you want to return. You check all the available options using `names(calcCidadao::inflation_indices())'`


# Warning

Because `calcCidadao` relies on web scraping to extract data from the Calculadora do Cidadão website, it can be quite slow for large requests.



