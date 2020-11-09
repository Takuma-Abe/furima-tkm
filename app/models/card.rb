class Card < ApplicationRecord
  belongs_to :user

  validates :card_token, :customer_token, presemce: true
end
