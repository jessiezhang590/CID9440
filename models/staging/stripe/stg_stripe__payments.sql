select 
    orderid as order_id,
    amount,
    status as payment_status
from `dbt-tutorial`.stripe.payment