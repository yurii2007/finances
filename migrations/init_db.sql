CREATE DATABASE finances;

CREATE TYPE transaction_type_enum AS ENUM ('INCOME', 'EXPENSE');

CREATE TYPE user_role_enum AS ENUM ('OWNER', 'CONTRIBUTOR');

CREATE TABLE
    products (
        id SERIAL NOT NULL PRIMARY KEY UNIQUE,
        label varchar(255),
        price int NOT NULL,
        quantity int DEFAULT 1
    );

CREATE TABLE
    receipts (
        id SERIAL NOT NULL PRIMARY KEY UNIQUE,
        overal_price INT NOT NULL,
        created_at timestamp DEFAULT current_timestamp,
        products SERIAL references products (id)
    );

CREATE TABLE
    transactions (
        id SERIAL NOT NULL PRIMARY KEY references receipts (id),
        created_at timestamp DEFAULT current_timestamp,
        transaction_type transaction_type_enum
    );

CREATE TABLE
    users (
        id SERIAL NOT NULL PRIMARY KEY,
        email varchar(255) UNIQUE,
        display_name varchar(255),
        user_role user_role_enum,
        joined_at timestamp DEFAULT current_timestamp
    );

CREATE TABLE
    accounts (
        id SERIAL NOT NULL PRIMARY KEY,
        balance INT NOT NULL DEFAULT 0,
        transactions SERIAL references transactions (id),
        created_at timestamp DEFAULT current_timestamp
    );

CREATE TABLE
    accounts_users (
        account_id SERIAL references accounts (id) ON DELETE CASCADE,
        user_id SERIAL references users (id) ON DELETE CASCADE,
        PRIMARY KEY (account_id, user_id)
    );

CREATE TABLE
    product_categories (
        id SERIAL NOT NULL PRIMARY KEY,
        category_name varchar(255),
        color varchar(255),
        created_by SERIAL references users (id),
        CONSTRAINT fk_catogires_user CHECK (
            created_by IS NULL
            OR created_by > 0
        )
    );