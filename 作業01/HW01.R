

# 時間紀錄 --------------------------------------------------------------------
Sys.time()
# [1] "2019-03-20 14:23:31 CST"



# 路徑設定 --------------------------------------------------------------------
setwd("D:/健保資料庫訓練/")
getwd()


# 套件載入 --------------------------------------------------------------------
library(dplyr)
library(data.table)
library(xlsx)
library(plotly)
library(ggplot2)


# 讀取資料 --------------------------------------------------------------------
tt <- paste0("UID", 2002:2013)

# 這種讀取方式也行
# 所以sheetname和sheetIndex功用差不多
# tmp01 <- read.xlsx(file = "作業01/作業01_ID_2005百萬抽樣檔_正規化.xlsx", sheetIndex = 1)

data <- list()
for (i in 1:length(tt)) {
   tmp01 <- read.xlsx(file = "作業01/作業01_ID_2005百萬抽樣檔_正規化.xlsx", 
                    sheetName = tt[i])
   colnames(tmp01) <- c("AGE", "SEX", "COUNT")
   data[[i]] <- tmp01
}





# 畫圖 ----------------------------------------------------------------------
pick <- 2002

# plotly
tmp01 <- data[[pick-2001]]
p1 <- plot_ly(tmp01, x = ~AGE, y = ~COUNT, color = ~SEX, 
              type = 'scatter', mode = 'markers+lines')
p1



# ggplot
tmp01 <- data[[pick-2001]]
p2 <- ggplot(tmp01, aes(x=AGE, y=COUNT, group=SEX))+ #group=SEX 可以省略
  geom_line(aes(colour=SEX))+
  geom_point(aes(colour=SEX))+
  labs(title=paste0(pick, " Age v.s. count in sex_group"))
p2





# 迴圈輸出結果 ------------------------------------------------------------------
for (pick in 2002:2013) {
  # 顯示進度
  print(pick-2001)
  
  # 要放置畫布、圖片的路徑設定
  png(width = 856, height = 796, 
      filename = paste0("作業01/pic/", pick, "_AgeCount_inSexGroup.png"))
  
  tmp01 <- data[[pick-2001]]
  p2 <- ggplot(tmp01, aes(x=AGE, y=COUNT, group=SEX))+ #group=SEX 可以省略
    geom_line(aes(colour=SEX), size = 1.5)+
    geom_point(aes(colour=SEX), size = 4)+
    labs(title=paste0(pick, " Age v.s. count in sex_group"))+
    theme(axis.text = element_text(size = 25), 
          axis.title = element_text(size = 25),
          plot.title = element_text(size = 30, face = "bold"),
          legend.text = element_text(size = 20),
          legend.title = element_text(size = 25))
  
  print(p2)
  dev.off()
}



