### Indices mensuales y estacionales desde un archivo xlsx
### https://github.com/hydrocodes
from google.colab import files #lectura desde gcolab
import pandas as pd
import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt
uploaded = files.upload()
import io
# Definicion de las cabeceras de meses del archivo xlsx
c = ["Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic"]
# Lectura del archivo xlsx y la hoja "indice"
data = pd.read_excel(io.BytesIO(uploaded['datos.xlsx']),usecols=c,sheet_name='indice')
fecha = pd.read_excel(io.BytesIO(uploaded['datos.xlsx']),usecols=["Año"])
start = str(fecha.iat[0,0])
end = str(fecha.iat[0,0]+len(fecha.index))
x = np.arange(np.datetime64(start), np.datetime64(end),np.timedelta64(1, 'M'),  dtype='datetime64[M]')     
# Transformacion dataframe a vector y plot mensual
p1 = data.to_numpy()
index1 = np.reshape(p1, -1)
plt.plot(x,index1, color = 'b')
plt.ylabel("Indice climatico mensual")
plt.show()
