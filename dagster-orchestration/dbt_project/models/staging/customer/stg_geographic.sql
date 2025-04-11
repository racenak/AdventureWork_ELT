{{ config(materialized="table")}}
select  state.StateProvinceID,
        state.StateProvinceCode,
        state.Name as StateName,
        state.CountryRegionCode,
        region.Name as RegionName,
        state.IsOnlyStateProvinceFlag
from {{ source('landing','raw_stateprovince')}} as state
left join {{ source('landing','raw_countryregion')}} as region
on state.CountryRegionCode = region.CountryRegionCode