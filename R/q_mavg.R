library(TTR)
library(quantmod)
library(ggplot2)

getSymbols("AAPL")

statQSMA <-
  ggproto("statQSMA", Stat,
          compute_group = function(data, scales, params, n = 10) {
            data.frame(x = as.integer(data$date), y = SMA(data$close, n = n))
          },
          required_aes = c("date", "close")
)

stat_q_sma <- function(mapping = NULL, data = NULL, geom = "line",
                       position = "identity", na.rm = FALSE, show.legend = NA,
                       inherit.aes = TRUE, n = 10, ...) {
  RetVal <- ggplot2::layer(
    stat = statQSMA, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, n = n, ...)
  )
  RetVal
}

g <-
  ggplot(AAPL) +
  geom_line(aes(x = index(AAPL), y = AAPL.Adjusted)) +
  stat_q_sma(aes(date = index(AAPL), close = AAPL.Adjusted), colour = "blue", n = 20)
print(g)