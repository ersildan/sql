select 
    order_id,
    sum(price) as order_price
from (select 
        order_id,
        unnest(product_ids) as product_id
      from orders) t
inner join products using(product_id)
group by order_id
order by order_id
limit 1000;
