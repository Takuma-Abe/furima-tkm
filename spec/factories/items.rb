FactoryBot.define do
  factory :item do
    name { 'サンプル商品' }
    info { 'サンプル商品の説明' }
    price { 1000 }
    category_id { 1 }
    sales_status_id { 1 }
    delivery_fee_payer_id { 1 }
    prefecture_id { 1 }
    delivery_day_id { 1 }
    association :user
    
    after(:build) do |item|
      item.images.attach(io: File.open('public/images/sample.png'), filename: 'sample.png')
    end

    trait :sold_out do
      after(:create) do |item|
        create(:item_transaction, item: item, user: create(:user))
      end
    end
  end
end
1