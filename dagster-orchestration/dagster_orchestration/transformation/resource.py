from dagster_dbt import DbtCliResource, DbtProject
from pathlib import Path


# Points to the dbt project path
dbt_project_directory = Path(__file__).resolve().parent.parent.parent / "dbt_project"
dbt_project = DbtProject(project_dir=dbt_project_directory)

# References the dbt project object
dbt_resource = DbtCliResource(project_dir=dbt_project)

print(dbt_project_directory)