#' Leaflet Map
#'
#' This function initializes a Leaflet map with layers 
#' OSM, ESRI, Power potential layers from SolarGIS.
#'
#' @importFrom leaflet addTiles addProviderTiles addWMSTiles addPolygons addLayersControl setView addLegends addDrawToolbar raster

leafletMap <- function(africa_lat, africa_lon, initial_zoom_level) {
  withProgress(
    message = 'Initiating map for solar potential calculation', 
    detail = 'This may take a few seconds...', value = 0, {
  library(raster)
  
  custom_palette <- colorRampPalette(c("#006400", "yellow", "orange", "#FF0000"))(10)
  
  incProgress(1/4)
  Tanzania_tif <- "data/GlobalSolarAtlas/PVOUT_Tanzania.tif"
  raster_PVOUT_Tanzania <- raster(Tanzania_tif)
  raster_PVOUT_Tanzania <- aggregate(raster_PVOUT_Tanzania, fact = 8, fun = mean)
  pal_tanzania <- colorNumeric(palette = custom_palette, domain = values(raster_PVOUT_Tanzania), na.color = "transparent")

  incProgress(2/4)
  Uganda_tif <- "data/GlobalSolarAtlas/PVOUT_Uganda.tif"
  raster_PVOUT_Uganda <- raster(Uganda_tif)
  raster_PVOUT_Uganda <- aggregate(raster_PVOUT_Uganda, fact = 8, fun = mean)
  pal_uganda <- colorNumeric(palette = custom_palette, domain = values(raster_PVOUT_Uganda), na.color = "transparent")
  
  incProgress(3/4)
  Madagascar_tif <- "data/GlobalSolarAtlas/PVOUT_Madagascar.tif"
  raster_PVOUT_Madagascar <- raster(Madagascar_tif)
  raster_PVOUT_Madagascar <- aggregate(raster_PVOUT_Madagascar, fact = 8, fun = mean)
  pal_madagascar <- colorNumeric(palette = custom_palette, domain = values(raster_PVOUT_Madagascar), na.color = "transparent")
  
  incProgress(4/4)
  Kenya_tif <- "data/GlobalSolarAtlas/PVOUT_Kenya.tif"
  raster_PVOUT_Kenya <- raster(Kenya_tif)
  raster_PVOUT_Kenya <- aggregate(raster_PVOUT_Kenya, fact = 8, fun = mean)
  pal_kenya <- colorNumeric(palette = custom_palette, domain = values(raster_PVOUT_Kenya), na.color = "transparent")
 
  centroids_tz_sam <- st_read("data/TZ_SAM/centroids.gpkg", layer = "centroids")
  
  leaflet() %>%
    addTiles(group = "OpenStreetMap") %>%
    
    addProviderTiles(
      providers$Esri.WorldImagery,
      options = (
        tileOptions(maxZoom = 19)
      ),
      group = "Esri Satellite") %>% 
    
    addMarkers(
      data = centroids_tz_sam,
      popup = ~paste(
        "ID: ", cluster_id, "<br>",
        "Capacity (MW): ", capacity_mw, "<br>", 
        "Constructed After: ", constructed_after, "<br>",
        "Constructed Before: ", constructed_before
        ),      
        clusterOptions = markerClusterOptions(),
      group = "Show solar parks"
    ) %>%
    addTiles(attribution = 'TransitionZero (2024) Solar Asset Mapper') %>% # there is no attribution argument in addMarkers above, hence this "hack") 
    
    addRasterImage(
       raster_PVOUT_Tanzania, 
       colors = pal_tanzania, 
       opacity = 0.7,
       attribution = "Solargis (2019)",
       group = "Power potential Tanzania"
       ) %>%
     
    addLegend(
       pal = pal_tanzania, 
       values = values(raster_PVOUT_Tanzania), 
       title = "Power potential Tanzania (kWh/kWp)",
       group = "Power potential Tanzania"
       ) %>%
     
    addRasterImage(
       raster_PVOUT_Uganda, 
       colors = pal_uganda, 
       opacity = 0.7,
       attribution = "Solargis (2019)",
       group = "Power potential Uganda"
       ) %>%
     
    addLegend(
       pal = pal_uganda, 
       values = values(raster_PVOUT_Uganda), 
       title = "Power potential Uganda (kWh/kWp)",
       group = "Power potential Uganda"
     ) %>%
     
    addRasterImage(
       raster_PVOUT_Madagascar, 
       colors = pal_madagascar, 
       opacity = 0.7,
       attribution = "Solargis (2019)",
       group = "Power potential Madagascar"
     ) %>%
     
    addLegend(
       pal = pal_madagascar, 
       values = values(raster_PVOUT_Madagascar), 
       title = "Power potential Madagascar (kWh/kWp)",
       group = "Power potential Madagascar"
     ) %>%
     
    addRasterImage(
       raster_PVOUT_Kenya, 
       colors = pal_kenya, 
       opacity = 0.7,
       attribution = "Solargis (2019)",
       group = "Power potential Kenya"
     ) %>%
     
    addLegend(
       pal = pal_uganda, 
       values = values(raster_PVOUT_Kenya), 
       title = "Power potential Kenya (kWh/kWp)",
       group = "Power potential Kenya"
     ) %>%
    
    addLayersControl(
      baseGroups = c(
        "OpenStreetMap",
        "Esri Satellite"
        ),
      overlayGroups = c(
        "Show solar parks", 
        "Power potential Tanzania", 
        "Power potential Uganda", 
        "Power potential Madagascar", 
        "Power potential Kenya"
        ),
      options = layersControlOptions(collapsed = TRUE) 
    ) %>%
    hideGroup(c(
        "OpenStreetMap",
        "Stadia Alidade Satellite",
        "Show solar parks",
        "Power potential Tanzania", 
        "Power potential Uganda", 
        "Power potential Madagascar",
        "Power potential Kenya"
        )) %>%
    
    showGroup("Esri Satellite") %>%
    
    addDrawToolbar(
      targetGroup='draw',
      
      editOptions = editToolbarOptions(
        selectedPathOptions = selectedPathOptions(
          weight = 0.3, 
          color = "orange",
          fill = TRUE,
          fillColor = "yellow",
          fillOpacity = 0.8
          )
        ),
      
      polylineOptions = FALSE,
      
      polygonOptions = list(
        shapeOptions = drawShapeOptions(
          color = "orange",
          fillColor = "yellow",
          weight = 1.3,
          fillOpacity = 0.7
          )
        ),
    circleOptions = FALSE,
    rectangleOptions = FALSE,
    circleMarkerOptions = FALSE,
    markerOptions = FALSE
    ) %>%
    
    addEasyButton(
      easyButton( 
        icon="fa-globe", 
        title="Zoom to Level 1",
        onClick = JS("function(btn, map){ map.setView([-7.441284, 35.692778, ], 5); }")
        )
      ) %>%
    
    setView(lng = africa_lon, lat = africa_lat, zoom = initial_zoom_level) %>%
    
    addResetMapButton() %>%
    
    addSearchOSM(
      options = searchOptions(
        autoCollapse = TRUE, 
        minLength = 2,
        textPlaceholder = "Search..."
        )
      )
    
    })
  }





