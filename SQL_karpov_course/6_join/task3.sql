select
    ua.user_id as user_id_left, 
    u.user_id as user_id_right,  
    ua.order_id, 
    ua.time, 
    ua.action,
    u.sex,
    u.birth_date
from user_actions ua 
left joint users u using(user_id)
order by ua.user_id;
