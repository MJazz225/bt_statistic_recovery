###########################################################################
#
#
#    copy statistic
#    為了挽救BT turnover report裡的每日統計數據
#   
#
############################################################################

rm(list=ls())
if(!require(data.table))install.packages("data.table")
if(!require(dplyr))install.packages("dpylr")
library(xts)
library(zoo)
library(stargazer)

setwd("D:\\Users\\marshaw.tan\\Desktop")
dataname <-  "bt_stat.csv"
rawdata2020 <- read.csv(dataname, sep = ",", stringsAsFactors = FALSE, header = FALSE) ##

splitset <-  NULL
data1 <- NULL
n = 44
for (i in 1:n) {
  
  cat(i , "/", n, "\n")
  
  splitset <- rawdata2020[(i*n-43):(i*n),]
  date1 <- splitset[1,1]
  splitset <-  splitset[3:7,]
  
  rawdata1 <- splitset[,1:2] %>% as.data.frame()
  colnames(rawdata1) <- c("1","2")
  rawdata2 <- splitset[1:3,4:5] %>% as.data.frame()
  colnames(rawdata2) <- c("1","2")
  rawdata3 <- splitset[,7:8] %>% as.data.frame()
  colnames(rawdata3) <- c("1","2")
  rawdata <- rbind(rawdata1,rawdata2,rawdata3)
  rawdata <- t(rawdata)
  rawdata <- rawdata[2,]
  rawdata <- c(date1, rawdata)
  rawdata <- as.data.frame(rawdata) 
  rawdata <- t(rawdata)
  
  data1 <- rbind(data1, rawdata)
}

data1 <- data1[nrow(data1):1,]
write.csv(data1, file = "bt_recover.csv")
