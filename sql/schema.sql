CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR (100) NOT NULL,
  email VARCHAR (250) UNIQUE,
  country VARCHAR (50),
  signup_date TIMESTAMP NOT NULL
);

CREATE TABLE suppliers (
  supplier_id INT PRIMARY KEY,
  supplier_name VARCHAR (250) NOT NULL,
  supplier_country VARCHAR (50)
);

CREATE TABLE warehouses (
  warehouse_id INT PRIMARY KEY,
  warehouse_name VARCHAR(100) NOT NULL,
  location VARCHAR (250)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR (100) NOT NULL,
  category VARCHAR (100) NOT NULL,
  price DECIMAL (10, 2) NOT NULL CHECK (price >= 0),
  cost DECIMAL (10, 2) CHECK (cost >= 0),
  supplier_id INT NOT NULL,
  FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id)
);

CREATE TABLE inventory(
  inventory_id INT PRIMARY KEY,
  product_id INT NOT NULL,
  warehouse_id INT NOT NULL,
  stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
  last_restock_date DATE,
  UNIQUE (product_id, warehouse_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouses (warehouse_id)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date TIMESTAMP NOT NULL,
  order_status VARCHAR (20) NOT NULL,
    CHECK (order_status IN ('pending','shipped','delivered','cancelled','unverified')),
  payment_method VARCHAR (50) NOT NULL,
    CHECK (payment_method IN ('credit_card','paypal','bank_transfer','cash')),
  FOREIGN KEY (customer_id) REFERENCES customers (customer_id) 
);

CREATE TABLE order_details (
  order_detail_id INT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
  discount DECIMAL (5, 2) NOT NULL DEFAULT 0 CHECK (discount >= 0),
  unit_price DECIMAL (10, 2) NOT NULL CHECK (unit_price >= 0),
  FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products (product_id)
);
