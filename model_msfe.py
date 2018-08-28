import pandas as pd
import numpy as np
from sklearn.metrics import mean_squared_error as mse
# culcurate MSFE
# for i in range(5):
#     m2 = m2 + (real - pred)**2
# msfe = m2/n
dfy = pd.read_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/sotudata.csv")
# model1
dfm1 = pd.read_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/m1pdfs2.csv")
dfm2 = pd.read_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/m2pdfs2.csv")
dfm3 = pd.read_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/m3pdfs2.csv")
dfm4 = pd.read_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/m4pdfs2.csv")
dfmf = pd.read_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/mf14pdfs.csv")
dfmvar = pd.read_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/mvarp.csv")
msfesm1 = []
msfesm2 = []
msfesm3 = []
msfesm4 = []
msfesmf = []
msfesmvar = []
msfesrd = []
for i in range(84,288):
    msfem1 = mse(list(dfy.loc[195:(i+111),"USDJPY"]),list(dfm1.loc[84:i,"m1p"]))
    msfesm1.append(msfem1)
    msfem2 = mse(list(dfy.loc[195:(i+111),"USDJPY"]),list(dfm2.loc[84:i,"m2p"]))
    msfesm2.append(msfem2)
    msfem3 = mse(list(dfy.loc[195:(i+111),"USDJPY"]),list(dfm3.loc[84:i,"m3p"]))
    msfesm3.append(msfem3)
    msfem4 = mse(list(dfy.loc[195:(i+111),"USDJPY"]),list(dfm4.loc[84:i,"m4p"]))
    msfesm4.append(msfem4)
    msfemvar = mse(list(dfy.loc[195:(i+111),"USDJPY"]),list(dfmvar.loc[84:i,"mvarp"]))
    msfesmvar.append(msfemvar)
    msferd = mse(list(dfy.loc[195:(i+111),"USDJPY"]),list(dfy.loc[194:(i+110),"USDJPY"]))
    msfesrd.append(msferd)
for i in range(204):
    msfemf = mse(list(dfy.loc[195:(i+195),"USDJPY"]),list(dfmf.loc[0:i,"mfp"]))
    msfesmf.append(msfemf)
# print(list(dfy.loc[195:196,"USDJPY"]))
# print(msfesm3)
