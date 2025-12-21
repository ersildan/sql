select 
    user_id,
    order_id,
    product_ids
from (
        select user_id, order_id
        from user_actions
        where order_id not in ( select order_id 
                                from user_actions
                                where action = 'cancel_order')
) t full join orders using(order_id)
order by user_id, order_id
limit 1000;
