{{ config(materialized="table") }}
SELECT 
	sc.CustomerID,
	sc.AccountNumber,
	sc.NameStyle,
	sc.Title,
	sc.FirstName ,
	sc.MiddleName,
	sc.LastName,
	sc.Suffix,
	sc.EmailPromotion,
	sc.AdditionalContactInfo,
	sc.Demographics,
	sfa.AddressLine1,
	sfa.AddressLine2,
	sfa.Name,
	sfa.City,
	sfa.PostalCode,
	sfa.SpatialLocation,
	sfa.StateProvinceCode,
	sfa.StateName,
	sfa.IsOnlyStateProvinceFlag,
	sfa.CountryRegionCode,
	sfa.RegionName,
FROM {{ref("stg_customer")}} as sc
INNER JOIN {{ ref("stg_full_address")}} sfa 
ON sc.BusinessEntityID = sfa.BusinessEntityID 
INNER JOIN {{ ref("stg_personal_info")}} spi
ON sc.BusinessEntityID = spi.BusinessEntityID
