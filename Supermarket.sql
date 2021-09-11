use SupermarketDB EXEC sp_changedbowner 'sa'

CREATE TABLE category(
	id int primary key identity,
	[description] nvarchar(250)
)

CREATE TABLE product(
	id int primary key identity,
	[name] nvarchar(50) not null,
	[description] nvarchar(500),
	price money check(price > 0),
	cost money check(cost > 0),
	code int,
	dep_id  INTEGER REFERENCES category(id)
)

CREATE TABLE special_care(
	prod_id INTEGER REFERENCES product(id),
	max_temp int,
	min_temp int,
	expiration_date date,
)

CREATE TABLE wish_list(
	product_id INTEGER REFERENCES product(id),
	costomer_id INTEGER REFERENCES product(id)
)

CREATE TABLE address_location(
	id INT PRIMARY KEY identity,
    city NVARCHAR(25), 
    district NVARCHAR(25),
    street NVARCHAR(25),
    building_number INT, 
    postal_code INT,
)

CREATE TABLE customer(
	id INT PRIMARY KEY identity,
	first_name NVARCHAR(30),
	last_name NVARCHAR(30),
	birth_date DATE,
	gender nvarchar (50),
	email NVARCHAR(64),
	username CHAR(20),
	passwd CHAR(64),
	phone_number CHAR(12),
	address_id  INTEGER REFERENCES address_location(id),
	created_date date,
	--[role] int
)

CREATE TABLE proffesion(
   id int primary key identity,
   prof_name nvarchar (50),
   salary money,
)

CREATE TABLE employee(
	id int primary key identity,
	first_name nvarchar(50),
    last_name nvarchar(50),
	birth_date DATE, 
	gender nvarchar (50),
	phone_number char (12),
	email nvarchar (64),
	address_id  INTEGER REFERENCES address_location(id),
	profession_id INTEGER REFERENCES proffesion(id),
	--[role] int
)

CREATE TABLE deliveryman(
	employee_id INTEGER REFERENCES employee(id),
	car_type NVARCHAR(20),
	car_number NVARCHAR(7),
	car_model NVARCHAR(15)
)

CREATE TABLE delivery_status(
    id INT  PRIMARY KEY IDENTITY,
	[name] VARCHAR(11)
);

--INSERT INTO delivery_status(name) VALUES('Done');
--INSERT INTO delivery_status(name) VALUES('In progress');


CREATE TABLE order_status(
    id INT  PRIMARY KEY IDENTITY,
	[name] NVARCHAR(8)
);

--INSERT INTO order_status(name) VALUES('Approved');
--INSERT INTO order_status(name) VALUES('Pending');
--INSERT INTO order_status(name) VALUES('Canceled')

CREATE TABLE [order](
	id INT PRIMARY KEY IDENTITY,
	customer_id INTEGER REFERENCES customer(id),
	delivery_status_id INTEGER REFERENCES delivery_status(id),
	order_status_id INTEGER REFERENCES order_status(id),
	delivery_man_id INTEGER REFERENCES deliveryman(id),
	order_description VARCHAR(255),
	peyment_status BIT DEFAULT 0,
	created_at TIMESTAMP, 
	delivered TIME(7)
)

