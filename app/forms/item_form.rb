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
  attribute :tag_name, :string
  

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
    binding.pry
    tag_name = params.delete(:tag_name)
    if tag_name.present?
    tag = Tag.where(name: tag_name).first_or_initialize
    end
    ActiveRecord::Base.transaction do
      if tag_name.present?
        item.update!(params)
        item.item_eq_relations.destroy_all
        if tag_name.present?
        item.tags << tag
        end
        return true
      end
      rescue => e
      if tag&.errors&.messages&.present?
      tag.errors.messages[:tag_name] = tag.errors.messages.delete(:name)
      end
      item&.errors&.messages&.each do |key, message|
        self.errors.add(key, message.first)
      end
      return false
    end
  end
end