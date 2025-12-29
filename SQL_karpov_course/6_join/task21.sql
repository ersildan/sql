select 
    user_id, 
    order_id, 
    time, 
    row_number() over (partition by user_id order by order_id) as order_number
from user_actions
where order_id not in (select order_id from user_actions where action = 'cancel_order')
order by user_id, order_number
limit 1000;
