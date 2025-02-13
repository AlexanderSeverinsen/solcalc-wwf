# Solar calculator


# Introduction

The project is part of a collaboration between Engineers without borders
(EWB) and the World Wildlife Fund (WWF). The initial idea was to create
an energy baseline for East-Africa.

Stuff that might be useful

- <https://globalenergymonitor.org/projects/africa-energy-tracker/>

- <https://globalenergymonitor.org/projects/global-solar-power-tracker/download-data/>

- <https://global-energy-transition.org/>

- <https://www.esmap.org/Updated_Global_Electrification_Platform_GEP_3.0>

- <https://www.activesustainability.com/?_adin=11734293023>

## Datasources

There are many initiatives to promote renewable energy, both globally
and for East-Africa. The *Global Solar Atlas*
(<https://globalsolaratlas.info/map>) provide easy access to the power
potential of photovoltaic power potential.

### TZ SAM dataset

TZ-SAM is made available under a Creative Commons Attribution
Non-Commercial 4.0 International License (CC-BY-NC-4.0). Attribution to
TransitionZero is required. You must also clearly indicate if you have
made any changes to the TZ-SAM dataset and what these are. Please refer
to the suggested citation formats:

Phillpott, M., O’Connor, J., Ferreira, A., Max, S., Kruitwagen, L., &
Guzzardi, M. (2024). Solar Asset Mapper: A continuously-updated global
inventory of solar energy facilities built with satellite data and
machine learning (1.0) \[Data set\]. Zenodo.
<https://doi.org/10.5281/zenodo.11368204>

“TransitionZero Solar Asset Mapper, TransitionZero, May 2024 release.”
“TZ-SAM, TransitionZero, May 2024 release.” “TransitionZero (2024) Solar
Asset Mapper.”

With this app you can do three different things

1)  Calculate the PV solar potential for your roof
2)  Get an overview of solar panels installations at Norwegian roofs
3)  Get an overview of solar production in Norway (grid exported
    electricity)

## Solar potential for your roof

1)  Search for an address. Lon/lat is stored and used to find
    irradiation data from PVGIS
2)  When you locate the address you can draw an area for solar panels on
    a roof
    - You can switch between Google Earth and ESRI satellite to inspect
      roofs, and use OSM map as visual guidance
    - You can activate the address borders and the property borders from
      “Matrikkelen”
    - I have included pictures from Geonorge for detailed pictures of
      Norway
    - You can have a look at shadows from the mountains - a bit course,
      but you get the idea
3)  After drawing area around you roof the area m2 is calculated, then
    70% is dedicated PV panels
4)  The peak power is estimated based on number of estimated panels from
    3)
5)  Looking up peak power and lon/lat in PVGIS –\> solar potential
6)  Choosing “Endre forutsetning” you can disagree with the calculations
    and change price, kwp, azimuth/orientation, PV angel

### PVGIS - calculating the solar potential

PVGIS provides information on solar radiation for any location in the
world, except the North and South Poles. They have a API which you can
read more about here:
<https://joint-research-centre.ec.europa.eu/photovoltaic-geographical-information-system-pvgis/getting-started-pvgis/api-non-interactive-service_en>.
API calls have a rate limit of 30 calls/second per IP address, hence 108
000 calls each hour. You can map the solar potential for many locations
during a day!

## Solar panels in Norway (and some from Sweden)

The data is fetched from OpenStreetMap (OSM)
(<https://www.openstreetmap.org/>). It is a free open geographic
database. The database in maintained by volunteers and open
collaboration. I am using two different methods to collect data,
`Overpass Turbo` queries and the `R`library `osmdata`. More details in
`scripts/solar_installations_OSM.R`

``` sql
[out:json][timeout:25];
// gather results
(
  // query part for: “amenity=drinking_water”
  node["amenity"="drinking_water"]({{bbox}});
  way["amenity"="drinking_water"]({{bbox}});
  relation["amenity"="drinking_water"]({{bbox}});
);
// print results
out body;
>;
out skel qt;
```

## Web framework and libraries

The app is written in `R` `Shiny` which is a magical tool that enables
anyone working with data to quickly develop a web application.

## Datasources

### PVGIS

Important to note that we are using the PVGIS API. It supports up to 30
queries each second, however, if the service is down, so are we. Hence,
we could query lon/lat across Norway and store the irradiation data in
our own database to prevent this. Also, this could be compared with our
own ground measurements where available. This might similar to the World
Bank validation report for the Global Solar Atlas
(<https://documents.worldbank.org/en/publication/documents-reports/documentdetail/507341592893487792/global-solar-atlas-2-0-validation-report>)

### OSMBuildings

The 3D layer is provided by OSMBuildings <https://osmbuildings.org/>. We
have been in contact with Jan March <mail@osmbuildings.org>, and after
providing details about the Solar analytics app OSMBuildings granted us
free use of their data tiles. Thank you!

### Solar production from Elhub

Elhub recently launched an API with access to production data:
https://api.elhub.no/api/energy-data. The solar production is energy
delivered to the grid, hence the solar production consumed by the
buildings is not included in the statistics.

## Things to look in to

1.  Get solar irradiation as a layer in the map? Take a look at the The
    World Bank and the IFC:
    <https://globalsolaratlas.info/support/about>. Solargis is the data
    provider.

<!-- -->

2)  NSRDB dataset with solar radiation (global horizontal, direct
    normal, diffuse horizontal)
    <https://nsrdb.nrel.gov/about/what-is-the-nsrdb>. The data is
    available through an API:
    <https://developer.nrel.gov/docs/solar/nsrdb/>

Also, have a look at Sengupta et al (2018). Xie, Y., Sengupta, M., 2018.
A Fast All-sky Radiation Model for Solar applications with Narrowband
Irradiances on Tilted surfaces (FARMS-NIT): Part I. The clear-sky model.
Sol. Energy 174, 691-702.
<https://doi.org/10.1016/j.solener.2018.09.056>.

3)  Saving picture from a map It would be useful to save the picture
    from the map where the polygon was drawn. Display it as part of
    saved roofs
    <https://stackoverflow.com/questions/44259716/how-to-save-a-leaflet-map-in-shiny>
    <https://stackoverflow.com/questions/35384258/save-leaflet-map-in-shiny?noredirect=1&lq=1>
    <https://rstudio.github.io/leaflet/shiny.html>
    <https://shiny.posit.co/r/gallery/interactive-visualizations/superzip-example/>

Google Maps tiles directly in Leaflet might not comply with Google’s
Terms of Service…so we should use the API

<https://stackoverflow.com/questions/57554643/integrating-tiled-wfs-into-r-leaflet-map>
<https://github.com/bhaskarvk/leaflet.extras/issues/84>
<https://inbo.github.io/tutorials/tutorials/spatial_wfs_services/>

## Open Geospatial Consortium Web feature Services

Interface Standard provides an interface allowing requests for
geographical features across the web using platform-independent calls

How to here:
<https://inbo.github.io/tutorials/tutorials/spatial_wfs_services/>

## Search

We are using Bing. However, nominatim (open source) works better on free
text search addresses Probably consider
<https://www.kartverket.no/api-og-data/eiendomsdata/brukarrettleiing-adresse-api>,
which is a SOAP-API directly against the national property register,
aka. “matrikkelen”.
