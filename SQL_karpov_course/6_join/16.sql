SELECT name,
       times_purchased
FROM   (SELECT product_id,
               count(product_id) as times_purchased
        FROM  (SELECT DISTINCT
                    order_id,
                    unnest(product_ids) as product_id
                FROM  orders
                WHERE order_id not in (SELECT order_id
                                        FROM   user_actions
                                        WHERE  action = 'cancel_order')
                                        and order_id in (
                                                            select order_id 
                                                            from courier_actions 
                                                            where action = 'deliver_order' 
                                                            and DATE(time) >= '2022-09-01' AND date(time) < '2022-10-01')
                ) t
        GROUP BY t.product_id
        ORDER BY times_purchased desc limit 10) t2
join products p using(product_id)
order by times_purchased desc
limit 10;
