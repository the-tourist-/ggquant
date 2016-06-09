library(TTR)
library(quantmod)
library(plyr)
library(dplyr)
library(ggplot2)

getSymbols("AAPL")

g <-
  ggplot(AAPL) +
  geom_line(aes(x = index(AAPL), y = AAPL.Adjusted)) +
  stat_q_sma(data = AAPL, aes(date = index(AAPL), close = AAPL.Adjusted))
print(g)
