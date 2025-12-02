select
    date,
    orders_count,
    SUM(orders_count) over (ORDER BY date) :: integer as orders_count_cumulative
FROM 
    (
    select 
        COUNT(*) as orders_count, 
        DATE(creation_time) as date
    from orders
    where order_id NOT IN (
                            select order_id 
                            from user_actions 
                            where action = 'cancel_order'
    )
    group by DATE(creation_time)
    ) t1;
