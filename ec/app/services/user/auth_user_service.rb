require 'bcrypt'
# ユーザー認証サービス
class User::AuthUserService
    def initialize
        user_repository = Rails.application.config.repositories[:user_repository]
        @get_user = Usecases::User::GetUser.new(user_repository)
    end

    # ユーザー認証を行うメソッド
    # @param name [String] ユーザー名
    # @param password [String] パスワード
    # @return [User] 認証されたユーザーオブジェクト
    def user_authenticated?(name, password)
        get_user_result = @get_user.get_user_by_name(name)
        Rails.logger.debug "get_user_result:#{get_user_result}"
        if not get_user_result[:success]
            return nil
        end

        # パスワードのハッシュを取得
        stored_password_hash = get_user_result[:user].password
        bcrypt_password = BCrypt::Password.new(stored_password_hash)
        
        Rails.logger.debug "get_user_result:#{bcrypt_password}"
        Rails.logger.debug "password: #{password}"

        if bcrypt_password == password
            get_user_result[:user]
        else
            nil
        end
    end
end
