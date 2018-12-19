DROP TABLE person CASCADE CONSTRAINTS;
DROP TABLE contact_list CASCADE CONSTRAINTS;
DROP TABLE message CASCADE CONSTRAINTS;
DROP TABLE image CASCADE CONSTRAINTS;
DROP TABLE message_image CASCADE CONSTRAINTS;

/* =========================
Create the Person table. 
Table Name: person
Primary Key: person_id
========================= */
CREATE TABLE person ( 
    person_id NUMBER(8) NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    PRIMARY KEY (person_id)
);

/* =========================
Create the Contact List table. 
Table Name: contact_list
Primary Key: connection_id
========================= */
CREATE TABLE contact_list ( 
    connection_id NUMBER(8) NOT NULL,
    person_id NUMBER(8) NOT NULL,
    contact_id NUMBER(8) NOT NULL,
    PRIMARY KEY (connection_id)
);

/* =========================
Create the Messages table. 
Table Name: message
Primary Key: message_id
========================= */
CREATE TABLE message ( 
    message_id NUMBER(8) NOT NULL,
    sender_id NUMBER(8) NOT NULL,
    receiver_id NUMBER(8) NOT NULL,
    message VARCHAR(255) NOT NULL,
    send_datetime TIMESTAMP NOT NULL,
    PRIMARY KEY (message_id)
);

/* =========================
Populate the Person table. 
========================= */
INSERT INTO person (person_id, first_name, last_name) VALUES (1,'Michael', 'Phelps');
INSERT INTO person (person_id, first_name, last_name) VALUES (2,'Katie', 'Ledecky');
INSERT INTO person (person_id, first_name, last_name) VALUES (3,'Usain', 'Bolt');
INSERT INTO person (person_id, first_name, last_name) VALUES (4,'Allyson', 'Felix');
INSERT INTO person (person_id, first_name, last_name) VALUES (5,'Kevin', 'Durant');
INSERT INTO person (person_id, first_name, last_name) VALUES (6,'Diana', 'Taurasi');

/* =========================
Populate the Contact List table. 
========================= */
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (1, 1, 2);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (2,1, 3);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (3,1, 4);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (4,1, 5);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (5,1, 6);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (6,2, 1);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (7,2, 3);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (8,2, 4);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (9,3, 1);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (10,3, 4);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (11,4, 5);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (12,4, 6);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (13,5, 1);
INSERT INTO contact_list (connection_id,person_id, contact_id) VALUES (14,5, 6);

/* =========================
Populate the Message table. 
========================= */
INSERT INTO message (message_id,sender_id, receiver_id, message, send_datetime) VALUES (1,1, 2, 'Congrats on winning the 800m Freestyle', to_date('2016-12-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO message (message_id,sender_id, receiver_id, message, send_datetime) VALUES (2,2, 1, 'Congrats on winning 23 gold medals!', to_date('2016-12-25 09:01:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO message (message_id,sender_id, receiver_id, message, send_datetime) VALUES (3,3, 1, 'You are the greatest swimmer ever', to_date('2016-12-25 09:02:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO message (message_id,sender_id, receiver_id, message, send_datetime) VALUES (4,1, 3, 'Thanks!  You are the greatest sprinter ever', to_date('2016-12-25 09:04:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO message (message_id,sender_id, receiver_id, message, send_datetime) VALUES (5,1, 4, 'Good luck on your race', to_date('2016-12-25 09:05:00','YYYY-MM-DD HH24:MI:SS'));

/* ========================= Verify Results ========================= */

select * from person;
select * from contact_list;


select * from message;

INSERT INTO person (person_id, first_name, last_name) VALUES (7,'Monica', 'Stettler');

ALTER TABLE person
ADD city VARCHAR2(20);

UPDATE person
SET city = 'Batavia'
WHERE first_name = 'Monica' and last_name = 'Stettler';

DELETE FROM person
WHERE first_name = 'Diana' and last_name = 'Taurasi';

ALTER table contact_list
ADD (favorite VARCHAR2(20));

UPDATE contact_list
SET favorite = 'y'
WHERE contact_id = 1;

UPDATE contact_list
SET favorite = 'N'
where contact_id <> 1;

INSERT INTO contact_list (connection_id,person_id, contact_id, favorite) VALUES (15, 7, 1, 'y');
INSERT INTO contact_list (connection_id,person_id, contact_id, favorite) VALUES (16,7, 1, 'y');
INSERT INTO contact_list (connection_id,person_id, contact_id, favorite) VALUES (17,7, 1, 'y');

CREATE TABLE image
(
    image_id NUMBER(8) primary key,
    image_name varchar2(20),
    image_location VARCHAR2(20)
    );

CREATE TABLE message_image
(
    image_id NUMBER(8)
      CONSTRAINT image_id_fk
      REFERENCES image(image_id),
      
    message_id NUMBER(8)
      constraint message_id_fk
      REFERENCES message(message_id),
      
    CONSTRAINT image_message_pk PRIMARY KEY(image_id, message_id)
    );

INSERT INTO image VALUES(1, 'race', 'pool');
INSERT INTO image VALUES(2, 'Freestyle', 'pool');
INSERT INTO image VALUES(3, 'sprint', 'track');
INSERT INTO image VALUES(4, 'medal', 'track');
INSERT INTO image VALUES(5, 'running', 'track');

INSERT INTO message_image(image_id, message_id) VALUES(1,2);
INSERT INTO message_image VALUES(2,3);
INSERT INTO message_image VALUES(4,5);
INSERT INTO message_image VALUES(4,2);
INSERT INTO message_image VALUES(5,1);

ALTER TABLE contact_list
ADD CONSTRAINT contact_person_id
FOREIGN KEY (person_id)
REFERENCES person(person_id);

ALTER TABLE message
ADD CONSTRAINT sender_id_person_id_fk
FOREIGN KEY (sender_id)
REFERENCES person(person_id);

ALTER TABLE message
ADD CONSTRAINT receiver_id_person_id_fk
FOREIGN KEY(receiver_id)
REFERENCES person(person_id);

ALTER TABLE message_image
ADD CONSTRAINT message_id_fk
FOREIGN KEY(message_id)
REFERENCES message(message_id;


select (select First_Name from person where First_Name = 'Michael') as Sender_First_Name,
(select Last_Name from person where Last_Name = 'Phelps') as Sender_Last_Name,
(select person.First_Name from person where person.person_id = message.receiver_id) as Receiver_First_Name,
(select person.Last_Name from person where person.person_id = message.receiver_id) as Receiver_Last_Name,
message_id, message, send_datetime as Message_Timestamp
from message
where sender_id = (select person_id
                  from person
                  where first_name = 'Michael'
                  and last_name = 'Phelps');
  

select p.last_name, p.first_name,  count(m.message_id)
from person p
  join message m
  on p.person_id = m.sender_id
group by p.last_name, p.first_name;

select m.message_id, m.send_datetime, i.image_name, i.image_location, m.message, count(mi.image_id)
from image i
  inner join message_image mi
  on i.image_id = mi.image_id
  inner join message m
  on mi.message_id = m.message_id
group by m.message_id, m.message, m.send_datetime, i.image_name, i.image_location
having count(mi.image_id) >= 1;