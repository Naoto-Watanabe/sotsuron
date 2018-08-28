# ==================================================
# bstsによる、状態空間モデルの推定
# ==================================================
# データの取り込み
setwd("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron")
getwd()
cv <- read.csv("sotudata.csv")
library("bsts", lib.loc="~/Library/R/3.4/library")
p <- c()
for (i in 111:112) {
  y <- cv$USDJPY[7:i]
  x1 <- cv$NYbond[6:(i-1)]
  x2 <- cv$UnE_rate[6:(i-1)]
  x3 <- cv$NYbond[5:(i-2)]
  x4 <- cv$UnE_rate[5:(i-2)]
  x5 <- cv$NYbond[4:(i-3)]
  x6 <- cv$NYbond[4:(i-3)]
  df <- data.frame(Y=y,X1=x1,X2=x2,X3=x3,X4=x4,X5=x5,X6=x6)
  df2 <- data.frame(X1=cv$NYbond[i],X2=cv$UnE_rate[i],X3=cv$NYbond[(i-1)],X4=cv$UnE_rate[(i-1)],X5=cv$NYbond[(i-2)],X6=cv$UnE_rate[(i-2)])
  # ---model1---
  ss <- AddLocalLinearTrend(list(), df$Y)
  ss <- AddAutoAr(ss, df$Y, lags=1)
  ss <- AddDynamicRegression(ss, formula=Y ~ X1+X2+X3+X4+X5+X6, data = df)
  model1 <- bsts(formula=df$Y,
                 state.specification = ss,
                 niter = 1000)
  pred1 <- predict(model1,newdata=df2,horizon=1)
  p <- append(p,pred1$mean)
}