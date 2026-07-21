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


def search_product(id: int):
    product = filter(lambda x: x.id == id, inventory)

    try:
        return list(product[0])
    except:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail={"message": "User not found"}
        )


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
    return search_product(id)


@router.post("/")
async def create_product(product: ProductClient):
    return


@router.put("/{id}")
async def update_product(id: int):
    return


@router.delete("/{id}")
async def delete_product(id: int):
    return
