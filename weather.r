library('ggplot2')
# get weather data from CSV at then graph each variable vs. time
# export it to a PDF

args <- commandArgs(trailingOnly=TRUE)
data <- read.csv("test_climate.csv",header=TRUE)

small_data <- data.frame(time = data$DATE, temp_C = data$HOURLYWETBULBTEMPC,
  humidity = data$HOURLYRelativeHumidity,
  pressure = data$HOURLYStationPressure)

fixed_f <- subset(small_data, temp_C != 'NA' & humidity != 'NA' & pressure != 'NA')
fixed_f$time<- as.numeric(fixed_f$time)

to_compare <- subset(fixed_f, select=-time)
cor(to_compare)

dat <- subset(fixed_f, select = c('time', 'temp_C'))
summary(dat)

ggplot(data = dat, aes(x = 'time', y = 'C Temp')) +
  geom_point(shape=1) +
  geom_smooth()

ggsave('test.pdf')
