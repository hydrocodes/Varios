### Indices mensuales y estacionales desde un archivo xlsx
### https://github.com/hydrocodes
from google.colab import files # solo para gcolab
import pandas as pd
import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt
# Lectura con gcolab del archivo xlsx y la hoja "indice" 
import io
uploaded = files.upload()
c = ["Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic"]
data = pd.read_excel(io.BytesIO(uploaded['24_datos.xlsx']),usecols=c,sheet_name='indice')
fecha = pd.read_excel(io.BytesIO(uploaded['24_datos.xlsx']),usecols=["Año"])

# Lectura simple del archivo xlsx y la hoja "indice"
data = pd.read_excel('.../24_datos.xlsx',sheet_name='indice', usecols=range(1,13))
fecha = pd.read_excel('.../24_datos.xlsx',sheet_name='indice', usecols=0)

start = str(fecha.iat[0,0])
end = str(fecha.iat[0,0]+len(fecha.index))
x = np.arange(np.datetime64(start), np.datetime64(end),np.timedelta64(1, 'M'),  dtype='datetime64[M]')     
# Transformacion dataframe a vector y plot mensual
p1 = data.to_numpy()
index1 = np.reshape(p1, -1)
plt.plot(x,index1, color = 'b')
plt.ylabel("Indice climatico mensual")
plt.show()
