WITH business_addresses AS (
    SELECT
        bea.BusinessEntityID,
        bea.AddressTypeID,
        at.Name AS AddressTypeName,
        a.AddressID,
        a.AddressLine1,
        a.AddressLine2,
        a.City,
        a.StateProvinceID,
        a.PostalCode
    FROM {{ source('landing', 'raw_businessentityaddress') }} AS bea
    -- Use INNER JOINs since we only want complete address records
    INNER JOIN {{ source('landing', 'raw_addresstype') }} AS at
        ON bea.AddressTypeID = at.AddressTypeID
    INNER JOIN {{ source('landing', 'raw_address') }} AS a
        ON bea.AddressID = a.AddressID
),

state_country AS (
    SELECT
        sp.StateProvinceID,
        sp.StateProvinceCode,
        sp.Name AS StateProvinceName,
        sp.IsOnlyStateProvinceFlag,
        cr.CountryRegionCode,
        cr.Name AS CountryRegionName
    FROM {{ source('landing', 'raw_stateprovince') }} AS sp
    INNER JOIN {{ source('landing', 'raw_countryregion') }} AS cr
        ON sp.CountryRegionCode = cr.CountryRegionCode
)
{{ config(materialized='table') }}
SELECT
    ba.BusinessEntityID as business_entity_id,
    ba.AddressTypeID as address_type_id,
    ba.AddressTypeName as address_type_name,
    ba.AddressID as address_id,
    ba.AddressLine1 as address_line1,
    ba.AddressLine2 as address_line2,
    ba.City as city,
    ba.PostalCode as postal_code,
    sc.StateProvinceID as state_province_id,
    sc.StateProvinceCode as state_province_code,
    sc.StateProvinceName as state_province_name,
    sc.IsOnlyStateProvinceFlag as is_only_state_province_flag,
    sc.CountryRegionCode as country_region_code,
    sc.CountryRegionName as country_region_name,
    -- Add standardized fields
    UPPER(TRIM(ba.City)) as standardized_city,
    UPPER(TRIM(sc.StateProvinceName)) as standardized_state,
    REGEXP_REPLACE(ba.PostalCode, '[^0-9A-Za-z]', '') as standardized_postal_code
FROM business_addresses AS ba
INNER JOIN state_country AS sc
    ON ba.StateProvinceID = sc.StateProvinceI