    # Spatial Ecology In R | Final Exam Project
    # Sofiya Tumanova



    # This project focuses on a multi temporal analysis of forest cover (FCOVER) as well as vegetation indices (NDVI)
    # in the Northeastern part of Thailand. The data was taken from Copernicus Land Monitoring Service,
    # and Copernicus Browser and included FCOVER rasters as well as raw bands from Sentinel-2 satellite. 

    # The main objectives include:
    # - analyzing FCOVER changes over time
    # - classifying FCOVER changes
    # - computing vegetation indices (NDVI)
    # - classifying vegetation types


    ## DATA PREPARATION

    # Installing the necessary packages for the project

install.packages("ncdf4")       # to open .nc files from Copernicus
install.packages("terra")       # to work with raster data ('crop','rast', 'classify' functions)
install.packages("imageRy")     # to perform classification ('im.classify' function)
install.packages("patchwork")   # to make combined plots
install.packages("ggplot2")     # to create plots 'geom_raster', allows for 'scale_fill_viridis'
install.packages("viridis")     # to implement colorblind friendly color palettes in ggplot2
#----------------- the code works without devtools so when you open again, try to run again, and it it works just delete it
#install.packages("devtools")   # for simplifying basic R functions
#-----------------
install.packages("tidyterra") # to perform the 'replace_na' function, necessary to avoid the 'error in 'fortify()', and
#install.packages("imager")   # the code works without this package can delete later
install.packages("dplyr")       # to work with data frames for example, performing the 'summarize function'



#_dplyr#_________________ Notes
# Classify function is part of the terra package
# Im.classify is part of the imageRy package, does the same as the terra but allows me to use viridis
# i deleted library(devtools) and library(imager)

library(terra)
library(imageRy)
library(ncdf4)      
library(patchwork)  
library(ggplot2)    
library(viridis)
library(tidyterra)
library(dplyr)


    # 1. DATA 


    # Downloading the data
    # The data was downloaded from Copernicus Land Monitoring Service (CLMS) for an area in the Northeastern
    # part of Thailand.
    # Fraction of Green Vegetation Cover (FCOVER) was downloaded for the years : 
    # 1999
    # 2004
    # 2009
    # 2014
    # 2019

    # Setting working directory

setwd("C:/Users/sofiy/Desktop/Spatial Ecology In R Project/DataCombined")

    # Importing rasters

FCOV1999 <- rast("c_gls_FCOVER_199902100000_GLOBE_VGT_V2.0.2__FCOVER.nc")
FCOV2004 <- rast("c_gls_FCOVER_200402100000_GLOBE_VGT_V2.0.1__FCOVER.nc")
FCOV2009 <- rast("c_gls_FCOVER_200902100000_GLOBE_VGT_V2.0.1__FCOVER.nc")
FCOV2014 <- rast("c_gls_FCOVER-RT6_201402100000_GLOBE_PROBAV_V2.0.2__FCOVER.nc")
FCOV2019 <- rast("c_gls_FCOVER-RT0_201902100000_GLOBE_PROBAV_V2.0.1__FCOVER.nc")

    # Cropping all rasters to the same extent

    # Defining extent

extent <- c(98.5,100.7,16.6,18.9)
    
    # Cropped rasters

fcov1999.crop <- crop(FCOV1999,extent)
fcov2004.crop <- crop(FCOV2004,extent)
fcov2009.crop <- crop(FCOV2009,extent)
fcov2014.crop <- crop(FCOV2014,extent)
fcov2019.crop <- crop(FCOV2019,extent)


    # Plotting using ggplot: 1999

    # In order to plot with ggplot we need to convert the raster into a data frame 
 
    # Converting to data frame to be able to plot

df1999 <- as.data.frame(fcov1999.crop, xy = TRUE)

ggplot1999 <- ggplot() +
  geom_raster(data = df1999, aes(x = x, y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "mako") +
  theme_minimal() +
  labs(x = "Longitude", y = "Latitude", title = "FCOVER 1999", fill = "FCOVER") +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_fixed()

    
    # Repeating for the remaining rasters

    # Plotting using ggplot: 2004

df2004 <- as.data.frame(fcov2004.crop, xy = TRUE) # Converting to dataframe 
ggplot2004 <- ggplot() +
  geom_raster(data = df2004, aes(x = x, y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "mako") +
  theme_minimal() +
  labs(x = "Longitude", y = "Latitude", title = "FCOVER 2004", fill = "FCOVER") +
  theme(plot.title = element_text(hjust = 0.5))+
  coord_fixed()

    # Combining the plots of 1999 and 2004 to visualize the differences in 5 years

combined_plot <- ggplot1999 + ggplot2004
print(combined_plot)

    # Plotting using ggplot: 2009

df2009 <- as.data.frame(fcov2009.crop, xy = TRUE) # Converting to dataframe 
ggplot2009 <- ggplot() +
  geom_raster(data = df2009, aes(x = x, y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "mako") +
  theme_minimal() +
  labs(x = "Longitude", y = "Latitude", title = "FCOVER 2009", fill = "FCOVER") +
  theme(plot.title = element_text(hjust = 0.5))+
  coord_fixed()

    # Plotting using ggplot: 2014

df2014 <- as.data.frame(fcov2014.crop, xy = TRUE) # Converting to dataframe 
ggplot2014 <- ggplot() +
  geom_raster(data = df2014, aes(x = x, y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "mako") +
  theme_minimal() +
  labs(x = "Longitude", y = "Latitude", title = "FCOVER 2014", fill = "FCOVER") +
  theme(plot.title = element_text(hjust = 0.5))+
  coord_fixed()

    # Plotting using ggplot: 2019

df2019 <- as.data.frame(fcov2019.crop, xy = TRUE) # Converting to dataframe 
ggplot2019 <- ggplot() +
  geom_raster(data = df2019, aes(x = x, y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "mako") +
  theme_minimal() +
  labs(x = "Longitude", y = "Latitude", title = "FCOVER 2019", fill = "FCOVER") +
  theme(plot.title = element_text(hjust = 0.5))+
  coord_fixed()

    # Combining all plots using patchwork

combined_plot <- (ggplot1999 + ggplot2004 + ggplot2009) /
  (ggplot2014 + ggplot2019) +
  plot_layout(guides = "collect")   # To make sure the color scale is consistent in all images
print(combined_plot)


    # 2. FCOVER DATA ANALYSIS 


    # Analysis of the forest cover

    # Seeing the difference between forest cover over 20 year period (from 1999 to 2019)

diff.1999.2019 <- fcov2019.crop - fcov1999.crop

    # Plotting the difference raster using ggplot

ggplot_diff.1999.2019 <- ggplot() + 
  geom_raster(diff.1999.2019, mapping = aes(x = x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "magma") + ggtitle("Forest Cover Change: from 1999 to 2019") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
                                                axis.title = element_text(size = 9))+
  coord_fixed()
    
    # Results: plot showing the changes in F cover from 1999 to 2019

ggplot_diff.1999.2019


    # 3. CLASSIFICATION OF FCOVER


    # Classifying the difference raster based on 3 categories for better interpretation

class.diff.1999.2019 <- im.classify(diff.1999.2019,c(-0.0001,0,0.0001), use_viridis = TRUE)

    # Plotting the classified raster using ggplot for visualization 

plot(class.diff.1999.2019)

    # Converting the classified raster into a data frame for ggplot

class.diff.df <- as.data.frame(class.diff.1999.2019, xy = TRUE)

    # Making the 'value' column correspond to the classified values in the df

colnames(class.diff.df)[3] <- "ChangeClass"

    # Plotting using ggplot

ggplot_class_diff <- ggplot(class.diff.df, aes(x = x, y = y, fill = as.factor(ChangeClass))) +
  geom_raster() +
  scale_fill_manual(values = c("1" = "#240032",  # Decrease
                               "2" = "purple",  # No Change
                               "3" = "orange"), # Increase
                    name = "Class", 
                    labels = c("Decrease", "No Change", "Increase")) +
  labs(x = "Longitude", y = "Latitude", title = "Forest Cover Change: 1999 to 2019") +
   theme(axis.text = element_text(size = 7),
        axis.title = element_text(size = 9))+
  theme(plot.title = element_text(hjust = 0.5))+
  coord_fixed()
print(ggplot_class_diff)

    # Plotting together the Fcover difference raster and the classified raster from 1999 to 2019

combined_plots <- ggplot_diff.1999.2019 + ggplot_class_diff
   
    # Results: two plots showing the difference in F cover over a 20 year period, and a classified raster

print(combined_plots)


    # 4. PERCENT OF CHANGE IN FCOVER


    # Counting the change of F Cover from 1999 to 2019 in percentages using 3 categories:
  
    # 'Decrease', 'Increase', and 'No Change' in F Cover

    # Counting the total number of pixels in the raster

pixel_total <- ncell(class.diff.1999.2019)

    # Computing the percentage of pixels that fall into each category mentioned above 

(freq(class.diff.1999.2019)/pixel_total)*100
    # layer       value    count
    # 1 0.001575324 0.001575324 13.70690   Decrease in F Cover
    # 2 0.001575324 0.003150648 44.09017   No Change in F Cover
    # 3 0.001575324 0.004725972 42.20293   Increase in F Cover 

    # Data frame

    # Creating a vector with 3 categories

fcover.categories <- c("Decrease", "No Change", "Increase")

    # Creating a vector with the percentages of pixels that fall into each class

fcover.change.1999.2019 <- c(13.70, 44.09, 42.21)
    
    # Creating the data frame

fcover.df <- data.frame(fcover.categories,fcover.change.1999.2019)
   
    # Plotting the results using the geom_bar function from the ggplot package

fcover.change.plot.1999.2019 <- ggplot(fcover.df, aes(x = fcover.categories, y = fcover.change.1999.2019)) + 
  geom_bar(stat = "identity", fill = c("#0072B2", "#E69F00", "#009E73")) +
  geom_text(aes(label = round(fcover.change.1999.2019, 2)), size = 4, hjust = 0.5, vjust = -0.5) + 
  ylim(0, 100) + 
  labs(x = "Change Categories", 
       y = "Changes in F Cover Classes in Percentages", 
       title = "Change in the F Cover Over the Period of 1999 to 2019") +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))  # Centering the title

    # Results: plot showing percentages of F Cover change in each of the 3 categories
    # 13.7% Decrease in F Cover
    # 42.21% Increase in F Cover
    # 44.09% Decrease in F Cover
print(fcover.change.plot.1999.2019)


    # 5. NDVI ANALYSIS


    # Analyzing vegetation index (NDVI) with Sentinel-2 data
    # Data downloaded from Copernicus Browser for two years 2016 and 2023
    # The images downloaded were level 2A, and contained less than 10% cloud cover
    # The following bands were downloaded: b2, b3, b4, b8
  
    # Importing bands for 2016

b2.2016 <- rast("2016-11-21-00_00_2016-11-21-23_59_Sentinel-2_L2A_B02_(Raw).tiff")
b3.2016 <- rast("2016-11-21-00_00_2016-11-21-23_59_Sentinel-2_L2A_B03_(Raw).tiff")
b4.2016 <- rast("2016-11-21-00_00_2016-11-21-23_59_Sentinel-2_L2A_B04_(Raw).tiff")
b8.2016 <- rast("2016-11-21-00_00_2016-11-21-23_59_Sentinel-2_L2A_B08_(Raw).tiff")

    # creating a stack with all the bands
    # stacksent: 
    # band2 blue element 1, stacksent[[1]] 
    # band3 green element 2, stacksent[[2]]
    # band4 red element 3, stacksent[[3]]
    # band8 nir element 4, stacksent[[4]]
stacksent <- c(b2.2016, b3.2016, b4.2016, b8.2016)
par(mfrow=c(1,2))

    # Plotting the true color composite (red, green, blue)

plotRGB(stacksent, r = 3, g = 2, b = 1, stretch="lin", main = "True Color Composite 2016")
    # Plotting the false color composite (near-infrared, red, green)
plotRGB(stacksent, r = 4, g = 3, b = 2, stretch="lin",main = "False Color Composite 2016")
    # the stretch = "lin" parameter is for displaying the images better (stretches the histogram)

    # NDVI for 2016:
    # NDVI formula: N D V I = (B 8 − B 4) / (B 8 + B 4)
NDVI.2016 = (stacksent[[4]] - stacksent[[3]]) / (stacksent[[4]] + stacksent[[3]])
plot(NDVI.2016)


    # Importing bands for 2023

b2.2023 <- rast("2023-11-20-00_00_2023-11-20-23_59_Sentinel-2_L2A_B02_(Raw).tiff")
b3.2023 <- rast("2023-11-20-00_00_2023-11-20-23_59_Sentinel-2_L2A_B03_(Raw).tiff")
b4.2023 <- rast("2023-11-20-00_00_2023-11-20-23_59_Sentinel-2_L2A_B04_(Raw).tiff")
b8.2023 <- rast("2023-11-20-00_00_2023-11-20-23_59_Sentinel-2_L2A_B08_(Raw).tiff")

    # creating a stack with all the bands
    # stacksent2: 
    # band2 blue element 1, stacksent[[1]] 
    # band3 green element 2, stacksent[[2]]
    # band4 red element 3, stacksent[[3]]
    # band8 nir element 4, stacksent[[4]]
stacksent2 <- c(b2.2023, b3.2023, b4.2023, b8.2023)
    # Plotting the true color composite (red, green, blue)
par(mfrow=c(1,2))
plotRGB(stacksent2, r = 3, g = 2, b = 1, stretch="lin", main = "True Color Composite 2023")
    # Plotting the false color composite (near-infrared, red, green)
plotRGB(stacksent2, r = 4, g = 3, b = 2, stretch="lin",main = "False Color Composite 2023")
    # the stretch = "lin" parameter is for displaying the images better (stretches the histogram)

    # NDVI for 2023:
    # NDVI formula: N D V I = (B 8 − B 4) / (B 8 + B 4)
NDVI.2023 = (stacksent2[[4]] - stacksent2[[3]]) / (stacksent2[[4]] + stacksent2[[3]])
plot(NDVI.2023)

par(mfrow=c(1,2))
plot(NDVI.2016)
plot(NDVI.2023)


    # Cropping both rasters to a new extent
    # Defining extent
extent.ndvi <- c(98.31,99.44824, 17.97943, 19.01578)
NDVI.2016.c <- crop(NDVI.2016,extent.ndvi)
NDVI.2023.c <- crop(NDVI.2023,extent.ndvi)

    # Plotting the NDVI for 2016
    # Data needs to be converted to a data frame for ggplot
ndvi_df_2016 <- as.data.frame(NDVI.2016.c, xy = TRUE)
colnames(ndvi_df_2016) <- c("x", "y", "NDVI")



p1 <- ggplot() +
  geom_raster(data = ndvi_df_2016, aes(x = x, y = y, fill = NDVI)) +
  scale_fill_viridis_c(option = "D", na.value = "transparent") +  # Using a color palette suitable for NDVI
  labs(title = "NDVI 2016", fill = "NDVI", x = "Longitude", y = "Latitude") +
  coord_equal() +
  theme_minimal()


    # Plotting the NDVI for 2023
    # Data needs to be converted to a data frame for ggplot
ndvi_df_2023 <- as.data.frame(NDVI.2023.c, xy = TRUE)
colnames(ndvi_df_2023) <- c("x", "y", "NDVI")


p2 <- ggplot() +
  geom_raster(data = ndvi_df_2023, aes(x = x, y = y, fill = NDVI)) +
  scale_fill_viridis_c(option = "D", na.value = "transparent") +  # Using a color palette suitable for NDVI
  labs(title = "NDVI 2023", fill = "NDVI", x = "Longitude", y = "Latitude") +
  coord_equal() +
  theme_minimal()

    # Arranging both plots together for visualization
ndvi.plots <- p1 + p2
print(ndvi.plots)


    # 6. NDVI DIFFERENCE 


    # Calculating NDVI difference between the years 2016 and 2023
NDVI_diff <- NDVI.2023.c - NDVI.2016.c
ndvi_diff_df <- as.data.frame(NDVI_diff, xy = TRUE)
colnames(ndvi_diff_df) <- c("Longitude", "Latitude", "NDVI_Difference")

    # Calculating the maximum and minimum values to be added to the legend
min_val <- min(ndvi_diff_df$NDVI_Difference, na.rm = TRUE)
max_val <- max(ndvi_diff_df$NDVI_Difference, na.rm = TRUE)
    
    # Plotting the NDVI Difference using ggplot
ggplot_NDVI_diff_mako <- ggplot() + 
  geom_raster(data = ndvi_diff_df, aes(x = Longitude, y = Latitude, fill = NDVI_Difference)) +
  scale_fill_viridis(option = "viridis",
                     breaks = c(min_val, 0, max_val),  
                     labels = scales::label_number(accuracy = 0.01),  # to round to two decimal points
                     na.value = "transparent") +
  labs(title = "NDVI Difference (2023 - 2016)", x = "Longitude", y = "Latitude", fill = "NDVI Difference") +
  coord_equal() +
  theme_minimal()

print(ggplot_NDVI_diff_mako)


    # 7. VEGETATION CLASSIFICATION


    # Classifying NDVI for 2016 with adjusted thresholds
    # Classification thresholds were selected based on the study:
    # URBAN VEGETATION CLASSIFICATION WITH NDVI THRESHOLD VALUE METHOD WITH VERY HIGH RESOLUTION (VHR) PLEIADES IMAGERY
    # by Haslina Hashim et. al
    
    # NDVI classification: Non-vegetation  - (-1.) - 0.1999)
    #                      Low Vegetation  - (0.2 - 0.5)
    #                      High Vegetation - (0.501 - 1.0)



    # Defining the matrix for reclassification

rcl_matrix <- matrix(c(-1, 0.1999, 1,  # No Vegetation + Clouds
                       0.2, 0.4999, 2,   # Low Vegetation
                       0.5, 1, 3),     # Dense Vegetation
                     ncol = 3, byrow = TRUE)

    # Classifying the NDVI rasters based on the matrix

NDVI.2016.class <- classify(NDVI.2016.c, rcl = rcl_matrix)
NDVI.2023.class <- classify(NDVI.2023.c, rcl = rcl_matrix)

    # Converting the classified rasters into data frames

ndvi_2016_df <- as.data.frame(NDVI.2016.class, xy = TRUE)
ndvi_2023_df <- as.data.frame(NDVI.2023.class, xy = TRUE)

    # Renaming the column for classification categories

colnames(ndvi_2016_df)[3] <- "NDVI_Class"
colnames(ndvi_2023_df)[3] <- "NDVI_Class"

    # Removing NA values from the data frames
ndvi_2016_df_no_na <- na.omit(ndvi_2016_df)
ndvi_2023_df_no_na <- na.omit(ndvi_2023_df)

    # Selecting only values 1, 2 and 3 for the NDVI_Class column
ndvi_2016_df_no_na <- ndvi_2016_df_no_na[ndvi_2016_df_no_na$NDVI_Class %in% c(1, 2, 3), ]
ndvi_2023_df_no_na <- ndvi_2023_df_no_na[ndvi_2023_df_no_na$NDVI_Class %in% c(1, 2, 3), ]

    # Converting numeric class values to descriptive factor levels
ndvi_2016_df_no_na$NDVI_Class <- factor(ndvi_2016_df_no_na$NDVI_Class,
                                        levels = c(1, 2, 3),
                                        labels = c("No Vegetation", "Low Vegetation", "Dense Vegetation"))

ndvi_2023_df_no_na$NDVI_Class <- factor(ndvi_2023_df_no_na$NDVI_Class,
                                        levels = c(1, 2, 3),
                                        labels = c("No Vegetation", "Low Vegetation", "Dense Vegetation"))

    # Plotting classified NDVI for 2016 using ggplot
ggplot_ndvi_2016 <- ggplot(ndvi_2016_df_no_na, aes(x = x, y = y, fill = NDVI_Class)) +
  geom_raster() +
  scale_fill_manual(values = c("No Vegetation" = "purple",
                               "Low Vegetation" = "lightgreen",
                               "Dense Vegetation" = "darkgreen"),
                                name = "NDVI Class") +
  labs(x = "Longitude", y = "Latitude", title = "Classified NDVI 2016") +
  theme(axis.text = element_text(size = 7),
        axis.title = element_text(size = 9),
        plot.title = element_text(hjust = 0.5)) +
  coord_fixed()

    # Plotting classified NDVI for 2023 using ggplot
ggplot_ndvi_2023 <- ggplot(ndvi_2023_df_no_na, aes(x = x, y = y, fill = NDVI_Class)) +
  geom_raster() +
  scale_fill_manual(values = c("No Vegetation" = "purple",
                               "Low Vegetation" = "lightgreen",
                               "Dense Vegetation" = "darkgreen"),
                    name = "NDVI Class") +
  labs(x = "Longitude", y = "Latitude", title = "Classified NDVI 2023") +
  theme(axis.text = element_text(size = 7),
        axis.title = element_text(size = 9),
        plot.title = element_text(hjust = 0.5)) +
  coord_fixed()

    # Displaying the two plots together
combined.ndvi.class.plots <- ggplot_ndvi_2016 + ggplot_ndvi_2023
plot(combined.ndvi.class.plots)


    # 8. PIXEL COUNT


    # Counting pixel numbers in each category for 2016 and 2023

count_2016 <- ndvi_2016_df_no_na %>%
  group_by(NDVI_Class) %>%
  summarize(Count_2016 = n())

count_2023 <- ndvi_2023_df_no_na %>%
  group_by(NDVI_Class) %>%
  summarize(Count_2023 = n())


    # Joining the counts data
pixel_counts <- count_2016 %>%
  full_join(count_2023, by = "NDVI_Class") %>%
  mutate(Count_2023 = replace_na(Count_2023, 0)) %>%
  mutate(Difference = Count_2023 - Count_2016)

    # Converting 'NDVI_Class' to factor for proper ordering
pixel_counts$NDVI_Class <- factor(pixel_counts$NDVI_Class, 
                                  levels = c("No Vegetation", "Low Vegetation", "Dense Vegetation"))

    # Creating a bar plot for pixel count differences
ggplot(pixel_counts, aes(x = NDVI_Class, y = Difference, fill = NDVI_Class)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("No Vegetation" = "purple",
                               "Low Vegetation" = "lightgreen",
                               "Dense Vegetation" = "darkgreen")) +
  labs(x = "NDVI Class", y = "Difference in Pixel Count",
       title = "Difference in Pixel Count Between 2016 and 2023",
       fill = "NDVI Class") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


    # 9. PIXEL COUNT PERCENTAGE CHANGE


    # Seeing the percentage change in Each category
    # Merging the counts data frames withe the 'merge' function

count_summary <- merge(count_2016, count_2023, by = "NDVI_Class")

    # Calculating the percentage change

count_summary <- count_summary %>%
  mutate(Percent_Change = round(((Count_2023 - Count_2016) / Count_2016) * 100, 2))

    
    # Adjusting the "Dense Vegetation" value to be below the bar while the rest is above the bars
vjust_values <- ifelse(count_summary$NDVI_Class == "Dense Vegetation", 2, -0.5)  

    # Creating a bar plot of the percentage changes
ggplot(count_summary, aes(x = NDVI_Class, y = Percent_Change, fill = NDVI_Class)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(Percent_Change, "%")), 
            vjust = vjust_values, size = 5, color = "black") +  # Add labels above/below each bar
  scale_fill_manual(values = c("No Vegetation" = "purple",
                               "Low Vegetation" = "lightgreen",
                               "Dense Vegetation" = "darkgreen")) +
  labs(x = "NDVI Class", y = "Percentage Change (%)", title = "Percentage Change in NDVI Categories (2016 to 2023)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

  # Seeing the exact number of percent change
count_summary
#         NDVI_Class Count_2016 Count_2023 Percent_Change
# 1 Dense Vegetation    1245718    1219299      -2.120785
# 2   Low Vegetation      87274     104401      19.624401
# 3    No Vegetation      19521      28153      44.219046
