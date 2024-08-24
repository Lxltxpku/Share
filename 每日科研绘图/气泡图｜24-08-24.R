# 清除变量
rm(list = ls())
# Libraries
library(tidyverse) # 加载tidyverse包，提供数据整理和图形制作的工具
library(hrbrthemes) # 加载hrbrthemes包，提供了一些美观的主题
library(viridis) # 加载viridis包，提供了颜色渐变方案
library(gridExtra) # 加载gridExtra包，用于在网格中排列图形
library(ggrepel) # 加载ggrepel包，用于避免点标签重叠
library(plotly) # 加载plotly包，用于创建交互式图形

# The dataset is provided in the gapminder library
library(gapminder) # 加载gapminder包，包含有关不同国家和地区随时间变化的生命期望、GDP和人口的数据
data <- gapminder %>% 
  filter(year=="2007") %>% # 筛选出2007年的数据
  dplyr::select(-year) # 移除年份列

# Show a bubbleplot
data %>%
  mutate(pop=pop/1000000) %>% # 将人口数量转换为百万单位
  arrange(desc(pop)) %>% # 按人口数量降序排列数据
  mutate(country = factor(country, country)) %>% # 将国家名称转换为因子类型，保持原有顺序
  ggplot( aes(x=gdpPercap, y=lifeExp, size = pop, color = continent)) + # 创建ggplot对象，设置x轴为人均GDP，y轴为预期寿命，点的大小代表人口，颜色代表大洲
  geom_point(alpha=0.7) + # 添加点图层，设置透明度为0.7
  scale_size(range = c(1.4, 19), name="Population (M)") + # 设置点的大小范围，并添加大小图例
  scale_color_viridis(discrete=TRUE, guide=FALSE) + # 使用viridis颜色方案，并且不显示颜色图例
  theme_minimal() + # 应用最小化主题
  theme(legend.position="bottom") # 将图例放置在底部

#####
# Prepare data
tmp <- data %>%
  mutate(
    annotation = case_when(
      gdpPercap > 5000 & lifeExp < 60 ~ "yes", # 如果人均GDP大于5000且预期寿命小于60岁，标记为"yes"
      lifeExp < 30 ~ "yes", # 如果预期寿命小于30岁，标记为"yes"
      gdpPercap > 40000 ~ "yes" # 如果人均GDP大于40000，标记为"yes"
    )
  ) %>%
  mutate(pop=pop/1000000) %>% # 将人口数量转换为百万单位
  arrange(desc(pop)) %>% # 按人口数量降序排列数据
  mutate(country = factor(country, country)) # 将国家名称转换为因子类型，保持原有顺序

# Plot
ggplot( tmp, aes(x=gdpPercap, y=lifeExp, size = pop, color = continent)) + # 创建ggplot对象，设置x轴为人均GDP，y轴为预期寿命，点的大小代表人口，颜色代表大洲
  geom_point(alpha=0.7) + # 添加点图层，设置透明度为0.7
  scale_size(range = c(1.4, 19), name="Population (M)") + # 设置点的大小范围，并添加大小图例
  scale_color_viridis(discrete=TRUE) + # 使用viridis颜色方案
  theme_minimal() + # 应用ipsum主题
  theme(legend.position="none") + # 不显示图例
  geom_text_repel(data=tmp %>% filter(annotation=="yes"), aes(label=country), size=4 ) # 对满足条件的国家添加文本标签，使用geom_text_repel避免标签重叠

#####
# Interactive version
p <- data %>%
  mutate(gdpPercap=round(gdpPercap,0)) %>% # 将人均GDP四舍五入到最接近的整数
  mutate(pop=round(pop/1000000,2)) %>% # 将人口数量转换为百万单位并保留两位小数
  mutate(lifeExp=round(lifeExp,1)) %>% # 将预期寿命四舍五入到最接近的十分位
  arrange(desc(pop)) %>% # 按人口数量降序排列数据
  mutate(country = factor(country, country)) %>% # 将国家名称转换为因子类型，保持原有顺序
  mutate(text = paste("Country: ", country, "\nPopulation (M): ", pop, "\nLife Expectancy: ", lifeExp, "\nGdp per capita: ", gdpPercap, sep="")) %>% # 创建一个新变量text，包含国家名称、人口、预期寿命和人均GDP的信息
  ggplot( aes(x=gdpPercap, y=lifeExp, size = pop, color = continent, text=text)) + # 创建ggplot对象，设置x轴为人均GDP，y轴为预期寿命，点的大小代表人口，颜色代表大洲，text变量用于交互式提示
  geom_point(alpha=0.7) + # 添加点图层，设置透明度为0.7
  scale_size(range = c(1.4, 19), name="Population (M)") + # 设置点的大小范围，并添加大小图例
  scale_color_viridis(discrete=TRUE, guide=FALSE) + # 使用viridis颜色方案，并且不显示颜色图例
  theme_minimal() + # 应用最小化主题
  theme(legend.position="none") # 不显示图例

ggplotly(p, tooltip="text") # 将静态图转换为交互式图，并设置鼠标悬停时显示text变量的信息
