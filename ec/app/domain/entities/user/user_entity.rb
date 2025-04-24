class Entities::User::UserEntity
    attr_accessor :user_id, :name,
                  :task_id, :password,
                  :birth_date, :created,
                  :updated
    def initialize
        @task_id = []
    end
end
