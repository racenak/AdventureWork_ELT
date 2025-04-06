select * from {{ref('stg_customer')}}
join {{ref('stg_address')}}
on stg_customer.BusinessEntityID = stg_address.BusinessEntityID
join {{ref('stg_personal_info')}}
on stg_customer.BusinessEntityID = stg_personal_info.BusinessEntityID