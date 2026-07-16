from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# Iniciar server: uvicorn users:app --reload


# Entidad user
class User(BaseModel):
    id: int
    name: str
    surname: str
    url: str
    age: int


users_list = [
    User(id=1, name="pulpo", surname="king", url="https://pulpo.com", age=20),
    User(id=2, name="anuel", surname="AA", url="https://anuel.com", age=34),
    User(id=3, name="drake", surname="iceman", url="https://iceman.com", age=36),
]


@app.get("/usersjson")  # path
async def usersjson():
    return [
        {"name": "pulpo", "surname": "king", "url": "https://pulpo.com", "age": 20},
        {"name": "anuel", "surname": "AA", "url": "https://anuel.com", "age": 34},
        {"name": "drake", "surname": "iceman", "url": "https://drake.com", "age": 36},
    ]


@app.get("/users/")  # path
async def users():
    return users_list


@app.get("/user/{id}/")  # query
async def user(id: int):
    return search_user(id)


@app.post("/user/")
async def user(user: User):

    if type(search_user(user.id)) == User:
        return {"error": "User already exists"}
    else:
        users_list.append(user)


def search_user(id: int):
    users = filter(lambda x: x.id == id, users_list)
    try:
        return list(users)[0]
    except:
        return {"error": "User not found"}
