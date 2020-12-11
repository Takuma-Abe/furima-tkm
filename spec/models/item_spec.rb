require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: user.id)
  end
  describe '商品作成' do
    context '内容に問題ない場合' do
      it '全て正常' do
        expect(@item.valid?).to eq true
      end
    end
    context '内容に問題がある場合' do
      it 'image:必須' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Images can't be blank")
      end
      it 'name:必須' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'info:必須' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it 'price:必須' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'price:半角数字' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width number")
      end
      it 'price:範囲指定' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end
      it 'price:範囲指定' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end
      it 'category_id:0以外' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end
      it 'sales_status_id:0以外' do
        @item.sales_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status must be other than 0")
      end
      it 'shipping_fee_status_id:0以外' do
        @item.delivery_fee_payer_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee payer must be other than 0")
      end
      it 'prefecture_id:0以外' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 0")
      end
      it 'scheduled_delivery_id:0以外' do
        @item.delivery_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day must be other than 0")
      end
    end
  end
end