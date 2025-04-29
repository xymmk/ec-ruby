# ユーザー作成のユースケース
class Usecases::User::CreateUser
  def initialize(user_repository)
    @user_repository = user_repository
  end

  # ユーザーを作成するメソッド
  # @param user [Entities::User::UserEntity] ユーザーエンティティ
  # @return [Hash] 成功した場合は{ success: true, errors: [] }
  # @throws [StandardError] ユーザー作成に失敗した場合
  def execute(user)
    begin
        is_create_user_success = @user_repository.create_user(user)
        { success: is_create_user_success, errors: [] }
    rescue StandardError => e
        Rails.logger.error "Error creating user: #{e.message}"
        raise User::CannotCreateException.new(e.message)
    end
  end
end
