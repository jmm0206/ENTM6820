library(tidyverse)
library(drc)

(5*(50 - 32)/9)

F_C <- function(x) {
  #code goes here#
  C <- (5*(x - 32)/9)
return(C)
}

F_C(80)

C_F <- function(x) {
  F <- ((x*(9/5)) + 32)
return(F)
}
C_F(0)


#For Loop

for (i in 1:10) {
  print(i*2)
}

for (i in -100:100) {
 result <- F_C(i)
 print(result)
}

EC50.data <- read.csv("EC50.all.csv")

nm <- unique(EC50.data$is)

for (i in seq_along(nm)) {
  isolate1 <- drm(100 * EC50.data$relgrowth[EC50.data$is == nm[[i]]])~
    EC50.data$conc[EC50.data$is == nm[[i]]],
  fct = LL.4(fixed = c(NA,NA,NA,NA),
  names = c("Slope","Lower","Upper","EC50")),
  na.action = na.omit)
summary.fit <- data.frame(summary(isolate1)[[3]])

EC50 <- ED(isolate1, respLev = c(50), type = "relative",
           interval = "delta") [[1]]
EC50
}

library(ggplot2)
library(drc) 
library(tidyverse)
library(dplyr)
#install.packages("drc")
library(drc)

EC50.data <- read.csv("EC50.all.csv")

isolate1 <- drm(100 * EC50.data$relgrowth[EC50.data$is == "ILSO_5-41c"] ~ 
                  EC50.data$conc[EC50.data$is == "ILSO_5-41c"], 
                fct = LL.4(fixed = c(NA, NA, NA, NA), 
                           names = c("Slope", "Lower", "Upper", "EC50")), 
                na.action = na.omit)
# outputs the summary of the paramters including the estimate, standard
# error, t-value, and p-value outputs it into a data frame called
# summary.mef.fit for 'summary of fit'
summary.fit <- data.frame(summary(isolate1)[[3]])
# outputs the summary of just the EC50 data including the estimate, standard
# error, upper and lower bounds of the 95% confidence intervals around the
# EC50
EC50 <- ED(isolate1, respLev = c(50), type = "relative", 
           interval = "delta")[[1]]
EC50

nm <- unique(EC50.data$is)

for (i in seq_along(nm)) {
  isolate1 <- drm(100 * EC50.data$relgrowth[EC50.data$is == nm[[i]]] ~ 
                    EC50.data$conc[EC50.data$is == nm[[i]]], 
                  fct = LL.4(fixed = c(NA, NA, NA, NA), 
                             names = c("Slope", "Lower", "Upper", "EC50")), 
                  na.action = na.omit)
  # outputs the summary of the paramters including the estimate, standard
  # error, t-value, and p-value outputs it into a data frame called
  # summary.mef.fit for 'summary of fit'
  summary.fit <- data.frame(summary(isolate1)[[3]])
  # outputs the summary of just the EC50 data including the estimate, standard
  # error, upper and lower bounds of the 95% confidence intervals around the
  # EC50
  EC50 <- ED(isolate1, respLev = c(50), type = "relative", 
             interval = "delta")[[1]]
  EC50
}

EC50.ll4 <- NULL # create a null object 
for (i in seq_along(nm)) {
  isolate1 <- drm(100 * EC50.data$relgrowth[EC50.data$is == nm[[i]]] ~ 
                    EC50.data$conc[EC50.data$is == nm[[i]]], 
                  fct = LL.4(fixed = c(NA, NA, NA, NA), 
                             names = c("Slope", "Lower", "Upper", "EC50")), 
                  na.action = na.omit)
  # outputs the summary of the paramters including the estimate, standard
  # error, t-value, and p-value outputs it into a data frame called
  # summary.mef.fit for 'summary of fit'
  summary.fit <- data.frame(summary(isolate1)[[3]])
  # outputs the summary of just the EC50 data including the estimate, standard
  # error, upper and lower bounds of the 95% confidence intervals around the
  # EC50
  EC50 <- ED(isolate1, respLev = c(50), type = "relative", 
             interval = "delta")[[1]]
  EC50
  isolate.ec_i <- data.frame(nm[[i]], EC50) # create a one row dataframe containing just the isolate name and the EC50
  colnames(isolate.ec_i) <- c("Isolate", "EC50") # change the column names
  
  # Then we need to append our one row dataframe to our null dataframe we created before
  # and save it as EC50.ll4. 
  EC50.ll4 <- rbind.data.frame(EC50.ll4, isolate.ec_i)
}

EC50.data %>%
  group_by(is) %>%
  nest()

EC50.data %>%
  group_by(is) %>%
  nest() %>%
  mutate(ll.4.mod = map(data, ~drm(.$relgrowth ~ .$conc, 
                                   fct = LL.4(fixed = c(NA, NA, NA, NA), 
                                              names = c("Slope", "Lower", "Upper", "EC50"))))) %>%
  mutate(ec50 = map(ll.4.mod, ~ED(., 
                                  respLev = c(50), 
                                  type = "relative",
                                  interval = "delta")[[1]])) %>%
  unnest(ec50)





