# Data wrangling for Task 6
# Peifeng Su
#*************************

library(dplyr)
library(tidyr)

# load data sets from github links
BPRS = read.csv('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt', sep=' ')
RATS = read.csv('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt', sep='\t')

# check the names
names(BPRS)
names(RATS)

# structures 
str(BPRS)
str(RATS)

# summary 
summary(BPRS)
summary(RATS)

# contents
glimpse(BPRS)
glimpse(RATS)

# convert the categorical variables to factors
BPRS$treatment = factor(BPRS$treatment)
BPRS$subject = factor(BPRS$subject)

RATS$ID = factor(RATS$ID)
RATS$Group = factor(RATS$Group)

# show the contents again
glimpse(BPRS)
glimpse(RATS)


# Convert to long form
BPRSL = BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL =  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))


# convert to long form
RATSL = RATS %>% gather(key=WD, value=rats, -ID, -Group)

# extract the WD numbers
RATSL = RATSL %>% mutate(Time = as.integer(substr(WD, 3,4)))


# glimpse 
glimpse(BPRSL)
glimpse(RATSL)

names(BPRSL)
names(RATSL)

# write the datasets to local device
write.csv(BPRSL,'data/BPRSL.csv', row.names = FALSE)
write.csv(RATSL,'data/RATSL.csv', row.names = FALSE)