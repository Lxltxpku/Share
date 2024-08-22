# 清除变量
rm(list = ls())

# Libraries
library(tidyverse)
library(hrbrthemes)
library(plotly)
library(patchwork)
library(babynames)
library(viridis)

# 设置文件路径
file_path <- "/Users/luoxiaoluotongxue/Desktop/硕士课题进展记录/科研绘图/每日科研绘图/24-08/24-08-22/24-08-22.csv"

# 使用read.table()函数读取CSV文件
# 注意：header=TRUE表示第一行是列名，sep=","表示数据分隔符是逗号
data <- read.table(file_path, header = TRUE, sep = ",", fileEncoding = "UTF-8")

data$date <- as.Date(data$date)


# Plot
data %>%
  tail(10) %>%
  ggplot( aes(x=date, y=value)) +
  geom_line(color="#69b3a2") +
  geom_point(color="#69b3a2", size=4) +
  ggtitle("Evolution of Bitcoin price") +
  ylab("bitcoin price ($)") +
  theme_minimal()

# Plot
p1 <- data %>%
  tail(60) %>%
  ggplot( aes(x=date, y=value)) +
  geom_line(color="#69b3a2") +
  ggtitle("Line chart") +
  ylab("bitcoin price ($)") +
  theme_minimal()

p2 <- data %>%
  tail(60) %>%
  ggplot( aes(x=date, y=value)) +
  geom_line(color="#69b3a2") +
  geom_point(color="#69b3a2", size=2) +
  ggtitle("Connected scatterplot") +
  ylab("bitcoin price ($)") +
  theme_minimal()

p1 + p2

# Plot
data %>%
  tail(60) %>%
  ggplot( aes(x=date, y=value)) +
  geom_point(color="#69b3a2", size=2) +
  ggtitle("Line chart") +
  ylab("bitcoin price ($)") +
  theme_minimal()

# 加载babynames包
library(babynames)

# 加载数据集并筛选出名为"Ashley"和"Amanda"的女性名字
data <- babynames %>% 
  filter(name %in% c("Ashley", "Amanda")) %>%
  filter(sex=="F")

# 绘制图表
data %>%
  ggplot( aes(x=year, y=n, group=name, color=name)) + # 设置x轴为年份，y轴为名字出现的次数，按名字分组并着色
  geom_line() + # 添加线条
  scale_color_viridis(discrete = TRUE, name="") + # 使用viridis颜色方案，并且不显示颜色条的名称
  theme(legend.position="none") + # 不显示图例
  ggtitle("Popularity of American names in the previous 30 years") + # 设置图表标题
  theme_minimal() # 使用最小化主题

