--1
create table customers(
	customer_id serial primary key,
	customer_name varchar(100),
	email varchar(100)
);
--2
create table customer_log(
	log_id serial primary key,
	customer_id int,
	customer_name varchar(100),
	action varchar(20),
	log_time timestamp default now()
);
--3
create or replace function log_customer_insert()
returns trigger
as
$$
begin
	insert into customer_log(customer_id, customer_name, action)
	values(new.customer_id, new.customer_name, 'insert');

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
insert into customers(customer_name, email)
values
('Nguyen Van A', 'a@gmail.com'),
('Tran Thhi B', 'b@gmail.com'),
('Le Van C', 'c@gmail.com');

select * from customers;

select * from customer_log;