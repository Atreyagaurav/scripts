import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from datetime import datetime
filename = './data/battery.log'
df =pd.read_csv(filename,header=None,sep=' ')
df.plot(x=0,y=1)
plt.show()

df['date'] = df[0]
df.date=df.date.map(lambda x: datetime.utcfromtimestamp(x).strftime('%Y-%m-%d %H:%M:%S'))
df
