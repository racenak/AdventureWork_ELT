from dagster import Definitions, load_assets_from_modules
from . import assets
from .resource import sling_resource

defs = Definitions(
    assets=load_assets_from_modules([assets]),
    resources={
        "sling": sling_resource,
    }
)