class User::UsersController < ApplicationController
  skip_before_action :user_signed_in?, only: [ :new, :create, :login, :auth ]
  # ユーザー登録画面を表示するアクション
  def new
  end

  # ユーザー登録処理を行うアクション
  # post /user/users
  def create
    # ユーザー登録のパラメータを取得
    name = params[:name]
    password = params[:password]
    repeat_password = params[:repeat_password]
    birth_date = params[:birth_date]

    # リピートパスワードのバリデーション
    errors = {}
    if repeat_password.blank?
      errors[:repeat_password] = "パスワードとパスワードは一致しません。"
      flash[:errors] = errors
      Rails.logger.debug "error:#{errors}, repeat_password:#{repeat_password}"
      render :new, status: :unprocessable_entity
      return
    end

    # リピートパスワードとパスワードの一致確認
    if password != repeat_password
      errors[:repeat_password] = "パスワードとパスワードは一致しません。"
      flash[:errors] = errors
      Rails.logger.debug "error:#{errors}"
      render :new, status: :unprocessable_entity
    end

    # ユーザー登録処理を実行
    begin
      create_user_service = User::CreateUserService.new
      create_user_result = create_user_service.create_user(name, password, birth_date)
      flash[:success] = "ユーザー登録が完了しました。"
      Rails.logger.debug "flash:#{flash}"
      redirect_to "/user/new", flash: { success: flash[:success] }
    rescue User::CannotCreateException => e
      # ユーザー登録に失敗した場合、エラーメッセージを取得
      errors = e.validate_errors
      flash[:errors] = errors
      Rails.logger.debug "error:#{flash[:errors]}"
      render :new, status: :unprocessable_entity
    end
  end

  # ユーザーログイン画面を表示するアクション
  # get /user/login
  def login
  end

  # ユーザーログイン処理を行うアクション
  # post /user/auth
  def auth
    # ユーザーログインのパラメータを取得
    name = params[:name]
    password = params[:password]

    auth_user_service = User::AuthUserService.new
    user = auth_user_service.user_authenticated?(name, password)

    if user.nil?
      # 認証失敗
      flash[:error] = "ユーザー名またはパスワードが間違っています。"
      Rails.logger.debug "ログインに失敗しました。flash:#{flash[:error]}"
      render :login, status: :unprocessable_entity
    end
    # 認証成功
    flash[:success] = "ログインに成功しました。"
    Rails.logger.debug "ログインに成功しました: flash:#{flash}"
    session[:user_id] = user.user_id
    session[:user_name] = user.name
    redirect_to "/task/list"
  end

  def logout
    # セッションをクリアしてログアウト
    session[:user_id] = nil
    session[:user_name] = nil
    flash[:success] = "ログアウトしました。"
    Rails.logger.debug "flash:#{flash}"
    redirect_to "/user/login"
  end
end
