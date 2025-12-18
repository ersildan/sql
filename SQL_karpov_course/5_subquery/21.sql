select 
    creation_time, 
    order_id, 
    product_ids, 
    unnest(product_ids) as product_id
from orders
limit 100;
