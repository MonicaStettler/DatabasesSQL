DROP TABLE customers CASCADE CONSTRAINTS;
DROP TABLE packages CASCADE CONSTRAINTS;
DROP TABLE sectors CASCADE CONSTRAINTS;


CREATE TABLE sectors
(
  sector_id NUMBER(3) PRIMARY KEY,
  sector_name VARCHAR2(20)
);

CREATE TABLE packages
(
  pack_id NUMBER(4) PRIMARY KEY,
  speed NUMBER(3),
  monthly_paymnet NUMBER(4),
  sector_id NUMBER(3)
    CONSTRAINT sector_id_fk
    REFERENCES sectors(sector_id)
);

CREATE TABLE customers
(
  customer_id NUMBER(3) PRIMARY KEY,
  first_name VARCHAR2(20),
  last_name VARCHAR2(20),
  city VARCHAR2(20),
  state VARCHAR2(20),
  monthly_discount NUMBER(3),
  pack_id NUMBER(3)
    CONSTRAINT pack_id_fk
    REFERENCES packages(pack_id)
);

Insert into sectorS
VALUES(1,'BUSINESS');

Insert into sectorS
VALUES(2,'consumer');

Insert into sectorS
VALUES(3, 'GOVERNMENT');

INSERT INTO packages
VALUES(22, 30, 50, 1);

INSERT INTO packages
VALUES(27, 150, 100, 2);

insert into packages
values(3,500,200, 3);

insert into packages
values(4,800, 300, 1);

insert into customers
values(1,'Joe', 'blue', 'batavia', 'IL', 10,NULL);

INSERT INTO CUSTOMERS
VALUES(2,'SUE','HO','GENEVA','IA',15,22);

INSERT INTO CUSTOMERS
VALUES(3,'JIM','SMITH','ST. CHARLES','IL',25,27);

INSERT INTO CUSTOMERS
VALUES(4,'JACK','BROZNY','AURORA','WI',30,3);

INSERT INTO CUSTOMERS
VALUES(5,'SALLY','HANSON','ELGIN','IL',35,3);

update customers
set city = 'AURORA'
where customer_id = 5;




select city, AVG(monthly_discount)
from customers
group by city;

select city, AVG(monthly_discount)
from customers
WHERE monthly_discount > 20
group by city;

select state, MIN(monthly_discount)
from customers
group by state;

select state, MIN(monthly_discount)
from customers
group by state
having min(monthly_discount) > 10;

select city, AVG(monthly_discount)
from customers
group by city;

select pack_id, count(customer_id)
from customers
group by pack_id;

select pack_id, count(customer_id)
from customers
where monthly_discount > 20
group by pack_id;

select pack_id, count(customer_id)
from customers
group by pack_id
having count(customer_id) >100;

select c.first_name, c.last_name, c.pack_id, p.speed
from customers c left outer join packages p
on c.pack_id = p.pack_id;

select c.first_name, c.last_name, c.pack_id, p.speed
from customers c join packages p
on c.pack_id = p.pack_id
where c.pack_id IN(22,27)
order by c.last_name;

select p.pack_id, p.speed, p.monthly_paymnet, s.sector_name
from packages p left outer join sectors s
on p.sector_id = s.sector_id;

select c.first_name, c.last_name, p.pack_id, p.speed, p.monthly_paymnet, s.sector_name
from customers c
  left outer join packages p
    on c.pack_id = p.pack_id
  left outer join sectors s
    on p.sector_id = s.sector_id;

select c.first_name, c.last_name, p.pack_id, p.speed, p.monthly_paymnet, s.sector_name
from customers c
  join packages p
    on c.pack_id = p.pack_id
  join sectors s
    on p.sector_id = s.sector_id
where s.sector_name = 'BUSINESS';

select c.first_name, c.last_name, p.speed, p.monthly_paymnet
from customers c
inner join packages p
on c.pack_id = p.pack_id;

select c.first_name, c.last_name, p.speed, p.monthly_paymnet
from customers c
left outer join packages p
on c.pack_id = p.pack_id;

select c.first_name, c.last_name, p.speed, p.monthly_paymnet
from customers c
right outer join packages p
on c.pack_id = p.pack_id;

select c.first_name, c.last_name, p.speed, p.monthly_paymnet
from customers c
full outer join packages p
on c.pack_id = p.pack_id;