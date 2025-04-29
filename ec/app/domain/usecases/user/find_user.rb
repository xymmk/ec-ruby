class Usecases::User::FindUser
    def initialize(user_repository)
        @user_repository = user_repository
    end

    def find_user_by_name(name)
        user = @user_repository.find_user_by_name(name)
        if user
            { success: true, user: user }
        else
            { success: false, user: nil }
        end
    end
    
    def find_user_by_id(user_id)
        user = @user_repository.find_user(user_id)
        if user
            { success: true, user: user }
        else
            { success: false, user: nil }
        end
    end
end
