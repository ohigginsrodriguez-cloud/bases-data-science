import pandas as pd
import numpy as np
import joblib
import os
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv(override=True)

engine = create_engine(
    f"postgresql://{os.getenv('INTELISTOCK_DB_USER')}:{os.getenv('INTELISTOCK_DB_PASSWORD')}@{os.getenv('INTELISTOCK_DB_HOST')}:{os.getenv('INTELISTOCK_DB_PORT')}/{os.getenv('INTELISTOCK_DB_NAME')}"
)


def cargar_datos_producto(producto_nombre, negocio_id=1):
    """
    Carga y prepara datos de ventas de un producto desde PostgreSQL
    """
    df = pd.read_sql(
        """
        SELECT v.fecha, vd.cantidad
        FROM VENTAS v
        JOIN venta_detalle vd ON vd.venta_id = v.id
        JOIN productos p ON p.id = vd.producto_id
        WHERE p.nombre = %(nombre)s AND v.negocio_id = %(negocio_id)s
        ORDER BY v.fecha
        """,
        engine,
        params={"nombre": producto_nombre, "negocio_id": negocio_id},
    )

    df["fecha"] = pd.to_datetime(df["fecha"])
    df["dia_numero"] = (df["fecha"] - df["fecha"].min()).dt.days
    df["dia_semana"] = df["fecha"].dt.weekday
    df["es_fin_semana"] = (df["dia_semana"] >= 5).astype(int)
    df["mes"] = df["fecha"].dt.month

    return df


def entrenar_modelo(df):
    """Entrena un Random Forest con los datos del producto"""
    X = df[["dia_numero", "dia_semana", "es_fin_semana", "mes"]]
    y = df["cantidad"]

    modelo = RandomForestRegressor(n_estimators=100, random_state=42)
    modelo.fit(X, y)

    # Evaluar con los mismos datos (referencia interna)
    mae = mean_absolute_error(y, modelo.predict(X))

    return modelo, mae


def predecir_proximos_dias(modelo, df, dias=7):
    """Predice la demanda de los proximos N dias"""
    ultimo_dia = df["dia_numero"].max()
    ultima_fecha = df["fecha"].max()

    fechas_futuras = pd.date_range(
        start=ultima_fecha + pd.Timedelta(days=1), periods=dias, freq="D"
    )

    datos_futuros = pd.DataFrame(
        {
            "dia_numero": range(ultimo_dia + 1, ultimo_dia + dias + 1),
            "dia_semana": fechas_futuras.weekday,
            "es_fin_semana": (fechas_futuras.weekday >= 5).astype(int),
            "mes": fechas_futuras.month,
        }
    )

    predicciones = modelo.predict(datos_futuros)

    resultado = pd.DataFrame(
        {"fecha": fechas_futuras, "cantidad_predicha": predicciones.round().astype(int)}
    )

    return resultado


def pipeline_completo(producto_nombre, negocio_id=1, dias=7):
    """
    Pipeline completo: carga datos, entrena modelo,
    predice y guarda el modelo entrenado.

    Returns:
    dict con predicciones y metricas
    """

    # 1. Cargar datos
    df = cargar_datos_producto(producto_nombre, negocio_id)

    if len(df) < 30:
        return {"error": "Datos insuficientes, Minimo 30 dias requeridos."}

    # 2. Entrenar
    modelo, mae = entrenar_modelo(df)

    # 3. Predecir
    prediccion = predecir_proximos_dias(modelo, df, dias)

    # 4. Guardar modelo
    nombre_archivo = f"modelo_{producto_nombre.replace(' ', '_').replace('/', '_')}.pkl"
    joblib.dump(modelo, nombre_archivo)

    return {
        "producto": producto_nombre,
        "mae": round(mae, 2),
        "dias_de_historial": len(df),
        "predicciones": prediccion.to_dict(orient="records"),
    }
