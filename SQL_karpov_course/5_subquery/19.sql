select 
    order_id,
    min(time) FILTER(where action = 'accept_order') as time_accepted,
    max(time) FILTER(WHERE action = 'deliver_order') as time_delivered,
    round(EXTRACT(epoch FROM (max(time) FILTER(WHERE action = 'deliver_order') - min(time) FILTER(where action = 'accept_order')))/60) :: int as delivery_time
from courier_actions
where order_id in (
                    select 
                        order_id
                    from orders
                    where ARRAY_LENGTH(product_ids, 1) > 5
) and order_id not in (select order_id from user_actions where action = 'cancel_order')
group by order_id
order by order_id;
