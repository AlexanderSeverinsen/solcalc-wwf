FROM rocker/r-ver:4
# FROM rocker/shiny works just fine in prod, but when switching to ARM64
# I had to do change image, also, ´tidyverse´ has a lot of system dependencies, hence dropping unnecessary libs
# I also had to change Docker setting -> general -> "Use containerned for pulling and storing" + "Use Rosetta..."

ENV LC_ALL=nb_NO.UTF-8  \
    LANG=nb_NO.UTF-8 \
    LANGUAGE=nb_NO:no \
    TZ="Europe/Oslo" \
    DOCKER_ENV=1
    

# Install system dependencies for the sf package
RUN apt-get update && apt-get install -y \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libglpk-dev  # Added for igraph/highcharter
    
# Install needed locales
RUN sed -i 's/^# *\(nb_NO.UTF-8\)/\1/' /etc/locale.gen \
  && sed -i 's/^# *\(nn_NO.UTF-8\)/\1/' /etc/locale.gen \
  && locale-gen

RUN mkdir -p /home/shiny-app/data
RUN mkdir -p /home/shiny-app/R

RUN R -e "install.packages(c('shiny', 'dplyr', 'tibble', 'sf', 'leaflet.extras', 'bslib', 'scales', 'bsicons', 'httr2', 'tibble', 'httr2', 'httr', 'jsonlite', 'highcharter', 'tidyverse', 'forcats', 'RColorBrewer', 'gt', 'shinyWidgets', 'htmltools', 'htmlwidgets'))"

COPY app.R /home/shiny-app/app.R
COPY .Renviron /home/shiny-app/.Renviron
COPY data /home/shiny-app/data
COPY fonts /home/shiny-app/fonts
COPY www /home/shiny-app/www
COPY R /home/shiny-app/R


#COPY shiny-server.conf /etc/shiny-server/shiny-server.conf


EXPOSE 8080

#CMD Rscript /home/shiny-app/app.R
CMD ["R", "-e", "shiny::runApp('/home/shiny-app', host='0.0.0.0', port=8080)"]
