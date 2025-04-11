{{ config(materialized="table")}}
select  sub.ProductSubcategoryID,
        cat.Name as CategoryName,
        sub.Name,
from {{ source('landing','raw_productsubcategory')}} as sub
left join {{ source('landing','raw_productcategory')}} as cat
on sub.ProductCategoryID = cat.ProductCategoryID