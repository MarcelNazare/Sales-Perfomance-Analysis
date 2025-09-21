CREATE DATABASE SuperstoreSalesData;

DROP TABLE sales;

CREATE TABLE sales(
    "Row ID" VARCHAR(15),
    "Order ID" VARCHAR(15),
    "Order Date" DATE,
    "Ship Date" DATE,
    "Ship Mode" VARCHAR(15),
    "Customer ID" VARCHAR(15),
    "Customer Name" VARCHAR(255),
    "Segment" VARCHAR(255),
    "Country" VARCHAR(255),
    "City" VARCHAR(255),
    "State" VARCHAR(255),
    "Postal Code" VARCHAR(255),
    "Region" VARCHAR(255),
    "Product ID" VARCHAR(255),
    "Category" VARCHAR(255),
    "Sub-Category" VARCHAR(255),
    "Product Name" VARCHAR(255),
    "Sales" VARCHAR(255),
    "Quantity" INT,
    "Discount" FLOAT,
    "Profit" FLOAT
);