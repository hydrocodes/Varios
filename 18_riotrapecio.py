# Calculo del tirante, velocidad y numero de Froude para un rio de seccion trapezoidal
### https://github.com/hydrocodes
import numpy as np
from scipy.optimize import fmin
# ingresar las variables
n = 0.025  #coeficiente de Manning
S = 0.01  #pendiente
Q = 8  #caudal m"/s
b = 10  #ancho de fondo m
z = 2  #talud zH:1V
# ingresar la profundidad de inicio de iteraciones
y0 = 0.1 
# procesamiento
def flow(y):
 Q_est = (1/n)*(S**0.5)*((b+z*y)*y)**(5/3)/(b+2*y*(1+z**2)**0.5)**(2/3)
 epsilon = np.abs(Q_est - Q)
 return epsilon
y_optimum = fmin(flow,y0)
print("Profundidad =",y_optimum,"m")
vel = Q/((b+z*y_optimum)*y_optimum)
print("Velocidad =",vel,"m/s")
Fr = vel/(9.81*((b+z*y_optimum)*y_optimum)/(b+2*z*y_optimum))**0.5
print("Nro de Froude =",Fr)
