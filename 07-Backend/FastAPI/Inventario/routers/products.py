from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter(prefix="/products", tags=["products"])


class ProductClient(BaseModel):
    name: str
    price: float
    stock: int


class ProductAPI(ProductClient):
    id: int


@router.get("/")
async def products():
    return


@router.get("/{id}/")
async def product(id: int):
    return


@router.post("/")
async def create_product(product: ProductClient):
    return


@router.put("/{id}/")
async def update_product(id: int):
    return


@router.delete("/{id}/")
async def delete_product(id: int):
    return
