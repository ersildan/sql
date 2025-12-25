select 
    o.order_id
from orders o
join courier_actions ca ON o.order_id = ca.order_id and ca.action = 'deliver_order'
order by ca.time - o.creation_time  desc
limit 10;
