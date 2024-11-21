library(sf)

### Import data

# If your data and code are in a project folder (repo), and you open the code from this project folder,
# you can use relative paths

cameras<-st_read("./Data/DeLuca_camera_traps.shp")
roads<-st_read("./Data/Roads.shp")


# How my data looks
plot(st_geometry(cameras))
plot(st_geometry(roads), add=T, col="red")

### Estimate distance to closest road for each camera

# Create distance matrix
distance<-st_distance(cameras, roads)

# Find the minimum distance for each road
Min.dist<-apply(distance,1,FUN = min)

# Create a data frame with results
results<-data.frame(cameras$Camera_sta,Min.dist)

# The same for exporting data regarding relative paths
write.csv(results, "./Results/Distance_roads.csv")

# Lets export a figure
tiff ("./Results/fig.tif",units="in", width=5, height=5, res=300)
plot(st_geometry(cameras))
plot(st_geometry(roads), add=T, col="red")
dev.off()
