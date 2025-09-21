# 📖 Data Dictionary: Sales Performance Analysis

**Version**: 1.0  
**Last Updated**: September 2025  
**Data Sources**: PostgreSQL Sales Database  
**Scope**: Sales transactions, customer data, product catalog

---

## 📋 Table of Contents

1. [Overview](#-overview)
2. [Database Schema](#-database-schema)
3. [Primary Tables](#-primary-tables)
4. [Calculated Fields](#-calculated-fields)
5. [Data Types & Formats](#-data-types--formats)
6. [Business Rules](#-business-rules)
7. [Data Quality Standards](#-data-quality-standards)
8. [Lookup Tables](#-lookup-tables)
9. [Change History](#-change-history)

---

## 🎯 Overview

### **Purpose**
This data dictionary provides comprehensive documentation for all data elements used in the Sales Performance Analysis project. It serves as the authoritative reference for data analysts, developers, and business users working with sales data.

### **Data Sources**
- **Primary Source**: PostgreSQL production database
- **Update Frequency**: Real-time for transactional data, daily for aggregated metrics
- **Data Retention**: 5 years of historical data
- **Backup Schedule**: Daily incremental, weekly full backup

### **Data Governance**
- **Data Owner**: Sales Operations Team
- **Data Steward**: Senior Data Analyst
- **Quality Assurance**: Automated daily validation
- **Access Control**: Role-based permissions

---

## 🗄️ Database Schema

### **Entity Relationship Diagram**
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│    customers    │    │    sales_data    │    │    products     │
│─────────────────│    │──────────────────│    │─────────────────│
│ customer_id (PK)│◄───┤ customer_id (FK) │    │ product_id (PK) │
│ customer_name   │    │ product_id (FK)  ├───►│ product_name    │
│ segment         │    │ order_id (PK)    │    │ category        │
│ registration_dt │    │ order_date       │    │ sub_category    │
└─────────────────┘    │ sales            │    │ cost_price      │
                       │ profit           │    └─────────────────┘
                       │ quantity         │
                       │ discount         │
                       │ region           │
                       │ customer_segment │
                       └──────────────────┘
```

### **Schema Statistics**
- **Total Tables**: 8 (3 primary, 5 lookup)
- **Total Columns**: 45 across all tables
- **Primary Keys**: 8
- **Foreign Keys**: 12
- **Indexes**: 23 for performance optimization

---

## 📊 Primary Tables

### **🏪 sales_data** *(Fact Table)*

**Description**: Core transaction data containing all sales records  
**Update Frequency**: Real-time  
**Primary Key**: `order_id`  
**Row Count**: ~500,000 records

| **Column Name** | **Data Type** | **Length** | **Null** | **Description** | **Example** |
|-----------------|---------------|------------|----------|-----------------|-------------|
| `order_id` | VARCHAR | 50 | No | Unique identifier for each order | "CA-2023-152156" |
| `order_date` | DATE | - | No | Date when order was placed | "2023-09-15" |
| `customer_id` | VARCHAR | 20 | No | Unique customer identifier | "CG-12495" |
| `product_id` | VARCHAR | 20 | No | Unique product identifier | "OFF-LA-10000240" |
| `category` | VARCHAR | 50 | No | Product category | "Office Supplies" |
| `sub_category` | VARCHAR | 50 | No | Product sub-category | "Labels" |
| `region` | VARCHAR | 20 | No | Geographic region | "West" |
| `state` | VARCHAR | 30 | No | State/province | "California" |
| `city` | VARCHAR | 50 | No | City name | "Los Angeles" |
| `sales` | DECIMAL | 10,2 | No | Revenue amount in USD | 261.96 |
| `quantity` | INTEGER | - | No | Number of items sold | 2 |
| `discount` | DECIMAL | 3,2 | Yes | Discount percentage (0-1) | 0.00 |
| `profit` | DECIMAL | 10,2 | Yes | Profit amount in USD | 41.91 |
| `customer_segment` | VARCHAR | 20 | No | Customer type | "Consumer" |
| `ship_mode` | VARCHAR | 30 | Yes | Shipping method | "Standard Class" |
| `ship_date` | DATE | - | Yes | Date order was shipped | "2023-09-20" |
| `created_at` | TIMESTAMP | - | No | Record creation timestamp | "2023-09-15 10:30:45" |
| `updated_at` | TIMESTAMP | - | Yes | Last update timestamp | "2023-09-15 10:30:45" |

### **👥 customers** *(Dimension Table)*

**Description**: Customer master data and demographics  
**Update Frequency**: Daily  
**Primary Key**: `customer_id`  
**Row Count**: ~15,000 records

| **Column Name** | **Data Type** | **Length** | **Null** | **Description** | **Example** |
|-----------------|---------------|------------|----------|-----------------|-------------|
| `customer_id` | VARCHAR | 20 | No | Unique customer identifier | "CG-12495" |
| `customer_name` | VARCHAR | 100 | No | Full customer name | "Claire Gute" |
| `segment` | VARCHAR | 20 | No | Customer segment | "Consumer" |
| `country` | VARCHAR | 50 | No | Country name | "United States" |
| `city` | VARCHAR | 50 | No | Customer city | "Henderson" |
| `state` | VARCHAR | 30 | No | Customer state | "Kentucky" |
| `postal_code` | VARCHAR | 10 | Yes | ZIP/postal code | "42420" |
| `registration_date` | DATE | - | Yes | Customer registration date | "2020-01-15" |
| `phone` | VARCHAR | 20 | Yes | Contact phone number | "+1-502-555-0123" |
| `email` | VARCHAR | 100 | Yes | Email address | "claire.gute@email.com" |
| `is_active` | BOOLEAN | - | No | Active customer flag | TRUE |
| `created_at` | TIMESTAMP | - | No | Record creation timestamp | "2020-01-15 09:15:30" |
| `updated_at` | TIMESTAMP | - | Yes | Last update timestamp | "2023-08-20 14:22:10" |

### **📦 products** *(Dimension Table)*

**Description**: Product catalog with pricing and categorization  
**Update Frequency**: Weekly  
**Primary Key**: `product_id`  
**Row Count**: ~3,000 records

| **Column Name** | **Data Type** | **Length** | **Null** | **Description** | **Example** |
|-----------------|---------------|------------|----------|-----------------|-------------|
| `product_id` | VARCHAR | 20 | No | Unique product identifier | "OFF-LA-10000240" |
| `product_name` | VARCHAR | 200 | No | Full product name | "Self-Adhesive Address Labels" |
| `category` | VARCHAR | 50 | No | Product category | "Office Supplies" |
| `sub_category` | VARCHAR | 50 | No | Product sub-category | "Labels" |
| `manufacturer` | VARCHAR | 100 | Yes | Product manufacturer | "Avery" |
| `cost_price` | DECIMAL | 10,2 | Yes | Product cost in USD | 3.60 |
| `list_price` | DECIMAL | 10,2 | No | Standard selling price | 5.28 |
| `weight_kg` | DECIMAL | 8,3 | Yes | Product weight in kg | 0.045 |
| `dimensions` | VARCHAR | 50 | Yes | Product dimensions | "10x8x2 cm" |
| `is_active` | BOOLEAN | - | No | Active product flag | TRUE |
| `launch_date` | DATE | - | Yes | Product launch date | "2018-03-01" |
| `discontinue_date` | DATE | - | Yes | Product discontinuation date | NULL |
| `created_at` | TIMESTAMP | - | No | Record creation timestamp | "2018-03-01 08:00:00" |
| `updated_at` | TIMESTAMP | - | Yes | Last update timestamp | "2023-09-10 16:45:00" |

---

## 🧮 Calculated Fields

### **Business Metrics** *(Derived in Analysis)*

| **Field Name** | **Formula** | **Data Type** | **Description** | **Usage** |
|----------------|-------------|---------------|-----------------|-----------|
| `profit_margin` | `profit / sales * 100` | DECIMAL(5,2) | Profit as percentage of sales | Performance analysis |
| `revenue_per_item` | `sales / quantity` | DECIMAL(10,2) | Average revenue per unit | Pricing analysis |
| `discount_amount` | `sales * discount / (1 - discount)` | DECIMAL(10,2) | Dollar amount of discount | Promotional impact |
| `cost_of_goods` | `sales - profit` | DECIMAL(10,2) | Total cost of products sold | Margin analysis |
| `days_to_ship` | `ship_date - order_date` | INTEGER | Shipping time in days | Logistics analysis |

### **Time-Based Fields** *(Extracted from order_date)*

| **Field Name** | **Formula** | **Data Type** | **Description** | **Example** |
|----------------|-------------|---------------|-----------------|-------------|
| `year` | `EXTRACT(YEAR FROM order_date)` | INTEGER | Year of transaction | 2023 |
| `quarter` | `EXTRACT(QUARTER FROM order_date)` | INTEGER | Quarter (1-4) | 3 |
| `month` | `EXTRACT(MONTH FROM order_date)` | INTEGER | Month (1-12) | 9 |
| `month_name` | `TO_CHAR(order_date, 'Month')` | VARCHAR(10) | Month name | "September" |
| `day_of_week` | `EXTRACT(DOW FROM order_date)` | INTEGER | Day of week (0-6) | 5 |
| `day_name` | `TO_CHAR(order_date, 'Day')` | VARCHAR(10) | Day name | "Friday" |
| `week_number` | `EXTRACT(WEEK FROM order_date)` | INTEGER | Week of year (1-53) | 37 |
| `is_weekend` | `EXTRACT(DOW FROM order_date) IN (0,6)` | BOOLEAN | Weekend flag | FALSE |

### **Customer Analytics** *(Aggregated Metrics)*

| **Field Name** | **Calculation Level** | **Data Type** | **Description** | **Business Value** |
|----------------|---------------------|---------------|-----------------|-------------------|
| `customer_ltv` | Customer | DECIMAL(10,2) | Customer lifetime value | Investment decisions |
| `avg_order_value` | Customer | DECIMAL(10,2) | Average order size | Customer segmentation |
| `order_frequency` | Customer | DECIMAL(5,2) | Orders per time period | Loyalty analysis |
| `days_since_last_order` | Customer | INTEGER | Recency metric | Churn prediction |
| `total_orders` | Customer | INTEGER | Order count | Customer ranking |
| `customer_age_days` | Customer | INTEGER | Days since first order | Lifecycle analysis |

---

## 📝 Data Types & Formats

### **Standard Data Types**

| **Type** | **Format** | **Range/Length** | **Example** | **Usage** |
|----------|------------|------------------|-------------|-----------|
| **VARCHAR(n)** | Text string | 1 to n characters | "Office Supplies" | Names, categories |
| **DECIMAL(