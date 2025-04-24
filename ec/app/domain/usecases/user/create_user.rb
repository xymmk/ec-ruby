class Usecases::User::CreateUser
  def initialize(user_repository, user_validator)
    @user_repository = user_repository
    @user_validator = user_validator
  end

  def execute(user)
    errors = @user_validator.validate(user)
    return { success: false, errors: errors } unless errors.empty?

    is_create_user_success = @user_repository.create_user(user)
    { success: is_create_user_success, errors: [] }
  end
end
