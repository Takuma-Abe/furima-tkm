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
  attribute :tag_name, :string
  attribute :id, :integer
  attribute :created_at, :datetime
  attribute :updated_at, :datetime
  

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

    if self.tag_name.present?
      # using where method to find tag by name if the name is already exist or not by using first_or_initialize
      tag = Tag.where(name: self.tag_name).first_or_initialize
      # put "tag" which has the result of the above code into item.tags
      item.tags << tag
    end
    item.save
  end

  def update(params, item)
    tag_name = params.delete(:tag_name)
    tag = Tag.where(name: tag_name).first_or_initialize if tag_name.present?
    ActiveRecord::Base.transaction do
      tag.save if tag_name.present?
        item.update!(params)
        binding.pry
        item.item_tags.destroy_all
        item.tags << tag if tag_name.present?
        return true
      end
      rescue => e
        tag.errors.messages[:tag_name] = tag.errors.messages.delete(:name) if tag&.errors&.messages&.present?
      item&.errors&.messages&.each do |key, message|
        self.errors.add(key, message.first)
      end
      tag&.errors&.messages&.each do |key, message|
        self.errors.add(key, message.first)
      end
      return false
    end
end