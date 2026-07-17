from fastapi import FastAPI, Depends, HTTPException, status
from pydantic import BaseModel
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm

# OAuth2PasswordBearer: Extrae el token de la cabecera 'Authorization' para proteger endpoints.
# OAuth2PasswordRequestForm: Recibe usuario y contraseña (form-data) en el endpoint de login.

app = FastAPI()

oauth2 = OAuth2PasswordBearer(tokenUrl="login")


class User(BaseModel):
    username: str
    full_name: str
    email: str
    disable: bool


class UserDB(User):
    password: str


users_db = {
    "pulpo": {
        "username": "pulpo",
        "full_name": "ohiggins rodriguez",
        "email": "ohigginsrodriguez@gmail.com",
        "disable": False,
        "password": "123456",
    },
    "anuel": {
        "username": "anuel",
        "full_name": "emmanuel gazmey",
        "email": "anuelrhlm@gmail.com",
        "disable": True,
        "password": "654321",
    },
}


def search_user_db(username: str):
    if username in users_db:
        return UserDB(**users_db[username])


def search_user(username: str):
    if username in users_db:
        return User(**users_db[username])


async def current_user(token: str = Depends(oauth2)):
    user = search_user(token)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid autentication credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )

    if user.disable:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Inactive user",
        )
    return user


@app.post("/login/")  # depends recibe datos pero no depende de nadie
async def login(form: OAuth2PasswordRequestForm = Depends()):
    user_db = users_db.get(form.username)
    if not user_db:
        raise HTTPException(status_code=400, detail="Wrong user")

    user = search_user_db(form.username)
    if not form.password == user.password:
        raise HTTPException(status_code=400, detail="Wrong password")

    return {"acces_token": user.username, "token_type": "bearer"}


@app.get("/users/me/")
async def me(user: User = Depends(current_user)):
    return user
