from dagster import Definitions,load_assets_from_modules

from .assets import ingest_customer, ingest_product, dbt_models
from .resources import sling_resource, dbt_resource
from .jobs import ingest_job, transform_job, ingest_product_job

# customer_assets = load_assets_from_modules([customer_assets])
# product_assets = load_assets_from_modules([product_assets])
# transforms = load_assets_from_modules([transforms])

defs = Definitions(
   assets=[ingest_customer,ingest_product,dbt_models],
   resources={
       "sling": sling_resource,
       "dbt": dbt_resource
   },
   jobs=[ingest_job,transform_job, ingest_product_job]
)
