#' Data and Goals chart
#'
#' Placeholder for front page solarsim "ad"
#' 
#' @return highcharter plot of monthly solar production
#' 
#' @importFrom highcharter magrittr



Solarsim_frontpage <- function(mapdata_name) {

   mapdata <- get_data_from_map(download_map_data(mapdata_name))
  
  data_fake <- mapdata %>%
    dplyr::select(code = `hc-a2`) %>%
    mutate(value = 1e5 * abs(rt(nrow(mapdata), df = 10)))
  
  hcmap(
    mapdata_name, #"countries/tz/tz-all",
    data = data_fake,
    value = "value",
    joinBy = c("hc-a2", "code"),
    name = "Fake data",
    dataLabels = list(enabled = TRUE, format = "{point.name}"),
    borderColor = "#FAFAFA",
    borderWidth = 0.1,
    tooltip = list(
      valueDecimals = 2,
      valuePrefix = "$",
      valueSuffix = "USD"
    )
  )  %>%
    hc_colorAxis(
      stops = color_stops(
        n = 4,
        colors = c("#FFE600", "#F89834", "#F36C42", "#EE3350")
      )
    ) 
}



