library(httr)
library(jsonlite)
library(readxl)
library(raster)
library(rgdal)
library(ggplot2)
library(sf)


# London
# ------

# import 2019 deprivation data
IMD2019 <- read_excel("Development/r/KAOS/IMD2019.xlsx", sheet = "IMD2019")
# rename LSOA Code (2011) to LSOA11CD to match shape file col name
colnames(IMD2019)[which(names(IMD2019) == "LSOA Code (2011)")] <- "LSOA11CD"
# import London LSOA boundary shape file
londonBoundaries <- st_read("/Users/SimonChapman/Development/r/KAOS/London/LSOA_2011_London_gen_MHW.shp")
# merge the london shape file with IMD file, matching boroughs by ID (LSOA11CD)
londonIMD <- merge(londonBoundaries, IMD2019, by = "LSOA11CD")

# this creates a single variable londonIMD which contains the geometry data to plot
# as well as the deprivation deciles and ranking

# rename the IMD Rank to a shorter column name - note we are using rank (more granular, the decile)
colnames(londonIMD)[which(names(londonIMD) == "Index of Multiple Deprivation (IMD) Rank")] <- "IMDRank"

# create a plot of london with thin black lines, fill based on IMD Rank, stored as london
london <-ggplot()+geom_sf(data=londonIMD, size=0.25, color="black", aes(color=IMDRank)) + geom_point()

# identify the mean IMD rank and store this value as mid
mid<-mean(londonIMD$IMDRank)

# render the map, scaline the fill of the borough shapes, based on IMD Rank, red above mean, blue below
# and adding a title
mapplot+scale_color_gradient2(midpoint=mid, low="blue", mid="white", high="red", space ="Lab" ) + ggtitle("London", subtitle = "All Boroughs Ranked for Deprivation")


# UK
# ----

# import 2019 deprivation data
IMD2019 <- read_excel("Development/r/KAOS/IMD2019.xlsx", sheet = "IMD2019")
# rename LSOA Code (2011) to LSOA11CD to match shape file col name
colnames(IMD2019)[which(names(IMD2019) == "LSOA Code (2011)")] <- "LSOA11CD"
# import UK clippled boundary shape file
boundary <- st_read("/Users/SimonChapman/Development/r/KAOS/Lower_Layer_Super_Output_Areas_(December_2011)_Boundaries_Super_Generalised_Clipped_(BSC)_EW_V3-shp")

# merge the 2019 deprivation data with the shape files, matching boroughs for LSOA id
# storing the result as ukIMD
ukIMD <- merge(boundary, IMD2019, by = "LSOA11CD")

#  rename the resulting merged file IMD decile heading to be shorter (note decile less granular than rank)
colnames(ukIMD[which(names(ukIMD) == "Index of Multiple Deprivation (IMD) Decile")] <- "IMDDecile")

# identify the mean IMD decile and store this value as mid
mid <- mean(ukIMD$IMDDecile)

# create a plot from the geometry data of the UK, filling the shapes base on IMDDecile
# store this in variable uk.
uk <- ggplot()+geom_sf(data=ukIMD, size=0.125, aes(fill=IMDDecile)) + coord_sf()

# render the map using blue for IMDRank below mean, and red for above, setting a title
uk + scale_color_gradient2(midpoint=mid, low="blue", mid="white", high="red", space ="Lab" ) + ggtitle("England and Wales", subtitle = "All Boroughs Ranked for Deprivation")