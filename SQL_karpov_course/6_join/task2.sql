select 
    count(distinct user_id) as users_count
from users u 
inner join user_actions using(user_id);
