{{ config(materialized="table") }}

SELECT  
    bea.BusinessEntityID,
    addr.AddressLine1,
    addr.AddressLine2,
    at.Name as AddressType,
    addr.City,
    addr.PostalCode,
    addr.SpatialLocation,
    addr.StateProvinceCode,
    addr.CountryRegionCode,
    addr.RegionName,
    addr.IsOnlyStateProvinceFlag,
    addr.StateName
FROM {{ source('landing','raw_businessentityaddress') }} AS bea

INNER JOIN {{ ref('stg_address') }} AS addr
    ON bea.AddressID = addr.AddressID

LEFT JOIN {{ source('landing','raw_addresstype') }} AS at
    ON bea.AddressTypeID = at.AddressTypeID
