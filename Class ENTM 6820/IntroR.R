# This is a comment - annotate code with ###
2+2
2-2
2/2
2*2

x = 3
y <- 2
name <- "Jo"
seven <- "7"
seven + x

class(seven)
class(x)

vec <- c(1,2,3,4,5,6,7) # numeric vector
vec <- c(1:7)
vec <- 1:7

vec2 <- c("Jo", "Mel", "C")
vec3 <- c(TRUE, FALSE)

vec2[2]

vec + x

mean(vec)
sd(vec)
sd(vec)/sqrt(7)
sum(vec)
min(vec)
min(vec)
summary(vec)
exp(vec)

# > # greater than
# < # less than
# | # or
# & # and
# != # not equal to
 
t <- 1:10 
t[(t>8) | (t<5)]
1 %in% t


mat1 <- matrix(data = c(1,2,3), nrow = 3, ncol = 3)
mat2 <- matrix(data = c("Jo", "Mel", "C"), nrow = 3, ncol = 3)

mat1[5]
mat1[1,2]
mat1[,2]
mat2[,1]

df <- data.frame(mat1[,1], mat2[,1])
colnames(df) <- c("value", "name")

df$value


df[df$name == "Mel",]
df$value[df$name == "Mel"]
subset(df, name =="Mel")
