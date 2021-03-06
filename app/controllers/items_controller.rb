class ItemsController < ApplicationController
  before_action :select_item, only: [:show, :edit, :update, :destroy, :purchase_confirm, :purchase]
  before_action :set_item_form, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :purchase_confirm, :purchase]
  before_action :sold_item, only: [:purchase_confirm, :purchase]
  before_action :current_user_has_no_card, only: [:purchase_confirm, :purchase]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid?
      @item_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    # 実装条件 ：ログイン状態の出品者だけが商品情報編集ページに遷移できること
    @item_form.tag_name = @item.tags.first&.name
    if current_user.id != @item.user.id
      redirect_to root_path
    end 
  end

  def update
    render 'edit' unless current_user.id == @item.user.id
    binding.pry
    if @item_form.update(item_form_params, @item)
        redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def show
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

  def destroy
    if current_user.id == @item.user.id
      @item.destroy
      redirect_to root_path 
    end
  end

  def purchase_confirm
    @address = Address.new
  end


  def purchase
    # binding.pry
    item_transaction = ItemTransaction.new(item_id: @item.id, user_id: current_user.id)

    @address = item_transaction.build_address(address_params)
    if @address.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
        Payjp::Charge.create(
          amount: @item.price,
          customer: current_user.card.customer_token,
          currency:'jpy'
        )
      @address.save
      redirect_to root_path
    else
      redirect_to purchase_confirm_item_path(@item)
    end
  end

  def search
    if params[:q]&.dig(:name)
      squished_keywords = params[:q][:name].squish
      params[:q][:name_cont_any] = squished_keywords.split(" ")
    end
    @q = Item.ransack(params[:q])
    @items = @q.result
  end
  
  private

  def address_params
    params.permit(
      :postal_code,
      :prefecture,
      :city,
      :addresses,
      :building,
      :phone_number
    )
  end

  def item_form_params
    params.require(:item_form).permit(
      :name,
      :info,
      :category_id,
      :tag_name,
      :delivery_day_id,
      :sales_status_id,
      :delivery_fee_payer_id,
      :prefecture_id,
      :price,
      {images: []} 
    ).merge(user_id: current_user.id)
  end

  def select_item
    @item = Item.find(params[:id])
  end

  def set_item_form
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
  end

  def sold_item
    redirect_to item_path(@item), alert: "売り切れの商品です" if @item.item_transaction.present?
  end

  def current_user_has_no_card
    redirect_to new_card_path, alert: "クレジットカードが登録されていません" unless current_user.card.present?
   end
end


# paramsハッシュ一致してるか確認するべき場所: controller, model, migration(DB内のカラム名)
# 