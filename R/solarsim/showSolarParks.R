#' Function to display solar parks
#' 
#' The underlying data in 'centroids_tz_sam 'is fetched from https://solar.transitionzero.org
#' The data is updated quarterly
#' @importFrom leaflet dplyr


showSolarParks <- function(input, centroids_tz_sam, mapId) {
  
  if (input$tz_sam) {

    # Update the map with markers
    leafletProxy("map", data = centroids_tz_sam) %>%
      addMarkers(popup = ~paste(
                   "ID: ", cluster_id, "<br>",
                   "Capacity (MW): ", capacity_mw, "<br>", 
                   "Constructed After: ", constructed_after, "<br>",
                   "Constructed Before: ", constructed_before),      
                 clusterOptions = markerClusterOptions(),
                 group = "SolarparkMarkers"
      )
    
    }
  else {
    # Switch is OFF 
    leafletProxy("map") %>%
      clearGroup("SolarparkMarkers")
  }
}
