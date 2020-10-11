# Varios
**01_lecturaPISCO_xy.R** <p>
Lectura datos raster PISCOm (precipitación mensual) desde una coordenada especifica, caso ciudad de Tarma (Peru) <p>
--> leer coordenadas desde 01_long_lat.csv / grabar serie de lluvias en 01_data_long_lat.csv <p>
**02_CDuracion.R** <p>
Grafico de una curva de duracion, indicar la persistencia alta en "lQ.thr="; indicar la persistencia baja en "hQ.thr="; thr (threshold) es el umbral<p>
  --> leer archivo de caudales diarios 1970 (Socsi) desde 02_caudales.csv<p>
**03_ETP_Oudin.R** <p>
Estimación de la evapotranspiración potencial diaria con el método de Oudin <p>
  --> leer las temperaturas medias diarias desde 03_Tm_d.csv / grabar serie ETP obtenida en 03_ETP.csv <p>
**04_lecturaPISCO_region.R** <p>
Lectura datos raster PISCOd (precipitación diaria) desde una región definida en un shapefile de poligono <p>
**05_lectura_shp_arid.R** <p>
Ploteo del shapefile del mapa de aridez del Perú 1x1km presentado en Rau (2019) basado en Trabucco y Zomer (2019) <p> 
  --> leer el shp contenido en 05_aridez_peru.7z categorizado en 1-Hiper arido; 2-Arido; 3-Semi arido; 4-Sub humedo seco; 5-Humedo<p> 
**06_courbe_hypsometrique.R** <p>
[FR] Obtention du relief et courbe hypsometrique, cas de l'oued Isser (Algerie) <p>
Préparer les fichiers "tif" du mosaïque SRTM et le "shapefile" polygone du bassin versant <p>
  --> ajuster la distribution d'altitudes et la localisation de l'echelle dans la figure.
