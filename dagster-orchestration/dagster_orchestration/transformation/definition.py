from dagster import Definitions

from .assets import dbt_models
from .resource import dbt_resource

defs_test = Definitions(
    assets=[dbt_models],
    resources={
        "dbt": dbt_resource
    }
)