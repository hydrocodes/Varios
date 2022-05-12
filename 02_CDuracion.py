### Curva de duracion de caudales desde archivo csv
### https://github.com/hydrocodes
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
data = pd.read_csv('02_caudales.csv', usecols=['Fecha','Qd_m3s'])
sort = data.sort_values(['Qd_m3s'], ascending=[False])
y = sort.Qd_m3s
exceedence = np.arange(1.,len(sort)+1) / len(sort)
plt.plot(exceedence*100, y)
plt.xlabel("Excedencia (%)")
plt.ylabel("Descarga (m3/s)")
plt.show()
