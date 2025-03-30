# ggplot graphics 1
# NJG
# 27 March 2025
#
library(ggplot2)
library(ggthemes)
library(patchwork)
# p1 <- ggplot(data= <DATA>) +
#   aes(<MAPPINGS>) +
#   <GEOM_FUNCTION>(aes(<MAPPINGS>),
#                   stat=<STAT>,
#                   position=<POSITION>) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>

# print(p1)

# ggsave(plot=p1, 
#        filename="MyPlot",
#        width=5,
#        height=3,
#        units="in",
#        device="pdf")

d <- mpg # use built in mpg data frame
str(d)
table(d$fl)

# basic histogram plot
ggplot(data=d) +
  aes(x=hwy) +
  geom_histogram()

ggplot(data=d) +
  aes(x=hwy) +
  geom_histogram(fill="khaki",color="black")

# # basic density plot
ggplot(data=d) +
  aes(x=hwy) +
  geom_density(fill="mintcream",color="blue")

# basic scatter plot
ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
geom_smooth() + 
  geom_smooth(method="lm",col="red")


# basic boxplot
ggplot(data=d) +
  aes(x=fl, y=cty) +
  geom_boxplot()
# basic boxplot
ggplot(data=d) +
  aes(x=fl, y=cty) +
  geom_boxplot(fill="thistle")

# basic barplot (long format)

ggplot(data=d) +
  aes(x=fl) +
  geom_bar(fill="thistle",color="black")

# bar plot with specified counts or meansw
x_treatment <- c("Control","Low","High")
y_response <- c(12,2.5,22.9)
summary_data <- data.frame(x_treatment,y_response)

ggplot(data=summary_data) +
  aes(x=x_treatment,y=y_response) +
  geom_col(fill=c("grey50","goldenrod","goldenrod"),col="black")

# basic curves and functions
my_vec <- seq(1,100,by=0.1)

# plot simple mathematical functions
d_frame <- data.frame(x=my_vec,y=sin(my_vec))
ggplot(data=d_frame) +
  aes(x=x,y=y) +
  geom_line()


# plot probability functions
d_frame <- data.frame(x=my_vec,y=dgamma(my_vec,shape=5, scale=3))
ggplot(data=d_frame) +
  aes(x=x,y=y) +
  geom_line()

# plot user-defined functions
my_fun <- function(x) sin(x) + 0.1*x
d_frame <- data.frame(x=my_vec,y=my_fun(my_vec))
ggplot(data=d_frame) +
  aes(x=x,y=y) +
  geom_line()

p1 <- ggplot(data=d) +
      (mapping=aes(x=displ,y=cty)) + 
      geom_point()
print(p1)

p1 + theme_classic() # no grid lines
p1 + theme_linedraw() # black frame
p1 + theme_dark() # good for brightly colored points
p1 + theme_base() # mimics base R
p1 + theme_par() # matches current par settings in base
p1 + theme_void() # shows data only
p1 + theme_solarized() # good for web pages
p1 + theme_economist() # many specialized themes
p1 + theme_grey() # ggplots default theme

library(extrafont)
font_import()  # Imports all system fonts (run once)
# loadfonts(device = "win")  # For Windows
fonts()
# Use the font in ggplot
ggplot(mpg, aes(x = fl, y = cty,fill=fl)) +
  geom_boxplot() +
   theme_linedraw(base_size=20,base_family="Noteworthy")
  # theme_linedraw(base_size=25,base_family = "serif")

# built in themes
# theme() xxxx
# theme_grey()
# theme_bw()
# theme_linedraw()
# theme_light()
# theme_dark()
# theme_minimal()
# theme_classic()
# theme_get() xxxx
# theme_replace() xxxx
# theme_set() xxxx
# theme_test() xxxx
# theme_update() xxxx
# theme_void() xxxx

# ggthemes package
# theme_base()
# theme_calc()
# theme_clean()
# theme_economist()
# theme_economist_white()
# theme_excel()
# theme_excel_new()
# theme_few()
# theme_fivethirtyeight()
# theme_foundation()
# theme_gdocs()
# theme_hc()
# theme_igray()
# theme_map()
# theme_pander()
# theme_par()
# theme_solarized()
# theme_solarized_2()
# theme_solid()
# theme_stata()
# theme_tufte()
# theme_wsj()


# hrbrthemes package
# ggthemr package
# ggtech package
# ggdark package

# Most basic violin chart
ggplot(data=d, aes(x=fl, y=cty, fill=fl)) + # fill=name allow to automatically dedicate a color for each group
  geom_violin()
