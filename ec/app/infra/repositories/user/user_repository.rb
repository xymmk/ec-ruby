class Repositories::User::UserRepository
  def create_user(user)
    Repositories::User::UserModel.create(user)
  end

  def get_user_by_name(name)
    Repositories::User::UserModel.get_by_name(name)
  end

  def get_user_by_id(user_id)
    Repositories::User::UserModel.get_by_id(user_id)
  end
end
