class TransactionsController < ApplicationController
  before_action :select_item, only: [:index, :create]
  before_action :authenticate_user!, only: [:index]
  def index
    return redirect_to root_path if current_user.id == select_item.user_id || select_item.item_transaction != nil
    @item_transaction = PayForm.new
    
  end

  def create
    @item_transaction = PayForm.new(item_transaction_params)
    if @item_transaction.valid?
      pay_item
      @item_transaction.save
      return redirect_to root_path
    end
    render 'index'
  end

  private

  def select_item
    @item = Item.find(params[:item_id])
  end

  def item_transaction_params
    params.permit(
      :item_id,
      :postal_code,
      :prefecture,
      :city,
      :addresses,
      :building,
      :token,
      :phone_number
    ).merge(user_id: current_user.id)
  end

  def pay_item
    # credentialsの記述に変更（ENV['PAYJP_SECRET_KEY']）
    # Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]

    Payjp::Charge.create(
      amount: @item.price,
      card: item_transaction_params[:token],
      currency: 'jpy'
    )
  end
end
