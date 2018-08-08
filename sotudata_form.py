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
        if i < 13 and y <= 99:
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
        if i < 13 and y <= 99:
            number_padded = '{0:02d}'.format(i)
            df1 = df[df['date'].str.contains('20{}/{}'.format(y,number_padded),na=False)].dropna()
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
pd_comp = pd.concat([df_a,df_ok],axis=1)
print(pd_comp.head())
