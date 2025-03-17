

# Energy pricing module
source("R/Module_Energy_Pricing.R")

# Solar simulator
source("R/solarsim/sidebar_menu.R")
source("R/solarsim/get_pvgis_data.R")
source("R/solarsim/showSolarRoofs.R")
source("R/solarsim/showSolarParks.R")
source("R/solarsim/leafletMap.R")

# Frontpage
source("R/home/DataAndGoalsChart.R")
source("R/home/Solarsim_frontpage.R")
source("R/home/pricing_frontpage.R")
source("R/home/home_ui.R")

# Data and goals
source("R/dataandgoals/dataandgoals_ui.R")

# ----- UI ----

ui <- page_navbar(
  useShinyjs(),
  useBusyIndicators(),
  id = "main_nav",

  lang = "en",
  title = "RENEWABLE ENERGY TOOL",
  tags$head(tags$link(rel="shortcut icon", href="favicon.ico")),
  
  # include WWF logo to the left of main app title
  tags$script(HTML("
    $(document).ready(function() {
        var header = $('.navbar > .container-fluid');
        var logoHtml = '<div style=\"float:left; margin-right:40px; padding:0;\">' +
                       '<img src=\"logo_wwf_panda.svg\" alt=\"logo\" style=\"height:100px; width:100px;\">' +
                       '</div>';
        header.prepend(logoHtml);
    });
  ")),
  nav_spacer(),
  HomeUI("Home"),
  dataandgoals_ui("DataAndGoals"),
  EnergyPricingUI("EnergyPricing"),
  
  nav_panel(
    "Solar simulator",
    id = "solar_simulator", # will use in front page text to get to the simulator
    value = "solar_simulator",
    introjsUI(),
    card(
      full_screen = TRUE,
      card_header(class = "bg-dark","Solar simulator"),
      
      layout_sidebar(
        fillable = TRUE,
        sidebar = sidebar(width = 275, open = FALSE, sidebar_menu()),
        leafletOutput("map"),
        actionButton("help", "Show Tour")
      )
    ), 
    
    conditionalPanel(
      condition = "output.hasData && output.dataReady",
      layout_column_wrap(
        width = 1/2,
        height = 250,
        card(full_screen = TRUE, 
             card_header("Estimated solar production"),
             highcharter::highchartOutput('solar_production')),
        value_box(
               title = "Yearly solar production",
               value = textOutput("solar_pot"),
               p("Number of solar panels:", textOutput("num_panels_output", inline = TRUE)),
               p("Area used:", textOutput("area", inline = TRUE)),
               p("Assuming 70% of area covered with panels"),
               showcase = fontawesome::fa_i("solar-panel"))
      )
    )
  ),
  
  nav_item(
    input_dark_mode(id = "dark_mode", mode = "light")
  )
  
)

# ---------  Server ------------

server <- function(input, output, session) {
  
  HomeServer("Home", parent_session = session)
  
  DataAndGoalsServer("DataAndGoals")


  # Dynamically show additional text when the card is in full-screen mode
  output$additional_info <- renderUI({
    if (isTRUE(input$GlobalSolarAtlas_card_full_screen)) {  # Check if card is in full screen
      markdown("
          Kenya. <br>
          Optimum tilt ranges from 0-12 degree towards equator. Losses due to dirt and soiling 3.5%. 
          Other conversion losses 7.5% (inter-row shading, mismatch, inverters, cables, transformers, etc.)
               ")
    } else {
      NULL  # Hide the additional text when not in full-screen mode
    }
  })
  
  
  # ---- Step 1 The map is initiated when user click "Solar simulator"
  # Note that the map is updated in ObserveEvent above using leafletProxy  
  
  output$map <- renderLeaflet({
    leafletMap(africa_lat, africa_lon, initial_zoom_level)
  })  
  
  # --- Step 2 The use may want to have a short tour of the functionality
  
  # Start the introjs tour when the help button is clicked
  observeEvent(input$help, {
    introjs(session, options = list(
      steps = data.frame(
        element = c(".leaflet-draw-draw-polygon", "#map", ".leaflet-control-layers-toggle", ".collapse-toggle"), 
        intro = c("Zoom in to the relevant area, and use this tool to outline an area for a potential solar panel installation.",
                  "The solar potential estimation will start automatically when the area is drawn, and a summary of the findings and the monthly production will be presented.",
                  "Use this menu to toggle between different layers such as satellite views and OpenStreetMap.",
                  "Click this button to toggle the sidebar where you can access the parameters that were used to estimate the solar potential for your chosen area. You may change aand of the parameters to investigate how that that impacts solar production.")
      )
    ))
  })
  
  # ---- Step 3 The user draws a polygon ----
  # Initiating reactive values
  
  lat <- reactiveVal(NULL)
  lon <- reactiveVal(NULL)
  num_panels <- reactiveVal(0)
  dataReady <- reactiveVal(FALSE) # to prevent value boxes from updating before we finish calculations
  area_sqm <- reactiveVal(0)
  appInitialized <- reactiveVal(FALSE)
  
  # Area calculations based on drawing polygon
  observeEvent(input$map_draw_new_feature, {
    feature <- input$map_draw_new_feature
    if(feature$geometry$type == "Polygon") {
      coordinates <- matrix(unlist(feature$geometry$coordinates), ncol = 2, byrow = TRUE)
      polygon <- st_polygon(list(coordinates))
      sf_polygon <- st_sfc(polygon, crs = st_crs(4326))
      
      # Calculate centroid (as a basis to fetch lon/lat)
      centroid <- st_centroid(sf_polygon)
      centroid_coords <- st_coordinates(centroid)
      
      # Extract longitude and latitude from centroid
      centroid_lon <- centroid_coords[1, 1]
      centroid_lat <- centroid_coords[1, 2]
      
      # Update the reactive values for latitude and longitude
      lat(centroid_lat) 
      lon(centroid_lon)
      
      #print(paste("Centroid Longitude:", centroid_lon, "Latitude:", centroid_lat))
      
      # Reproject to UTM Zone 33N  and calculate total area used for panels
      sf_polygon_utm <- st_transform(sf_polygon, crs = 32633)
      calculated_area <- as.numeric(st_area(sf_polygon_utm))
      
      # Update the reactive value
      area_sqm(calculated_area)  
      #print(paste("Calculated Area: ", area_sqm())) 
      
      # --- Function to find peak power based on roof area
      
      # assuming that we can install panels on 70% of the roof (roof_efficiency)
      # we will use kwp to feed into the get_pv_gis function (PVGIS)
      
      roof_peakpower <- function(roof_area_calc) {
        standard_panel <- 1.6 #m2
        roof_area_calc = area_sqm()
        roof_efficiency = 0.7
        n_panels <- round(roof_area_calc/standard_panel)*roof_efficiency 
        num_panels(n_panels) # Update the reactive value
        optimal_peakpower = (n_panels * 330)/1000
        roof_peakpower = optimal_peakpower #* roof_efficiency
        return(roof_peakpower)
      }
      
      # this is for the value_box in UI
      output$num_panels_output <- renderText({
        round(num_panels())
      })
      
      peakpower <- roof_peakpower(area_sqm)
      print(paste("peak",peakpower))
      
      # Function to update kwp 
      updateNumericInput(session, "kwp", value = peakpower) 
      
      dataReady(TRUE)
      output$dataReady <- reactive({ dataReady() })
      outputOptions(output, 'dataReady', suspendWhenHidden = FALSE)
      
      # Reactive expression to check if data_df_reactive has data, will be used to display result after calculations
      hasData <- reactive({
        !is.null(data_df_reactive())
      })
      
      output$hasData <- reactive({
        hasData()
      })
      
      outputOptions(output, 'hasData', suspendWhenHidden = FALSE)
      
    }
  })
  

  
  showProgress <- function() {
    if(appInitialized()) {  
      withProgress(message = 'Connecting to PVGIS solar database..', value = 0, {
        n <- 10
        for (i in 1:n) {
          incProgress(1/n, detail = paste("Estimating potential...", i))
          Sys.sleep(0.1)
        }
      })
    }
  }
  
  # ----  Observers for changes in "Change parameter" UI inputs
  
  observeEvent(input$azimuth, {
    showProgress()
  })
  
  observeEvent(input$angle, {
    showProgress()
  })
  
  
  # Hi. I am just here to make sure the progress bar shows AFTER initiating the app
  observe({
    appInitialized(TRUE)
  })
  
  # picking up choice of orientation
  selected_azimuth <- reactive({
    input$azimuth
  })
  
  # ---- Get data from PVGIS into a reactive
  # content of reactive: solar potential and irradiation
  # initially the reactive will have peak_power based on area_sqm
  # when user inputs a kWp this will be re-calculated
  
  data_df_reactive <- reactive({
    if (is.null(lat()) || is.null(lon())) {
      return(NULL)
    }
    
    current_peakpower <- if (is.null(input$kwp)) roof_peakpower(area_sqm) else input$kwp
    aspect <- selected_azimuth()
    print("Fetching PVGIS data")  # Debugging statement
    req(lat(), lon())
    get_pvgis_data(lon(), lat(), current_peakpower, input$angle, aspect)
  }) %>% debounce(2000) 
  
  

  
  # Activate markers for PV on East-African roofs - data from OSM
  # observe({
  #   showSolarRoofs(input, solar_polygons, solar_polygons_centroids, "map")
  # })
  
  # Activate markers for TZ-SAM solar parks
  # observe({
  #   showSolarParks(input, centroids_tz_sam, "map")
  # })
  # 
  
  # Event listener for clicking a marker
  observeEvent(input$map_marker_click, {
    click <- input$map_marker_click
    leafletProxy("map") %>%
      setView(lng = click$lng, lat = click$lat, zoom = 17) # 17 is the maximum in Esri Satelite 
  })
  
  # the solar potential that will be displayed in the app
  solar_pot <- reactive({
    if (!is.null(data_df_reactive())) {
      sum(data_df_reactive()$outputs$monthly$fixed$E_m)
    } else {
      0 
    }
  })
  

  
  
  # ---- This observer does the following when the underlying solar production data change ----
  # 1. Get monthly solar data & show production graph
  # 2. Display area of roof in value box
  # 3. Display the solar potential in value box
  observe({
    
    data_df <- data_df_reactive()
    monthly_data <- data_df$outputs$monthly$fixed
    print(monthly_data)
    
    if (is.null(monthly_data) || nrow(monthly_data) == 0) {
      return(NULL)
    }
  
    output$solar_production <- renderHighchart({
      monthlySolarProductionChart(monthly_data)
    })  
    
    # ---- OUTPUT FOR VALUE BOXES FRONT PAGE ----
    
    formatter <- label_number(big.mark = " ", decimal.mark = ",", accuracy = 1)
    
    # Roof area - VALUE BOX (1)
    output$area <- renderText({
      formatted_area <- formatter(area_sqm())
      paste(formatted_area," m²")
    })
    
    # Potential production - VALUE BOX (2)
    output$solar_pot <- renderText({
      formatted_solar_pot <- formatter(solar_pot())
      paste(formatted_solar_pot, "kWh")
    })
    
  })
  
  # ---- Module for Solar production in East-Africa
  
  EnergyPricingServer("EnergyPricing")
  

  # ---- Output for the frontpage ----
  
  output$data_goals <- renderHighchart({
    DataAndGoalsChart()
  })  
  
  output$solar_sim_front <- renderHighchart({
    Solarsim_frontpage("countries/tz/tz-all")
  })  
  
  output$pricing_front <- renderHighchart({
    pricing_frontpage()
  })  
  
}

shinyApp(ui = ui, server = server)
