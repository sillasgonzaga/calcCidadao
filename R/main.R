#' Brazilian inflation indices
#'
#' Vector character of all Brazilian inflation indices supported by the Central Bank of Brazil.
#'
#'
#' @return Vector character
#' @examples
#' # inflation_indices()
#' @export
inflation_indices <- function(){
  c(
    "IGP-M" = "00189IGP-M",
    "IGP-DI" = "00190IGP-DI",
    "INPC" = "00188INPC",
    "IPC-A" = "00433IPC-A",
    "IPCA-E" = "10764IPC-E",
    "IPC-BRASIL" = "00191IPC-BRASIL",
    "IPC-SP" = "00193IPC-SP"
  )
}


#' Inflation return
#'
#' Returns the adjustment return of a selected Brazilian inflation index.
#' See data(inflation_indices) for all possible values.
#'
#' @param index A inflation index. Must be one of `names(inflation_indices())`.
#' @param start_date A date object.
#' @param end_date A date object.
#'
#' @return A numeric vector of length 1.
#' The adjustament return rate from `start_date` to `end_date`
#' @examples
#' return_inflation("IGP-M", as.Date("2010-01-01"), as.Date("2017-01-01"))
#' # To adjust a value:
#' 100 * return_inflation("IGP-M", as.Date("2010-01-01"), as.Date("2017-01-01"))
#' @export
return_inflation <- function(index, start_date, end_date){

  if(!inherits(start_date, "Date")) {
    stop("Argument start_date is not a Date object")
    }

  if(!inherits(end_date, "Date")) {
    stop("Argument end_date is not a Date object")
    }

  # list of accepted inflation indices
  inflation <- inflation_indices()

  index <- toupper(index)
  match.arg(index, names(inflation), several.ok = FALSE)

  # request parameters
  index = unname(inflation[names(inflation) == index]) #selIndice
  start_date =  format_date_request(start_date, "my")
  end_date = format_date_request(end_date, "my")

  url_request <- "https://www3.bcb.gov.br/CALCIDADAO/publico/corrigirPorIndice.do?method=corrigirPorIndice&aba=1&selIndice={index}&dataInicial={start_date}&dataFinal={end_date}&valorCorrecao=100%2C00&idIndice=&nomeIndicePeriodo="
  url_request <- as.character(glue::glue(url_request))

  # web scraping
  out <- scrape(url_request)
  out
}



#' Taxa Referencial (TR or Referential Rate) return
#'
#' Adjustment return of the Referential Rate.
#'
#' @param start_date A Date object.
#' @param end_date A Date object.
#'
#' @return A numeric vector of length 1.
#' @examples
#' return_tr(as.Date("2010-01-01"), as.Date("2017-01-01"))
#' @export
return_tr <- function(start_date, end_date){
  # TODO: ADD PAYMENT DATE

  # request parameters
  start_date =  format_date_request(start_date, "dmy")
  end_date = format_date_request(end_date, "dmy")
  #valorCorrecao = 1

  url_request <- "https://www3.bcb.gov.br/CALCIDADAO/publico/corrigirPelaTR.do?method=corrigirPelaTR&aba=2&dataInicioSerie=01%2F01%2F2015&dataVencimentoSerie=01%2F01%2F2017&dataEfetivoPagamento=&valorCorrecao=1%2C00"
  url_request <- as.character(glue::glue(url_request))

  out <- scrape(url_request)
  out
}

#' Poupança (Brazilian Savings Rate)
#'
#' Adjustment return of Poupança.
#'
#' @param start_date A Date object.
#' @param end_date A Date object.
#'
#' @return A numeric vector of length 1.
#' @examples
#' return_poupanca(as.Date("2010-01-01"), as.Date("2017-01-01"))
#' @export
return_poupanca <- function(start_date, end_date){
  # request parameters
  new_rule_date = as.Date("2012-05-04") #4/5/2012

  new_rule = ifelse(start_date < new_rule_date, "false", "true")
  start_date =  format_date_request(start_date, "dmy")
  end_date = format_date_request(end_date, "dmy")


  url_request <- "https://www3.bcb.gov.br/CALCIDADAO/publico/corrigirPelaPoupanca.do?method=corrigirPelaPoupanca&aba=3&dataInicial={start_date}&dataFinal={end_date}&valorCorrecao=100%2C00&regraNova={new_rule}"
  url_request <- as.character(glue::glue(url_request))

  out <- scrape(url_request)
  out
}

#' Selic (Brazilian Interest Rate)
#'
#' Adjustment return of Selic.
#'
#' @param start_date A Date object.
#' @param end_date A Date object.
#'
#' @return A numeric vector of length 1.
#' @examples
#' return_selic(as.Date("2010-01-01"), as.Date("2017-01-01"))
#' @export
return_selic <- function(start_date, end_date){
  start_date =  format_date_request(start_date, "dmy")
  end_date = format_date_request(end_date, "dmy")


  url_request <- "https://www3.bcb.gov.br/CALCIDADAO/publico/corrigirPelaSelic.do?method=corrigirPelaSelic&aba=4&dataInicial={start_date}&dataFinal={end_date}&valorCorrecao=100%2C00"
  url_request <- as.character(glue::glue(url_request))

  out <- scrape(url_request)
  out
}


#' CDI (Certificado de depósito interbancário or Interbank Money Market)
#'
#' Adjustment return of CDI
#'
#' @param start_date A Date object.
#' @param end_date A Date object.
#' @param cdi_pct Rate of CDI index.
#'
#' @return A numeric vector of length 1.
#' @examples
#' return_cdi(as.Date("2010-01-01"), as.Date("2017-01-01"))
#' @export
return_cdi <- function(start_date, end_date, cdi_pct = 100){
  start_date =  format_date_request(start_date, "dmy")
  end_date = format_date_request(end_date, "dmy")

  url_request <- "https://www3.bcb.gov.br/CALCIDADAO/publico/corrigirPeloCDI.do?method=corrigirPeloCDI&aba=5&dataInicial={start_date}&dataFinal={end_date}&valorCorrecao=&percentualCorrecao={cdi_pct}"
  url_request <- as.character(glue::glue(url_request))

  out <- scrape(url_request)
  out

}
