
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # ユーザーログイン済かチェックする
  before_action :user_signed_in?

  private

  # ユーザログイン済か確認
  def user_signed_in?
    unless session[:user_id]
      redirect_to "/user/login", alert: "ログインしてください。"
    end
    return
  end
end
