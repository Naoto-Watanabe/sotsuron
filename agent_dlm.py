import numpy as np
import numpy.random as rd

rd.seed(71)

T = 500
v_sd = 20 # 観測誤差の標準偏差
i_sd = 10 # interceptの標準偏差
a10 = 10
e_sd1 = .5 # 回帰係数1の変動の標準偏差
a20 = 20
e_sd2 = .8 # 回帰係数1の変動の標準偏差

# 時変回帰係数２つ
e1 = np.random.normal(0, e_sd1, size=T)
a1 = e1.cumsum() + a10
e2 = np.random.normal(0, e_sd2, size=T)
a2 = e2.cumsum() + a20

# intercept
intercept = np.cumsum(np.random.normal(0, i_sd, size=T))

# 説明変数
x1 = rd.normal(10, 10, size=T)
x2 = rd.normal(10, 10, size=T)

# 被説明変数
v = np.random.normal(0, v_sd, size=T) # 観測誤差
y = intercept + a1*x1 + a2*x2 + v
y_noerror = intercept + a1*x1 + a2*x2  # 観測誤差がなかった時の　y
import os
os.environ['R_HOME'] = 'C:\Program Files\R\R-3.4.1' #path to your R installation
os.environ['R_USER'] = 'C:\ProgramData\Anaconda3\Lib\site-packages\rpy2' #path depends on where you installed Python. Mine is the Anaconda distribution


import rpy2
from rpy2.robjects.packages import importr
import rpy2.robjects as robjects
from rpy2.rinterface import R_VERSION_BUILD
from rpy2.robjects import pandas2ri
pandas2ri.activate()

dlm = importr("dlm")

buildDlmReg = lambda theta: dlm.dlmModReg(
    X=df[["x1", "x2"]], 
    dV=np.exp(theta[0]), 
    dW=[np.exp(theta[1]), np.exp(theta[2]), np.exp(theta[3])]
  )

# 2段階で最尤推定を行う
%time parm = dlm.dlmMLE(y, parm=[2, 1, 1, 1], build=buildDlmReg, method="L-BFGS-B") 
par = np.array(get_method(parm, "par"))
print("par:", par)
%time fitDlmReg = dlm.dlmMLE(y, parm=par, build=buildDlmReg, method="SANN")

show_result(fitDlmReg)