#' Monthly Solar Production and Irradiance Chart
#'
#' Creates an interactive Highcharts chart to visualize monthly solar production 
#' and irradiance. The chart displays solar production in kWh as a column chart 
#' and solar irradiance in kWh/m² as a line chart. The solar irradiance series is 
#' initially invisible and can be toggled via the chart's legend.
#' 
#' @param monthly_data estimated monthly solar production fetched from PVGIS API
#' 
#' @return highcharter plot of monthly solar production
#' 
#' @importFrom highcharter magrittr


monthlySolarProductionChart <- function(monthly_data) {
  highchart() %>%
    hc_add_series(
      data = monthly_data,
      type = "column",
      hcaes(x = month, y = E_m)
    ) %>%
    hc_xAxis(title = list(text = "Month")) %>%
    hc_yAxis(title = list(text = "Production (kWh)")) %>%
  
    hc_legend(enabled = FALSE) %>%
    
    hc_tooltip(
      headerFormat = "",
      pointFormat = "Month: {point.x}<br>Production: {point.y} kWh"
    ) %>%
    
    hc_add_theme(hc_theme_smpl()) 
}
