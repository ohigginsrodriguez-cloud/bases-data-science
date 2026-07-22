from fastapi import APIRouter, HTTPException, status
from pydantic import BaseModel, Field  # Field es para add restrictions

router = APIRouter(prefix="/products", tags=["products"])


class ProductClient(BaseModel):
    name: str = Field(min_length=1, max_length=25, description="Product name")
    price: float = Field(
        gt=0, description="Product price must be greater than 0"
    )  # gt = greater than
    stock: int = Field(
        ge=0, description="Product stock can't be lesser than 0"
    )  # ge = greater or equal


class ProductUpdate(BaseModel):
    name: str | None = None
    price: float | None = None
    stock: int | None = None


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
async def list_products():
    """Return all products"""
    if not inventory:
        return []

    return list(inventory.values())


@router.get("/{id}")
async def get_product(id: int):
    """Return specific product by id"""
    return search_product(id)


@router.post("/")
async def create_product(product: ProductClient):
    """Create a product using pydantic validation"""

    global next_id

    if any(i.name == product.name for i in inventory.values()):
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail={"message": "product already exists"},
        )

    new_product = ProductAPI(**product.model_dump(), id=next_id + 1)
    inventory[next_id + 1] = new_product
    next_id += 1

    return new_product


@router.put("/{id}")
async def update_product(id: int, body: ProductUpdate):
    """Update a existent product"""
    product = search_product(id)

    for key, value in body.model_dump(exclude_unset=True).items():
        # .model_dump() extrae solo los elementos que no son null, .items() hace que sean tuplas para poder desarmar
        setattr(product, key, value)
        # modifica el objeto recibiendo clave y valor

    return product


@router.delete("/{id}")
async def delete_product(id: int):
    """Delete a product"""
    search_product(id)

    inventory.pop(id)

    return {"message": "product deleted"}
