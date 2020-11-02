FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    password { '1a' + Faker::Internet.password(min_length: 7, max_length: 20) }
    email { Faker::Internet.email }
    # 誕生日は一意性ではないよ
    birthday { Faker::Date.between_except(from: 20.year.ago, to: 1.year.from_now, excepted: Date.today) }
    last_name { '田中' }
    first_name { '太郎' }
    last_name_reading { 'タナカ' }
    first_name_reading { 'タロウ' }
  end
end
