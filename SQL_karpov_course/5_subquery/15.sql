select 
    order_id,
    product_ids
from orders
where order_id IN (select order_id
                    from courier_actions
                    where action = 'deliver_order'
                    order by time desc
                    limit 100)
order by order_id;
