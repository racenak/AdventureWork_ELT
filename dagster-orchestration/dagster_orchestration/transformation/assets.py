import dagster as dg
from dagster_dbt import dbt_assets, DbtCliResource, DbtProject, DagsterDbtTranslator
from pathlib import Path
from typing import Any, Optional
from collections.abc import Mapping

# Points to the dbt project path
dbt_project_directory = Path(__file__).resolve().parent.parent.parent / "dbt_project"
dbt_project = DbtProject(project_dir=dbt_project_directory)


# Compiles the dbt project & allow Dagster to build an asset graph
dbt_project.prepare_if_dev()

class CustomDagsterDbtTranslator(DagsterDbtTranslator):
    def get_group_name(
        self, dbt_resource_props: Mapping[str, Any]
    ) -> Optional[str]:
        return "transform"


# Yields Dagster events streamed from the dbt CLI
@dbt_assets(manifest=dbt_project.manifest_path, dagster_dbt_translator=CustomDagsterDbtTranslator())
def dbt_models(context: dg.AssetExecutionContext, dbt: DbtCliResource):
   yield from dbt.cli(["build"], context=context).stream()

