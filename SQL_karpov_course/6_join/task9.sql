select 
    u.user_id,
    o.order_id,
    o.product_ids
from user_actions u
full join orders o using(order_id) 
order by u.user_id, o.order_id
limit 1000;
