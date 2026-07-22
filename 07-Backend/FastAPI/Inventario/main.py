from routers import products
from fastapi import FastAPI

app = FastAPI()

app.include_router(router=products.router)


@app.get("/")
async def root():
    return {"message": "Running..."}
