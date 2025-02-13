#' Data and Goals chart
#'
#' Placeholder for front page pricing
#' 
#' @return highcharter plot of monthly solar production
#' 
#' @importFrom highcharter magrittr

library(magrittr)
library(highcharter)

pricing_frontpage <- function() {
  highchart() %>%
    hc_chart(type = "pie") %>%
    hc_plotOptions(
      pie = list(
        innerSize = "65%",  
        dataLabels = list(
          enabled = FALSE, 
          format = "{point.name}: {point.y}",
          style = list(color = "#000000")  
        ),
        borderWidth = 1  
      )
    ) %>%
    hc_series(
      list(
        name = "Categories",
        data = list(
          list(name = "Kenya", y = 10),
          list(name = "Uganda", y = 20),
          list(name = "Tanzania", y = 30),
          list(name = "Madagascar", y = 40)
        )
      )
    ) %>%
    hc_colors(c("#00B9AD", "#0094D5", "#4E5EAA", "#92449A"))  
}

#pricing_frontpage()

