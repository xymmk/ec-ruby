class User::UsersController < ApplicationController
  # ユーザー登録画面を表示するアクション
  def new
  end

  # ユーザー登録処理を行うアクション
  # post /user/users/create
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
    elsif password != repeat_password
      errors[:repeat_password] = "パスワードとパスワードは一致しません。"
      flash[:errors] = errors
      Rails.logger.debug "error:#{errors}"
      render :new, status: :unprocessable_entity
      return
    end

    # ユーザー登録処理を実行
    create_user_service = User::CreateUserService.new
    create_user_result = create_user_service.create_user(name, password, birth_date)
    
    # ユーザー登録の結果を確認し、成功した場合はリダイレクト、失敗した場合はエラーメッセージを表示
    if create_user_result[:success]
      flash[:success] = "ユーザー登録が完了しました。"
      Rails.logger.debug "flash:#{flash}"
      redirect_to "/user/users/new", flash: { success: flash[:success] }
      return
    else
      errors = create_user_result[:errors]
      flash[:errors] = errors
      Rails.logger.debug "error:#{flash[:errors]}"
      render :new, status: :unprocessable_entity
      return
    end
  end

end
