# ---- User interface for the 'Data and goals' tab


dataandgoals_ui <- function(id) {
  ns <- NS(id)
  nav_panel(
  "Data and goals",
  id = "data_goals", 
  value = "data_goals", # !! to be able to link from home !!
  navset_card_underline(
    
    # --------------- Uganda ------------
    
    nav_panel(
      "Uganda",
      layout_column_wrap(
        width = 1/2,
        height = 300,
        card(
          full_screen = TRUE, 
          "Electricity access",
          highchartOutput(ns("El_Access_Ug"))
        ),
        card(
          full_screen = TRUE, 
          "Clean cooking access",
          highchartOutput(ns("cleancook_Ug"))
        ),
        
        navset_card_tab(
          height = 450,
          full_screen = TRUE,
          title = "Electricity generation",
          nav_panel(
            "All sources",
            highchartOutput(ns("el_gen_uganda"))
            
          ),
          nav_panel( 
            "Renewable sources",
            highchartOutput(ns("el_gen_uganda_32"))
            
          ),
          nav_panel(
            "On & off-grid",
            highchartOutput(ns("on_off_uganda"))
          )
          
        ),
        
        card(
          full_screen = TRUE,
          "Renewable share",
          highchartOutput(ns("RenShare_Ug"))
          
        )
      )
    ),
    
    # ---- tanzania ----
    
    nav_panel(
      "Tanzania",
      layout_column_wrap(
        width = 1/2,
        height = 300,
        card(
          full_screen = TRUE,
          "Electricity access",
          highchartOutput(ns("El_Access_Ta"))
        ),
        card(
          full_screen = TRUE,
          "Clean cooking access",
          highchartOutput(ns("cleancook_Ta"))
        ),
        
        navset_card_tab(
          height = 450,
          full_screen = TRUE,
          title = "Electricity generation",
          nav_panel(
            "All sources",
            highchartOutput(ns("el_gen_tanzania"))
            
          ),
          nav_panel(
            "Renewable sources",
            highchartOutput(ns("el_gen_tanzania_32"))
            
          ),
          nav_panel(
            "On & off-grid",
            highchartOutput(ns("on_off_tanzania"))
          )
          
        ),
        
        card(
          full_screen = TRUE,
          "Renewable share",
          highchartOutput(ns("RenShare_Ta"))
          
        )
      )
    ),
    
    
    # ---- Kenya ----
    
    nav_panel(
      "Kenya",
      layout_column_wrap(
        width = 1/2,
        height = 300,
        card(
          full_screen = TRUE,
            "Electricity access",
          highchartOutput(ns("El_Access_Ke"))
        ),
        card(
          full_screen = TRUE,
            "Clean cooking access",
          highchartOutput(ns("cleancook_Ke"))
        ),
        
        navset_card_tab(
          height = 450,
          full_screen = TRUE,
          title = "Electricity generation",
          nav_panel(
           "All sources",
            highchartOutput(ns("el_gen_kenya"))
   
          ),
          nav_panel(
            "Renewable sources",
            highchartOutput(ns("el_gen_kenya_32"))
        
          ),
          nav_panel(
            "On & off-grid",
            highchartOutput(ns("on_off_kenya"))
          )
       
        ),
        
        card(
          full_screen = TRUE,
            "Renewable share",
          highchartOutput(ns("RenShare_Ke"))
          
          
        )
      )
    ),
    
    # ------ Madagascar --------
    
    nav_panel(
      "Madagascar",
      layout_column_wrap(
        width = 1/2,
        height = 300,
        card(
          full_screen = TRUE,
          "Electricity access",
          highchartOutput(ns("El_Access_Ma"))
        ),
        card(
          full_screen = TRUE,
          "Clean cooking access",
          highchartOutput(ns("cleancook_Ma"))
        ),
        
        navset_card_tab(
          height = 450,
          full_screen = TRUE,
          title = "Electricity generation",
          nav_panel(
            "All sources",
           highchartOutput(ns("el_gen_mad"))
            
          ),
          nav_panel(
            "Renewable sources",
            highchartOutput(ns("el_gen_mad_32"))
            
          ),
          nav_panel(
            "On & off-grid",
            highchartOutput(ns("on_off_mad"))
          )
          
        ),
        
        card(
          full_screen = TRUE,
          "Renewable share",
          highchartOutput(ns("RenShare_Ma"))
          
        )
      )
    ),
    
    
    # ---- Data sources all countries ------
    
    nav_panel(
      "Data sources",
      layout_column_wrap(
        card(
          id = "GlobalSolarAtlas_card",
          full_screen = TRUE,
          card_header(
            "Global Solar Atlas"
          ),
          card_body(
              card_image(
                file = "pictures/gsa_logo.png",
                alt = "Global Solar atlas logo",
                href = "https://globalsolaratlas.info/map"
              ),
              markdown("The solar potential layers in the *Solar simulator* was collected from the [Global Solar Atlas](https://globalsolaratlas.info).
                         The service is provided by The World Bank and the International Finance Corporation. The data was prepared
                         by Solargis under contract to The World Bank.")
          )
        ),
        card(
          card_header(
      
            "PVGIS"
          ),
          card_body(
            layout_column_wrap(
              card_image(
                file = "pictures/PVGIS_logo.png",
                alt = "PVGIS logo",
                href = "https://joint-research-centre.ec.europa.eu/photovoltaic-geographical-information-system-pvgis_en"
              ),
              markdown("The solar simulator automatically fetched data from [PVGIS](https://joint-research-centre.ec.europa.eu/photovoltaic-geographical-information-system-pvgis_en).
                         PVGIS provides information on solar radiation and photovoltaic system performance for any location in the world, except the North and South Poles")
            )
          )
        ),
        card(
          card_header(
  
            "Transition Zero"
          ),
          card_body(
            layout_column_wrap(
              markdown("Info placeholder"), 
              markdown("Info placeholder <br>
                         [TransitionZero Solar Asset Mapper](https://solar.transitionzero.org/)")
            )
          )
        )
      ),
      layout_column_wrap(
        card(
          card_header(
            "IEA"
          ),
          card_body(
            layout_column_wrap(
              card_image(
                file = "pictures/iea-logo.png",
                alt = "IEA logo",
                href = "https://www.iea.org"
              ),
              markdown("The International Energy Agency (IEA) cooporate with governments and industry to secure and sustainable energy future for all <br>
                       More information? Visit <https://www.iea.org/about>")
            )
          )
        ),
        card(
          card_header(
        
            "The World Bank"
          ),
          card_body(
            layout_column_wrap(
              card_image(
                file = "pictures/The_World_Bank_logo.svg",
                alt = "The World Bank logo",
                href = "https://www.worldbank.org/ext/en/home"
              ),
              markdown("The World Bank is an international financial institution that provides grants and loans to the governments of low- and middle-income countries for the purposes of economic development. <br>
                       Find more information here: <https://www.worldbank.org>")
            )
          )
        ),
        card(
          card_header(

            "IRENA"
          ),
          card_body(
            layout_column_wrap(
              card_image(
                file = "pictures/irena_logo.png",
                alt = "IRENA logo",
                href = "https://www.irena.org/"
              ),
              markdown("The International Renewable Energy Agency (IRENA) is a lead global intergovernmental agency for energy transformation that serves as the principal platform for international cooperation, supports countries in their energy transitions, and provides state of the art data and analyses on technology, innovation, policy, finance and investment")
            )
          )
        )
      )
    )
  )
)

}


DataAndGoalsServer <- function(id) {
  moduleServer(id, function(input, output, session) {

    
    # ---- Uganda
    
    
    
    output$el_gen_uganda <- renderHighchart({  
      load("data/el_gen_uganda.Rda")
      highchart() %>%
        hc_add_series(data = el_gen_uganda, 
                      type = "line", 
                      hcaes(x = year, y = Generation, group = Energy_Source)) %>%
        #hc_title(text = "Electricity Generation by Source in Uganda (1990-2023)") %>%
        hc_xAxis(title = list(text = "Year")) %>%
        hc_yAxis(title = list(text = "Generation (GWh)")) %>%
        hc_tooltip(shared = TRUE) %>%
        hc_legend(enabled = TRUE)
    })
    
    # ---- Tanzania
    
    
    
    output$el_gen_tanzania <- renderHighchart({  
      load("data/el_gen_tanzania.Rda")
      highchart() %>%
        hc_add_series(data = el_gen_tanzania, 
                      type = "line", 
                      hcaes(x = year, y = Generation, group = Energy_Source)) %>%
       # hc_title(text = "Electricity Generation by Source in Tanzania (1990-2023)") %>%
        hc_xAxis(title = list(text = "Year")) %>%
        hc_yAxis(title = list(text = "Generation (GWh)")) %>%
        hc_tooltip(shared = TRUE) %>%
        hc_legend(enabled = TRUE)
    })
    
    
    
    
  # ---- Kenya


    
  output$el_gen_kenya <- renderHighchart({  
    load("data/el_gen_kenya.Rda")
    highchart() %>%
      hc_add_series(data = el_gen_kenya, 
                    type = "line", 
                    hcaes(x = year, y = Generation, group = Energy_Source)) %>%
     # hc_title(text = "Electricity Generation by Source in Kenya (1990-2023)") %>%
      hc_xAxis(title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Generation (GWh)")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(enabled = TRUE)
    })
  
  # ---- Madagascar
  
  
  
  output$el_gen_mad <- renderHighchart({  
    load("data/el_gen_mad.Rda")
    highchart() %>%
      hc_add_series(data = el_gen_mad, 
                    type = "line", 
                    hcaes(x = year, y = Generation, group = Energy_Source)) %>%
     # hc_title(text = "Electricity Generation by Source in Madagascar (1990-2023)") %>%
      hc_xAxis(title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Generation (GWh)")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(enabled = TRUE)
  })
  
  
  
  # ------------------- Renewable --------------------
  
  # ---- Uganda ----
  
  output$el_gen_uganda_32 <- renderHighchart({  
    
    load("data/el_gen_uganda_32.Rda")
    
    highchart() %>%
      hc_add_series(data = el_gen_uganda_32, 
                    type = "line", 
                    hcaes(x = year, y = Generation, group = Energy_Source)) %>%
     # hc_title(text = "Renewable Electricity by Source in Uganda (1990-2023)") %>%
      hc_xAxis(title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Generation (GWh)")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(enabled = TRUE)
  
  })
  
  # ---- Tanzania ----
  
  output$el_gen_tanzania_32 <- renderHighchart({  
    
    load("data/el_gen_tanzania_32.Rda")
    
    highchart() %>%
      hc_add_series(data = el_gen_tanzania_32, 
                    type = "line", 
                    hcaes(x = year, y = Generation, group = Energy_Source)) %>%
      #hc_title(text = "Renewable Electricity by Source in Tanzania (1990-2023)") %>%
      hc_xAxis(title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Generation (GWh)")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(enabled = TRUE)
    
  })
  
  # ---- Kenya ----
  
  output$el_gen_kenya_32 <- renderHighchart({  
    
    load("data/el_gen_kenya_32.Rda")
    
    highchart() %>%
      hc_add_series(data = el_gen_kenya_32, 
                    type = "line", 
                    hcaes(x = year, y = Generation, group = Energy_Source)) %>%
      #hc_title(text = "Renewable Electricity by Source in Kenya (1990-2023)") %>%
      hc_xAxis(title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Generation (GWh)")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(enabled = TRUE)
    
  })
  
  # ---- Madagascar ----
  
  output$el_gen_mad_32 <- renderHighchart({  
    
    load("data/el_gen_mad_32.Rda")
    
    highchart() %>%
      hc_add_series(data = el_gen_mad_32, 
                    type = "line", 
                    hcaes(x = year, y = Generation, group = Energy_Source)) %>%
     # hc_title(text = "Renewable Electricity by Source in Madagascar (1990-2023)") %>%
      hc_xAxis(title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Generation (GWh)")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(enabled = TRUE)
    
  })

  # ------------ On-grid off-grid --------
  
  # ----- Uganda -----
  
  output$on_off_uganda <- renderHighchart({  
    
    load("data/electricity_gen_3_3/plot_data_ug.Rda")
    
    highchart() %>%
      hc_chart(type = "column") %>%
     # hc_title(text = "Electricity Statistics in Uganda by Year") %>%
      hc_xAxis(categories = unique(plot_data_ug$Year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "GWh")) %>%
      hc_plotOptions(column = list(stacking = "normal")) %>%
      hc_add_series(
        name = "Renewable - On-grid",
        data = plot_data_ug %>%
          filter(Technology == "Total Renewable") %>%
          pull(On_grid),
        stack = "Total Renewable"
      ) %>%
      hc_add_series(
        name = "Renewable - Off-grid",
        data = plot_data_ug %>%
          filter(Technology == "Total Renewable") %>%
          pull(Off_grid),
        stack = "Total Renewable"
      ) %>%
      hc_add_series(
        name = "Non-Renewable - On-grid",
        data = plot_data_ug %>%
          filter(Technology == "Total Non-Renewable") %>%
          pull(On_grid),
        stack = "Total Non-Renewable"
      ) %>%
      hc_add_series(
        name = "Non-Renewable - Off-grid",
        data = plot_data_ug %>%
          filter(Technology == "Total Non-Renewable") %>%
          pull(Off_grid),
        stack = "Total Non-Renewable"
      )
    
  })
  
  # ----- Tanzania -----
  
  
  output$on_off_tanzania <- renderHighchart({  
    
    load("data/electricity_gen_3_3/plot_data_tanzania.Rda")
    
    highchart() %>%
      hc_chart(type = "column") %>%
     # hc_title(text = "Electricity Statistics in Tanzania by Year") %>%
      hc_xAxis(categories = unique(plot_data_tanzania$Year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "GWh")) %>%
      hc_plotOptions(column = list(stacking = "normal")) %>%
      hc_add_series(
        name = "Renewable - On-grid",
        data = plot_data_tanzania %>%
          filter(Technology == "Total Renewable") %>%
          pull(On_grid),
        stack = "Total Renewable"
      ) %>%
      hc_add_series(
        name = "Renewable - Off-grid",
        data = plot_data_tanzania %>%
          filter(Technology == "Total Renewable") %>%
          pull(Off_grid),
        stack = "Total Renewable"
      ) %>%
      hc_add_series(
        name = "Non-Renewable - On-grid",
        data = plot_data_tanzania %>%
          filter(Technology == "Total Non-Renewable") %>%
          pull(On_grid),
        stack = "Total Non-Renewable"
      ) %>%
      hc_add_series(
        name = "Non-Renewable - Off-grid",
        data = plot_data_tanzania %>%
          filter(Technology == "Total Non-Renewable") %>%
          pull(Off_grid),
        stack = "Total Non-Renewable"
      )
    
  })
  
  
  # ----- Kenya -----
  
  output$on_off_kenya <- renderHighchart({  
    
    load("data/electricity_gen_3_3/plot_data_kenya.Rda")
    
    highchart() %>%
      hc_chart(type = "column") %>%
     # hc_title(text = "Electricity Statistics in Kenya by Year") %>%
      hc_xAxis(categories = unique(plot_data_kenya$Year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "GWh")) %>%
      hc_plotOptions(column = list(stacking = "normal")) %>%
      hc_add_series(
        name = "Renewable - On-grid",
        data = plot_data_kenya %>%
          filter(Technology == "Total Renewable") %>%
          pull(On_grid),
        stack = "Total Renewable"
      ) %>%
      hc_add_series(
        name = "Renewable - Off-grid",
        data = plot_data_kenya %>%
          filter(Technology == "Total Renewable") %>%
          pull(Off_grid),
        stack = "Total Renewable"
      ) %>%
      hc_add_series(
        name = "Non-Renewable - On-grid",
        data = plot_data_kenya %>%
          filter(Technology == "Total Non-Renewable") %>%
          pull(On_grid),
        stack = "Total Non-Renewable"
      ) %>%
      hc_add_series(
        name = "Non-Renewable - Off-grid",
        data = plot_data_kenya %>%
          filter(Technology == "Total Non-Renewable") %>%
          pull(Off_grid),
        stack = "Total Non-Renewable"
      )
    
  })
  
  
  
  # ----- Madagascar -----
  
  
  
  output$on_off_mad <- renderHighchart({  
    
    
    load("data/electricity_gen_3_3/plot_data_mad.Rda")
    
    highchart() %>%
      hc_chart(type = "column") %>%
     # hc_title(text = "Electricity Statistics in Madagascar by Year") %>%
      hc_xAxis(categories = unique(plot_data_mad$Year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "GWh")) %>%
      hc_plotOptions(column = list(stacking = "normal")) %>%
      hc_add_series(
        name = "Renewable - On-grid",
        data = plot_data_mad %>%
          filter(Technology == "Total Renewable") %>%
          pull(On_grid),
        stack = "Total Renewable"
      ) %>%
      hc_add_series(
        name = "Renewable - Off-grid",
        data = plot_data_mad %>%
          filter(Technology == "Total Renewable") %>%
          pull(Off_grid),
        stack = "Total Renewable"
      ) %>%
      hc_add_series(
        name = "Non-Renewable - On-grid",
        data = plot_data_mad %>%
          filter(Technology == "Total Non-Renewable") %>%
          pull(On_grid),
        stack = "Total Non-Renewable"
      ) %>%
      hc_add_series(
        name = "Non-Renewable - Off-grid",
        data = plot_data_mad %>%
          filter(Technology == "Total Non-Renewable") %>%
          pull(Off_grid),
        stack = "Total Non-Renewable"
      )
    
    
  })
  
  
  
  # ----- Share of renewables 4
  
  # ---- Uganda -----
  
  output$RenShare_Ug <- renderHighchart({  
    
    load("data/renshare4/renShare_Uganda.Rda")
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(renShare_Uganda$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Share of Renewables (%)")) %>%
      hc_tooltip(pointFormat = "Year: {point.x}<br>Share: {point.y}%") %>%
      hc_add_series(
        name = "Modern Renewables",
        data = renShare_Uganda %>%
          pull(share_modern_renewables)
      )
    
  })
  
  # ---- Tanzania -----
  
  output$RenShare_Ta <- renderHighchart({  
    
    load("data/renshare4/renShare_Tanzania.Rda")
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(renShare_Tanzania$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Share of Renewables (%)")) %>%
      hc_tooltip(pointFormat = "Year: {point.x}<br>Share: {point.y}%") %>%
      hc_add_series(
        name = "Modern Renewables",
        data = renShare_Tanzania %>%
          pull(share_modern_renewables)
      )
    
  })
  
  # ---- Kenya -----
  
  output$RenShare_Ke <- renderHighchart({  
    
    load("data/renshare4/renShare_Kenya.Rda")
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(renShare_Kenya$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Share of Renewables (%)")) %>%
      hc_tooltip(pointFormat = "Year: {point.x}<br>Share: {point.y}%") %>%
      hc_add_series(
        name = "Modern Renewables",
        data = renShare_Kenya %>%
          pull(share_modern_renewables)
      )
    
  })
  
  # ---- Madagascar -----
  
  output$RenShare_Ma <- renderHighchart({  
  
    load("data/renshare4/renShare_Madagascar.Rda")

    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(renShare_Madagascar$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Share of Renewables (%)")) %>%
      hc_tooltip(pointFormat = "Year: {point.x}<br>Share: {point.y}%") %>%
      hc_add_series(
        name = "Modern Renewables",
        data = renShare_Madagascar %>%
          pull(share_modern_renewables)
      )
    
    
    
  })
  
  
  # ---------   Electricity access 1 (rural, urban, total ---------------
  
  
  # ---- Uganda -----
  
  output$El_Access_Ug <- renderHighchart({  
    
    load("data/electricity_access/uganda_el_access.Rda")
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(uganda_el_access$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Percentage")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(
        enabled = TRUE,
        align = "center",
        verticalAlign = "bottom",
        layout = "horizontal"
      ) %>%
      hc_add_series(
        name = "Urban",
        data = uganda_el_access %>%
          pull(urban)
      ) %>%
      hc_add_series(
        name = "Rural",
        data = uganda_el_access %>%
          pull(rural)
      ) %>%
      hc_add_series(
        name = "Total",
        data = uganda_el_access %>%
          pull(total)
      )
    
  })
  
  # ---- Tanzania -----
  
  output$El_Access_Ta <- renderHighchart({  
    
    load("data/electricity_access/tanzania_el_access.Rda")
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(tanzania_el_access$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Percentage")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(
        enabled = TRUE,
        align = "center",
        verticalAlign = "bottom",
        layout = "horizontal"
      ) %>%
      hc_add_series(
        name = "Urban",
        data = tanzania_el_access %>%
          pull(urban)
      ) %>%
      hc_add_series(
        name = "Rural",
        data = tanzania_el_access %>%
          pull(rural)
      ) %>%
      hc_add_series(
        name = "Total",
        data = tanzania_el_access %>%
          pull(total)
      )
    
  })
  
  
  
  # ----- Kenya ------
  
  output$El_Access_Ke <- renderHighchart({  
    
    load("data/electricity_access/kenya_el_access.Rda")
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(kenya_el_access$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Percentage")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(
        enabled = TRUE,
        align = "center",
        verticalAlign = "bottom",
        layout = "horizontal"
      ) %>%
      hc_add_series(
        name = "Urban",
        data = kenya_el_access %>%
          pull(urban)
      ) %>%
      hc_add_series(
        name = "Rural",
        data = kenya_el_access %>%
          pull(rural)
      ) %>%
      hc_add_series(
        name = "Total",
        data = kenya_el_access %>%
          pull(total)
      )
    
  })
  
  # ----- Madagascar ------
  
  output$El_Access_Ma <- renderHighchart({  
    
    load("data/electricity_access/madagascar_el_access.Rda")
    
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(madagascar_el_access$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Percentage")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(
        enabled = TRUE,
        align = "center",
        verticalAlign = "bottom",
        layout = "horizontal"
      ) %>%
      hc_add_series(
        name = "Urban",
        data = madagascar_el_access %>%
          pull(urban)
      ) %>%
      hc_add_series(
        name = "Rural",
        data = madagascar_el_access %>%
          pull(rural)
      ) %>%
      hc_add_series(
        name = "Total",
        data = madagascar_el_access %>%
          pull(total)
      )
    
  })



# -------   Clean cooking ------


# ---- Uganda -----

  output$cleancook_Ug <- renderHighchart({  
    
    load("data/cleanCooking/uganda_cc.Rda")
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(uganda_cc$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Percentage")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(
        enabled = TRUE,
        align = "center",
        verticalAlign = "bottom",
        layout = "horizontal"
      ) %>%
      hc_add_series(
        name = "Urban",
        data = uganda_cc %>%
          pull(urban)
      ) %>%
      hc_add_series(
        name = "Rural",
        data = uganda_cc %>%
          pull(rural)
      ) %>%
      hc_add_series(
        name = "Total",
        data = uganda_cc %>%
          pull(total)
      )
  
  })


# ---- Tanzania -----

  output$cleancook_Ta <- renderHighchart({  
    
    load("data/cleanCooking/tanzania_cc.Rda")
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(tanzania_cc$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Percentage")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(
        enabled = TRUE,
        align = "center",
        verticalAlign = "bottom",
        layout = "horizontal"
      ) %>%
      hc_add_series(
        name = "Urban",
        data = tanzania_cc %>%
          pull(urban)
      ) %>%
      hc_add_series(
        name = "Rural",
        data = tanzania_cc %>%
          pull(rural)
      ) %>%
      hc_add_series(
        name = "Total",
        data = tanzania_cc %>%
          pull(total)
      )
    
  })


# ---- Kenya -----

  output$cleancook_Ke <- renderHighchart({  
    
    load("data/cleanCooking/kenya_cc.Rda")
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(kenya_cc$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Percentage")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(
        enabled = TRUE,
        align = "center",
        verticalAlign = "bottom",
        layout = "horizontal"
      ) %>%
      hc_add_series(
        name = "Urban",
        data = kenya_cc %>%
          pull(urban)
      ) %>%
      hc_add_series(
        name = "Rural",
        data = kenya_cc %>%
          pull(rural)
      ) %>%
      hc_add_series(
        name = "Total",
        data = kenya_cc %>%
          pull(total)
      )
    
  })


# ---- Madagascar -----

  output$cleancook_Ma <- renderHighchart({  
    
    load("data/cleanCooking/madagascar_cc.Rda")
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = unique(madagascar_cc$year), title = list(text = "Year")) %>%
      hc_yAxis(title = list(text = "Percentage")) %>%
      hc_tooltip(shared = TRUE) %>%
      hc_legend(
        enabled = TRUE,
        align = "center",
        verticalAlign = "bottom",
        layout = "horizontal"
      ) %>%
      hc_add_series(
        name = "Urban",
        data = madagascar_cc %>%
          pull(urban)
      ) %>%
      hc_add_series(
        name = "Rural",
        data = madagascar_cc %>%
          pull(rural)
      ) %>%
      hc_add_series(
        name = "Total",
        data = madagascar_cc %>%
          pull(total)
      )
    

  })


  
  })
}










