class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    # binding.pry
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    # 実装条件 ：ログイン状態の出品者だけが商品情報編集ページに遷移できること
    if current_user.id != @item.user.id
      redirect_to root_path
    end 
  end

  def update
    # binding.pry
    @item = Item.find(params[:id])
    if current_user.id == @item.user.id
      if @item.update(item_params)
        redirect_to item_path 
      end 
    else
      render 'edit'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :info,
      :category_id,
      :delivery_day_id,
      :sales_status_id,
      :delivery_fee_payer_id,
      :prefecture_id,
      :price
    ).merge(user_id: current_user.id)
  end

end


# paramsハッシュ一致してるか確認するべき場所: controller, model, migration(DB内のカラム名)
# 