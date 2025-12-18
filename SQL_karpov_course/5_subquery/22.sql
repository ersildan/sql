select product_id, times_purchased
from (
        select 
            unnest(product_ids) as product_id,
            count(*) as times_purchased
        from orders
        where order_id not in (
                                select order_id 
                                from user_actions 
                                where action = 'cancel_order')
        group by product_id
        order by times_purchased desc
        limit 10
) t
order by product_id;
