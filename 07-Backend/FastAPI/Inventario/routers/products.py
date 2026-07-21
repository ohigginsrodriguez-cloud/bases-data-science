from fastapi import APIRouter, HTTPException, status
from pydantic import BaseModel

router = APIRouter(prefix="/products", tags=["products"])


class ProductClient(BaseModel):
    name: str
    price: float
    stock: int


class ProductAPI(ProductClient):
    id: int


inventory: dict[int, ProductAPI] = {}
next_id: int = 1


@router.get("/")
async def products():
    if not inventory:
        raise HTTPException(
            status_code=status.HTTP_200_OK,
            detail={"message": "No products, add one"},
        )

    return list(inventory.values)


@router.get("/{id}")
async def product(id: int):
    return


@router.post("/")
async def create_product(product: ProductClient):
    return


@router.put("/{id}")
async def update_product(id: int):
    return


@router.delete("/{id}")
async def delete_product(id: int):
    return
