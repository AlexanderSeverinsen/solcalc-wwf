#' Data and Goals chart
#'
#' Placeholder for front page plot
#' 
#' @return highcharter plot of monthly solar production
#' 
#' @importFrom highcharter magrittr

DataAndGoalsChart <- function() {
  highchart() %>%
    hc_chart(type = "column") %>% 
    hc_xAxis(categories = c("Uganda", "Tanzania", "Kenya", "Madagascar")) %>% 
    hc_yAxis(
      title = list(text = "Values"),
      gridLineWidth = 0 
    ) %>%
    hc_series(list(
      name = "Data Series",
      data = list(
        list(y = 10, color = "#FEC01E"), 
        list(y = 14, color = "#F89834"), 
        list(y = 9,  color = "#F36C42"), 
        list(y = 12, color = "#EE3350")  
      ),
      showInLegend = FALSE
    ))
}

