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
from {{ ref('raw_customer') }}
inner join {{ ref('raw_person') }}
on raw_person.BusinessEntityID = raw_customer.PersonID