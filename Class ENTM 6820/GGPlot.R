data("mtcars")

plot(x = mtcars$wt, y = mtcars$mpg)
plot(x = mtcars$wt, y = mtcars$mpg,
     xlab = "Car Weight",
     ylab = "Miles per gallon",
     font.lab = 6,
     pch = 20)

ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point() +
  geom_smooth (method = lm, se = FALSE) +
  geom_point(aes(color = wt)) +
  xlab("Weight") +
  ylab("Miles per Gallon") +
  theme_classic() +
  scale_color_gradient(low = "forestgreen", high = "black")+
  scale_y_log10()
