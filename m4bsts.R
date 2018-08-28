# ==================================================
# bstsによる、状態空間モデルの推定
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
  df <- data.frame(Y=y,X1=x1,X2=x2)
  df2 <- data.frame(X1=cv$NYbond[i],X2=cv$UnE_rate[i])
  # ---model4---
  ss <- AddLocalLinearTrend(list(), df$Y)
  ss <- AddAutoAr(ss, df$Y, lags=3)
  ss <- AddDynamicRegression(ss, formula=Y ~ X1+X2, data = df)
  ss <- AddAutoAr(ss, df$X1, lags = 2)
  ss <- AddAutoAr(ss, df$X2, lags = 2)
  model4 <- bsts(formula=df$Y,
                 state.specification = ss,
                 niter = 500)
  pred1 <- predict(model4,newdata=df2,horizon=1)
  p <- append(p,pred1$mean)
  pdf <- append(pdf,dnorm(cv$USDJPY[(i+1)],mean=pred1$mean,sd=sd(pred1$distribution)))
}
# 予測値と確率密度のデータフレーム作成
m4data <- data.frame(m4p=p,m4pdf=pdf)
# csvファイルへ書き出し
write.csv(m4data,"/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/m4pdfs2.csv",row.names=T,quote=F)