SELECT product_id,
       name,
       price,
       row_number() OVER (ORDER BY price desc) as product_number,
       rank() OVER (ORDER BY price desc) as product_rank,
       dense_rank() OVER (ORDER BY price desc) as product_dense_rank
FROM   products;
