import pyper
import pandas as pd

r = pyper.R(use_pandas='True')
r("""
setwd("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron")
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
ss2 <- AddAutoAr(ss, y = y, lags=3)
model1 <- bsts(formula=y,
               state.specification = ss2,
               niter = 1000)
model2 <- bsts(formula=y,
               state.specification = ss,
               niter = 1000)
plot(model1, "comp")
plot(model1, "resid")

# forecasting
pred1 <- predict(model1,newdata=xp, horizon = 1)
pred2 <- predict(model2,horizon=1)
p <- pred1$mean
""")

