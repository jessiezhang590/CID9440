select *
from {{ ref('stg_stripe__payments') }} payments
left join {{ ref('stg_jaffle_shop__orders') }} orders
on payments.order_id = orders.order_id
where payments.created_at < orders.order_date