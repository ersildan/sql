select 
    order_id, 
    product_ids
from orders
where exists (
        select 1
        from unnest(product_ids) as pid 
        where pid in ( select product_id
                       from products
                       order by price desc
                       limit 5)
)
order by order_id;
