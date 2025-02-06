{{config(materialized = 'table', schema = 'transforming_dev')}}
 
select
o.order_id,
od.line_no,
o.customer_id,
o.EMP_ID,
o.SHIPPED_ID,
od.product_id,
od.quantity,
od.UNIT_PRICE,
od.discount,
od.order_date,
to_decimal((od.UNIT_PRICE * od.Quantity) * (1-od.Discount), 9, 2 ) as linesalesamount,
to_decimal(p.UnitCost * od.Quantity,9,2) as costofgoodssols,
to_decimal(((od.UNIT_PRICE * od.Quantity) * (1-od.Discount)) - (p.UnitCost * od.Quantity), 9, 2 ) as margin
 
from
 
{{ref('stg_orders')}} as o inner join {{ref('stg_order_details')}} as od
 
on o.order_id = od.order_id inner join {{ref('stg_products')}} as p
 
on od.product_id = p.product_id