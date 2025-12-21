select 
    user_id,
    round(avg(array_length(product_ids, 1)), 2) as avg_order_size
from (
        select user_id, order_id
        from user_actions
        where order_id not in ( select order_id 
                                from user_actions
                                where action = 'cancel_order')
) t full join orders using(order_id)
group by user_id
order by user_id
limit 1000;