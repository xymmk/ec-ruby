# ユーザー作成サービス
class User::CreateUserService
    def initialize
        user_repository = Rails.application.config.repositories[:user_repository]
        @create_user = Usecases::User::CreateUser.new(user_repository)
        @get_user = Usecases::User::GetUser.new(user_repository)
    end

    # ユーザーを作成するメソッド
    # @param name [String] ユーザー名
    # @param password [String] パスワード
    # @param birth_date [Date] 生年月日
    # @return [Hash] 成功した場合は{ success: true, errors: [] }、
    #                失敗した場合は{ success: false, errors: ["エラーメッセージ"]
    def create_user(name, password, birth_date)
        # ユーザー名は登録済か確認
        if is_exist_user?(name)
            error = { name: "ユーザー名はすでに使用されています。" }
            raise User::CannotCreateException.new(error)
        end

        user = Entities::User::UserEntity.new.create_new_user(name, password, birth_date)
        @create_user.execute(user)
    end

    private

    # ユーザー名がすでに存在するか確認するメソッド
    # @param name [String] ユーザー名
    # @return [Boolean] ユーザー名が存在する場合はtrue、存在しない場合はfalse
    def is_exist_user?(name)
        get_user_result = @get_user.get_user_by_name(name)
        get_user_result[:success]
    end
end
