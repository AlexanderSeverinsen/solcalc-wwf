
EnergyPricingUI <- function(id) {
  ns <- NS(id)
  nav_panel(
    "Energy pricing",
    value = "energy_pricing", 
    
    navset_card_underline(
      nav_panel(
        "Uganda",
        layout_column_wrap(
          width = 1/2,
          height = 300,
  
          
          navset_card_tab(
            height = 450,
            full_screen = TRUE,
            title = "",
            nav_panel(
              "Energy cost components per kWh for example cases",
              highchartOutput(ns("energy_chart_ug"))
           
            ),
            nav_panel(
              "Domestic customer",
              highchartOutput(ns("pieChartUg")),
                layout_column_wrap(
                  value_box(
                    title = "Total cost per kWh for example case",
                    value = "486 UGX/kWh",
                    #p("bslib ain't one", bs_icon("emoji-smile")),
                    #p("hit me", bs_icon("suit-spade"))
                  ),
                  value_box(
                    title = "Total monthly cost for example case",
                    value = "48 616 UGX",
                    #p("bslib ain't one", bs_icon("emoji-smile")),
                    #p("hit me", bs_icon("suit-spade"))
                  ),
                  value_box(
                    title = "",
                    value = "",
                    p(tags$b("Description")),  # Bold text
                    p(tags$small("A family of five has a few more appliances and uses a small electric cooker a few times a week. They have a medium-sized refrigerator and occasionally use a microwave, in addition to lighting, TV, fan and charging electronics.Their average monthly consumption is 130 kWh")) # Smaller text
                  )
                  
               )
            )
          ),
          layout_column_wrap(
            width = 1,
            heights_equal = "row",
            card(
              full_screen = TRUE,
              card_header("Stakeholders"),
              gt_output(ns("stakeholders_table_uganda"))
            ),
            card(
              full_screen = TRUE,
              card_header("Price components"),
              gt_output(ns("component_table_ug"))
            )
            
            
          )
          
          
        )
        
      ),
      
      
      nav_panel(
        "Tanzania",
        
            layout_column_wrap(
              width = 1/2,
              height = 300,
              card(
                full_screen = TRUE,
                card_header("Energy cost components per kWh for example cases"),
                highchartOutput(ns("energy_chart"))
              )
              
              ,
              layout_column_wrap(
                width = 1,
                heights_equal = "row",
                card(
                  full_screen = TRUE,
                  card_header("Stakeholders in Tanzania’s Energy Sector"),
                  gt_output(ns("stakeholders_table_tz"))
                ),
                card(
                  full_screen = TRUE,
                  card_header("Price components"),
                  gt_output(ns("component_table_tz"))
                )
               
                  
              )
              
              
            )
        
        
    
        
        
        
      ),
      
      
      nav_panel(
        "Kenya",
        layout_column_wrap(
          width = 1/2,
          height = 300,
          card(
            full_screen = TRUE,
            card_header("Energy cost components per kWh for example cases"),
            highchartOutput(ns("energy_chart_kenya"))
          )
          
          ,
          layout_column_wrap(
            width = 1,
            heights_equal = "row",
            card(
              full_screen = TRUE,
              card_header("Stakeholders"),
              gt_output(ns("stakeholders_table_kenya"))
            ),
            card(
              full_screen = TRUE,
              card_header("Price components"),
              gt_output(ns("component_table_kenya"))
            )
            
            
          )
          
          
        )
        
      ),
      nav_panel(
        "Madagascar",
        layout_column_wrap(
          width = 1/2,
          height = 300,
          card(
            full_screen = TRUE,
            card_header("Energy cost components per kWh for example cases"),
            highchartOutput(ns("energy_chart_mad"))
          )
          
          ,
          layout_column_wrap(
            width = 1,
            heights_equal = "row",
            card(
              full_screen = TRUE,
              card_header("Stakeholders"),
              gt_output(ns("stakeholders_table_mad"))
            ),
            card(
              full_screen = TRUE,
              card_header("Price components"),
              gt_output(ns("component_table_mad"))
            )
            
            
          )
          
          
        )
        
      )
    )
    
    
    
  )
}

EnergyPricingServer <- function(id) {
  moduleServer(id, function(input, output, session) {
  
    
    # -----------   Tanzania ---------------
    
    price_data_tz <- tibble(
      Group = c(
        "Domestic low consumption (D1)", 
        "Domestic medium consumption (D1)", 
        "Small business (T1)", 
        "Medium sized factory (T2)", 
        "Large manufacturing plant (T3-MV)", 
        "Steel-mill (T3-HV)"
      ),
      Energy_cost_kWh = c(100, 193.75, 292, 195, 157, 152),
      Demand_cost_kWh = c(0, 0, 0, 37.51, 66, 50.55),
      Service_charge_kWh = c(0, 0, 0, 1.779125, 0.33538, 0),
      VAT_kWh = c(18, 34.875, 52.56, 42.1720425, 40.2003684, 36.459)
    )
    
    output$energy_chart <- renderHighchart({
      highchart() %>%
        hc_chart(type = "column") %>%
        hc_title(text = "") %>%
        hc_subtitle(
          text = "
          Electricity prices in Tanzania are influenced by production costs (including fuel mix), transmission and distribution expenses, 
          government subsidies and regulatory decisions by EWURA (Energy and Water Utilities Regulatory Authority). 
          The government regularly assesses service provision costs to determine appropriate pricing 
          ",
          align = "left",  
          verticalAlign = "bottom",  # Position the note at the bottom
          style = list(fontSize = "12px", color = "#555555")  # Customize font size and color
        ) %>%
        hc_xAxis(categories = price_data_tz$Group, title = list(text = "Group")) %>%
        hc_yAxis(title = list(text = "Price per kWh in TZS")) %>%
        hc_add_series(name = "Energy Cost (kWh)", data = price_data_tz$Energy_cost_kWh) %>%
        hc_add_series(name = "Demand Cost (kWh)", data = price_data_tz$Demand_cost_kWh) %>%
        hc_add_series(name = "Service Charge (kWh)", data = price_data_tz$Service_charge_kWh) %>%
        hc_add_series(name = "VAT (kWh)", data = price_data_tz$VAT_kWh) %>%
        hc_plotOptions(column = list(stacking = "normal")) %>%
        hc_legend(enabled = TRUE)
    })
    
    
    stakeholders_tz <- tibble(
      Stakeholder = c(
        "Ministry of Energy",
        "EWURA (Energy and Water Utilities Regulatory Authority)",
        "Rural Energy Agency (REA)"
      ),
      Description = c(
        "This ministry formulates energy policies and strategies, overseeing the development of Tanzania’s energy infrastructure and renewable energy projects.",
        "EWURA regulates the energy sector, sets tariffs, and ensures compliance with safety and service standards.",
        "REA focuses on expanding electricity access in rural areas by developing energy infrastructure and promoting off-grid solutions."
      )
    )
    
  output$stakeholders_table_tz <- render_gt({
   stakeholders_tz %>%
        gt() %>%
        cols_label(
          Stakeholder = md("Stakeholders"),
          Description = md("Descriptions")
        ) %>%
        tab_style(
          style = list(
            cell_text(weight = "bold")
          ),
          locations = cells_column_labels(everything())
        ) 
    })
  
 
  components_tz <- tibble(
    Component = c(
      "Energy charge",
      "Service charge",
      "Demand charge",
      "VAT"
    ),
    Description = c(
      "The base cost of electricity per kWh, which differs by usage and consumer type.",
      "A fixed monthly charge for grid connection and maintenance, applied regardless of consumption.",
      "Applied to large industrial and commercial users based on their peak power demand (in kVA).",
      "An 18% value-added tax applied to the total electricity bill."
    )
  )
  
  output$component_table_tz <- render_gt({
    components_tz %>%
      gt() %>%
      cols_label(
        Component = md("Component"),
        Description = md("Description")
      ) %>%
      tab_style(
        style = list(
          cell_text(weight = "bold")
        ),
        locations = cells_column_labels(everything())
      ) 
  })
  

    # ------------------ Uganda ---------------------
    
    price_data_ug <- tibble(
      Group = c(
        "Domestic lifeline", 
        "Domestic low consumption", 
        "Domestic medium consumption", 
        "Domestic high consumption", 
        "Commercial", 
        "Medium industrial", 
        "Large industrial", 
        "Extra-Large Industrial"
      ),
      Energy_cost_kWh = c(250, 796, 412, 796, 600, 448, 379, 320),
      VAT_kWh = c(45, 143, 74, 143, 108, 81, 68, 58)
    ) %>%
    arrange(desc(Energy_cost_kWh))
    
    output$energy_chart_ug <- renderHighchart({
      highchart() %>%
        hc_chart(type = "column") %>%
        hc_title(text = "") %>%
        hc_subtitle(
          text = "
            There are several electrical distribution operators in Uganda, and although the tariff consumer groups are fixed by the ERA, the tariffs differs slightly between operators. 
            We use Umemes tariff structure and numbers in our example. ERA adjust the prices each quarter using their tariff adjustment methodology which accounts for production, demand, 
            losses, operation and maintenance costs, revenue requirements, price index, fuel prices, exchange rates etc.
          ",
          align = "left",  
          verticalAlign = "bottom",  # Position the note at the bottom
          style = list(fontSize = "12px", color = "#555555")  # Customize font size and color
        ) %>%
        hc_xAxis(categories = price_data_ug$Group, title = list(text = "Group")) %>%
        hc_yAxis(title = list(text = "Price (UGX)")) %>%
        hc_add_series(name = "Energy Cost (kWh)", data = price_data_ug$Energy_cost_kWh) %>%
        hc_add_series(name = "VAT (kWh)", data = price_data_ug$VAT_kWh) %>%
        hc_plotOptions(column = list(stacking = "normal")) %>%
        hc_legend(enabled = TRUE)
    })
    
    
   
    components_ug <- tibble(
      Component = c(
        "Energy charge",
        "VAT"
      ),
      Description = c(
        "The base cost of electricity per kWh, which differs by usage and consumer type.",
        "An 18% value-added tax applied to the total electricity bill."
      )
    )
    
    output$component_table_ug <- render_gt({
      components_ug %>%
        gt() %>%
        cols_label(
          Component = md("Component"),
          Description = md("Description")
        ) %>%
        tab_style(
          style = list(
            cell_text(weight = "bold")
          ),
          locations = cells_column_labels(everything())
        ) 
    })
    
    

    stakeholders_uganda <- tibble(
      Stakeholder = c(
        "MEMD (Ministry of Energy and Mineral Development)",
        "ERA (The Electricity Regulatory Authority)",
        "Rural Electrification Agency (REA)",
        "Uganda Electricity Generation Company Ltd (UEGCL)",
        "Uganda Electricity Transmission Company Ltd (UETCL)",
        "Uganda Electricity Distribution Company Ltd (UEDCL)",
        "Umeme Ltd",
        "Independent Power Producers (IPPs)"
      ),
      Description = c(
        "This ministry formulates energy policies and strategies, overseeing the development of Uganda’s energy infrastructure and renewable energy projects.",
        "Regulates and supervises generation, transmission, distribution, sale, export, and import of electrical energy in Uganda. Responsible for issuing licenses, overseeing import/export, and establishing the tariff structure.",
        "Focuses on expanding electricity access in rural areas. It designs and implements rural electrification projects, aiming to increase Uganda's electrification rate.",
        "Primary state-owned power producer in Uganda, which operates the major hydropower plants along the Nile River.",
        "Manages and operates the high voltage transmission grid (above 33 kV), manages import and export, and serves as the system operator responsible for power balance and dispatching production.",
        "Manages and operates the distribution of electrical energy in the power grid below 33 kV. Although the distribution network is largely leased to private companies (such as Umeme), UEDCL retains ownership.",
        "Primary electricity distribution company.",
        "Private entities that generate electricity, particularly in renewable energy sectors like hydro, solar, and biomass. Key IPPs include Bujagali Energy Limited (BEL) and other small and medium-sized renewable energy producers."
      )
    )
    
    
    output$stakeholders_table_uganda <- render_gt({
      stakeholders_uganda %>%
        gt() %>%
        cols_label(
          Stakeholder = md("Stakeholders"),
          Description = md("Descriptions")
        ) %>%
        tab_style(
          style = list(
            cell_text(weight = "bold")
          ),
          locations = cells_column_labels(everything())
        ) 
    })
    
    
    
    
    
    # ------- Kenya ------------
    
 
    price_data_kenya <- tibble(
      Group = c(
        "Domestic lifeline", 
        "Domestic above lifeline", 
        "Small commercial", 
        "Large commercial (415 V)", 
        "Industrial - Medium (33 kV)", 
        "Industrial - Large (132 kV)"
      ),
      Energy_cost_kWh = c(14.9, 18.0, 19.2, 13.7, 11.9, NA),
      Demand_cost_kWh = c(NA, NA, NA, 5.5, 2.8, NA),
      FCC_kWh = c(3.3, 3.3, 3.3, 3.3, 3.3, NA),
      FERFA_kWh = c(2.0, 2.0, 2.0, 2.0, 2.0, NA),
      IA_kWh = c(0.3, 0.3, 0.3, 0.3, 0.3, NA),
      WARMA_kWh = c(0.0, 0.0, 0.0, 0.0, 0.0, NA),
      ERC_EPRA_kWh = c(0.1, 0.1, 0.1, 0.1, 0.1, NA),
      REP_kWh = c(0.0, 0.0, 0.0, 0.0, 0.0, NA),
      VAT_kWh = c(3.3, 3.8, 4.0, 4.0, 3.3, NA)
    )
    
    output$energy_chart_kenya <- renderHighchart({
      highchart() %>%
        hc_chart(type = "column") %>%
        hc_title(text = "") %>%
        hc_subtitle(
          text = "Historic tariffs can be accessed at <a href='https://www.stimatracker.com/' target='_blank'>StimaTracker</a>",
          align = "left",  
          verticalAlign = "bottom",  # Position the note at the bottom
          style = list(fontSize = "12px", color = "#555555")  # Customize font size and color
        ) %>%
        hc_xAxis(categories = price_data_kenya$Group, title = list(text = "Group")) %>%
        hc_yAxis(title = list(text = "Price (KES)")) %>%
        hc_add_series(name = "Energy Cost (kWh)", data = price_data_kenya$Energy_cost_kWh) %>%
        hc_add_series(name = "Demand Cost (kWh)", data = price_data_kenya$Demand_cost_kWh) %>%
        hc_add_series(name = "FCC (kWh)", data = price_data_kenya$FCC_kWh) %>%
        hc_add_series(name = "FERFA (kWh)", data = price_data_kenya$FERFA_kWh) %>%
        hc_add_series(name = "IA (kWh)", data = price_data_kenya$IA_kWh) %>%
        hc_add_series(name = "VAT (kWh)", data = price_data_kenya$VAT_kWh) %>%
        hc_plotOptions(column = list(stacking = "normal")) %>%
        hc_legend(enabled = TRUE)
      })
    
    
    
    components_kenya <- tibble(
      Component = c(
        "Energy price",
        "Demand charge",
        "Fuel Cost Charge (FCC)",
        "Foreign Exchange Rate Fluctuation Adjustment (FERFA)",
        "Inflation Adjustment (IA)",
        "WARMA Levy",
        "ERC/EPRA Levy",
        "REP Levy",
        "Power Factor Surcharge",
        "VAT"
      ),
      Description = c(
        "The base cost of electricity per kWh, which differs by usage and consumer type.",
        "Applied to large industrial and commercial users based on their peak power demand (in kVA).",
        "Variable rate per kWh, published monthly by KPLC in the Kenya Gazette (but not on their website!). It is reflective of the cost (to KPLC) of generating electricity during the previous month.",
        "Variable rate per kWh, published monthly by KPLC. This includes the sum of the foreign currency costs incurred by KenGen, the sum of the foreign currency costs incurred by KPLC other than those costs relating to Electric Power Producer, and the sum of the foreign currency costs incurred by KenGen.",
        "Variable rate per kWh, published monthly by KPLC. Factors include the Underlying Consumer Price Index as posted by Kenya National Bureau of Statistics and the Consumer Prices Index for all urban consumers (CPI - U) for the US city average for all items 1982 - 84 as published by the United States Department of Labour Statistics.",
        "Variable rate per kWh, published monthly by KPLC. It is determined from the amount of energy supplied from hydroelectric facilities in the previous month.",
        "Flat rate of 8 cents per kWh.",
        "5% of the energy price (base rate) for the given consumer group.",
        "A surcharge applied if the consumer's power factor (a value describing the efficiency of energy consumption) falls below 0.9. The surcharge applied is 2% of the base rate and the demand charge for every 1 per cent by which the Power Factor is below 0.9.",
        "16% on demand charge, fuel energy cost, and non-fuel energy cost."
      )
    )
    
   
    output$component_table_kenya <- render_gt({
      components_kenya %>%
        gt() %>%
        cols_label(
          Component = md("Component"),
          Description = md("Description")
        ) %>%
        tab_style(
          style = list(
            cell_text(weight = "bold")
          ),
          locations = cells_column_labels(everything())
        ) 
    })
    
    stakeholders_kenya <- tibble(
      Stakeholder = c(
        "Ministry of Energy",
        "EPRA (Energy and Petroleum Regulatory Authority)",
        "County Governments",
        "Kenya Power (KPLC)",
        "KenGen (Kenya Electricity Generating Company)",
        "Kenya Electricity Transmission Company (KETRACO)",
        "Rural Electrification and Renewable Energy Corporation (REREC)",
        "Geothermal Development Company (GDC)",
        "Independent Power Producers (IPPs)",
        "The Electricity Sector Association of Kenya (ESAK)"
      ),
      Description = c(
        "This government body sets energy policies, oversees energy development, and promotes renewable energy investments.",
        "Regulates the energy sector, sets electricity tariffs, licenses operators, and ensures compliance with energy standards.",
        "Prepare county energy plans and some provide supplementary funding for rural electrification.",
        "The main utility responsible for electricity distribution to consumers across the country. It handles metering, billing, and grid maintenance.",
        "The largest producer of electricity, focusing on geothermal, hydro, wind, and solar generation.",
        "Plans, designs, builds, and maintains high voltage electricity transmission lines and associated substations.",
        "Implements the Rural Electrification Programme and develops off-grid renewable energy solutions in rural areas.",
        "Responsible for exploring and developing Kenya’s geothermal energy resources.",
        "Private companies that generate electricity, often from renewable sources, and sell it to Kenya Power under power purchase agreements.",
        "A member-based organization composed of stakeholders in the electricity sector, including IPPs, project developers, consultants, and contractors."
      )
    )
    
  
    
    output$stakeholders_table_kenya <- render_gt({
      stakeholders_kenya %>%
        gt() %>%
        cols_label(
          Stakeholder = md("Stakeholders"),
          Description = md("Descriptions")
        ) %>%
        tab_style(
          style = list(
            cell_text(weight = "bold")
          ),
          locations = cells_column_labels(everything())
        ) 
    })
    
    
    # ----- Madagascar ----------
    
    
    price_data_mad <- tibble(
      Group = c(
        "Small domestic, lifeline", 
        "Small domestic", 
        "Medium domestic", 
        "Small commercial", 
        "Medium commercial, zone 1", 
        "Medium commercial, zone 3", 
        "Medium industrial, Zone 1", 
        "Medium industrial, Zone 3", 
        "Large industrial"
      ),
      Energy_cost_kWh = c(130, 340, 600, 795, 863, 1020, 504, 862, 352),
      Demand_cost_kWh = c(NA, 75, 42, 44, 75, 129, 156, 138, 150),
      Redevance_kWh = c(20, 80, 33, 2, 1, 25, 5, 4, 1),
      VAT = c(30, 99, 135, 168, 188, 235, 133, 201, 101)
    )
    
    output$energy_chart_mad <- renderHighchart({
      highchart() %>%
        hc_chart(type = "column") %>%
        hc_title(text = "") %>%
        hc_xAxis(categories = price_data_mad$Group, title = list(text = "Group")) %>%
        hc_yAxis(title = list(text = "Cost (MGA)")) %>%
        hc_subtitle(
          text = "
          There are several electrical distribution operators in Uganda, and although the tariff consumer groups are fixed by the ERA, 
          the tariffs differs slightly between operators. We use Umemes tariff structure and numbers in above example.
          ",
          align = "left",  
          verticalAlign = "bottom",  # Position the note at the bottom
          style = list(fontSize = "12px", color = "#555555")  # Customize font size and color
        ) %>%
        hc_add_series(name = "Energy Cost (kWh)", data = price_data_mad$Energy_cost_kWh) %>%
        hc_add_series(name = "Demand Cost (kWh)", data = price_data_mad$Demand_cost_kWh) %>%
        hc_add_series(name = "Redevance (kWh)", data = price_data_mad$Redevance_kWh) %>%
        hc_add_series(name = "VAT", data = price_data_mad$VAT) %>%
        hc_plotOptions(column = list(stacking = "normal")) %>%
        hc_legend(enabled = TRUE)
    })
    
    
    components_mad <- tibble(
      Component = c(
        "Energy charge",
        "VAT"
      ),
      Description = c(
        "The base cost of electricity per kWh, which differs by usage and consumer type.",
        "An 18% value-added tax applied to the total electricity bill."
      )
    )
    
    output$component_table_mad <- render_gt({
      components_mad %>%
        gt() %>%
        cols_label(
          Component = md("Component"),
          Description = md("Description")
        ) %>%
        tab_style(
          style = list(
            cell_text(weight = "bold")
          ),
          locations = cells_column_labels(everything())
        ) 
    })
    
    
    # Stakeholders
    stakeholders_mad <- tibble(
      Stakeholder = c(
        "Ministry of Energy and Hydrocarbons",
        "Ministry of Finance and Budget",
        "Agency for the Development of Rural Electrification (ADER)",
        "Office de Régulation de l’Electricitè (ORE)",
        "La Jirosy Rano Malagasy (JIRAMA)",
        "Independent Power Producers (IPPs)"
      ),
      Description = c(
        "Responsible for setting policies and strategies for the energy sector, including renewable energy initiatives.",
        "Involved in financing energy projects, budgeting for subsidies, and supporting international funding programs.",
        "Focuses on expanding access to electricity in rural and remote areas, often through renewable sources like solar and hydro.",
        "Regulates the energy sector, ensuring fair practices, tariff setting, and compliance with energy standards.",
        "Madagascar’s state-owned utility company responsible for generating, transmitting, and distributing electricity. It dominates the power market, though it faces challenges related to infrastructure and reliability.",
        "Private companies that generate electricity, often through renewable sources such as hydro, wind, and solar. IPPs sell power to JIRAMA or directly to end-users in some cases."
      )
    )
    
    
    output$stakeholders_table_mad <- render_gt({
      stakeholders_mad %>%
        gt() %>%
        cols_label(
          Stakeholder = md("Stakeholders"),
          Description = md("Descriptions")
        ) %>%
        tab_style(
          style = list(
            cell_text(weight = "bold")
          ),
          locations = cells_column_labels(everything())
        ) 
    })
 
    
    
    # ----- Uganda example case
    
    
    output$pieChartUg <- renderHighchart({
      highchart() %>%
        hc_chart(type = "pie") %>%
        hc_title(
          text = "Energy cost distribution",
          align = "center"
        ) %>%
        hc_subtitle(
          text = "for domestic medium consumption",
          align = "center"
        ) %>%
        hc_series(
          list(
            name = "Cost",
            data = list(
              list(name = "Energy Cost/kWh", y = 85),
              list(name = "Demand Cost/kWh", y = 15)
            )
          )
        ) %>%
        hc_plotOptions(
          pie = list(
            dataLabels = list(
              enabled = TRUE,
              format = '{point.name}: {point.y}%' # Display name and percentage
            )
          )
        ) %>%
        hc_legend(
          align = "center",
          verticalAlign = "bottom",
          layout = "horizontal"
        )
    })
    
    
    
    
    
    # ----- Tanzania example case
    
    
    
    
    
    # ---- Kenya example case
    
    
    
    
    # ----- Madagascar example case
    
    

    
   
  })
}






