with t as (
    SELECT user_id,
        EXTRACT(EPOCH FROM (time - LAG(time)
                OVER (PARTITION BY user_id ORDER BY time))) as diff_sec
    FROM   user_actions
    WHERE  order_id not in (SELECT order_id
                            FROM   user_actions
                            WHERE  action = 'cancel_order')
    ORDER BY user_id
)
select
    user_id,
    round(avg(diff_sec)/3600) :: INT as hours_between_orders
from t
where diff_sec is not null
group by user_id
having count(*) >= 1
ORDER BY user_id
LIMIT 1000;
