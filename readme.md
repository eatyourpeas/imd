# Index of Multiple Deprivation, 2019

This is a first attempt at plotting maps of London and England and Wales using public data sets.

I have done this with R.

The datasets are publicly available - here stored as .xlsx but can be imported as JSON from the [API](https://opendata.arcgis.com/datasets/6bced6c6f81448cf9692ed3f472b11ce_0.geojson)

1. The England/Wales IMD [data](https://data-communities.opendata.arcgis.com/datasets/lower-super-output-area-lsoa-imd2019-wgs84/data?geometry=-18.148%2C50.560%2C13.493%2C55.196)
2. The LSOA shape [data](<https://geoportal.statistics.gov.uk/datasets/ons::lower-layer-super-output-areas-december-2001-ew-bfe/data?geometry=-33.811%2C48.013%2C29.470%2C57.298>) for England/Wales
3. The [LSOA boundaries](https://data.london.gov.uk/dataset/lsoa-atlas) for London

R packages used:

1. httr
2. jsonlite
3. readxl
4. ggplot
5. sf

### England/Wales

<img src="https://github.com/eatyourpeas/imd/blob/main/assets/england_wales_deprivation.png" alt="Deprivation in England and Wales" width="500"/>

### London

<img src="https://github.com/eatyourpeas/imd/blob/main/assets/london_deprivation.png" alt="Deprivation in London" width="500"/>
