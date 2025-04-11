from dagster import define_asset_job, AssetSelection

ingest_job = define_asset_job(name="ingest_job", selection=AssetSelection.groups("raw"))
ingest_product_job = define_asset_job(name="ingest_product_job", selection=AssetSelection.groups("raw_ingest_product"))
transform_job = define_asset_job(name="transform_job", selection=AssetSelection.groups("transform"))
