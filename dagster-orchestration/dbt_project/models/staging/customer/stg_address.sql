{{ config(materialized="table")}}
select  raw.AddressID,
        raw.AddressLine1,
        raw.AddressLine2,
        raw.City,
        raw.PostalCode,
        raw.SpatialLocation,
        geo.StateProvinceCode,
        geo.CountryRegionCode,
        geo.RegionName,
        geo.IsOnlyStateProvinceFlag,
        geo.StateName
from {{ source('landing','raw_address')}} as raw
left join {{ ref('stg_geographic')}} as geo
on raw.StateProvinceID = geo.StateProvinceID
