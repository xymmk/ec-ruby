require 'bcrypt'
class User::CreateUserService
    def initialize
        user_repository = Rails.application.config.repositories[:user_repository]
        user_validator = Usecases::User::UserValidator.new
        @create_user = Usecases::User::CreateUser.new(user_repository, user_validator)
    end

    def create_user(name, password, birth_date)
        user = Entities::User::UserEntity.new
        user.name = name
        user.password = encrypt_password(password)
        user.birth_date = birth_date
        user.created = Time.now
        user.updated = Time.now
        @create_user.execute(user)
    end

    private

    def encrypt_password(password)
        BCrypt::Password.create(password)
    end
end
