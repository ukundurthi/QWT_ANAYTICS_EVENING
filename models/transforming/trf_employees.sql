{{config(materialized = 'table', schema = 'transforming_dev')}}
 
select
emp.EmpID,
emp.firstname,
emp.lastname,
emp.title,
emp.hiredate,
IFF(emp.extension = '-', 'NA', emp.extension) as extension,
emp.year_salary,
IFF(mgr.firstname is null, emp.firstname, mgr.firstname) as managername,
IFF(mgr.title is null, emp.title, mgr.title) as managertitle,
ofc.OFFICEADDRESS,
ofc.OFFICECITY,
ofc.OFFICECOUNTRY
 
from
 
{{ref('stg_employees')}} as emp left join
 
{{ref('stg_employees')}} as mgr on emp.reportsto = mgr.EmpID
 
left join {{ref('stg_offices')}} as ofc on emp.OFFICE = ofc.officeid
