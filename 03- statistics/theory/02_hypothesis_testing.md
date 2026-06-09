# Tests de hipótesis

## ¿Qué es?
Una herramienta estadística para determinar si la diferencia entre dos grupos 
es real o producto de la aleatoriedad.

## ¿Para qué sirve en DS?
- A/B testing: ¿el nuevo diseño realmente aumentó conversiones?
- Validar features: ¿esta variable realmente aporta al modelo?
- Comparar modelos: ¿el modelo A es realmente mejor que el B?
- Comparar grupos: ¿los vendedores del norte realmente venden más que los del sur?

## Hipótesis
- **H0 (hipótesis nula)**: no hay diferencia real — cualquier variación es aleatoria
- **H1 (hipótesis alternativa)**: sí existe una diferencia real entre los grupos

## p-value
Es la probabilidad de que la diferencia observada sea pura casualidad.
- p-value = 0.05 → 5% de probabilidad de que sea casualidad
- p-value = 0.001 → 0.1% de probabilidad de que sea casualidad
- p-value = 0.80 → 80% de probabilidad de que sea casualidad

## Regla de decisión
- p-value < 0.05: rechazas H0 — la diferencia es real
- p-value >= 0.05: no puedes rechazar H0 — la diferencia podría ser casualidad

## Ejemplo real
Comparar dos campañas de marketing:
- Campaña A: media de 126.5
- Campaña B: media de 150.5
- p-value: 0.0000046 → diferencia real, la campaña B funciona mejor

## Cuándo usarlo
Cuando quieres saber si la diferencia entre dos grupos es estadísticamente 
significativa y no producto del azar. El umbral estándar en la industria es 0.05.

## En Python
```python
from scipy import stats

t_stat, p_value = stats.ttest_ind(grupo_a, grupo_b)

if p_value < 0.05:
    print("Diferencia real")
else:
    print("Podría ser casualidad")
```