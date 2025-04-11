with base as
(
select  
        mdc.ProductModelID,
        rc.Name,
        descrip.Description
from {{ source("landing","raw_model_description_culture")}} as mdc
inner join {{ source("landing","raw_model_description")}} as descrip
on mdc.ProductDescriptionID = descrip.ProductDescriptionID
LEFT JOIN {{ source("landing","raw_culture")}} rc 
on mdc.CultureID = rc.CultureID
),
pivoted as (
    select 
        ProductModelID,
        max(if(Name = 'English', Description, null)) as DescriptionEnglish,
        max(if(Name = 'French', Description, null)) as DescriptionFrench,
        max(if(Name = 'Arabic', Description, null)) as DescriptionArabic,
        max(if(Name = 'Thai', Description, null)) as DescriptionThai,
        max(if(Name = 'Hebrew', Description, null)) as DescriptionHebrew,
        max(if(Name = 'Chinese', Description, null)) as DescriptionChinese
    from base
    group by ProductModelID
)

select * from pivoted
