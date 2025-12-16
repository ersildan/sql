with t_1 as (
    select 
        order_id,
        count(action)
    from courier_actions
    GROUP BY order_id
    having count(action) = 1
), t_2 as (
    SELECT 
        order_id
    from user_actions
    where action = 'cancel_order'
), t_3 as (
    select 
        order_id 
    from t_1
    where order_id NOT IN (select order_id from t_2)
)

select 
    count(*) as orders_undelivered,
    (select count(*) from t_2) as orders_canceled,
    (select count(*) from t_3) as orders_in_process
from t_1;
