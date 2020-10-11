- # README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* users table
|column|type|optiom|
|------|----|------|
|nickname (devise default)|string|null: false|
|email(devise default)|string|null: false|
|encrypted_password (devise default)|integer|null: false|
|first name|string|null: false|
|last name|string|null: false|
|first name reading|string|null: false|
|last name reading|string|null: false|
|birthday|date|null: false|

## Association
has_many :items
has_many :item_transactions
* items table
|column|type|optiom|
|------|----|------|
|name|string|null: false|
|price|integer|null: false|
|info|text|null: false|
|delivery_fee_payer_id(active_hash)|integer|null: false| 
|delivery_method_id(active_hash)|integer|null: false| 
|delivery_day_id(active_hash)|integer|null: false| 
|category_id(active_hash)|integer|null: false|
|user_id|references/integer|foreign_key: true|

## Association
has_many :items
has_one :item_transaction

* addresses table
|column|type|optiom|
|------|----|------|
|postal_code|string|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|phone_number|string|null: false|
|item_transaction_id(FK)|references/integer|foreign_key: true|

## Association
belongs_to :item_transactionuser

* item_transactions table
column|type|optiom|
|------|----|------|
|item_id|references/integer|foreign_key: true|
|user_id|references/integer|foreign_key: true|

## Association
belongs_to :item
belongs_to :user
has_one: address