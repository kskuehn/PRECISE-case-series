token <- "14DA391731B04882837E9D6B86EC85A7"
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
precise <- httr::content(response)

colnames(precise)[colnames(precise)=="all_emas_complete"]<-"complete"

## NEED TO CHANGE VARIABLE NAMES TO COMBINE (REMOVE _morning and _pm)
morning<-precise[c(1:7, 8:75)]
morning = morning[morning$pingnumber == "1",]
morning <- morning[ !is.na(morning$pingnumber), ]
pm<-precise[c(1:7, 76:137)]
pm = pm[pm$pingnumber != 1|is.na(pm$pingnumber),]

colnames(morning) <- gsub('_morning', '', colnames(morning))
colnames(pm) <- gsub('_pm', '', colnames(pm))

morning<-morning[-c(5,7,10),]

pm$substance<-NA
pm$substance_type___1<-NA
pm$substance_type___2<-NA
pm$substance_type___3<-NA
pm$substance_type___4<-NA
pm$substance_type___5<-NA
pm$sub_cope<-NA

morning$complete <- NA

precise<-rbind(morning, pm)

precise$PID<-NA
precise$PID[precise$participantid=="RbUQ4UBGlGyXme6cTpuB"]<-801
precise$PID[precise$participantid=="18QNNwsxcfhvFfM2XQkn"]<-804
precise$PID[precise$participantid=="eSh6Dx66pJBeMciNlwqu"]<-806
precise$PID[precise$participantid=="3C0HEZKQBiZNRMKZaCmO"]<-808
precise$PID[precise$participantid=="96oFiPNUw0WGcMFO7yZk"]<-810

precise$sh_intention_30<-precise$sh_intention_30-1
precise$sui_intent_30<-precise$sui_intent_30-1
precise$sui_intent_now<-precise$sui_intent_now-1

precise$sh_gating[is.na(precise$sh_gating=="TRUE")]<-0
precise$sh_30[precise$sh_30=="NA"]<-0
precise$sh_intention_30[is.na(precise$sh_intention_30)=="TRUE"]<-0
precise$sui_intent_30[is.na(precise$sui_intent_30)=="TRUE"]<-0
precise$sui_intent_now[is.na(precise$sui_intent_now)=="TRUE"]<-0

precise$SI<-0
precise$SI[precise$sui_intent_30>0]<-1

precise$STB<-0
precise$STB[precise$sh_intention_30>0]<-1

precise$daynumber[precise$record_id==12]<-3
precise$pingnumber[precise$record_id==12]<-0.33
precise$daynumber[precise$record_id==13]<-3
precise$pingnumber[precise$record_id==13]<-0.66
precise$daynumber[precise$record_id==19]<-4
precise$pingnumber[precise$record_id==19]<-0.5
precise$daynumber[precise$record_id==32]<-6
precise$pingnumber[precise$record_id==32]<-0.33
precise$daynumber[precise$record_id==33]<-6
precise$pingnumber[precise$record_id==33]<-0.66
precise$daynumber[precise$record_id==50]<-9
precise$pingnumber[precise$record_id==50]<-0.5
precise$daynumber[precise$record_id==86]<-16
precise$pingnumber[precise$record_id==86]<-0.5

column_names <- colnames(precise)
new_data <- data.frame(matrix(NA, ncol = length(column_names), nrow = 58))
colnames(new_data) <- column_names

new_data$pingnumber[1]<-4
new_data$daynumber[1]<-18
new_data$pingnumber[2]<-4
new_data$daynumber[2]<-25
new_data$pingnumber[3]<-5
new_data$daynumber[3]<-31
new_data$pingnumber[4]<-1
new_data$daynumber[4]<-34
new_data$pingnumber[5]<-3
new_data$daynumber[5]<-40
new_data$pingnumber[6]<-4
new_data$daynumber[6]<-42

new_data$pingnumber[7]<-5
new_data$daynumber[7]<-6
new_data$pingnumber[8]<-1
new_data$daynumber[8]<-22
new_data$pingnumber[9]<-3
new_data$daynumber[9]<-29
new_data$pingnumber[10]<-1
new_data$daynumber[10]<-37
new_data$pingnumber[11]<-2
new_data$daynumber[11]<-37
new_data$pingnumber[12]<-4
new_data$daynumber[12]<-37
new_data$pingnumber[13]<-5
new_data$daynumber[13]<-37
new_data$pingnumber[14]<-1
new_data$daynumber[14]<-38
new_data$pingnumber[15]<-2
new_data$daynumber[15]<-38
new_data$pingnumber[16]<-3
new_data$daynumber[16]<-38
new_data$pingnumber[17]<-4
new_data$daynumber[17]<-38
new_data$pingnumber[18]<-5
new_data$daynumber[18]<-38
new_data$pingnumber[19]<-1
new_data$daynumber[19]<-39
new_data$pingnumber[20]<-2
new_data$daynumber[20]<-39
new_data$pingnumber[21]<-3
new_data$daynumber[21]<-39
new_data$pingnumber[22]<-4
new_data$daynumber[22]<-39
new_data$pingnumber[23]<-5
new_data$daynumber[23]<-39
new_data$pingnumber[24]<-1
new_data$daynumber[24]<-40
new_data$pingnumber[25]<-2
new_data$daynumber[25]<-40
new_data$pingnumber[26]<-3
new_data$daynumber[26]<-40
new_data$pingnumber[27]<-4
new_data$daynumber[27]<-40
new_data$pingnumber[28]<-5
new_data$daynumber[28]<-40
new_data$pingnumber[29]<-1
new_data$daynumber[29]<-41
new_data$pingnumber[30]<-2
new_data$daynumber[30]<-41
new_data$pingnumber[31]<-3
new_data$daynumber[31]<-41
new_data$pingnumber[32]<-4
new_data$daynumber[32]<-41
new_data$pingnumber[33]<-5
new_data$daynumber[33]<-41
new_data$pingnumber[34]<-1
new_data$daynumber[34]<-42
new_data$pingnumber[35]<-2
new_data$daynumber[35]<-42
new_data$pingnumber[36]<-3
new_data$daynumber[36]<-42
new_data$pingnumber[37]<-4
new_data$daynumber[37]<-42
new_data$pingnumber[38]<-5
new_data$daynumber[38]<-42

new_data$pingnumber[39]<-5
new_data$daynumber[39]<-4
new_data$pingnumber[40]<-5
new_data$daynumber[40]<-12
new_data$pingnumber[41]<-2
new_data$daynumber[41]<-13
new_data$pingnumber[42]<-5
new_data$daynumber[42]<-19
new_data$pingnumber[43]<-4
new_data$daynumber[43]<-24
new_data$pingnumber[44]<-5
new_data$daynumber[44]<-27
new_data$pingnumber[45]<-2
new_data$daynumber[45]<-28
new_data$pingnumber[46]<-3
new_data$daynumber[46]<-31
new_data$pingnumber[47]<-5
new_data$daynumber[47]<-32
new_data$pingnumber[48]<-1
new_data$daynumber[48]<-33
new_data$pingnumber[49]<-5
new_data$daynumber[49]<-33
new_data$pingnumber[50]<-3
new_data$daynumber[50]<-35
new_data$pingnumber[51]<-5
new_data$daynumber[51]<-35
new_data$pingnumber[52]<-2
new_data$daynumber[52]<-36
new_data$pingnumber[53]<-5
new_data$daynumber[53]<-36
new_data$pingnumber[54]<-5
new_data$daynumber[54]<-37
new_data$pingnumber[55]<-5
new_data$daynumber[55]<-41
new_data$pingnumber[56]<-1
new_data$daynumber[56]<-42
new_data$pingnumber[57]<-1
new_data$daynumber[57]<-6
new_data$pingnumber[58]<-5
new_data$daynumber[58]<-22

new_data$PID[1:6]<-801
new_data$PID[7:38]<-808
new_data$PID[39:58]<-810

precise<-rbind(precise, new_data)

precise <- precise %>%
  mutate(daynumber = case_when(
    PID == 808 & record_id > 279 ~ daynumber + 7,
    TRUE ~ daynumber
  ))

precise <- precise %>%
  group_by(PID, daynumber, pingnumber) %>%
  arrange(PID, daynumber, pingnumber)

precise <- precise %>%
  filter(!(PID == 808 & record_id %in% c(141, 394, 586, 652, 668)))

precise <- precise %>%
  filter(!(PID == 810 & record_id %in% c(464)))

precise$obs<-ave(precise$PID, precise$PID, FUN=seq_along)

precise$neg.emo<-rowSums(precise[8:12], na.rm=TRUE)
precise$neg.emo<-precise$neg.emo/5

eightone<-subset(precise, precise$PID==801)
eightfour<-subset(precise, precise$PID==804)
eightsix<-subset(precise, precise$PID==806)
eighteight<-subset(precise, precise$PID==808)
eightten<-subset(precise, precise$PID==810)

summary(glm(eightone$STB~eightone$obs))
summary(lm(eightone$neg.emo~eightone$obs))

summary(glm(eighteight$SI~eighteight$obs))
summary(lm(eighteight$neg.emo~eighteight$obs))
summary(lm(eighteight$sui_intent_30~eighteight$obs))

summary(glm(eightten$STB~eightten$obs))
summary(lm(eightten$neg.emo~eightten$obs))
