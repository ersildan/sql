select 
    order_id,
    product_id,
    price
from (select 
        order_id,
        unnest(product_ids) as product_id
      from orders) t
inner join products using(product_id)
order by order_id, product_id
limit 1000;