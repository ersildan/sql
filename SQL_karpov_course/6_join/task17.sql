SELECT
    COALESCE(sex, 'unknown') as sex,
    round(avg(cancel_rate), 3) as avg_cancel_rate
FROM ( 
    select
        ua.user_id,
        u.sex,
        count(distinct order_id) filter (where action = 'cancel_order')::decimal / count(distinct order_id) as cancel_rate
    from user_actions ua
    left join users u ON ua.user_id = u.user_id
    group by ua.user_id, u.sex
) t
group by COALESCE(sex, 'unknown')
order by COALESCE(sex, 'unknown');
