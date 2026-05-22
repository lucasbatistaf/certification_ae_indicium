# certification_ae_indicium

## Project objectives and Data Modeling

### Objectives

#### BI dashboard

- (Dashboard link)[]

#### Video demonstration
- (Video link)[]

#### Project Questions
Question 1
 - What is the number of orders, quantity purchased, total value negotiated per  product, card type, reason for sale, sale date, customer, status, city, state and country?

Question 2
- Which products have the highest ticket per month, year, city, state and country?
 - Average ticket = (Gross Revenue - product discounts) / number of orders

Question 3
-  What are the 10 best customers by total value negotiated, filtered by product, card type, reason for sale, sale date, status, city, state, and country?

Question 4
- What are the 5 best cities in total value negotiated per product, card type, reason for sale, sale date, customer, status, city, state and country?

Question 5
- What is the number of orders, quantity purchased, total value negotiated per month and year?

Question 6
- Which product has the highest number of units purchased for the "Promotion" sales reason?


## Data Modeling

### Defining the Business Process
- Orders from retail 

### Defining Grain of the Fact Table
- One row per Product per Order

### Identifying the dimensions
- Order Detail (SalesOrderHeader, SalesOrderDetail)
- Product (Product)
- Customer (Person, Store, Customer)
- Sales (SalesOrderHeaderSalesReason, SalesReason, CreditCard)
- Location (Address, StateProvince, CountryRegion)
- Date (month, year)

### Identifying the facts

- Order
    - ProductID
    - OrderID
    - CustomerID
    - SaleReasonID
    - AddressID
    - CreditCardTypeID
    - DateID
    - ProductQuantity
    - ProductPrice
    - ProductDiscount
    - Status (Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled)
    - PersonType (Primary type of person: SC = Store Contact, IN = Individual (retail) customer, SP = Sales person, EM = Employee (non-sales), VC = Vendor contact, GC = General contact)


### dbt Modeling

#### Staging - Bronze Layer
- Customer
    - Customer
    - Person
    - Store
- Location
    - Address
    - Country Region
    - State Province
- Order Detail
    - Credit Card
    - Sales Order Detail
    - Sales Order Header Sales Reason
    - Sales Order Header
    - Sales Reason
- Product
    - Product

#### Intermediate - Silver Layer
- Order
    - Cross joined to reasons

#### Marts - Gold layer

- Fact
    - Orders
- Dimensions
    - Dates
    - Customers
    - Locations
    - Order Details
    - Products