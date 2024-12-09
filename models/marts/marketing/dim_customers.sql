with customers as (

     select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as ( 

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

customer_lifetime_value as (
    select customer_id, sum(amount) as lifetime_value from {{ ref('fct_orders') }}

    where payment_status = 'success'
    group by 1
),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(orders.order_id) as number_of_orders,

    from orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce (customer_orders.number_of_orders, 0) 
        as number_of_orders,
        coalesce (customer_lifetime_value.lifetime_value/100, 0) 
        as lifetime_value

    from customers

    left join customer_orders using (customer_id)
    left join customer_lifetime_value using (customer_id)

)

select * from final