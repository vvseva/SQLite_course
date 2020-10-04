CREATE TABLE IF NOT EXISTS orderitem(
   order_id INT    PRIMARY KEY    NOT NULL,
   product_name     TEXT    NOT NULL,
   amount  INT  NOT NULL  DEFAULT 1 CHECK(amount > 0)
);

CREATE TABLE IF NOT EXISTS Orders(
    o_id INT  PRIMARY KEY    NOT NULL,
    order_date TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS product(
    p_name TEXT  PRIMARY KEY    NOT NULL,
    price NUMERIC NOT NULL
);
