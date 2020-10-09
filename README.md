# README

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

* users
|column|type|optiom|
|------|----|------|
|first name|string|not null|
|last name|string|not null|
|nickname|string|not null|
|email|string|not null|
|first name reading|string|not null|
|last name reading|string|not null|
|birthday|date|not null|

## Association
has_many :items
has_one :card dependent destroy

* items
|column|type|optiom|
|------|----|------|
|name|string|not null|
|price|integer|not null|
|detail|text|not null|
|condition|integer|not null|
|category_id|references|not null|
|user_id|references|not null|
|delivery_fee_payer|integer|not null| *
|delivery_method|integer|not null| *
|delivery_day|integer|not null| *
|prefecture_id|integer|-----| *
＊ユーザー管理機能実装時点でまだ不明

## Association
belongs_to :user
belomgs_to :category

* images (using active_storage) 
|column|type|optiom|
|------|----|------|
|src|text|not null|
|item|references|not null|

## Association
belongs_to :item


* categries (using active_hash)
|column|type|optiom|
|------|----|------|
|name|string|not null|
|item_id|references|not null|

## Association
has_many :items

* cards
|column|type|optiom|
|------|----|------|
|customer_token|string|not null|
|card_token|string|not mull|
|user_id|references|not null|

## Association
belongs_to :user

<!-- *
|column|type|optiom|
|------|----|------|
||||

##Association -->