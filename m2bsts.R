# ==================================================
# bstsによる、状態空間モデルの推定と予測
# ==================================================
# データの取り込み
setwd("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron")
getwd()
cv <- read.csv("sotudata.csv")
library("bsts", lib.loc="~/Library/R/3.4/library")
p <- c()
pdf <- c()
for (i in 111:399) {
  y <- cv$USDJPY[(i-105):i]
  x1 <- cv$NYbond[(i-106):(i-1)]
  x2 <- cv$UnE_rate[(i-106):(i-1)]
  df <- data.frame(Y=y)
  df2 <- data.frame(X1=cv$NYbond[i],X2=cv$UnE_rate[i])
  # ---model2---
  ss <- AddLocalLinearTrend(list(), df$Y)
  ss <- AddAutoAr(ss, df$Y, lags=3)
  model2 <- bsts(formula=df$Y,
                 state.specification = ss,
                 niter = 1000)
  pred1 <- predict(model2,horizon=1)
  p <- append(p,pred1$mean)
  pdf <- append(pdf,dnorm(cv$USDJPY[(i+1)],mean=pred1$mean,sd=sd(pred1$distribution)))
}
# 予測値と確率密度のデータフレーム作成
m2data <- data.frame(m2p=p,m2pdf=pdf)
# csvファイルへ書き出し
write.csv(m2data,"/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/m2pdfs2.csv",row.names=T,quote=F)