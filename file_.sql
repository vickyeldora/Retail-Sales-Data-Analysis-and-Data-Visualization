-- Pembuatan table 1
CREATE TABLE tabel_lengkap (
    id SERIAL PRIMARY KEY,
	Segment INTEGER,
	Country INTEGER,
	Product INTEGER,
	Discount_Band INTEGER,
	Units_Sold FLOAT,
	Manufacturing_Price FLOAT,
	Sale_Price FLOAT,
	Gross_Sales FLOAT,
	Discounts FLOAT,
	Sales FLOAT,
	COGS FLOAT,
	Profit FLOAT,
	Date DATE,
	Month_Number DATE,
	Month_Name VARCHAR(800),
    YEAR INTEGER
);


-- Pengisian value table 1
COPY tabel_lengkap(Segment,
	Country,
	Product,
	Discount_Band,
	Units_Sold ,
	Manufacturing_Price,
	Sale_Price,
	Gross_Sales,
	Discounts,
	Sales,
	COGS,
	Profit,
	Date,
	Month_Number,
	Month_Name,
    YEAR)
FROM 'C:\tmp\tabel_lengkap'
DELIMITER ','
CSV HEADER;


-- Pembuatan table 2-5
CREATE TABLE Segment_table (
    id SERIAL PRIMARY KEY,
	id_segment VARCHAR(100)
);
CREATE TABLE Country_table (
    id SERIAL PRIMARY KEY,
	id_country VARCHAR(100)
);
CREATE TABLE Product_table (
    id SERIAL PRIMARY KEY,
	id_product VARCHAR(100)
);
CREATE TABLE Discount_Band_table (
    id SERIAL PRIMARY KEY,
	id_discount_Band VARCHAR(100)
);


-- Pengisian value table 2-5
COPY Segment_table(id_segment)	
FROM 'C:\tmp\Segment_table'
DELIMITER ','
CSV HEADER;	

COPY Country_table(id_country)	
FROM 'C:\tmp\Country_table'
DELIMITER ','
CSV HEADER;

COPY Product_table(id_product)	
FROM 'C:\tmp\Product_table'
DELIMITER ','
CSV HEADER;

COPY Discount_Band_table(id_discount_Band)	
FROM 'C:\tmp\Discount_Band_table'
DELIMITER ','
CSV HEADER;


-- Pembuatan User
CREATE USER user_baru1 WITH PASSWORD '1234';

CREATE USER user_baru2 WITH PASSWORD '234';


-- User_baru1 = hanya bisa select di semua table
GRANT SELECT ON ALL TABLES
IN SCHEMA public TO user_baru1;


-- user_baru2 = bisa melakukan apa saja di semua table
GRANT ALL PRIVILEGES ON ALL TABLES
IN SCHEMA public TO user_baru2;


-- Mengecek privileges apa saja yang dapat dilakukan user_baru1 pada semua tabel
SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'tabel_lengkap' AND grantee = 'user_baru1';

SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'segment_table' AND grantee = 'user_baru1';

SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'country_table' AND grantee = 'user_baru1';

SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'product_table' AND grantee = 'user_baru1';

SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'discount_band_table' AND grantee = 'user_baru1';


-- Mengecek privileges apa saja yang dapat dilakukan user_baru2 pada semua tabel
SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'tabel_lengkap' AND grantee = 'user_baru2';

SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'segment_table' AND grantee = 'user_baru2';

SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'country_table' AND grantee = 'user_baru2';

SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'product_table' AND grantee = 'user_baru2';

SELECT grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'discount_band_table' AND grantee = 'user_baru2';


-- untuk memlihat user apa yang sekarang digunakan
SELECT current_user;


-- untuk memilih role postgres
SET ROLE postgres;


-- untuk memilih role user_baru1
SET ROLE user_baru1;


-- untuk memilih role user_baru2
SET ROLE user_baru2;


--- PENGUJIAN 1
BEGIN;
copy (
SELECT Segment, SUM(profit) as total_profit
FROM tabel_lengkap
WHERE discounts > 0
GROUP BY 1
ORDER BY 1 asc
)
TO 'C:\tmp\pengujian_1' WITH CSV HEADER;
COMMIT;


--- PENGUJIAN 2
BEGIN;
copy (
SELECT 
	Country,
	AVG(sales) as rata2_sales,
	MIN(sales) as min_sales,
	MAX(sales) as max_sales
FROM tabel_lengkap
GROUP BY 1
ORDER BY 1 asc
)
TO 'C:\tmp\pengujian_2' WITH CSV HEADER;
COMMIT;


-- Cara melihat tabel
SELECT * FROM tabel_lengkap
SELECT * FROM Segment_table
SELECT * FROM Country_table
SELECT * FROM Product_table
SELECT * FROM Discount_Band_table
