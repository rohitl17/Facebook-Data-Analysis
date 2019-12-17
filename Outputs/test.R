print("Facebook dataset for page analysis")
data<-read.csv("facebook.csv")
#print(data)
print (is.data.frame(data))
print (ncol(data))
print (nrow(data))

####MULTIPLE REGRESSION ANALYSIS #####
input<-read.csv(file = "facebook.csv", sep = ",")[ ,c('PTL','LPTReach','LPTImpressions','Type','Weekday','Hour')]
print (head(input))
model<-lm(PTL~LPTReach+LPTImpressions+Type+Weekday+Hour,data=input)
print(model)
a <- coef(model)[1]
#print(a)
XLPTReach <- coef(model)[2]
XLPTImpressions <- coef(model)[3]
XTypePhoto <- coef(model)[4]
XTypeStatus <- coef(model)[5]
XTypeVideo <- coef(model)[6]
XWeekday <- coef(model)[7]
Xhour <- coef(model)[8]


####PREDICTION OF NUMBER OF LIKES FROM VARIOUS PARAMETERS####
print("Prediction of number of likes from the multiple regression analysis")
x1 <- readline("What is the total reach?")
x1 <- as.numeric(x1)
x2 <- readline("What is the value for total impressions?") 
x2 <- as.numeric(x2)
x6 <- readline("What is weekday?")
x6 <- as.numeric(x6)
x7 <- readline("Which is the hour of the day?") 
x7 <- as.numeric(x7)
x<-c("Photo","Status","Video")
print(x)
type<-readline("What is the type of post?")
if("Photo" %in% type) {
  Y = a + XLPTReach*x1+XLPTImpressions*x2+XTypePhoto*2.5+XWeekday*x6+Xhour*x7
  Z = a + XLPTReach*x1+XLPTImpressions*x2+XTypePhoto*3+XWeekday*x6+Xhour*x7
  print("Range of likes:")
  print(Y)
  print(Z)
} else if ("Status" %in% x) {
  Y = a + XLPTReach*x1+XLPTImpressions*x2+XTypeStatus*1.4+XWeekday*x6+Xhour*x7
  Z = a + XLPTReach*x1+XLPTImpressions*x2+XTypeStatus*2+XWeekday*x6+Xhour*x7
  print("Range of likes:")
  print(Y)
  print(Z)
} else if ("Video" %in% x) {
  Y = a + XLPTReach*x1+XLPTImpressions*x2+XTypeVideo*1.1+XWeekday*x6+Xhour*x7
  Z = a + XLPTReach*x1+XLPTImpressions*x2+XTypeVideo*1.8+XWeekday*x6+Xhour*x7
  print("Range of likes:")
  print(Y)
  print(Z)
}


#####Relation between post day and number of reached,Number of impressions####

day1<- subset(data,Weekday==1)
mean1R <- mean(day1$LPTReach)
mean1I <- mean(day1$LPTImpressions)


day2<- subset(data,Weekday==2)
mean2R <- mean(day2$LPTReach)
mean2I <- mean(day2$LPTImpressions)

day3<- subset(data,Weekday==3)
mean3R <- mean(day3$LPTReach)
mean3I <- mean(day3$LPTImpressions)

day4<- subset(data,Weekday==4)
mean4R <- mean(day4$LPTReach)
mean4I <- mean(day4$LPTImpressions)

day5<- subset(data,Weekday==5)
mean5R <- mean(day5$LPTReach)
mean5I <- mean(day5$LPTImpressions)

day6<- subset(data,Weekday==6)
mean6R <- mean(day6$LPTReach)
mean6I <- mean(day6$LPTImpressions)

day7<- subset(data,Weekday==7)
mean7R <- mean(day7$LPTReach)
mean7I <- mean(day7$LPTImpressions)

v<-c(mean1R,mean2R,mean3R,mean4R,mean5R,mean6R,mean7R)
t<-c(mean1I,mean2I,mean3I,mean4I,mean5I,mean6I,mean7I)
png(file = "Weekday_TotalReach.png")
plot(v,type = "o",col = "red", xlab = "Weekday", ylab = "Total Reach", 
 main = "Chart for analysis of total reach")
dev.off()

png(file = "Weekday_TotalImpressions.png")
plot(t,type = "o",col = "blue", xlab = "Weekday", ylab = "Total Impressions", 
     main = "Chart for analysis of total impressions")
dev.off()

#####RELATION BETWEEN TYPE OF POST & REACH, POST & IMPRESSIONS#####
photodf <- subset(data,Type=="Photo")
meanPR <- mean(photodf$LPTReach)
meanPI <- mean(photodf$LPTImpressions)
#meanPLikesP <- mean(photodf$PTL)


statusdf <- subset(data,Type=="Status")
meanSR <- mean(statusdf$LPTReach)
meanSI <- mean(statusdf$LPTImpressions)
#meanPLikesS <- mean(statusdf$PTL)


videodf <- subset(data,Type=="Video")
meanVR <- mean(videodf$LPTReach)
meanVI <- mean(videodf$LPTImpressions)
#meanPLikesV <- mean(videodf$PTL)


linkdf <- subset(data,Type=="Link")
meanLR <- mean(linkdf$LPTReach)
meanLI <- mean(linkdf$LPTImpressions)
#meanPLikesL <- mean(linkdf$PTL)

ValueR <- c(meanPR,meanSR,meanVR,meanLR)
ValueI <- c(meanPI,meanSI,meanVI,meanLI)
Post <- c("Photo","Status","Video","Link")
png(file = "barchart_reach&postType.png")

barplot(ValueR,names.arg = Post,xlab = "Post Type",ylab = "Total Reach",col = "blue",
        main = "Total Reach v/s Post Type",border = "red")
dev.off()

png(file = "barchart_Impressions&postType.png")
barplot(ValueI,names.arg = Post,xlab = "Post Type",ylab = "Total Impressions",col = "red",
        main = "Total Impressions v/s Post Type",border = "blue")
dev.off()

######Total Reach,Impressions,Likes on basis of total interactions######
ReachInt<-data$LPTReach
ImpressionInt<-data$LPTImpressions
LikesInt<-data$PTL
TotalInt<-data$Total.Interactions

relation <- lm(TotalInt~ReachInt)
png(file = "linearregression(ReachvsInteractions.png")
plot(ReachInt,TotalInt,col = "blue",main = "Reach v/s Interactions",
     cex = 1.3,pch = 16,ylab = "Total Interactions",xlab = "Total Reach")
dev.off()

relation <- lm(TotalInt~ImpressionInt)
png(file = "linearregression(ImpressionsvsInteractions.png")
plot(ImpressionInt,TotalInt,col = "red",main = "Impressions v/s Interactions",
     cex = 1.3,pch = 16,ylab = "Total Interactions",xlab = "Total Impressions")
dev.off()

relation <- lm(LikesInt~TotalInt)
png(file = "linearregression(LikesvsInteractions.png")
plot(TotalInt,LikesInt,col = "violet",main = "Likes v/s Interactions",
     cex = 1.3,pch = 16,xlab = "Total Interactions",ylab = "Total Page Likes")
dev.off()


######Paid And Type,LPTReachL,Reach,Impressions######
data1<-read.csv("facebook.csv")
library(party)

png(file = "Paid(PartialData).png")
output.tree <- ctree(
  Paid[1:100] ~ ReachInt[1:100] + ImpressionInt[1:100], 
  data = data1)
plot(output.tree)
dev.off()

png(file = "Paid(FullData).png")
output.tree <- ctree(
  Paid[1:100] ~ ReachInt[1:100] + ImpressionInt[1:100], 
  data = data1)
plot(output.tree)
dev.off()


#####Lifetimepost liked & engaged ones####
LPEuser1<-data$LPEuser
LEngaged1<-data$LEngaged
divi.result <- (LPEuser1/LEngaged1)*100
LPEuser1mean<-mean(divi.result)
LEngaged1mean=100-LPEuser1mean
x<-c(LPEuser1mean,LEngaged1mean)
piepercent<- round(100*x/sum(x), 1)
png(file = "Engaged_users.png")
pie(x,labels=piepercent, main = "Engaged users %", col = rainbow(length(x)))
legend("topright", c("Users already liked the page","Others"), cex = 0.8,fill = rainbow(length(x)))
dev.off()

#####Reached,Engaged and Consumed per post type#######
LPTreach<-photodf$LPTReach
LEngaged2<-photodf$LEngaged
LConsumer<-photodf$LPConsumers
print("Statistical results for post type=photo")
print(mean(LPTreach))
print(mean(LEngaged2))
print(mean(LConsumer))
divi.result1<- (LEngaged2/LPTreach)*100
divi.result2<- (LConsumer/LPTreach)*100
others<-100-(divi.result1+divi.result2)
LEngaged2mean<-mean(divi.result1)
LConsumermean<-mean(divi.result2)
others<-100-(LEngaged2mean+LConsumermean)
x<-c(LEngaged2mean,LConsumermean,others)
piepercent<- round(100*x/sum(x), 1)
png(file = "Reach_Engaged_Consumers(photo).png")
pie(x,labels=piepercent, main = "Engaged Users,Consumed from total reach(photo)%", col = rainbow(length(x)))
legend("topright", c("Engaged users%","Lifetime Post Consumers%","Others%"), cex = 0.8,fill = rainbow(length(x)))
dev.off()

LPTreach<-statusdf$LPTReach
LEngaged2<-statusdf$LEngaged
LConsumer<-statusdf$LPConsumers
print("Statistical results for post type=status")
print(mean(LPTreach))
print(mean(LEngaged2))
print(mean(LConsumer))
divi.result1<- (LEngaged2/LPTreach)*100
divi.result2<- (LConsumer/LPTreach)*100
others<-100-(divi.result1+divi.result2)
LEngaged2mean<-mean(divi.result1)
LConsumermean<-mean(divi.result2)
others<-100-(LEngaged2mean+LConsumermean)
x<-c(LEngaged2mean,LConsumermean,others)
piepercent<- round(100*x/sum(x), 1)
png(file = "Reach_Engaged_Consumers(status).png")
pie(x,labels=piepercent, main = "Engaged Users,Consumed from total reach(status)%", col = rainbow(length(x)))
legend("topright", c("Engaged users%","Lifetime Post Consumers%","Others%"), cex = 0.8,fill = rainbow(length(x)))
dev.off()

LPTreach<-videodf$LPTReach
LEngaged2<-videodf$LEngaged
LConsumer<-videodf$LPConsumers
print("Statistical results for post type=video")
print(mean(LPTreach))
print(mean(LEngaged2))
print(mean(LConsumer))
divi.result1<- (LEngaged2/LPTreach)*100
divi.result2<- (LConsumer/LPTreach)*100
others<-100-(divi.result1+divi.result2)
LEngaged2mean<-mean(divi.result1)
LConsumermean<-mean(divi.result2)
others<-100-(LEngaged2mean+LConsumermean)
x<-c(LEngaged2mean,LConsumermean,others)
piepercent<- round(100*x/sum(x), 1)
png(file = "Reach_Engaged_Consumers(video).png")
pie(x,labels=piepercent, main = "Engaged Users,Consumed from total reach(video)%", col = rainbow(length(x)))
legend("topright", c("Engaged users%","Lifetime Post Consumers%","Others%"), cex = 0.8,fill = rainbow(length(x)))
dev.off()

LPTreach<-linkdf$LPTReach
LEngaged2<-linkdf$LEngaged
LConsumer<-linkdf$LPConsumers
print("Statistical results for post type=link")
print(mean(LPTreach))
print(mean(LEngaged2))
print(mean(LConsumer))
divi.result1<- (LEngaged2/LPTreach)*100
divi.result2<- (LConsumer/LPTreach)*100
others<-100-(divi.result1+divi.result2)
LEngaged2mean<-mean(divi.result1)
LConsumermean<-mean(divi.result2)
others<-100-(LEngaged2mean+LConsumermean)
x<-c(LEngaged2mean,LConsumermean,others)
piepercent<- round(100*x/sum(x), 1)
png(file = "Reach_Engaged_Consumers(link).png")
pie(x,labels=piepercent, main = "Engaged Users,Consumed from total reach(link)%", col = rainbow(length(x)))
legend("topright", c("Engaged users%","Lifetime Post Consumers%","Others%"), cex = 0.8,fill = rainbow(length(x)))
dev.off()


#####Total consumptions,Engaged v/s impressions per post type#####
LPConsumptions<-photodf$LPConsumptions
LPTimpressions<-photodf$LPTImpressions
LEngaged2<-photodf$LEngaged
print("Statistical Results for post type=photo")
print(mean(LPTimpressions))
print(mean(LPConsumptions))
print(mean(LEngaged2))
divi.result<-(LPConsumptions/LPTimpressions)*100
divi.result2<-(LEngaged2/LPTimpressions)*100
LEngaged2mean<-mean(divi.result)
LPConsumptionsmean<-mean(divi.result2)
others<-100-(LEngaged2mean + LPConsumptionsmean)
x<-c(LEngaged2mean,LPConsumptionsmean,others)
piepercent<- round(100*x/sum(x), 1)
png(file = "Impressions_Engaged_Consumptions(photo).png")
pie(x,labels=piepercent, main = "Engaged Users,Consumptions from total impressions(photo)%", col = rainbow(length(x)))
legend("topright", c("Engaged users%","Lifetime Post Consumptions%","Others%"), cex = 0.8,fill = rainbow(length(x)))
dev.off()

LPConsumptions<-statusdf$LPConsumptions
LPTimpressions<-statusdf$LPTImpressions
LEngaged2<-statusdf$LEngaged
print("Statistical Results for post type=status")
print(mean(LPTimpressions))
print(mean(LPConsumptions))
print(mean(LEngaged2))
divi.result<-(LPConsumptions/LPTimpressions)*100
divi.result2<-(LEngaged2/LPTimpressions)*100
LEngaged2mean<-mean(divi.result)
LPConsumptionsmean<-mean(divi.result2)
others<-100-(LEngaged2mean + LPConsumptionsmean)
x<-c(LEngaged2mean,LPConsumptionsmean,others)
piepercent<- round(100*x/sum(x), 1)
png(file = "Impressions_Engaged_Consumptions(status).png")
pie(x,labels=piepercent, main = "Engaged Users,Consumptions from total impressions(status)%", col = rainbow(length(x)))
legend("topright", c("Engaged users%","Lifetime Post Consumptions%","Others%"), cex = 0.8,fill = rainbow(length(x)))
dev.off()

LPConsumptions<-videodf$LPConsumptions
LPTimpressions<-videodf$LPTImpressions
LEngaged2<-videodf$LEngaged
print("Statistical Results for post type=video")
print(mean(LPTimpressions))
print(mean(LPConsumptions))
print(mean(LEngaged2))
divi.result<-(LPConsumptions/LPTimpressions)*100
divi.result2<-(LEngaged2/LPTimpressions)*100
LEngaged2mean<-mean(divi.result)
LPConsumptionsmean<-mean(divi.result2)
others<-100-(LEngaged2mean + LPConsumptionsmean)
x<-c(LEngaged2mean,LPConsumptionsmean,others)
piepercent<- round(100*x/sum(x), 1)
png(file = "Impressions_Engaged_Consumptions(video).png")
pie(x,labels=piepercent, main = "Engaged Users,Consumptions from total impressions(video)%", col = rainbow(length(x)))
legend("topright", c("Engaged users%","Lifetime Post Consumptions%","Others%"), cex = 0.8,fill = rainbow(length(x)))
dev.off()

LPConsumptions<-linkdf$LPConsumptions
LPTimpressions<-linkdf$LPTImpressions
LEngaged2<-linkdf$LEngaged
print("Statistical Results for post type=link")
print(mean(LPTimpressions))
print(mean(LPConsumptions))
print(mean(LEngaged2))
divi.result<-(LPConsumptions/LPTimpressions)*100
divi.result2<-(LEngaged2/LPTimpressions)*100
LEngaged2mean<-mean(divi.result)
LPConsumptionsmean<-mean(divi.result2)
others<-100-(LEngaged2mean + LPConsumptionsmean)
x<-c(LEngaged2mean,LPConsumptionsmean,others)
piepercent<- round(100*x/sum(x), 1)
png(file = "Impressions_Engaged_Consumptions(link).png")
pie(x,labels=piepercent, main = "Engaged Users,Consumptions from total impressions(link)%", col = rainbow(length(x)))
legend("topright", c("Engaged users%","Lifetime Post Consumptions%","Others%"), cex = 0.8,fill = rainbow(length(x)))
dev.off()

