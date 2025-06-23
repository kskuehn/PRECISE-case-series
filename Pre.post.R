# Importing packages
library(flexdashboard)
library(tidyverse)
library(htmltools)
library(viridis)
library(flexdashboard)
library(ggplot2)
library(gt)
library(plotly)
library(corrplot)
library(RCurl)

# Importing data

## Importing Pre-Post Data
token <- "50BAA1024286C966744E2E6797B79C41"
url <- "https://redcap.ucsd.edu/api/"
formData <- list("token"=token,
                 content='record',
                 action='export',
                 format='csv',
                 type='flat',
                 rawOrLabel='raw',
                 rawOrLabelHeaders='raw',
                 exportCheckboxLabel='true',
                 exportSurveyFields='false',
                 exportDataAccessGroups='false',
                 returnFormat='csv'
)
response <- httr::POST(url, body = formData, encode = "form")
pre.post<- httr::content(response)

baseline<-subset(pre.post, pre.post$redcap_event_name=="baseline_arm_1")

baseline <- baseline %>%
  filter(!(record_id %in% c(802, "TEST")))

base_cssrs<-baseline$cssr_score_1month

my_list <- seq(362, 396, by = 2)
baseline$mssi<-rowSums(baseline[c(my_list)], na.rm=TRUE)

names(baseline)[names(baseline) == "cssr_score_1month"] <- "cssrs_ideation_score"

vars<-c('record_id', 'cssrs_ideation_score', 'mssi')
base<-baseline[vars]
base$timepoint<-"baseline"

sixmo<-subset(pre.post, pre.post$redcap_event_name=="6week_arm_1")
sixmo <- sixmo %>%
  filter(!(record_id %in% c(802, "TEST")))

six_cssrs<-sixmo$cssrs_ideation_score

my_list <- seq(362, 396, by = 2)
sixmo$mssi<-rowSums(sixmo[c(my_list)], na.rm=TRUE)

vars<-c('record_id', 'cssrs_ideation_score', 'mssi')
sixmo<-sixmo[vars]
sixmo$timepoint<-"6_months"

twelmo<-subset(pre.post, pre.post$redcap_event_name=="12week_arm_1")
twelmo <- twelmo %>%
  filter(!(record_id %in% c(802, "TEST")))

twel_cssrs<-twelmo$cssrs_ideation_score

my_list <- seq(362, 396, by = 2)
twelmo$mssi<-rowSums(twelmo[c(my_list)], na.rm=TRUE)

vars<-c('record_id', 'cssrs_ideation_score', 'mssi')
twelmo<-twelmo[vars]
twelmo$timepoint<-"12_months"

library(dplyr)

long_data <- bind_rows(base, sixmo, twelmo)

long_data$ID <- as.factor(long_data$record_id)
long_data$timepoint <- factor(long_data$timepoint, levels = c("baseline", "6_months", "12_months"))

library(afex)

aov_ez(
  id = "ID",
  dv = "cssrs_ideation_score",
  data = long_data,
  within = "timepoint"
)

aov_ez(
  id = "ID",
  dv = "mssi",
  data = long_data,
  within = "timepoint"
)

write.csv(long_data, '/Users/kevinkuehn/Documents/Post-doc/pre.post.csv')

