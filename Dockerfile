FROM rocker/r-ver:4

# Environment variables
ENV LC_ALL=nb_NO.UTF-8  \
    LANG=nb_NO.UTF-8 \
    LANGUAGE=nb_NO:no \
    TZ="Europe/Oslo" \
    DOCKER_ENV=1

# Install system dependencies for spatial and visualization packages
RUN apt-get update && apt-get install -y \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libglpk-dev \   
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*


# Install needed locales
RUN sed -i 's/^# *\(nb_NO.UTF-8\)/\1/' /etc/locale.gen \
  && sed -i 's/^# *\(nn_NO.UTF-8\)/\1/' /etc/locale.gen \
  && locale-gen

# Create necessary directories
RUN mkdir -p /home/shiny-app/data
RUN mkdir -p /home/shiny-app/R

# Install R packages
RUN R -e "install.packages(c( \
    'shiny', 'dplyr', 'tibble', 'sf', 'leaflet', 'leaflet.extras', 'bslib', \
    'scales', 'bsicons', 'httr2', 'httr', 'jsonlite', 'highcharter', 'tidyverse', \
    'forcats', 'RColorBrewer', 'gt', 'shinyWidgets', 'htmltools', 'htmlwidgets', \
    'shinyjs', 'fontawesome', 'rintrojs'))"

# Copy application files
COPY app.R /home/shiny-app/app.R
COPY data /home/shiny-app/data
COPY fonts /home/shiny-app/fonts
COPY www /home/shiny-app/www
COPY R /home/shiny-app/R

# Expose port
EXPOSE 8050

# Run Shiny application
CMD ["R", "-e", "shiny::runApp('/home/shiny-app', host='0.0.0.0', port=8050)"]
