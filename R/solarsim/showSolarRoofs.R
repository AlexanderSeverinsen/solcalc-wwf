#' Function to display roofs in Norway with solar panels on
#' 
#' The underlying data in 'solar_polygons & solar_polygons_centroids' is fetched from the 
#' Overpass Turbo API using the R library 'osmdata'. It takes some time to fetch
#' the data, hence this is not done on the fly. It will probably make sense to update
#' the underlying data from time to time, go to /scripts/solar_installations.OSM.R
#' for more details. Also, loading the polygons for all locations at the same time
#' probably does not make much sense, might be better to initiate these at certain 
#' zoom levels and/or fetch from sqlite
#' @importFrom leaflet dplyr


showSolarRoofs <- function(input, solar_polygons, solar_polygons_centroids,  mapId) {
  
  # we should only show polygons at certain
  zoom <- input$map_zoom
  print(zoom)
  if (input$NorskSol) {
    # Retrieve the min and max values from the slider
    min_area <- input$roofsize[1]
    max_area <- input$roofsize[2]
    
    # Filter the solar_polygons_centroids based on area_m2
    filtered_data <- solar_polygons_centroids %>%
      filter(area_m2 >= min_area & area_m2 <= max_area)
    
    # Update the map with polygons
    leafletProxy("map", data = solar_polygons) %>%
      addPolygons(color = "#FF0000",
                  weight = 2.5,
                  fillColor = "#FFFF00",
                  fillOpacity = 0.2,
                  group = "solarPolygons")
    
    # Clear existing markers and add new filtered markers
    # This ensures that the map resets every time the users use the area slider
    leafletProxy("map") %>%
      clearGroup("solarMarkers")
    
    # Update the map with filtered markers
    if (nrow(filtered_data) > 0) {
      leafletProxy("map") %>%
        addMarkers(data = filtered_data,
                   popup = ~paste("Area: ", area_m2, "m²",
                                  "<br>Generator Method:", generator_method,
                                  "<br>Generator Type:", generator_type,
                                  "<br>Kilde: Open Street Map"),
                   clusterOptions = markerClusterOptions(),
                   group = "solarMarkers")
    }
  } else {
    # Switch is OFF 
    leafletProxy("map") %>%
      clearGroup("solarPolygons") %>%
      clearGroup("solarMarkers")
  }
}
