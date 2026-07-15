from fastapi import FastAPI

app = FastAPI(title="Api desde cero sin IA")


@app.get("/")
async def root():
    return {"message": "Hello World"}
