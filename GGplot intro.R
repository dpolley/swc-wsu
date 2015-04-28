#install and load ggplot2
install.packages("ggplot2")
library(ggplot2)

# Load gapminder data
gapminder <- read.csv("gapminder.csv")
head(gapminder)

# scatterplot of lifeExp vs gdpPercap
ggplot(gapminder, 
       aes(x=gdpPercap, y=lifeExp)) + geom_point()
  ## aesthetics = data - 
  ## geometrics = plot display - actual objects in the graph

#Alternatively
p <- ggplot(gapminder, 
            aes(x=gdpPercap, y=lifeExp)) 
p2 <- p + geom_point()    
print(p2)     ##Nothing is plotted until this command is made

##Make x-axis have a log scale
p3 <- p + geom_point() + scale_x_log10()
print(p3)

#alternatively - - -- - - basically you "add" the plot modifiers
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + scale_x_log10() + geom_point()

##Challenge: Mkae scatter plot of LifeExp vs gdpPercap with only data for China
ggplot(filter(gapminder, country == "China"), aes(x=gdpPercap, y=lifeExp)) + scale_x_log10() + geom_point()
 ### OR:
gapminder %>%
  filter(country == "China") %>%
  ggplot(aes(x=gdpPercap, y=lifeExp)) +
  geom_point(size=5)            ####"size" argument chnages marker size
        ##other marker aesthetics: color, alpha

###Try color = continent - identify different continents
p3 <- p2 + aes(color=continent) + scale_x_log10()

###Challenge: try size, shape, color aesthetics for categorical AND numeric variables
p4 <- p2 + aes(shape=continent, color=continent) + geom_point(size=3) + scale_x_log10()
p4
#### Chek out "cut" function ?cut 

##Back to China example
gm_china <- gapminder %>%
  filter(country == 'China')

p5 <- ggplot(gm_china, 
  aes(x=gdpPercap, y=lifeExp)) +
  geom_point(color="lightblue",size=5)  +
  geom_line(color="violetred")
p5

#points colored by year 
ggplot(gm_china, 
       aes(x=gdpPercap, y=lifeExp)) +
  geom_line() + 
  geom_point(aes(color=year))

gm_chinaindia <- gapminder %>%
  filter(country %in% c("China", "India"))

## Challenge plot lifeExp vs gdpPercap for CHina and India 
## with lines in black but points colored by country
ggplot(gm_chinaindia,
       aes(x=gdpPercap, y=lifeExp)) + 
  geom_line(aes(group=country)) +      ### Use "group" to seperate the two countries' lines
  geom_point(aes(color=country))

##Histogram###

gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x=lifeExp)) + 
  geom_histogram(binwidth=2.5, fill="lightblue", color="black")
    ###So bin width is 2.5 years

####Box plot###
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(y=lifeExp, x=continent)) +   ###try switching x and y
  geom_boxplot(binwidth=2.5, fill="lightblue", color="black")

## Scatter ## - shows more data
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(y=lifeExp, x=continent)) + 
  geom_point(position=position_jitter(width=0.1, height=0)) +
  geom_boxplot(fill="lightblue", color="black", alpha=0.5)

## Faceting
#facet grid
ggplot(gapminder,
       aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + scale_x_log10() + 
  facet_grid(continent ~ year)

#facet wrap
ggplot(gapminder,
       aes(x=gdpPercap, y=lifeExp, color=continent)) + 
  geom_point() + scale_x_log10() + 
  facet_wrap(~ year)

##Challenge: select five countries, plot lifeExp vs gdpPercap across time, faceting by country 
gm_5countries <- gapminder %>%
  filter(country %in% c("China", "Nigeria", "Japan", "France", "United States"))
p6 <- ggplot(gm_5countries,
       aes(x=gdpPercap, y=lifeExp)) + 
  geom_line() + scale_x_log10() + 
  facet_wrap(~ country)

p_five <- gapminder %>%
  filter(country %in% c("China", "India", "Somalia", "France") )  %>%
  ggplot(aes(x=gdpPercap, y=lifeExp, group = country)) +
  geom_line(color = "black") +
  geom_point( aes(color = country)) +
  facet_wrap(~ country) +
  scale_color_discrete(guide = "none")
p_five

#change some themes - need to install that package
#install.packages("ggthemes)
library(ggthemes)
p6 + theme_wsj

getwd()
ggsave("/Users/drew/Desktop/swc-wsu/5_countries.pdf", p6, width=7, height=7)
