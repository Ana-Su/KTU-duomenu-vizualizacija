library("tidyverse")
library("shiny")
library("dplyr")
library("ggplot2")

#1 užduotis 
data1 = read.csv("lab_sodra.csv")
data1=data1 %>%
  filter(ecoActCode==692000)
data1[is.na(data1)]=0

ggplot(data=data1, aes(x=avgWage, y=after_stat(count))) +
  geom_histogram(bins = 30, fill="steelblue", color="white") +
  labs(x="Average Wage", y="Count")


#2 užduotis
data2=data1
imones <- data2 %>%
  group_by(name) %>%
  summarise(avgWage = mean(avgWage)) %>%
  arrange(desc(avgWage)) %>%
  head(5) %>%
  pull(name)
ggplot(data2 %>% filter(name %in% imones),
       aes(x = month, y = avgWage, color = name)) +
  geom_line() +
  labs(x = "Menesiai", y = "Vidutinis darbo užmokestis")


#3 užduotis
data3 <- data2 %>% 
  group_by(name) %>%
  summarise(numInsured = sum(numInsured))%>%
  arrange(desc(numInsured))%>% 
  filter(name %in% imones) 

ggplot(data3, aes(x=reorder(name, -numInsured), y=numInsured, fill = name)) +
  geom_col() +
  labs(x="Pavadinimas", y="Apdraustieji")
