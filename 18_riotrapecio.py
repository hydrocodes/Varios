### Formula de Manning y optimizacion del tirante en un rio de seccion trapezoidal
### https://github.com/hydrocodes
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import fmin
# ingresar las variables
Q = 8  #caudal m"/s
n = 0.025  #coeficiente de Manning
S = 0.01  #pendiente
b = 10  #ancho de fondo m
z1 = 2  #talud margen 1 zH:1V
z2 = 0.5  #talud margen 2 zH:1V
h = 1  #profundidad m
# ingresar el tirante de inicio de iteraciones
y0 = 0.1 
# procesamiento
def flow(y):
 Q_est = (1/n)*(S**0.5)*((b+(z1+z2)*y/2)*y)**(5/3)/(b+y*(1+z1**2)**0.5+y*(1+z2**2)**0.5)**(2/3)
 epsilon = np.abs(Q_est - Q)
 return epsilon
y_opt = fmin(flow,y0)
print("Tirante =",y_opt,"m")
vel = Q/((b+(z1+z2)*y_opt/2)*y_opt)
print("Velocidad =",vel,"m/s")
Fr = vel/(9.81*(b+(z1+z2)*y_opt/2)*y_opt/(b+z1*y_opt+z2*y_opt))**0.5
print("Nro de Froude =",Fr)
if h>=y_opt:
  plt.plot([0,h*z1,h*z1+b,h*z1+h*z2+b], [h,0,0,h], 'k')
  plt.plot([(h-y_opt)*z1,(h*z1+b+y_opt*z2)], [y_opt,y_opt], 'b')
  plt.show()
else:
  print("Seccion insuficiente! Tirante > h")
