import streamlit as st
import requests
import pandas as pd
import matplotlib.pyplot as plt

API_URL = "http://127.0.0.1:8000"

st.title("InteliStock")
st.subheader("Prediccion de demanda para tu negocio")

# Obtener productos disponibles
productos = requests.get(f"{API_URL}/productos").json()["productos"]

# Controles
producto_seleccionado = st.selectbox("Selecciona un producto", productos)
dias = st.slider("Dias a predecir", min_value=7, max_value=30, value=7)

if st.button("Generar prediccion"):
    with st.spinner("Calculando..."):
        response = requests.get(
            f"{API_URL}/prediccion/{producto_seleccionado}?dias={dias}"
        )
        data = response.json()

    st.metric("Error promedio del modelo (MAE)", f"{data['mae']} unidades")
    st.metric("Dias de historial", data["dias_de_historial"])

    df_pred = pd.DataFrame(data["predicciones"])
    df_pred["fecha"] = pd.to_datetime(df_pred["fecha"])

    st.subheader("Predicciones")
    st.dataframe(df_pred)

    fig, ax = plt.subplots(figsize=(10, 4))
    ax.plot(df_pred["fecha"], df_pred["cantidad_predicha"], marker="o")
    ax.set_title(f"Prediccion de demanda - {producto_seleccionado}")
    ax.set_xlabel("Fecha")
    ax.set_ylabel("Cantidad predicha")
    plt.xticks(rotation=45)
    plt.tight_layout()
    st.pyplot(fig)
