class Item < ApplicationRecord
  # association with other tables ---
  belongs_to :user
  has_one :item_order

  # active_storage's assciation------
  has_one_attached :image

  # active_hash's assciation---------
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :delivery_fee_payer
  belongs_to_active_hash :sales_status

  # Validation-----------------------

  # chech if these value are presence or not
  with_options presence: true do
    validates :image   
    validates :name
    validates :info
    validates :price
  end

  # check if the price value is half-width and integer
  
  validates :price, numericality: {with: /\A[0-9]+\z/, message: "Half-width number"}

  # check if the price is in the range
  validates_inclusion_of :price, in: 300..9_999_999, message: "Out of setting range"

  # check if the select is still in id: 0 whoch is "---"
  with_options numericality: {other_than: 0, massage: "Select"}do
    validates :category_id
    validates :sales_status_id
    validates :delivery_fee_payer_id
    validates :prefecture_id
    validates :delivery_day_id
  end

end