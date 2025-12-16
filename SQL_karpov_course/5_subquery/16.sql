with t as (
    select
        courier_id, birth_date, sex
    from couriers
)

SELECT 
    courier_id, birth_date, sex
from t
where courier_id in (
    select
        courier_id
    from courier_actions
    where 
        to_char(time, 'Month') = 'September'
        and DATE_PART('year', time) = '2022' 
        and action = 'deliver_order'
    group by courier_id
    having count(courier_id) >= 30
)
order by courier_id;
