from dagster_dbt import DbtProject
from pathlib import Path

dbt_project_directory = Path(__file__).resolve().parent.parent.parent / "dbt_project"
dbt_project = DbtProject(project_dir=dbt_project_directory).prepare_if_dev()

