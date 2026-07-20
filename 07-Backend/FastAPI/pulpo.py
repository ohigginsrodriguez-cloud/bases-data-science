from fastapi import FastAPI
from pydantic import BaseModel, EmailStr

app = FastAPI()


class User(BaseModel):
    name: str
    username: str
    email: EmailStr
    coder: bool
    age: int


@app.get("/")
async def root():
    return {"message": "Running..."}


@app.get("/user/")
async def user(user: User):
    return user
