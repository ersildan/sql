WITH table_1 as (
    SELECT order_id,
           sum(price) as order_price
    FROM   (SELECT order_id,
                   unnest(product_ids) as product_id
            FROM   orders) t
        INNER JOIN products using(product_id)
    GROUP BY order_id
    ORDER BY order_id
), table_2 as (
    SELECT user_id,
           order_id,
           round(avg(array_length(product_ids, 1)), 2) as avg_order_size
    FROM   (SELECT user_id,
                   order_id
            FROM   user_actions
            WHERE  order_id not in (SELECT order_id
                                    FROM   user_actions
                                    WHERE  action = 'cancel_order')) t full join orders using(order_id)
    GROUP BY user_id, order_id
    ORDER BY user_id 
)

select 
    user_id, 
    count(*) as orders_count, 
    round(avg(t2.avg_order_size), 2) as avg_order_size, 
    sum(t1.order_price) as sum_order_value, 
    round(avg(t1.order_price), 2) as avg_order_value, 
    min(t1.order_price) as min_order_value, 
    max(t1.order_price) as max_order_value
from table_2 t2
JOIN table_1 t1 using(order_id)
group by user_id
order by user_id
limit 1000;
