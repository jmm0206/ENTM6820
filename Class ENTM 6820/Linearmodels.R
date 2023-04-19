bull.richness <- read.csv('Bull_richness.csv')

library(tidyverse)
library(lme4)
library(emmeans)
library(multcomp)
install.packages('multcomp')

ggplot(mtcars, aes(x = wt, y = mpg))+
  geom_smooth(method = lm, se = FALSE)+
  geom_point()
  
lm1 <- lm(mpg~wt, data = mtcars)
summary(lm1)
anova(lm1)
cor.test(mtcars$wt, mtcars$mpg)

ggplot(lm1, aes(y = .resid, x = .fitted))+
  geom_point()+
  geom_hline(yintercept = 0)

plot(lm1)


bull.rich <-read.csv("Bull_richness.csv")
bull.rich %>%
  filter(GrowthStage == "V8" & Treatment == "Conv.") %>%
  ggplot(aes(x = Fungicide, y = richness)) +
  geom_boxplot()

bull.rich.sub <- bull.rich %>%
  filter(GrowthStage == "V8" & Treatment == "Conv.")

t.test(richness~Fungicide, data = bull.rich.sub, var.equal = TRUE)
summary(lm(richness~Fungicide, data = bull.rich.sub))
anova(lm(richness~Fungicide, data = bull.rich.sub))

bull.rich.sub2 <- bull.rich %>%
  filter(Fungicide == "C" & Treatment == "Conv." & Crop == "Corn")

ggplot(bull.rich.sub2, aes(x = GrowthStage, y = richness)) +
  geom_boxplot()

lm.growth <- lm(richness ~ GrowthStage, data = bull.rich.sub2)
summary(lm.growth)

anova(lm.growth)


lsmeans <- emmeans(lm.growth, ~GrowthStage)
results <- multcomp::cld(lsmeans, alpha = 0.05, reversed = TRUE, details = TRUE)

install.packages('multcompView')
library(multcompView)

lsmeans <- emmeans(lm.growth, ~GrowthStage)
results <- multcomp::cld(lsmeans, alpha = 0.05, reversed = TRUE, details = TRUE)
results

bull.rich.sub3 <- bull.rich %>%
  filter(Treatment == "Conv." & Crop == "Corn")

lm.inter <- lm(richness ~ GrowthStage + Fungicide + GrowthStage:Fungicide,
               data = bull.rich.sub3)

lm.inter <- lm(richness ~ GrowthStage*Fungicide,
               data = bull.rich.sub3)
summary(lm.inter)

ggplot(bull.rich.sub3, aes(x = GrowthStage, y = richness, fill = Fungicide)) +
  geom_boxplot()

lsmeans <- emmeans(lm.inter, ~Fungicide|GrowthStage)
results <- cld(lsmeans,alpha = 0.05, reversed = TRUE, details = TRUE)
results

lm.inter <- lm(richness ~ GrowthStage*Fungicide,
               data = bull.rich.sub3)
lme1 <- lmer(richness ~ GrowthStage*Fungicide + (1|Rep), data = bull.rich.sub3)
summary(lm.inter)
summary(lme1)

lsmeans <- emmeans(lm.inter, ~Fungicide|GrowthStage)
results <- cld(lsmeans,alpha = 0.05, reversed = TRUE, details = TRUE)
results

