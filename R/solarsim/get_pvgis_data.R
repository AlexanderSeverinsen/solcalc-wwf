#' -----------  Function to get data from the PVGIS API --------------
#'
#' Depending on the position (longitude/latitude) of the request the results will
#' be based on either the database PVGIS-ERA5 or the PVGIS-SARAH 2
#' parameter 'angel' is ignored if optimalinclination = 1
#' parameters 'angel' and 'aspect' (azimuth) is ignored if optimalangles = 1
#'
#' TO-DO: in many ways it would probably make more sense to set optimalinclination = 1
#' and optimalangles = 1 and drop the user inputs for 'angle' and 'aspect'
#' However, there is learning in doing this as well, and maybe the best would be to
#' make 2 calls to the PVGIS api, first fetch optimal angles and inclination, and then
#' use those as parameters in the below function, that way the first calculation will
#' always give the best production estimate, and the user may change those to experiment
#' Though that would mean
#' 1. Fetch optimal angles and inclication
#' 2. Update UI with results
#' 3. Make a new function that fetches production based on user input for angle and inclination
#'
#' @param lon longitude
#' @param lat latitude
#' @param angle the angle of the solar panel
#' @param aspect the orientation/azimuth of the solar panel
#' @param peakpower the the max kw of the solar installation
#'
#' @return potential solar production from PV-GIS 
#'
#' @importFrom httr get content
#' @importFrom jsonlite fromJSON
#' 
#' @examples
#' get_pvgis_data(10.5295324, 59.6758338, 10, 45, 90)
#' 



get_pvgis_data <- function(lon, lat, peakpower, angle, aspect) {
  # default database, global coverage 
  raddatabase <- "PVGIS-ERA5"
  
  # Check for SARAH2 coverage (Europe, Africa, Asia within ±65° longitude and ±65° latitude)
  if (lon >= -65 && lon <= 65 && lat >= -65 && lat <= 65) {
    raddatabase <- "PVGIS-SARAH2"
  } 
  print(raddatabase)
  url <- "https://re.jrc.ec.europa.eu/api/v5_2/PVcalc"
  params <- list(lat = lat, 
                 lon = lon, 
                 peakpower = peakpower, 
                 loss = 7.5, # default is 14%, GlobalSolarAtlas use 7.5% 
                 raddatabase = raddatabase, 
                 #optimalinclination = 1,
                 #optimalangles = 1,
                 angle = angle,
                 aspect = aspect,
                 outputformat = "json", 
                 browser = 0)
  response <- httr::GET(url, query = params) 
  json_content <- httr::content(response, "text", encoding = "UTF-8") 
  data_df <- jsonlite::fromJSON(json_content)
}

#df <- get_pvgis_data(10.5295324, 59.6758338, 10, 45, 90)
#df <- df$outputs$monthly
#df <- df[["outputs"]][["hourly"]]

# 
# url <- "https://re.jrc.ec.europa.eu/api/v5_2/PVcalc"
# params <- list(lat = 59.6758338, 
#                lon = 10.5295324, 
#                peakpower = 10, 
#                loss = 14, 
#                raddatabase = "PVGIS-SARAH2", 
#                optimalangles = 1,
#                outputformat = "json", 
#                browser = 0)
# 
# response <- httr::GET(url, query = params) 
# json_content <- httr::content(response, "text", encoding = "UTF-8") 
# data_df <- jsonlite::fromJSON(json_content)

# ---- Get hourly production data
# Note that by default you are getting the data from the first year, eg. 2005 up until 2016 > 100' obs!
# url_hour <- "https://re.jrc.ec.europa.eu/api/seriescalc"
# params_hour <- list(
#   lat = 59.6758338, 
#   lon = 10.5295324,
#   outputformat = "json",
#   start_year = "2015",
#   optimalangles = 1
# )
# response <- httr::GET(url_hour, query = params_hour) 
# json_content <- httr::content(response, "text", encoding = "UTF-8") 
# data_df <- jsonlite::fromJSON(json_content)
# df <- data_df[["outputs"]][["hourly"]]



