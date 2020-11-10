class ItemsController < ApplicationController
  before_action :select_item, only: [:show, :edit, :update, :destroy, :purchase_confirm]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :purchase_confirm]
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
    # 実装条件 ：ログイン状態の出品者だけが商品情報編集ページに遷移できること
    if current_user.id != @item.user.id
      redirect_to root_path
    end 
  end

  def update
    if current_user.id == @item.user.id
      if @item.update(item_params)
        redirect_to item_path 
      end 
    else
      render 'edit'
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

  def purchase_item
    @address = Address.new
  end

  def purchase
    item_transaction.new(item_id: @item.id, user_id: current_user.id)

    @address = item_transaction.build_address(address_params)
    if @address.valid?
  end
  private

  def item_params
    params.require(:item).permit(
      :name,
      :info,
      :category_id,
      :delivery_day_id,
      :sales_status_id,
      :delivery_fee_payer_id,
      :prefecture_id,
      :price,
      images: [] 
    ).merge(user_id: current_user.id)
  end

  def select_item
    @item = Item.find(params[:id])
  end

end


# paramsハッシュ一致してるか確認するべき場所: controller, model, migration(DB内のカラム名)
# 