##Vector
z<-c(1:200)
z
mean(z) #100.5
sd(z) #57.88
z>1

##Dataframe
df<-data.frame(z,z>1)
df

colnames(df)<-c("z","zlog")
df

##Add Column
z^2
df2<-data.frame(z,z>1,z^2)
df2
colnames(df2)<-c("z","zlog","zsquared")
df2

##Subset
subset(df2,zsquared>10 & zsquared<100) #Only 6 Rows