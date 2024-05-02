# just because I always do....
library(tidyverse)

# clean up the environment
rm(list=ls())

# work with some climate data
# read in monthly precipitation data
# below data imported from https://www.weather.gov/wrh/climate?wfo=mtr
# for "Kentfield", "monthly summarized data", "precipitation", "sum", "por-por" (limits)
# there's no "export" option so I selected/copied/pasted
# the data into a text file.  Could not highlight column headers so
# will have to add them below.  By inspection the data is "tab delimited".

dfSFPrecip <- read.delim("data/SanFranciscoPrecip1909toPresent.txt", header = FALSE, sep = "\t")
# set column names
colnames(dfSFPrecip) <- c("Year", month.abb, "Annual")

# what's in the totals column?
dfSFPrecip[["Annual"]]
# lots of "M"s in there, and some "T"s in the monthly columns
# replace those characters with NA
dfSFPrecip[dfSFPrecip == 'M' | dfSFPrecip == 'T' ] <- NA
# convert {numeric-looking text values} to actual numeric
dfSFPrecip[] <- lapply(dfSFPrecip, as.numeric)
# recalculate "Annual" column, dropping NAs
dfSFPrecip[["Annual"]] <- rowSums( dfSFPrecip[, month.abb], na.rm = TRUE, )

# that is the end of the ETL process


