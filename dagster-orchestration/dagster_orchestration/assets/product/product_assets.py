from dagster_sling import sling_assets, SlingResource, DagsterSlingTranslator
from typing import Mapping, Any

class ProductSlingDagsterTranslator(DagsterSlingTranslator):
    def get_group_name(self, stream_definition: Mapping[str, Any]) -> str | None:
        return "raw_ingest_product"
    
product_config = {
    "source": "MY_SQLSERVER",
    "target": "MY_CH",
    "defaults": {
        "mode": "incremental",
    },
    "streams": {
        "Production.Product": {
            "object": "raw_product",
            "update_key": "ProductID"
        },
        "Production.UnitMeasure": {
            "object": "raw_unitmeasure",
            "mode": "full-refresh"
        },
        "Production.ProductSubcategory": {
            "object": "raw_productsubcategory",
            "update_key": "ProductSubcategoryID"
        },
        "Production.ProductCategory": {
            "object": "raw_productcategory",
            "update_key": "ProductCategoryID"
        },
        "Production.ProductModel": {
            "object": "raw_productmodel",
            "update_key": "ProductModelID"
        },
        "Production.ProductModelProductDescriptionCulture" : {
            "object": "raw_model_description_culture",
            "mode": "full-refresh"
        },
        "Production.Culture": {
            "object": "raw_culture",
            "update_key": "CultureID"
        },
        "Production.ProductDescription": {
            "object": "raw_model_description",
            "update_key": "ProductDescriptionID"
        }
    }
}

@sling_assets(replication_config=product_config,
              dagster_sling_translator=ProductSlingDagsterTranslator())
def ingest_product(context, sling: SlingResource):
    yield from sling.replicate(context=context, debug=True)