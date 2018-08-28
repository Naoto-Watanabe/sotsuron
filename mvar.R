# ==================================================
# varsによる、varモデルの推定
# ==================================================
# データの取り込み
setwd("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron")
getwd()
cv <- read.csv("sotudata.csv")
library("vars", lib.loc="~/Library/R/3.4/library")
p <- c()
pdf <- c()
for (i in 111:399) {
  y <- cv$USDJPY[(i-105):i]
  x1 <- cv$NYbond[(i-106):(i-1)]
  x2 <- cv$UnE_rate[(i-106):(i-1)]
  df <- data.frame(Y=y,X1=x1,X2=x2)
  df.var<-VAR(df,p=VARselect(df,lag.max=4)$selection[1])
  df.pred<-predict(df.var,n.ahead=1,ci=0.95)
  p <- append(p,df.pred$fcst$Y[1,1])
}
# 予測値と確率密度のデータフレーム作成
mvardata <- data.frame(mvarp=p)
# csvファイルへ書き出し
write.csv(mvardata,"/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/mvarp.csv", sep=""),row.names=T,quote=F)

