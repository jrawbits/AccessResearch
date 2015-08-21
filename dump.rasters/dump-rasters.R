# Test R file for dumping rasters from the current folder
# Developed under R 3.2.2
library(rgdal)
library(sp)
library(raster)

# Load sample shapefile
study.area <- readOGR("Study_Area_TAZ.shp",layer="Study_Area_TAZ")

# Extract extent of study area
e <- extent(study.area)

# Build empty R raster with extent and resolution
t <- raster(e,res=20) # resolution is 20 projected units in x/y direction
# Many formats ("ascii", "SAGA")

# Rasterize (assign values to raster cells) for the study area
rsa <- rasterize(study.area,t,field="TAZ")

# show available formats
print(writeFormats())

# write out some sample formatswriteRaster(rsa,filename="Study_Area",format="raster")
writeRaster(rsa,filename="Study_Area.tif",format="GTiff",overwrite=TRUE)         # geoTIFF
writeRaster(rsa,filename="Study_Area.img",format="HFA",overwrite=TRUE)       # Erdas IMAGINE
writeRaster(rsa,filename="Study_area.raster",format="raster",overwrite=TRUE) # R-Raster

# The following are probably not useful
# writeRaster(rsa,filename="Study_Area.saga",format="SAGA") # SAGA GIS
# writeRaster(rsa,filename="Study_area.asc",format="ascii") # ESRI ascii format
# writeRaster(rsa,filename="Study_Area.bmp",format="BMP")   # Bitmap (no CRS - not useful)

# Plot the R raster as a PNG image
png(file="Study_Area.png",bg="transparent")
plot(rsa)
dev.off()

jpeg(file="Study_Area.jpg",quality=100,bg="white")
plot(rsa)
dev.off()

bmp(file="Study_Area.bmp",bg="white")
plot(rsa)
dev.off()
