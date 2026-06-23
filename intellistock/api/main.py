from fastapi import FastAPI, HTTPException
import sys
import os

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import pipeline_completo

app = FastAPI(title="InteliStock API", version="0.1")


@app.get("/")
def root():
    return {"mensaje": "Intelistock API funcionando"}


@app.get("/prediccion/{producto}")
def predecir(producto: str, dias: int = 7):
    resultado = pipeline_completo(producto, dias=dias)

    if "error" in resultado:
        raise HTTPException(status_code=400, detail=resultado["error"])

    return resultado


@app.get("/productos")
def listar_productos():
    return {
        "productos": [
            "Coca-Cola 600ml",
            "Sabritas Original",
            "Pan Bimbo",
            "Leche Lala 1L",
        ]
    }
