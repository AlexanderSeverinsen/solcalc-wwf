# ---- UI for front page ----
HomeUI <- function(id) {
  ns <- NS(id)
  
    nav_panel(
        "Home",
        layout_column_wrap(
          card(
            card_header(
              class = "bg-dark",
              "Data and goals"
            ),
            card_body(
              layout_column_wrap(
                highcharter::highchartOutput('data_goals'),
                # Combine markdown text and actionLink for an inline flow
                markdown(
                  paste0(
                    "Explore the development in renewable energy in East-Africa. Learn about regional and national goals and plans compared to current activity.
                    <br><br> For more details, visit ",
                    actionLink(
                      inputId = ns("go_to_data_and_goals"),
                      label = "Data and goals",
                      style = "cursor: pointer; text-decoration: underline; color: #007bff;" 
                    )
                  )
                )
              )
            )
            
          ),
          card(
            card_header(
              class = "bg-dark",
              "Energy Pricing"
            ),
            card_body(
              layout_column_wrap(
                highcharter::highchartOutput('pricing_front'),
                markdown(
                  paste0(
                    "Learn how the electricity prices in your country are determined, what the price drivers are and get an overview of the energy system.
                    <br><br> For more details, visit ",
                    actionLink(
                      inputId = ns("go_to_energy_pricing"),
                      label = "Energy pricing",
                      style = "cursor: pointer; text-decoration: underline; color: #007bff;" 
                    )
                  )
                )
              )
             
            )
          )
        ),
        
        card(
          card_header(
            class = "bg-dark",
            "Solar simulator"
          ),
          card_body(
            layout_column_wrap(
              highcharter::highchartOutput('solar_sim_front'),
              markdown(
                paste0(
                  "Research the potential for solar energy production in your region. Calculate possible energy production in spesific area
                    <br><br> For more details, visit ",
                  actionLink(
                    inputId = ns("go_to_solar_simulator"),
                    label = "Solar simulator",
                    style = "cursor: pointer; text-decoration: underline; color: #007bff;" 
                  )
                )
              )
            )
          )
        )
      )
    
    
}    

#https://forum.posit.co/t/cant-use-updatetabsetpanel-within-shiny-module/137512

HomeServer <- function(id, parent_session) {
  moduleServer(id, function(input, output, session) {
    
    observeEvent(input$go_to_data_and_goals, {
      cat("Button clicked! Navigating to Data and Goals...\n") 
      
      # Use the parent session and updateNavbarPage
      updateNavbarPage(
        parent_session, 
        inputId = "main_nav", 
        selected = "data_goals"
        )
    })
    
    observeEvent(input$go_to_energy_pricing, {
      cat("Button clicked! Navigating to Energy pricing...\n") 
      
      # Use the parent session and updateNavbarPage
      updateNavbarPage(
        parent_session, 
        inputId = "main_nav", 
        selected = "energy_pricing"
      )
    })
    
    observeEvent(input$go_to_solar_simulator, {
      cat("Button clicked! Navigating to Solar simulator...\n") 
      
      # Use the parent session and updateNavbarPage
      updateNavbarPage(
        parent_session, 
        inputId = "main_nav", 
        selected = "solar_simulator"
      )
    })
    
    
    
    
  })
}    



