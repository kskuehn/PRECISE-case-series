# setwd<-[#INSERT PATH TO WORKING DIRECTORY#$]

precise<-read.csv('~/precise.aim.1.csv')

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
