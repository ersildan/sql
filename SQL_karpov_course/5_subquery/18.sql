with max_date as (
    select max(time) :: date as date
    from user_actions
), age_t as (
    select 
        user_id,
        date_part('Year', age((select * from max_date), birth_date)) :: int as age
    from users
)

select 
    user_id,
    coalesce(age, (select avg(age) from age_t)) :: int as age
from age_t
order by user_id;
