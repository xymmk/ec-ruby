class Repositories::User::UserRepository
  def create_user(user)
    Repositories::User::UserModel.create(user)
  end

  def find_user_by_name(name)
    Repositories::User::UserModel.find_by_name(name)
  end

  def find_user_by_id(user_id)
    Repositories::User::UserModel.find_by_id(user_id)
  end
end
