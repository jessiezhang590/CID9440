select 
    orders.*
from 
    {{ ref('stg_jaffle_shop__orders') }} orders
left join {{ ref('stg_jaffle_shop__customers') }} customers
on orders.customer_id = customers.customer_id
where customers.customer_id IS NULL