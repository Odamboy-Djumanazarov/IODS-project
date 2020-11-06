# Odamboy Djumanazarov 
# Exercise 2 for the IODS course - Regression and model validation


create_learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)


##Dimension of create_learning2014 data
dim(create_learning2014) 
"consist of 180 observations and 60 variables"

##Structure of create_learning2014 data
str(create_learning2014)

"Most results are showed as likert scale (1-5) variables"
"Data also  includes gender (F or M, as a two level factor) and age (in years) of the person"
"Data also includes points and attitude of the person"


#Creation of analysis dataset with the variables gender, age, attitude, deep, stra, surf and points

gender <-c("Gender")
age <- c("Age")
attitude_questions <- c("Da","Db","Dc", "Dd", "De", "Df", "Dg", "Dh", "Di", "Dj")
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")
stra_questions <- c("ST01", "ST09", "ST17", "ST25", "ST04", "ST12", "ST20", "ST28")
surf_questions <- c("SU02", "SU10", "SU18", "SU26","SU05", "SU13", "SU21", "SU29", "SU08", "SU16", "SU24", "SU32")
points <- c("Points")

#Scaling of all combination variables to original scales (by taking mean)
library(dplyr)
deep_columns <- select(create_learning2014, one_of(deep_questions))
stra_columns <- select(create_learning2014, one_of(stra_questions))
surf_columns <- select(create_learning2014, one_of(surf_questions))
attitude_columns <- select(create_learning2014, one_of(attitude_questions))

create_learning2014$deep <- rowMeans(deep_columns)
create_learning2014$stra <- rowMeans(stra_columns)
create_learning2014$surf <- rowMeans(surf_columns)
create_learning2014$attitude <- attitude_columns / 10

keep_columns <- c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")

create_learning2014 <- select(create_learning2014, one_of(keep_columns))

create_learning2014$Attitude <- c(create_learning2014$Attitude) / 10
create_learning2014$Attitude

create_learning2014 <-filter(create_learning2014, Points>0)
dim(create_learning2014)

setwd("~/Odamboy-DjumanazarovIODS-project/IODS-project/data")
write.csv(create_learning2014, file = "create_learning2014.csv")
read.csv("create_learning2014.csv")
str(create_learning2014)
head(create_learning2014)


#Data analysis

#read the data
learning2014 <- read.csv("create_learning2014.csv")

str(learning2014)
View(learning2014)
dim(learning2014) 
colnames(learning2014) 
summary(learning2014)

table(learning2014$gender) 
table(learning2014$age)


plot(learning2014[c(-1,-2)]) #[c(-1,-2)] >>> is to remove indexcolumn and gender (strings) elements of df, source: https://statisticsglobe.com/remove-element-from-list-in-r
hist(learning2014$age, col='grey') 


#install.packages("ggplot2")
library(ggplot2)


p1 <- ggplot(learning2014, aes(x = attitude, y = points, col = gender))
p2 <- p1 + geom_point()
p2
p3 <- p2 + geom_smooth(method = "lm")
p4 <- p3 + ggtitle("Student's attitude versus exam points")
p4

pairs(learning2014[c(-1:-2)])
pairs(learning2014[c(-1:-2)], col= c("black", "red"))

library(GGally)
library(ggplot2)
p <- ggpairs(learning2014[c(-1:-2)], mapping = aes(), lower = list(combo = wrap("facethist", bins = 20)))
p


qplot(attitude, points, data = learning2014) + geom_smooth(method = "lm")

my_model <- lm(points ~ attitude, data = learning2014)
summary(my_model)

ggpairs(learning2014, lower = list(combo = wrap("facethist", bins = 20)))
my_model2 <- lm(points ~ attitude + stra + surf, data = learning2014)
summary(my_model2)


par(mfrow = c(2,2)) #defines that plots go to 2*2 frame (joining plots together)
plot(my_model4, which = c(1,2,5))


boxplot(my_model4$residuals,
        main = "Residuals of the model",
        xlab = "Residual values",
        ylab = "",
        col = "orange",
        border = "brown",
        horizontal = F,
        notch = F)


