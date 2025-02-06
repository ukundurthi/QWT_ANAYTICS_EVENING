{{config(materialized = 'table', schema = 'transforming_dev')}}
 
select
c.customerid,
c.companyname,
c.contactname,
c.city,
c.country,

c.address,
c.fax,
c.phone,
c.postalcode,
IFF(c.stateprovince = '', 'NA', c.stateprovince) as stateprovincename
 
from
{{ref('stg_customers')}} as c 

