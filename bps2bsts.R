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
x1cos <- c()
x2cos <- c()
x3cos <- c()
x4cos <- c()
for (i in 195:399) {
  y <- cv$USDJPY[113:i]
  x1 <- cv1$m1pdf[2:(i-111)]
  x2 <- cv2$m2pdf[2:(i-111)]
  x3 <- cv3$m3pdf[2:(i-111)]
  x4 <- cv4$m4pdf[2:(i-111)]
  df <- data.frame(Y=y,X1=x1,X2=x2,X3=x3,X4=x4)
  df2 <- data.frame(X1=cv1$m1pdf[(i-192)],X2=cv2$m2pdf[(i-192)],
                    X3=cv3$m3pdf[(i-192)],X4=cv4$m4pdf[i-192])
  # ---model---
  ss <- AddLocalLinearTrend(list(), df$Y)
  ss <- AddAutoAr(ss, df$Y, lags=1)
  ss <- AddDynamicRegression(ss, formula=Y ~ X1+X2+X3+X4, data = df)
  model <- bsts(formula=df$Y,
                state.specification = ss,
                niter = 500)
  pred1 <- predict(model,newdata=df2,horizon=1)
  co <- model$dynamic.regression.coefficients
  x1co <- 0
  x2co <- 0
  x3co <- 0
  x4co <- 0
  for (l in 1:500) {
    x1co <- x1co+as.numeric(co[l,1,(i-112)])
    x2co <- x2co+as.numeric(co[l,2,(i-112)])
    x3co <- x3co+as.numeric(co[l,3,(i-112)])
    x4co <- x4co+as.numeric(co[l,4,(i-112)])
  }
  x1co <- x1co/500
  x2co <- x2co/500
  x3co <- x3co/500
  x4co <- x4co/500
  x1cos <- append(x1cos,x1co)
  x2cos <- append(x2cos,x2co)
  x3cos <- append(x3cos,x3co)
  x4cos <- append(x4cos,x4co)
  p <- append(p,pred1$mean)
  pdf <- append(pdf,dnorm(cv$USDJPY[(i+1)],mean=pred1$mean,sd=sd(pred1$distribution)))
}
# 予測値と確率密度のデータフレーム作成
mfdata <- data.frame(mfp=p,mfpdf=pdf)
coefdata <- data.frame(x1cos=x1cos,x2cos=x2cos,x3cos=x3cos,x4cos=x4cos)
# csvファイルへ書き出し
#write.csv(mfdata,"/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/mf2pdfs.csv",row.names=T,quote=F)
write.csv(coefdata,"/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/coefdata.csv",row.names=T,quote=F)
