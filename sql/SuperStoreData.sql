CREATE DATABASE SuperstoreSalesData;

DROP TABLE IF EXISTS superstore;
DROP TABLE IF EXISTS superstore_staging;

-- Create staging table
CREATE TABLE superstore_staging (
    row_id VARCHAR(50),
    order_id VARCHAR(50),
    order_date VARCHAR(50),
    ship_date VARCHAR(50),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(50),
    postal_code VARCHAR(50),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(200),
    sales VARCHAR(50),
    quantity VARCHAR(50),
    discount VARCHAR(50),
    profit VARCHAR(50)
);

-- Copy data into staging table
COPY superstore_staging FROM 'C:\\Users\\marcel\\Documents\\Data Analysis Projects\\Sales Perfomance Analysis\\Data\\raw\\Superstore.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    ENCODING 'WIN1252'
);

-- Create final table
CREATE TABLE superstore (
    row_id INTEGER,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(50),
    postal_code INTEGER,
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(200),
    sales DECIMAL(10,2),
    quantity INTEGER,
    discount DECIMAL(5,4),
    profit DECIMAL(10,2)
);

-- Insert data from staging table into final table with date conversion
INSERT INTO superstore (
    row_id, order_id, order_date, ship_date, ship_mode,
    customer_id, customer_name, segment, country, city,
    state, postal_code, region, product_id, category,
    sub_category, product_name, sales, quantity, discount, profit
)
SELECT
    CAST(row_id AS INTEGER),
    order_id,
    TO_DATE(order_date, 'MM/DD/YYYY'),
    TO_DATE(ship_date, 'MM/DD/YYYY'),
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    CAST(postal_code AS INTEGER),
    region,
    product_id,
    category,
    sub_category,
    product_name,
    CAST(sales AS DECIMAL(10,2)),
    CAST(quantity AS INTEGER),
    CAST(discount AS DECIMAL(5,4)),
    CAST(profit AS DECIMAL(10,2))
FROM superstore_staging;

-- Optionally drop the staging table after successful data insertion
DROP TABLE superstore_staging;


SELECT * FROM superstore LIMIT 100;