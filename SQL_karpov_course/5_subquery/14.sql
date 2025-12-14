select * from users limit 10;select 
    user_id,
    birth_date
from users
where sex = 'male' and birth_date < (
    select min(birth_date)
    from users
    where sex = 'female'
)
order by user_id;
