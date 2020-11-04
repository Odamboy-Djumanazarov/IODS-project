# Odamboy Djumanazarov - 1.11.2020
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