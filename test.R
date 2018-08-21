# ==================================================
# bstsによる、状態空間モデルの推定
# ==================================================
# データの取り込み
setwd("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron")
getwd()
cvdata <- read.csv("m1data.csv")
x <- cvdata$x
y <- cvdata$y

# パッケージの読み込み
library("bsts", lib.loc="~/Library/R/3.4/library")


# --- model 1 ----
ss <- AddLocalLinearTrend(list(), y)
model1 <- bsts(y,
               state.specification = ss,
               niter = 1000)
plot(model1, "comp")
plot(model1, "resid")

# forecasting
pred1 <- predict(model1, horizon = 12)
plot(pred1, plot.original = 156)