# Estadística descriptiva

## Medidas de tendencia central
- **Media**: promedio (suma de todos los valores dividida entre la cantidad). 
  Sensible a outliers — un valor extremo la afecta mucho.
  *Útil para: reportar promedios de ventas, temperaturas, métricas de modelos.*

- **Mediana**: valor del medio después de ordenar los datos. 
  Robusta ante outliers — un valor extremo no la afecta.
  *Útil para: salarios, precios de casas, ingresos — donde hay valores extremos.*

- **Moda**: valor que más se repite.
  *Útil para: datos categóricos — producto más vendido, ciudad más frecuente.*

## Medidas de dispersión
- **Desviación estándar**: qué tan dispersos están los datos alrededor de la media.
  Alta = datos muy dispersos. Baja = datos concentrados cerca de la media.
  *Útil para: entender variabilidad, detectar outliers, normalizar datos para ML.*

- **Varianza**: desviación estándar al cuadrado. Se usa más en cálculos 
  internos de algoritmos que para interpretar directamente.

- **Rango**: distancia entre valor máximo y mínimo. 
  Muy sensible a outliers.
  *Útil para: primera vista rápida de la amplitud de los datos.*

- **IQR (Rango Intercuartílico)**: percentil 75 - percentil 25. 
  Es el rango donde vive el 50% central de los datos.
  Robusto ante outliers porque ignora el 25% más bajo y el 25% más alto.
  *Útil para: detectar outliers, comparar dispersión sin que afecten extremos.*

## Percentiles
Indican qué porcentaje de los datos cae por debajo de ese valor.
- Percentil 25: el 25% de los datos están por debajo de este valor
- Percentil 50: es la mediana
- Percentil 75: el 75% de los datos están por debajo de este valor
*Útil para: entender la distribución, definir rangos, detectar outliers.*

## Outliers
Valores que se alejan mucho del resto — pueden ser errores de medición,
casos excepcionales o datos corruptos.
Fórmula estándar para detectarlos:
- Outlier bajo: valor < P25 - 1.5 × IQR
- Outlier alto: valor > P75 + 1.5 × IQR
*Útil para: limpieza de datos antes de entrenar modelos de ML — 
un outlier puede arruinar un modelo.*

## Correlación
Mide qué tan relacionadas están dos variables. Va de -1 a 1:
- **1**: correlación positiva perfecta — cuando una sube, la otra sube igual
- **0**: sin relación
- **-1**: correlación negativa perfecta — cuando una sube, la otra baja
Importante: correlación no implica causalidad.
*Útil para: seleccionar variables para modelos de ML, detectar variables 
redundantes, entender relaciones entre datos.*

## Distribuciones
- **Normal**: simétrica, forma de campana, media ≈ mediana. 
  Muchos algoritmos de ML asumen que los datos son normales.
  
- **Sesgada positiva**: mayoría de datos a la izquierda, cola hacia la derecha.
  Media > mediana. Ejemplo: salarios, precios de casas.
  Requiere transformación antes de usar en ML.
  
- **Uniforme**: todos los valores tienen la misma probabilidad de aparecer.
  Ejemplo: números aleatorios, dados.

## Regla 68-95-99.7
En una distribución normal:
- 68% de los datos caen dentro de 1 desviación estándar de la media
- 95% dentro de 2 desviaciones estándar
- 99.7% dentro de 3 desviaciones estándar
*Útil para: detectar outliers — un valor a más de 3 std es muy raro 
y probablemente es un error o caso excepcional.*



# Mis palabras (antes)

# Estadística descriptiva

## Medidas de tendencia central
- **Media**: es el promdio (suma de todos los valores y luego divididos entre la cantidad de valores)
- **Mediana**: valor de enmedio despues de ordenar los valores
- **Moda**: valor que se repite mas veces

## Medidas de dispersión
- **Desviación estándar**: rango en el que se mueven en promedio los valores
- **Varianza**: de esta no estoy seguro, pero creo que es la std al cuadrado
- **Rango**: distancia entre valor maximo y minimo
- **IQR**: tampoco me quedo claro, pero se que resta entre p75 y p25, es donde caen el 50% de valores, algo asi

## Percentiles
Es donde debajo de ese valor cae x porcentaje de los valores

## Outliers
Datos raros, podrian ser errores

## Correlación
Dependencia que tienen unos datos hacia a otros

## Distribuciones
- **Normal**: sin sesgo o casi cero, forma de campana, buena para ml
- **Sesgada positiva**: la mayoria de datos a la izquierda y con mayor frenciuencia, cola hacia la derecha
- **Uniforme**: datos repartidos de manera bastante equitativa

## Regla 68-95-99.7
De esta me acordaba masomenos, revise el codigo y si masomenos, es donde estan los valores entre una std es el 68%, entre 2std 95, y entre 3std 99.7