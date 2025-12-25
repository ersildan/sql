with t as (
    select max(time)::date as date
    from user_actions
)

select
    o.order_id, 
    u.user_id, 
    EXTRACT(YEAR FROM age((select date from t), u.birth_date))::integer as user_age, 
    c.courier_id, 
    EXTRACT(YEAR FROM age((select date from t), c.birth_date))::integer as courier_age

from orders o

join user_actions ua using(order_id)
join users u using(user_id)
join courier_actions ca using(order_id)
join couriers c using(courier_id)

where o.order_id not in (select order_id from user_actions where action = 'cancel_order')
group by 
    o.order_id, o.product_ids, u.user_id,
    c.courier_id, u.birth_date, c.birth_date
order by 
    array_length(o.product_ids, 1) desc,
    o.order_id
limit 5;