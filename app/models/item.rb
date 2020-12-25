class Item < ApplicationRecord
  # association with other tables ---
  belongs_to :user
  has_one :item_transaction
  has_many :comments

  # active_storage's assciation------
  # has_one_attached :image
  has_many_attached :images
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }

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
    validates :images
    validates :name
    validates :info
    validates :price
  end

  with_options presence: true do {message: "Select"}
    validates :category_id
    validates :sales_status_id
    validates :delivery_fee_payer_id
    validates :prefecture_id
    validates :delivery_day_id
  end

  # check if the price value is half-width and integer
  
  validates :price, numericality: {with: /\A[0-9]+\z/, message: "Half-width number"}
 
  # check if the price is in the range
  validates_inclusion_of :price, in: 300..9_999_999, message: "Out of setting range"

  # check if the select is still in id: 0 whoch is "---"
  # with_options numericality: {other_than: 0, massage: "Select"} do
  #   validates :category_id
  #   validates :sales_status_id
  #   validates :delivery_fee_payer_id
  #   validates :prefecture_id
  #   validates :delivery_day_id
  # end

end
