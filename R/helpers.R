scrape <- function(url){

  # tab <- xml2::read_html(url)
  # tab <- rvest::html_nodes(tab, "table.tabela")
  # tab <- rvest::html_table(tab, fill = TRUE)
  # tab <- tab[[1]]

  tab <- xml2::read_html(url)
  tab <- rvest::html_table(tab, fill = TRUE)
  tab <- tab[[4]]

  row <- which(grepl(pattern = "Índice", tab[,1]))
  x <- tab[row, 2]
  x <- gsub(",", ".", x)
  x <- as.numeric(x)
  x <- ifelse(length(x) == 0, NA_real_, x)
  x
}

format_date_request <- function(date, output_format) {
  d <- format(date, "%d")
  m <- format(date, "%m")
  y <- format(date, "%Y")

  possible_formats <- c("my", "dmy")
  match.arg(output_format, possible_formats)

  if(output_format == "my"){
    return(paste0(c(m, y), collapse = "%2F"))
  } else {
    return(paste0(c(d, m, y), collapse = "%2F"))
  }

}
