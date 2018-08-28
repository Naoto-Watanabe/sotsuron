#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd

df = pd.read_csv('/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/nybond_usdjpy.csv',header=1)
df_a = pd.read_csv('/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/unemploy.csv',header=1)
#　為替と国債のデータが日次データなので平均を計算して、月次データに変換
for i in range(90):
    df = df.drop(i)
df = df.reset_index(drop=True)
# print(df.head())
y = 85
nyave = []
ujave = []
while y <=99:
    for i in range(1,14):
        if i < 13:
            number_padded = '{0:02d}'.format(i)
            df1 = df[df['date'].str.contains('19{}/{}'.format(y,number_padded),na=False)].dropna()
            ave1 = df1['NYbond'].mean()
            ave2 = df1['USDJPY'].mean()
            nyave.append(ave1)
            ujave.append(ave2)

        elif i == 13:
            y += 1
y = 0
while y <=18:
    for i in range(1,14):
        if i < 13:
            y_padded = '{0:02d}'.format(y)
            number_padded = '{0:02d}'.format(i)
            df1 = df[df['date'].str.contains('20{}/{}'.format(y_padded,number_padded),na=False)].dropna()
            ave1 = df1['NYbond'].mean()
            ave2 = df1['USDJPY'].mean()
            nyave.append(ave1)
            ujave.append(ave2)

        elif i == 13:
            y += 1

data_new = [nyave,ujave]
df_ok = pd.DataFrame(data_new)
df_ok = df_ok.T

# 失業率の月次データにくっつける
df_ok.columns = ["NYbond","USDJPY"]
df_comp = pd.concat([df_a,df_ok],axis=1)
print(df_comp.head())
# df_comp.to_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/sotudata.csv")
print(df_comp.loc[4:399,"USDJPY"])
# df_m1 = pd.DataFrame({"y":np.array(df_comp.loc[6:399,"USDJPY"]),
#                       "x":np.array(df_comp.loc[5:398,"USDJPY"])})
# df_m2 = pd.DataFrame({"y":np.array(df_comp.loc[6:399,"USDJPY"]),
#                       "x1":np.array(df_comp.loc[5:398,"USDJPY"]),
#                       "x2":np.array(df_comp.loc[5:398,"NYbond"]),
#                       "x3":np.array(df_comp.loc[5:398,"UnE_rate"])})
# df_m3 = pd.DataFrame({"y":np.array(df_comp.loc[6:399,"USDJPY"]),
#                       "x1":np.array(df_comp.loc[5:398,"USDJPY"]),
#                       "x2":np.array(df_comp.loc[4:397,"USDJPY"]),
#                       "x3":np.array(df_comp.loc[3:396,"USDJPY"])})
# df_m4 = pd.DataFrame({"y":np.array(df_comp.loc[6:399,"USDJPY"]),
#                       "x1":np.array(df_comp.loc[5:398,"USDJPY"]),
#                       "x2":np.array(df_comp.loc[4:397,"USDJPY"]),
#                       "x3":np.array(df_comp.loc[3:396,"USDJPY"]),
#                       "x4":np.array(df_comp.loc[5:398,"NYbond"]),
#                       "x5":np.array(df_comp.loc[4:397,"NYbond"]),
#                       "x6":np.array(df_comp.loc[3:396,"NYbond"]),
#                       "x7":np.array(df_comp.loc[5:398,"UnE_rate"]),
#                       "x8":np.array(df_comp.loc[4:397,"UnE_rate"]),
#                       "x9":np.array(df_comp.loc[3:396,"UnE_rate"]),})
y = pd.Series(np.array(df_comp.loc[6:300,"USDJPY"]))
x = pd.Series(np.array(df_comp.loc[5:299,"USDJPY"]))
date = pd.Series(np.array(df_comp.loc[6:300,"date"]))
yp = pd.Series(np.array(df_comp.loc[301:399,"USDJPY"]))
xp = pd.Series(np.array(df_comp.loc[300:398,"USDJPY"]))
df_mt = pd.DataFrame({"y":y,"x":x,"yp":yp,"xp":xp})
df_date = pd.DataFrame({"date":date})
# df_m1.to_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/m1data.csv")
# df_m2.to_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/m2data.csv")
# df_m3.to_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/m3data.csv")
# df_m4.to_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/m4data.csv")
# df_mt.to_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/mtdata.csv")
# df_date.to_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/datedata.csv")
print(len(date))
