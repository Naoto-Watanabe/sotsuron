# ==================================================
# bstsによる、状態空間モデルの推定
# ==================================================
# データの取り込み
setwd("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron")
getwd()
cvdata <- read.csv("mtdata.csv")
dated <- read.csv("datedata.csv")
x <- cvdata$x
y <- cvdata$y
xp <- cvdata$xp
yp <- cvdata$yp
date <- dated$date
# パッケージの読み込み
library("bsts", lib.loc="~/Library/R/3.4/library")

# モデルの推定
# --- model 1 ----
ss <- AddLocalLinearTrend(list(), y)
ss1 <- AddDynamicRegression(ss, formula=y ~ x, data = cvdata)
model1 <- bsts(formula=y,timestamps=date,
               state.specification = ss,
               niter = 1000)
plot(model1, "comp")
plot(model1, "resid")

# forecasting
pred1 <- predict(model1,newdata=xp, horizon = 99)
plot(pred1, ylim=c(0,250))
lines(c(y,yp),col=2)
