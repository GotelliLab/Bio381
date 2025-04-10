# ggplot graphics 1
# NJG
# 27 March 2025
#
library(ggplot2)
library(ggthemes)
library(patchwork)
library(extrafont)
font_import()  # Imports all system fonts (run once)
# loadfonts(device = "win")  # For Windows
fonts()
# Use the font in ggplot
ggplot(data=d) +
  aes(x = fl, y = cty,fill=fl)) +
  geom_boxplot() +
   theme_classic(base_size=30, base_family="Geneva")

ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  labs(x="Fuel efficiency (mpg)", y="Weight (tons)",
       title="Seminal ggplot2 scatterplot example",
       subtitle="A plot that is only useful for demonstration purposes",
       caption="Brought to you by the letter 'g'") +
  theme_linedraw(base_size=20)


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
# only ipsum and modern themes working
# ggthemr package
# ggtech package
# ggdark package

# Most basic violin chart
ggplot(data=d, aes(x=fl, y=cty, fill=fl)) + # fill=name allow to automatically dedicate a color for each group
  geom_violin()
