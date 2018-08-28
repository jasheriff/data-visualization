library("ggplot2")
library("dplyr")
library("stringr")

titanic <- read.csv("titanic_clean.csv")

# 1 - Check the structure of titanic

names(titanic)[names(titanic) == 'pclass'] <- 'ticket_class'
titanic <- dplyr::mutate(titanic, survived = replace(survived, stringr:: str_detect(survived, "1"), "survived"))
titanic <- dplyr::mutate(titanic, survived = replace(survived, stringr:: str_detect(survived, "0"), "died"))

# 2 - Use ggplot() for the first instruction
ggplot(titanic, aes(x = ticket_class, fill = sex)) +
  geom_bar(position = "dodge")

#2.5 Created new dataset by removing observations with survived == NA 
titanic[is.na(titanic$survived), ]
titanic2 <- titanic[-c(1310), ]

# 3 - Plot 2, add facet_grid() layer
ggplot(data = titanic2, aes(x = ticket_class, fill = sex)) +
  geom_bar(position = "dodge") +
  facet_grid("survived")

# 4 - Define an object for position jitterdodge, to use below
posn.jd <- position_jitterdodge(0.5, 0, 0.6)


# 5 - Plot 3, but use the position object from instruction 4
ggplot(titanic2, aes(x = ticket_class, y = age, color = sex)) +
  geom_point(size = 3, alpha = 0.5, position = posn.jd) +
  facet_grid("survived")

write.csv(titanic2, "titanic_na.rm_survived.csv")