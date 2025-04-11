{{ config(
    materialized='table'
) }}

select  CustomerID,
        BusinessEntityID,
        AccountNumber,
        NameStyle, 
        Title, 
        FirstName, 
        MiddleName ,
        LastName ,
        Suffix ,
        EmailPromotion ,
        AdditionalContactInfo ,
        Demographics 
from {{ source('landing','raw_customer') }}
inner join {{ source('landing','raw_person') }}
on raw_person.BusinessEntityID = raw_customer.PersonID