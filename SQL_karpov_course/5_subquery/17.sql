SELECT round(avg(array_length(product_ids, 1)), 3) as avg_order_size
FROM   orders
WHERE  order_id in (SELECT order_id
                    FROM   user_actions as t1 join users t2 using(user_id)
                    WHERE  t1.action = 'cancel_order'
                       and t2.sex = 'male')
                       