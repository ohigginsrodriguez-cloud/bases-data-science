from fastapi import FastAPI
from routers import products, users
from fastapi.staticfiles import StaticFiles

app = FastAPI()

# Routers
app.include_router(products.router)
app.include_router(users.router)

# Static resources
app.mount(path="/static", app=StaticFiles(directory="static"), name="static")
# http://127.0.0.1:8000/static/images/thorfinn.jpg


@app.get("/")
async def root():
    return "Hola FastAPI!"


@app.get("/url/")
async def root():
    return {"url": "https://pulpo.com"}
