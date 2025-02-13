#' -----------  Function to get hourly data from the PVGIS API --------------
#'
#' Depending on the position (longitude/latitude) of the request the results will
#' be based on either the database PVGIS-ERA5 or the PVGIS-SARAH 2
#' parameter 'angel' is ignored if optimalinclination = 1
#' parameters 'angel' and 'aspect' (azimuth) is ignored if optimalangles = 1
#' 
#' Note that the query without startyear and endyear will return 140000 observations
#' Hence, it will typically take 10 seconds. We do a shortcut here by setting the latest year (2020)
#' https://joint-research-centre.ec.europa.eu/photovoltaic-geographical-information-system-pvgis/pvgis-tools/hourly-radiation_en
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

get_pvgis_hour <- function(lon, lat, peakpower, angle, aspect) {
  # default database, global coverage 
  raddatabase <- "PVGIS-ERA5"
  
  # Check for SARAH2 coverage (Europe, Africa, Asia within ±65° longitude and ±65° latitude)
  if (lon >= -65 && lon <= 65 && lat >= -65 && lat <= 65) {
    raddatabase <- "PVGIS-SARAH2"
  } 
  print(raddatabase)
  url <- "https://re.jrc.ec.europa.eu/api/v5_2/seriescalc"
  params <- list(lat = lat, 
                 lon = lon, 
                 peakpower = peakpower, 
                 loss = 7.5, # default is 14%, GlobalSolarAtlas use 7.5% 
                 raddatabase = raddatabase, 
                 pvcalculation = 1, # = 1 will give you the hours, P = power output
                 angle = angle,
                 aspect = aspect,
                 startyear = 2020,
                 outputformat = "json", 
                 browser = 0)
  response <- httr::GET(url, query = params) 
  json_content <- httr::content(response, "text", encoding = "UTF-8") 
  data_df <- jsonlite::fromJSON(json_content)
}

df_hour <- get_pvgis_hour(10.5295324, 59.6758338, 10, 45, 90)
df_hour <- df_hour[["outputs"]][["hourly"]]
glimpse(df_hour)



