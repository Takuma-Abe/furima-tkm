class Tag < ApplicationRecord
  validates :name, presence: true, uniqueless: true, length: { maximum: 5 }

  has_many :item_tag, dependent: :destroy
  has_many :items, through: :item_tags
end
