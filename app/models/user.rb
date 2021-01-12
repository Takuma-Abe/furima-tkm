class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: { case_sensitive: true }

  validates :birthday, presence: true

  # 英数字混在を否定
  PASSWROD_REGEX = /\A(?=..*?[a-z])(?=..*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWROD_REGEX, messages: 'You must include both letters and numbers'

  # 全角ひらがな、漢字を使用していないかを確認
  with_options presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' } do
    validates :first_name
    validates :last_name
  end
  # 全角のカタカナを使用していないか検証
  with_options presence: true, format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/, message: 'Full-width katakana characters'} do
    validates :first_name_reading
    validates :last_name_reading
  end
  # アソシエーション
  has_many :items
  has_many :item_transaction
  has_one :card, dependent: :destroy
  has_one :address_preset, dependent: :destroy
end
