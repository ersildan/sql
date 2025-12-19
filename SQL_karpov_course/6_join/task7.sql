select 
    count(birth_date) as dates_count
FROM (
    SELECT birth_date
    FROM users
    WHERE birth_date IS NOT NULL

    union

    SELECT birth_date
    FROM couriers
    WHERE birth_date IS NOT NULL) t;
    