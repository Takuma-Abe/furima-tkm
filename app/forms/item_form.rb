class ItemForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :name, :string
  attribute :info, :string
  attribute :category_id, :big_integer
  attribute :sales_status_id, :big_integer
  attribute :delivery_day_id, :big_integer
  attribute :prefecture_id, :big_integer
  attribute :delivery_fee_payer_id, :big_integer
  attribute :price, :integer
  attribute :images, :binary
  attribute :user_id, :big_integer

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
    item = Item.new(
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