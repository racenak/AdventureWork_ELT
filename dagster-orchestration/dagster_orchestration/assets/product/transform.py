from typing import Any, Mapping
from ...utils import dbt_project
from dagster_dbt import dbt_assets, DbtCliResource, DagsterDbtTranslator
from dagster import AssetExecutionContext

class ProductDBTTranslator(DagsterDbtTranslator):
    def get_group_name(self, dbt_resource_props: Mapping[str, Any]) -> str | None:
        return "product"
    
@dbt_assets(manifest=dbt_project.manifest_path, dagster_dbt_translator=ProductDBTTranslator())
def transform_product(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build --select path:models/staging/product path:models/mart"], context=context).stream()
