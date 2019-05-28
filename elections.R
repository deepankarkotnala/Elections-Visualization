# ========================================================================================================================#
#                                                                                                                         #
#                                   Indian General Election (1984 to 2019) Study                                          #
#                                                                                                                         #
# ========================================================================================================================#

# Recently BJP secured majority in Lok Sabha Election. 
# In 1984, they contested first time in Lok Sabha Election. 
# INC (Indian National Congress) used to be the biggest political party in India a decade ago. 
# Here we will see the trend analysis on "% of seats won by these two parties) from 1984 to 2019. 
# Source of Data : Election Commission of India 

# Installing required packages and loading the required libraries
# install.packages("gganimate")
# install.packages("directlabels")
# install.packages("png")
# install.packages("transformr")
# install.packages("gifski")


library(ggplot2)
library(tidyverse)
library(gganimate)
library(directlabels)
library(png)
library(transformr)
library(grid)
library(ffmpeg)   # for saving visualization as video

# Read Data
df = read.table(text = 
                  " Year	Perc_Seats	Party
                1984	0.79	INC
                1989	0.38	INC
                1991	0.45	INC
                1996	0.27	INC
                1998	0.27	INC
                1999	0.22	INC
                2004	0.28	INC
                2009	0.4   INC
                2014	0.09	INC
                2019	0.1	  INC
                1984	0	    BJP
                1989	0.17	BJP
                1991	0.23	BJP
                1996	0.31	BJP
                1998	0.35	BJP
                1999	0.35	BJP
                2004	0.27	BJP
                2009	0.23	BJP
                2014	0.52	BJP
                2019	0.56	BJP
                ", header=TRUE)

# Set Theme
theme_set(theme_minimal())

# Plot and animate
p = ggplot(data = df, aes(x= factor(Year), y=Perc_Seats, group=Party, colour=Party)) +
  geom_line(size=2, show.legend = FALSE) +
  scale_color_manual(values=c("#ff9933", "#006400")) +
  scale_x_discrete(position = "top") +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  labs(title = 'Lok Sabha Election : % of seats won', 
       x = NULL, y = NULL) +
  geom_text(aes(label=scales::percent(Perc_Seats, accuracy = 1),
                vjust= -2), show.legend = FALSE) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_dl(aes(label=Party), method="last.points") +
  transition_reveal(Year) +
  coord_cartesian(clip = 'off') + 
  ease_aes('cubic-in-out')

animate(p, fps = 10, width = 800, height = 400)
anim_save("election.gif", p, width = 800, height = 400)

