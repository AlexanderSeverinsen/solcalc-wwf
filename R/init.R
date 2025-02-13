# ------ Libraries ------
# renv::init()
# renv::status()
# renv::snapshot()
library(shiny)

# Data manipulation and visualization
library(tibble)
library(dplyr)
library(scales)
library(highcharter)
library(RColorBrewer)
library(gt)

# Mapping and spatial data
library(leaflet)
library(sf)
library(leaflet.extras)

# Shiny extensions and UI
library(bslib)
library(shinyWidgets)
library(htmltools)
library(htmlwidgets)
library(bsicons)
library(fontawesome)
library(rintrojs)
library(shinyjs)

# Data fetching and processing
library(tidyverse)
library(httr)
library(httr2)
library(jsonlite)



# OSM scraped buildings/park to display in Solar simulator
solar_polygons <- st_read("data/osm/solar_polygons.gpkg")
solar_polygons_centroids <- st_read("data/osm/solar_polygons_centroids.gpkg")

# TZ-SAM solar park to display in Solar simulator
centroids_tz_sam <- st_read("data/TZ_SAM/centroids.gpkg", layer = "centroids")

# starting positions for the map

africa_lat <- -7.441284
africa_lon <- 35.692778

initial_zoom_level <- 6
search_zoom_level <- 17

# if (Sys.getenv("DOCKER_ENV") == "1") {
#   # it seems that Docker in unable to find the .Renviron file without setting it explicitly
#   Sys.setenv(R_RENVIRON_USER='/home/shiny-app/.Renviron')
#   readRenviron(Sys.getenv("R_RENVIRON_USER"))
# } else {
#   # renv makes it difficult to find proj, hence this when local
#   Sys.setenv(PROJ_LIB = "/usr/local/Cellar/proj/9.3.1/share/proj")
# }

Sys.setenv(PROJ_LIB = "/usr/local/Cellar/proj/9.3.1/share/proj")
#Sys.getenv("PROJ_LIB")


# addResourcePath("fonts", "./fonts") 

# Aneo_theme <- bs_theme(
#   preset = "shiny", 
#   heading_font = font_face(
#     family = "GT-Planar-Regular",
#     src = "url('/fonts/GT-Planar-Regular.otf')"
#   ),
#   base_font = font_face(
#     family = "GT-Planar-Regular",
#     src = "url('/fonts/GT-Planar-Regular.otf')"
#   )
# )