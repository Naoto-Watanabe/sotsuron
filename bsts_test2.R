# ==================================================
# bstsによる、状態空間モデルの推定
# ==================================================
# データの取り込み
setwd("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron")
getwd()
cv <- read.csv("sotudata.csv")
library("bsts", lib.loc="~/Library/R/3.4/library")
p <- c()
for (i in 111) {
  y <- cv$USDJPY[6:i]
  x <- cv$USDJPY[5:(i-1)]
  x1 <- cv$NYbond[5:(i-1)]
  x2 <- cv$UnE_rate[5:(i-1)]
  df <- data.frame(Y=y,X=x,X1=x1,X2=x2)
  df2 <- data.frame(X=cv$USDJPY[i],X1=cv$NYbond[i],X2=cv$UnE_rate[i])
  # ---model1---
  ss <- AddLocalLinearTrend(list(), df$Y)
  #ss <- AddDynamicRegression(ss, formula=y ~ x, data = cvdata)
  model1 <- bsts(formula=Y~X+X1+X2,
                 data = df,
                 state.specification = ss,
                 niter = 1000)
  pred1 <- predict(model1,newdata=df2,horizon=1)
  p <- append(p,pred1$mean)
}