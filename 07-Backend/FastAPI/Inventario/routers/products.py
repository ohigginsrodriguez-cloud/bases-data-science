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
next_id: int = 0


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


@router.post("/add-product/")
async def create_product(product: ProductClient):
    """Create a product using pydantic validation"""

    global next_id

    search_name = any(i.name == product.name for i in inventory.values())

    if search_name is True:
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail={"meessage": "product already exists"},
        )

    new_product = ProductAPI(**product.model_dump(), id=next_id + 1)
    inventory[next_id + 1] = new_product
    next_id += 1

    return new_product


@router.put("/{id}")
async def update_product(id: int):
    """Update a existent product"""
    return


@router.delete("/{id}")
async def delete_product(id: int):
    """Delete a product"""
    return
