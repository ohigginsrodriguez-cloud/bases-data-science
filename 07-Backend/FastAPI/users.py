from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# Iniciar server: uvicorn users:app --reload


# Entidad user
class User(BaseModel):
    name: str
    surname: str
    url: str
    age: int


users_list = [
    User(name="pulpo", surname="king", url="https://pulpo.com", age=20),
    User(name="anuel", surname="AA", url="https://anuel.com", age=34),
    User(name="drake", surname="iceman", url="https://iceman.com", age=36),
]


@app.get("/usersjson")
async def usersjson():
    return [
        {"name": "pulpo", "surname": "king", "url": "https://pulpo.com", "age": 20},
        {"name": "anuel", "surname": "AA", "url": "https://anuel.com", "age": 34},
        {"name": "drake", "surname": "iceman", "url": "https://drake.com", "age": 36},
    ]


@app.get("/users")
async def users():
    return users_list
