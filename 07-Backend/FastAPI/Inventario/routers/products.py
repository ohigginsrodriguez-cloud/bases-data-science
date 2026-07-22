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
    product = inventory.get(id)

    if product is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"message": "Product not found"},
        )

    return product


@router.get("/")
async def products():
    """Return all products"""
    if not inventory:
        return []

    return list(inventory.values())


@router.get("/product/{id}")
async def product(id: int):
    """Return specific product by id"""
    return search_product(id)


@router.post("/")
async def create_product(product: ProductAPI):
    """Create a product using pydantic validation"""
    if search_product(product.id) == product:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"message": "product already exists"},
        )

    return


@router.put("/{id}")
async def update_product(id: int):
    """Update a existent product"""
    return


@router.delete("/{id}")
async def delete_product(id: int):
    """Delete a product"""
    return
