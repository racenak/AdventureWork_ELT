from dagster_embedded_elt.sling import SlingConnectionResource, SlingResource


source = SlingConnectionResource(
    name="MY_SQLSERVER",
    type="sqlserver",
    host="localhost",  # type: ignore
    port=1433,  # type: ignore
    database="AdventureWorks2022",  # type: ignore
    user="sa",  # type: ignore
    password="YourStrong!Passw0rd"
)
target = SlingConnectionResource(
    name="MY_CH",
    type="clickhouse",
    host="localhost",
    port=9000,
    user="admin",
    password="admin",
    database="landing",
    # http_url = "http://admin:admin@localhost:8123/landing"
)

sling_resource = SlingResource(connections=[source, target])
