select 
    o.order_id,
    array_agg(p.name) as product_names
from products p
join (
    select 
        order_id, 
        unnest(product_ids) as product_id
    from orders) o using(product_id)
GROUP BY o.order_id
limit 1000;
