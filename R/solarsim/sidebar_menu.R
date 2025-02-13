#' Menu for the app sidebar menu
#' 
#' The menu options are searching for a building (no autocomplete, please help :-))
#' The search uses Bing map API (BingSearchMap.R). All the different conditions
#' for the PV potential can be changed in the menu: elprice, peak power (kwp), azimuth & angle
#' 
#' @importFrom shiny

sidebar_menu <- function() {
  sidebar_calc <- accordion(
    accordion_panel(
      open = FALSE,
      "Change parameters",
      icon = fontawesome::fa("calculator"),
      # numericInput("elprice", "Price (NOK)",
      #              min = 0, max = 50, value = 1.7, step = 0.1),
      numericInput("kwp", "Peak power (kWp)",
                   min = 0, max = 1500, value = 50, step = 1),
      selectizeInput(
        "azimuth", "PV Orientation", 
        choices = c("↑ North " = -180, 
                    "↗ North-East " = -135,
                    "→ East  " = -90,
                    "↘ South-East " = -45,
                    "↓ South " = 0,
                    "↙ South-West " = 45,
                    "← West " = 90,
                    "↖ North-West " = 135),
        multiple = FALSE,
        selected = -180, # sør
        options = list(plugins = "remove_button")
      ),
      sliderInput("angle", "PV angle °",
                  min = 0, max = 90, value = 10),
      # note that default loss factor from PVGIS is 14% which is probably pessimistic
      # The GlobalSolarAtlas sets this to 7.5%. Maybe include this as a menu choice
    )

  )
}




