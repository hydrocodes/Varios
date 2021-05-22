# Calculo del tirante, velocidad y numero de Froude para un rio de seccion trapezoidal
### https://github.com/hydrocodes
import numpy as np
from scipy.optimize import fmin
# definiendo las variables
Q = 8 # caudal m3/s
n = 0.025 # coeficiente de Manning
S = 0.01 # pendiente
b = 10 # ancho de fondo m
z = 2 # talud zH:1V
# definiendo la funcion del caudal
def flow(y):
 Q_est = (1/n)*(S**0.5)*((b+z*y)*y)**(5/3)/(b+2*y*(1+z**2)**0.5)**(2/3)
 epsilon = np.abs(Q_est - Q)
 return epsilon
y_optimum = fmin(flow,0.2)
print("tirante =",y_optimum,"m")
vel = Q/((b+z*y_optimum)*y_optimum)
print("velocidad =",vel,"m/s")
Fr = vel/(9.81*((b+z*y_optimum)*y_optimum)/(b+2*z*y_optimum))**0.5
print("Nro de Froude =",Fr)
