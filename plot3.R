
dataSubsetRaw <- read.table( "./household_power_consumption.txt"
                             , header = FALSE
                             , sep = ";"
                             , col.names = c( "Date"
                                              , "Time"
                                              , "Global_active_power"
                                              , "Global_reactive_power"
                                              , "Voltage"
                                              , "Global_intensity"
                                              , "Sub_metering_1"
                                              , "Sub_metering_2"
                                              , "Sub_metering_3"
                             )
                             , colClasses = c( "character"
                                               , "character"
                                               , "numeric"
                                               , "numeric"
                                               , "numeric"
                                               , "numeric"
                                               , "numeric"
                                               , "numeric"
                                               , "numeric"
                             )
                             , skip = 66637
                             , nrows = 2880
                             , na.strings = "?"
)

# Date an Time columns are concatenated, converted to POSIXct
# and added as column DateTime
# Date column is converted to date and added as column Date
# to the newly constructed data frame
# All but the columns Date and Time from the original dataset
# are appended to the data frame retaining names and formats

dataSubset <- data.frame( DateTime = strptime( paste( dataSubsetRaw$Date
                                                      , dataSubsetRaw$Time
)
, "%d/%m/%Y %H:%M:%S"
)
, Date = as.Date( dataSubsetRaw$Date, "%d/%m/%Y" )
, dataSubsetRaw[,3:9]
)

# Auto labeling uses localized names for weekday
# abbreviations. Since this a German environment
# we need to switch to the US English locale 
# to reproduce the exact result.

Sys.setlocale("LC_TIME", "English")

# opening the PNG graphics device and associating
# it with an output file of the required dimensions.
# The original files in the figure subdirectory 
# have transparent background color, but I choose 
# a white backgroud here , because this resembles more 
# closely the presentation of the master plots.

png( file = "plot3.png"
     , width = 480
     , height = 480
     , units = "px"
     , bg = "white"
)

# compose the line diagram on the PNG device
# overlaying three data series 

plot( dataSubset$DateTime
      , dataSubset$Sub_metering_1
      , type = "n"
      , xlab = NA
      , ylab = "Energy sub metering"
)

points( dataSubset$DateTime
        , dataSubset$Sub_metering_1
        , type = "l"
        , col = "black"
)

points( dataSubset$DateTime
        , dataSubset$Sub_metering_2
        , type = "l"
        , col = "red"
)

points( dataSubset$DateTime
        , dataSubset$Sub_metering_3
        , type = "l"
        , col = "blue"
)

# add a legend to the plot

legend( "topright"
        , legend = c( "Sub_metering_1"
                      , "Sub_metering_2"
                      , "Sub_metering_3"
        )
        , col = c( "black"
                   , "red"
                   , "blue"
        )
        , lty = 1 
)


# close the PNG device and save the output file
dev.off()

# Switch back to German locale (on Windows)
Sys.setlocale("LC_TIME", "German")

# cleaning up the environment
rm(dataSubsetRaw, dataSubset)