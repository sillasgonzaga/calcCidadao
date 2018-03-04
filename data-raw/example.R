library(lubridate)
library(tidyverse)

x0 = as.Date("2000-01-01")

xf = floor_date(x0 + ddays(seq(365, (365*17), length.out = 17)), "year")
xf = xf[xf > x0]

foo <- function(x1, x2){
  m <- matrix(c(
    return_tr(x1, x2),
    return_cdi(x1, x2),
    return_poupanca(x1, x2),
    return_selic(x1, x2)
  ), nrow = 1)
  colnames(m) <- c("TR", "CDI", "Poupança", "Selic")
  m
}

# 149 sec
system.time(x <- map(xf, foo, x1 = x0))

mat <- as.data.frame(reduce(x, rbind))

mat$years <- as.numeric(round((xf - x0)/365))

mat %>%
  gather(investment, return_rate, -years) %>%
  ggplot(aes(x = years, y = return_rate, color = investment)) +
  geom_line()


