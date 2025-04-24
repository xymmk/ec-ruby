class Repositories::User::UserRepository
  def create_user(user)
    Repositories::User::UserModel.create(user)
  end
end
