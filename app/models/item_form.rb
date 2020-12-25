class ItemForm
  include ActiveModel::Model
  attr_accessor(
                :name, :info, :category_id, :sales_status_id,
                :delivery_day_id, :prefecture_id, :delivery_fee_payer_id,
                :price, :images, :user_id
                )

  with_options presence: true do
    validates :images
    validates :name
    validates :info
    validates :price
  end

  # check if the price value is half-width and integer

  validates :price, numericality: {with: /\A[0-9]+\z/, message: "Half-width number"}

  # check if the price is in the range
  validates_inclusion_of :price, in: 300..9_999_999, message: "Out of setting range"
  
  def save
    item = Item.neww(
      name: name,
      info: info,
      category_id: category_id,
      sales_status_id: sales_status_id,
      delivery_day_id: delivery_day_id,
      prefecture_id: prefecture_id,
      delivery_fee_payer_id: delivery_fee_payer_id,
      price: price, 
      user_id: user_id,
      images: images
    )
    item.save
  end
end