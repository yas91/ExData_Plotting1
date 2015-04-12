dataSubset <- read.table( 
        "./household_power_consumption.txt"
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

# opening the PNG graphics device and associating
# it with an output file of the required dimensions.
# The original files in the figure subdirectory 
# have transparent background color, but I choose 
# a white backgroud here , because this resembles more 
# closely the presentation of the master plots.

png( file = "plot1.png"
     , width = 480
     , height = 480
     , units = "px"
     , bg = "white"
)

# drawing the histogram on the PNG device
# overwriting some of the defaults

hist( dataSubset$Global_active_power
      , col = "Red"
      , xlab = "Global Active Power (kilowatts)"
      , main = "Global Active Power"
)

# close the PNG device and save the output file
dev.off()

# cleaning up the environment
rm(dataSubset)
