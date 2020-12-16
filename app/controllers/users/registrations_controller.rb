class Users::RegistrationsController < Devise::RegistrationsController
  
  def create # for 1st page : make user instance -> judge by valid -> setting session 
    @user = User.new(sign_up_params)
  unless @user.valid?
    render :new and return
  end
  session["devise.regist_data"] = {user: @user.attributes}
  session["devise.regist_data"][:user]["password"] = params[:user][:password]
  @address_preset = @user.build_address_preset
  render :new_address_preset
  end

  def create_address_preset # for 2nd page: remake @user -> make address instance
    @user = User.new(session["devise.regist_data"]["user"])
    @address_preset = AddressPreset.new(address_preset_params)
    @user.build_address_preset(@address_preset.attributes)
    unless @user.valid?
      render :new_address_preset and return
    end
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end
  
  private

  def address_preset_params
    params.require(:address_preset).permit(:postal_code, :prefecture, :city, :addresses, :building, :phone_number)
  end

  def session_has_not_user_data
      redirect_to root_path, alert: "ユーザー情報がありません" unless session["devise.regist_data"]
  end
end



# session深堀
# rails上にsessionというメソッドがすでに存在している
# 左辺にsession内のキーを作成し、右辺にparamsに乗ってきた値を取得する記述を行う
# ex) session[:nickname] = params[:user][:nickname]
#"devise.regist_data"-> devise側で用意された変数。
# -> "devise.regist_data"はdeviseが落ちたときに自動的にセッションを切る機能を持っている
# -> attributesメソッドでのデータ整形した際PWD情報は含まれないため、PWDを再度sessionに入れる必要がある
# 