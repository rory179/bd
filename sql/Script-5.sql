-- 1. Создание таблицы и последовательности
create table if not exists patients(
    patient_id integer,
    first_name text,
    last_name text,
    date_of_birthday date,
    gender text,
    phone text,
    email text,
    diagnos text
);

create sequence if not exists patients_s increment by 1 start with 1 minvalue 1 maxvalue 999;

-- Очистка таблицы и сброс счетчика перед заполнением
truncate table patients;
alter sequence patients_s restart with 1;

-- 2. Создание процедуры
create or replace procedure create_new_patients(
    p_patients_firstname text, 
    p_patients_lastname text, 
    p_date_of_birthday date, 
    p_gender text, 
    p_phone text, 
    p_email text, 
    p_diagnos text
)
language sql
as $$
    insert into patients(patient_id, first_name, last_name, date_of_birthday, gender, phone, email, diagnos)
    values (nextval('patients_s'), p_patients_firstname, p_patients_lastname, p_date_of_birthday, p_gender, p_phone, p_email, p_diagnos);
$$;

-- 3. Добавление 3 строк через процедуру
call create_new_patients('Ilya', 'Ivanov', to_date('2009.01.28', 'YYYY.mm.dd'), 'male', '89119550298', 'frewfjwq@mail.ru', 'bronhit');
call create_new_patients('Anna', 'Smirnova', to_date('2005.05.14', 'YYYY.mm.dd'), 'female', '89112345678', 'anna.sm@mail.ru', 'angina');
call create_new_patients('Maxim', 'Petrov', to_date('2001.11.03', 'YYYY.mm.dd'), 'male', '89219876543', 'max.petrov@mail.ru', 'gripp');

-- 4. Вывод результата
select * from patients;