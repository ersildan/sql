select 
    first_order_date as date, 
    count(user_id) as first_orders
from (  select 
            user_id,
            min(time) :: date as first_order_date
        from user_actions
        where order_id not in (
                            select order_id
                            from user_actions
                            where action = 'cancel_order')
        group by user_id) t
group by first_order_date
order by date;
