MycotoxinData <- read.csv("MycotoxinData.csv",na.strings=".")

#GGPlot Question 1
#Geom: a geometric object that are the building blocks of ggplot
#Facet: subset of data
#Layering: allows you to build individual layers of visuals/data that
   #can be built upon one another to create complex visualizations
#Adding Variables: Typed in the script box (HERE) using different
   #different ggplot functions such as plot(), geom(), and aes()
#Jitter: adds small variation to prevent overplotting, adds "random noise"
    #to make plots more readable

library(ggplot2)

#Question 2: Making a Boxplot
ggplot(MycotoxinData, aes(x = Treatment,y = DON, color = Cultivar))+
  geom_boxplot()+
  geom_point(position=position_jitterdodge(dodge.width=0.9))+
  xlab("") + ylab("DON (ppm)")+
  theme_classic()

#Question 3: Making a Bar Graph
ggplot(MycotoxinData,aes(x=Treatment,y= DON,fill= Cultivar))+
  stat_summary(fun= mean,geom= "bar", position= "dodge",color= "black")+
  stat_summary(fun.data=mean_se,geom="errorbar", position= "dodge")+
  scale_color_manual(values= c("gray","blue"))+
  scale_fill_manual(values= c("gray","blue"))+
  xlab("") + ylab("DON (ppm)")+
  theme_classic()
 #error bars are coded, but not visible?

#Question 4: Data Points
ggplot(MycotoxinData,aes(x=Treatment,y=DON,fill=Cultivar))+
  stat_summary(fun=mean,geom="bar",position="dodge",color="black")+
  stat_summary(fun.data=mean_se,geom="errorbar",position="dodge")+
  geom_point(position=position_jitterdodge(dodge.width=1),shape=21,color="black")+
  scale_color_manual(values= c("gray","blue"))+
  scale_fill_manual(values= c("gray","blue"))+
  xlab("") + ylab("DON (ppm)")+
  theme_classic()

#Question 5: Colorblind
ggplot(MycotoxinData,aes(x=Treatment,y=DON,fill=Cultivar))+
  stat_summary(fun=mean,geom="bar",position="dodge",color="black")+
  stat_summary(fun.data=mean_se,geom="errorbar",position="dodge")+
  geom_point(position=position_jitterdodge(dodge.width=1),shape=21,color="black")+
  scale_color_manual(values=c("#56B4E9","#D55E00"))+
  scale_fill_manual(values=c("#56B4E9","#D55E00"))+
  xlab("") + ylab("DON (ppm)")+
  theme_classic()

#Question 6: Facet
ggplot(MycotoxinData,aes(x=Treatment,y=DON,fill=Cultivar))+
  stat_summary(fun=mean,geom="bar",position="dodge",color="black")+
  stat_summary(fun.data=mean_se,geom="errorbar",position="dodge")+
  geom_point(position=position_jitterdodge(dodge.width=1),shape=21,color="black")+
  scale_color_manual(values=c("#56B4E9","#D55E00"))+
  scale_fill_manual(values=c("#56B4E9","#D55E00"))+
  xlab("") + ylab("DON (ppm)")+
  facet_wrap(~Treatment*Cultivar,scales="free")+
  theme_classic()

#Question 7: Themes
ggplot(MycotoxinData,aes(x=Treatment,y=DON,fill=Cultivar))+
  stat_summary(fun=mean,geom="bar",position="dodge",color="black")+
  stat_summary(fun.data=mean_se,geom="errorbar",position="dodge")+
  geom_point(position=position_jitterdodge(dodge.width=1),shape=21,color="black")+
  scale_color_manual(values=c("#56B4E9","#D55E00"))+
  scale_fill_manual(values=c("#56B4E9","#D55E00"))+
  xlab("") + ylab("DON (ppm)")+
  facet_wrap(~Treatment*Cultivar,scales="free")+
  theme_minimal()

#Question 8: Transparency (alpha function)
ggplot(MycotoxinData,aes(x=Treatment,y=DON,fill=Cultivar))+
  stat_summary(fun=mean,geom="bar",position="dodge",color="black")+
  stat_summary(fun.data=mean_se,geom="errorbar",position="dodge")+
  geom_point(position=position_jitterdodge(dodge.width=1),shape=21,color="black",
             alpha=.2)+
  scale_color_manual(values=c("#56B4E9","#D55E00"))+
  scale_fill_manual(values=c("#56B4E9","#D55E00"))+
  xlab("") + ylab("DON (ppm)")+
  facet_wrap(~Treatment*Cultivar,scales="free")+
  theme_minimal()

#Question 9: Boxplot v. Bar Graph
#The box plot is showing the average 50% of the treatment categories 
    #including the outlying data points. The bar chart is showing the variation
    #between the treatment categories. For this data, the bar chart is more clear
    #because it is directly comparing the different treatments and replicates
    #in terms of their y value, while the boxplot does not.

#Question 9: Other Options
ggplot(MycotoxinData,aes(x=Treatment,y=DON,color=Cultivar))+
  geom_count()+
  scale_size_area()+
  scale_color_manual(values=c("#56B4E9","#D55E00"))+
  scale_fill_manual(values=c("#56B4E9","#D55E00"))+
  xlab("") + ylab("DON (ppm)")+
  theme_classic()

ggplot(MycotoxinData,aes(x=Treatment,y=DON,color=Cultivar))+
  stat_boxplot()+
  stat_summary(fun.data=mean_se,geom="errorbar",position="dodge")+
  scale_color_manual(values=c("#56B4E9","#D55E00"))+
  scale_fill_manual(values=c("#56B4E9","#D55E00"))+
  xlab("") + ylab("DON (ppm)")+
  theme_classic()
#These include standard error

#I would use geom_smooth or stat_smooth because I have population counts over time
