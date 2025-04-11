{{ config(materialized="table")}}
select  product.ProductID,
        product.Name,
        product.ProductNumber,
        product.MakeFlag,
        product.FinishedGoodsFlag,
        product.Color,
        product.SafetyStockLevel,
        product.ReorderPoint,
        product.StandardCost,
        product.ListPrice,
        product.Size,
        measure_size.Name as SizeUnit,
        measure_weight.Name as WeightUnit,
        product.Weight,
        product.DaysToManufacture,
        product.ProductLine,
        product.Class,
        product.Style,
        category.CategoryName,
        category.Name as SubCategoryName,
        dcu.DescriptionEnglish,
        dcu.DescriptionFrench,
        dcu.DescriptionArabic,
        dcu.DescriptionThai,
        dcu.DescriptionHebrew,
        dcu.DescriptionChinese,
        product.SellStartDate,
        product.SellEndDate,
        product.DiscontinuedDate
from {{ source('landing','raw_product')}} as product
left join {{ source('landing','raw_unitmeasure')}} as measure_size
on product.SizeUnitMeasureCode = measure_size.UnitMeasureCode
left join {{ source('landing','raw_unitmeasure')}} as measure_weight
on product.WeightUnitMeasureCode = measure_weight.UnitMeasureCode
left join {{ ref('stg_fullcategory')}} as category
on product.ProductSubcategoryID = category.ProductSubcategoryID
inner join {{ ref('stg_des_culture')}} as dcu
on product.ProductModelID = dcu.ProductModelID