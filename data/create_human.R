#4.Clustering and classification
#Create a new R script called create_human.R
#Read the "Human development" and "Gender inequality" datas into R. Here are the links to the datasets: (1 point)

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
# and
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

head(hd)
str(hd)
dim(hd)
summary(hd)
head(gii)
str(gii)
dim(gii)
summary(gii)
colnames(hd) <- c('HDI.Rank', 'Country', 'HDI', 'LifeExp', 'ExpEdu', 'MeanEdu', 'GNIpercap', 'GNIrank_minus_HDIrank')
#head(hd)
#head(gii)
hd <- as.data.frame(hd)
F.M.Edu.ratio <- gii$S.Edu.F/gii$S.Edu.M 
F.M.LF <- gii$LFF/gii$LFM
gii <- as.data.frame(gii)
gii <- cbind(gii, F.M.Edu.ratio, F.M.LF)
library(dplyr)
human <- inner_join(hd, gii, by = c("Country"))
setwd("~/Odamboy-DjumanazarovIODS-project/IODS-project/data")
write.csv(human, file = 'human.csv')

read.csv(file = "~/Odamboy-DjumanazarovIODS-project/IODS-project/data/human")
str(human)
# The data includes information of the population of 195 countries. You can find info about f.ex. HDI, GNI and Birth Rate.

# 1: transform GNI to numeric
library(stringr)
human$GNI <- as.numeric(str_replace(human$GNI, pattern = ',', replace = ''))

# 2: exclude some columns
keep <- c('Country', 'eduFM', 'labFM', 'ExpEdu', 'ExpLife', 'GNI', 'MMR', 'BirthRate', 'PP')
human <- dplyr::select(human, one_of(keep))
# 3: remove observations with NA
human <- filter(human, complete.cases(human))
# 4: remove observations that relate to regions
human <- human[1:155,]

# rownames
rownames(human) <- human$Country
human <- human[,-1]

write.csv(human, file = 'human.csv', row.names = TRUE)

