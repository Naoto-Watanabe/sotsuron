# ==================================================
# bstsによる、状態空間モデルの推定と予測
# ==================================================
# データの取り込み
setwd("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron")
getwd()
cv <- read.csv("sotudata.csv")
cv1 <- read.csv("m1pdfs.csv")
cv2 <- read.csv("m2pdfs.csv")
cv3 <- read.csv("m3pdfs.csv")
cv4 <- read.csv("m4pdfs.csv")
library("bsts", lib.loc="~/Library/R/3.4/library")
p <- c()
pdf <- c()
for (i in 195:399) {
  y <- cv$USDJPY[(i-82):i]
  x1 <- cv1$m1pdf[(i-193):(i-111)]
  x2 <- cv2$m2pdf[(i-193):(i-111)]
  x3 <- cv3$m3pdf[(i-193):(i-111)]
  x4 <- cv4$m4pdf[(i-193):(i-111)]
  df <- data.frame(Y=y,X1=x1,X2=x2,X3=x3,X4=x4)
  df2 <- data.frame(X1=cv1$m1pdf[(i-192)],X2=cv2$m2pdf[(i-192)],
                    X3=cv3$m3pdf[(i-192)],X4=cv4$m4pdf[i-192])
  # ---model---
  ss <- AddLocalLinearTrend(list(), df$Y)
  ss <- AddAutoAr(ss, df$Y, lags=1)
  ss <- AddDynamicRegression(ss, formula=Y ~ X1+X2+X3+X4, data = df)
  model <- bsts(formula=df$Y,
                 state.specification = ss,
                 niter = 600)
  pred1 <- predict(model,newdata=df2,horizon=1)
  p <- append(p,pred1$mean)
  pdf <- append(pdf,dnorm(cv$USDJPY[(i+1)],mean=pred1$mean,sd=sd(pred1$distribution)))
}
# 予測値と確率密度のデータフレーム作成
mfdata <- data.frame(mfp=p,mfpdf=pdf)
# csvファイルへ書き出し
#write.csv(mfdata,"/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/mfpdfs.csv",row.names=T,quote=F)