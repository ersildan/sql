with t as (
    select 
        order_id,
        DATE(creation_time) as date,
        product_ids
    from orders
    where order_id not in (select order_id from user_actions where action = 'cancel_order')
), t2 as (
    select 
        order_id,
        date,
        unnest(product_ids) as product_id
    from t
)

select 
    date,
    sum(price) as revenue
from t2
join products using(product_id)
group by date
order by date;
