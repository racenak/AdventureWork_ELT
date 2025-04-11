WITH PhoneData AS (
    SELECT 
    BusinessEntityID,
    PhoneNumber,
    PhoneNumberTypeID
    FROM {{ source('landing','raw_personphone')}} 
),
PhoneNumberType AS (
    SELECT 
    PhoneNumberTypeID,
    Name 
    FROM {{ source('landing','raw_phonenumbertype')}} 
),
Email AS (
    SELECT 
    BusinessEntityID,
    EmailAddressID,
    EmailAddress
    FROM {{ source('landing','raw_emailaddress')}} 
),
stg_personal_info AS(
    SELECT 
        p.BusinessEntityID as BusinessEntityID,
        p.PhoneNumber,
        pnt.Name AS PhoneNumberTypeName,
        e.EmailAddress
    FROM PhoneData AS p
    LEFT JOIN Email AS e
        ON p.BusinessEntityID = e.BusinessEntityID
    LEFT JOIN PhoneNumberType AS pnt
        ON p.PhoneNumberTypeID = pnt.PhoneNumberTypeID
)
{{ config(materialized='table') }}
SELECT * FROM stg_personal_info