select
    l.user_id, r.name
from (
    select user_id 
    from users 
    limit 100) l cross join products r
order by l.user_id, r.name;