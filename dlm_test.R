# 解析の準備


# ==================================================
# dlmパッケージによる、状態空間モデルの推定
# ==================================================

# パッケージの読み込み
library("dlm", lib.loc="~/Library/R/3.4/library")

# モデルの推定

#　Step1 モデルの型を決める
buildDlmReg <- function(theta){
  dlmModReg(
    X=explanatory , 
    dV=exp(theta[1]), 
    dW=c(exp(theta[2]), exp(theta[3]))
  )
}

#　Step2　パラメタ推定
fitDlmReg <- dlmMLE(
  response, 
  parm=c(2, 1, 1), 
  buildDlmReg,
  method = "SANN"
)

print(fitDlmReg)
print(sqrt(exp(fitDlmReg$par)))


