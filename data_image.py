import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt

df = pd.read_csv("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/sotudata.csv")
df = df.set_index("date")
del df["Unnamed: 0"]
print(df.head())
df["UnE_rate"].plot()
plt.show()
df["NYbond"].plot()
plt.show()
df["USDJPY"].plot()
plt.show()
