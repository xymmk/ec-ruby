require 'bcrypt'
# ユーザー作成サービス
class User::CreateUserService
    def initialize
        user_repository = Rails.application.config.repositories[:user_repository]
        @user_validator = Usecases::User::UserValidator.new
        @create_user = Usecases::User::CreateUser.new(user_repository)
        @find_user = Usecases::User::FindUser.new(user_repository)
    end

    # ユーザーを作成するメソッド
    # @param name [String] ユーザー名
    # @param password [String] パスワード
    # @param birth_date [Date] 生年月日
    # @return [Hash] 成功した場合は{ success: true, errors: [] }、
    #                失敗した場合は{ success: false, errors: ["エラーメッセージ"] 
    def create_user(name, password, birth_date)
        user = Entities::User::UserEntity.new
        user.name = name
        user.password = password
        user.birth_date = birth_date

        # ユーザー名のバリデーション
        errors = @user_validator.validate(user)
        if errors.any?
            raise User::CannotCreateException.new(errors)
        end

        # ユーザー名は登録済か確認
        if is_exist_user?(name)
            error = { name: "ユーザー名はすでに使用されています。" }
            raise User::CannotCreateException.new(error)
        end
        
        user = Entities::User::UserEntity.new
        user.name = name
        user.password = encrypt_password(password)
        user.birth_date = birth_date
        user.created = Time.now
        user.updated = Time.now
        @create_user.execute(user)
    end

    private

    # ユーザー名がすでに存在するか確認するメソッド
    # @param name [String] ユーザー名
    # @return [Boolean] ユーザー名が存在する場合はtrue、存在しない場合はfalse
    def is_exist_user?(name)
        found_user_result = @find_user.find_user_by_name(name)
        found_user_result[:success]
    end

    # パスワードをハッシュ化するメソッド
    # @param password [String] パスワード
    # @return [String] ハッシュ化されたパスワード
    # @example
    #   encrypt_password("my_password") #=> "$2a$12$EIX5Z1Q0v8x5J6z4F7G3eOe5Y5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z"
    def encrypt_password(password)
        BCrypt::Password.create(password)
    end
end
