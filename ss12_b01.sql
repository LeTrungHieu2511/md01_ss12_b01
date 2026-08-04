--1
create table customers(
	customer_id serial primary key,
	name varchar(50),
	email varchar(50)
);
--2
create table customer_log(
	log_id serial primary key,
	customer_name varchar(100),
	action_time timestamp,
);
--3
create or replace function log_customer_insert()
returns trigger
as
$$
begin
	insert into customer_log(customer_name, action_time)
	values(new.name, now());

	return new;
end;
$$
language plpgsql;

create trigger trg_customer_insert
after insert
on customers
for each row
execute function log_customer_insert();
--4
insert into customers(name, email)
values
('nguyen van a', 'a@gmail.com'),
('tran thi b', 'b@gmail.com'),
('le van c', 'c@gmail.com');

select * from customers;

select * from customer_log;