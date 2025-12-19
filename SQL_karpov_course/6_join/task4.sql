select 
    count(distinct user_id) as users_count
from user_actions ua 
left join users u using(user_id);
