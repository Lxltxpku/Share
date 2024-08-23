# Libraries
library(tidyverse) # 加载tidyverse包，提供数据整理和图形绘制功能
library(hrbrthemes) # 加载hrbrthemes包，提供一些美观的主题
library(plotly) # 加载plotly包，用于创建交互式图形
library(patchwork) # 加载patchwork包，用于组合多个图形
library(babynames) # 加载babynames包，用于处理婴儿名字数据
library(viridisLite)
library(viridis) # 加载viridis包，提供一组连续的颜色调色板


# Load dataset from github
#data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered.csv", header=T) # 从GitHub加载数据集# 设置文件路径

#读取文件并保存
write.csv(data,file = "/Users/luoxiaoluotongxue/Desktop/硕士课题进展记录/科研绘图/每日科研绘图/24-08/每日科研绘图/区域图｜24-08-23/24-08-23.csv",row.names = FALSE)

file_path <- "/Users/luoxiaoluotongxue/Desktop/硕士课题进展记录/科研绘图/每日科研绘图/24-08/每日科研绘图/区域图｜24-08-23/24-08-23.csv"

# 使用read.table()函数读取CSV文件
# 注意：header=TRUE表示第一行是列名，sep=","表示数据分隔符是逗号
data <- read.table(file_path, header = TRUE, sep = ",", fileEncoding = "UTF-8")
data$date <- as.Date(data$date) # 将数据集中的date列转换为日期格式

# plot
data %>%
  ggplot( aes(x=date, y=value)) + # 使用ggplot2创建图形，设置x轴为日期，y轴为数值
  geom_area(fill="#69b3a2", alpha=0.5) + # 添加面积图层，填充颜色为#69b3a2，透明度为0.5
  geom_line(color="#69b3a2") + # 添加折线图层，颜色为#69b3a2
  ggtitle("Evolution of Bitcoin price") + # 设置图形标题为"比特币价格演变"
  ylab("bitcoin price ($)") + # 设置y轴标签为"比特币价格（美元）"
  theme_minimal() # 使用最小化主题

######
# Load dataset from github
don <- babynames %>% # 从babynames包中加载数据集
  filter(name %in% c("Ashley", "Amanda", "Mary", "Deborah", "Dorothy", "Betty", "Helen", "Jennifer", "Shirley")) %>% # 筛选出指定的名字
  filter(sex=="F") # 筛选出女性名字

# Plot
don %>%
  ggplot( aes(x=year, y=n, group=name, fill=name)) + # 使用ggplot2创建图形，设置x轴为年份，y轴为名字出现的次数，按名字分组并填充颜色
  geom_area() + # 添加面积图层
  scale_fill_viridis(discrete = TRUE) + # 设置填充颜色为viridis调色板的离散颜色
  theme(legend.position="none") + # 移除图例
  ggtitle("Popularity of American names in the previous 30 years") + # 设置图形标题为"过去30年美国名字的流行度"
  theme_minimal() + # 使用最小化主题
  theme(
    legend.position="none", # 移除图例
    panel.spacing = unit(0, "lines"), # 设置面板间距为0
    strip.text.x = element_text(size = 8), # 设置分面标题字体大小为8
    plot.title = element_text(size=13) # 设置图形标题字体大小为13
  ) +
  facet_wrap(~name, scale="free_y") # 按名字分面，并允许每个分面的y轴范围自由调整

###

data %>%
  tail(10) %>% # 从数据集中取出最后10行数据
  ggplot( aes(x=date, y=value)) + # 使用ggplot2创建图形，设置x轴为日期，y轴为数值
  geom_line(color="#69b3a2") + # 添加折线图层，颜色为#69b3a2
  geom_point(color="#69b3a2", size=4) + # 添加点图层，颜色为#69b3a2，大小为4
  ggtitle("Cuting") + # 设置图形标题为"Cuting"
  ylab("bitcoin price ($)") + # 设置y轴标签为"比特币价格（美元）"
  theme_minimal() # 使用最小化主题

####
ggplot(mpg, aes(displ, hwy)) + # 使用ggplot2创建图形，数据集为mpg，x轴为displ（发动机排量），y轴为hwy（高速公路上的燃油效率）
  geom_point() + # 添加散点图层，显示每个数据点的位置
  geom_smooth(color="#69b3a2") + # 添加平滑曲线图层，颜色为#69b3a2，用于展示数据的趋势
  theme_minimal() # 应用minimal主题，使图形具有更美观的外观
