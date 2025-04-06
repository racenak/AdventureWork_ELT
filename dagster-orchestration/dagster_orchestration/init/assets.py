from typing import Any, Mapping, Optional
from dagster_sling import SlingResource, sling_assets, DagsterSlingTranslator

class CustomeSlingDagsterTranslator(DagsterSlingTranslator):
    def get_group_name(self, stream_definition: Mapping[str, Any]) -> str | None:
        return "raw"
        

# Common configuration shared across all assets
BASE_CONFIG = {
    "source": "MY_SQLSERVER",
    "target": "MY_CH",
    "defaults": {
        "mode": "incremental",
    },
    "streams": {
        "Sales.Customer": {
            "object": "landing.raw_customer",
            "update_key": "CustomerID"
        },
        "Person.Person": {
            "object": "landing.raw_person",
            "update_key": "BusinessEntityID"
        },
        "Person.Address": {
            "object": "landing.raw_address",
            "update_key": "AddressID"
        },
        "Person.AddressType": {
            "object": "landing.raw_addresstype",
            "update_key": "AddressTypeID"
        },
        "Person.BusinessEntityAddress": {
            "object": "landing.raw_businessentityaddress",
            "update_key": "BusinessEntityID"
        },
        "Person.CountryRegion": {
            "object": "landing.raw_countryregion"
        },
        "Person.StateProvince": {
            "object": "landing.raw_stateprovince",
            "update_key": "StateProvinceID"
        },
        "Person.EmailAddress": {
            "object": "landing.raw_emailaddress",
            "update_key": "BusinessEntityID"
        },
        "Person.PersonPhone": {
            "object": "landing.raw_personphone",
            "update_key": "BusinessEntityID"
        },
        "Person.PhoneNumberType": {
            "object": "landing.raw_phonenumbertype",
            "update_key": "PhoneNumberTypeID"
        }
    }
}



@sling_assets(replication_config=BASE_CONFIG,
              dagster_sling_translator=CustomeSlingDagsterTranslator())
def ingest(context, sling: SlingResource):
    yield from sling.replicate(context=context, debug=True)


