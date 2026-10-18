--SQL для БД ClickHouse

CREATE DATABASE IF NOT EXISTS raw_vault;


CREATE TABLE IF NOT EXISTS raw_vault.hub_customer
(
    customer_hk     FixedString(16),
    customer_bk     String,
    load_dts        DateTime,
    record_source   String
)
ENGINE = ReplacingMergeTree(load_dts)
ORDER BY customer_hk;

CREATE TABLE IF NOT EXISTS raw_vault.hub_product
(
    product_hk      FixedString(16),
    product_bk      String,
    load_dts        DateTime,
    record_source   String
)
ENGINE = ReplacingMergeTree(load_dts)
ORDER BY product_hk;

CREATE TABLE IF NOT EXISTS raw_vault.hub_order
(
    order_hk        FixedString(16),
    order_bk        String,
    load_dts        DateTime,
    record_source   String
)
ENGINE = ReplacingMergeTree(load_dts)
ORDER BY order_hk;


CREATE TABLE IF NOT EXISTS raw_vault.link_order_customer
(
    link_hk         FixedString(16),
    order_hk        FixedString(16),
    customer_hk     FixedString(16),
    load_dts        DateTime,
    record_source   String
)
ENGINE = ReplacingMergeTree(load_dts)
ORDER BY link_hk;

CREATE TABLE IF NOT EXISTS raw_vault.link_order_product
(
    link_hk         FixedString(16),
    order_hk        FixedString(16),
    product_hk      FixedString(16),
    sales           Decimal(18, 4),
    quantity        UInt32,
    discount        Decimal(18, 4),
    profit          Decimal(18, 4),
    load_dts        DateTime,
    record_source   String
)
ENGINE = ReplacingMergeTree(load_dts)
ORDER BY link_hk;


CREATE TABLE IF NOT EXISTS raw_vault.sat_customer_details
(
    customer_hk     FixedString(16),
    load_dts        DateTime,
    hash_diff       FixedString(16),
    customer_name   String,
    segment         LowCardinality(String),
    country         LowCardinality(String),
    city            String,
    state           String,
    postal_code     String,
    region          LowCardinality(String),
    record_source   String
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(load_dts)
ORDER BY (customer_hk, load_dts);

CREATE TABLE IF NOT EXISTS raw_vault.sat_product_details
(
    product_hk      FixedString(16),
    load_dts        DateTime,
    hash_diff       FixedString(16),
    category        LowCardinality(String),
    sub_category    LowCardinality(String),
    product_name    String,
    record_source   String
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(load_dts)
ORDER BY (product_hk, load_dts);

CREATE TABLE IF NOT EXISTS raw_vault.sat_order_details
(
    order_hk        FixedString(16),
    load_dts        DateTime,
    hash_diff       FixedString(16),
    order_date      Date,
    ship_date       Date,
    ship_mode       LowCardinality(String),
    record_source   String
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(load_dts)
ORDER BY (order_hk, load_dts);
