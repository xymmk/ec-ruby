class Repositories::User::UserModel < ApplicationRecord
  def self.create(user)
    ApplicationRecord.transaction do
        Rails.logger.debug "user:#{user}"
        sql = "INSERT INTO users (name, password, birth_date, created, updated) VALUES (?, ?, ?, ?, ?)"
        ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([ sql, user.name,
        user.password, user.birth_date,
        user.created, user.updated ]))
    end
    true
    rescue Exception => e
        Rails.logger.error("Transaction failed: #{e.message}")
        false
    end

    def self.find_by_name(name)
        sql = "SELECT * FROM users WHERE name = ?"
        query_result = ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([ sql, name ]))
        if query_result.any?
            queried_user = query_result.first
            user = Entities::User::UserEntity.new()
            user.user_id = queried_user['user_id']
            user.name = queried_user['name']
            user.password = queried_user['password']
            user.birth_date = queried_user['birth_date']
            user.created = queried_user['created']
            user.updated = queried_user['updated']
            user
        else
            nil
        end
    end

    def self.find_by_id(user_id)
        sql = "SELECT * FROM users WHERE id = ?"
        query_result = ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([ sql, user_id ]))
        if query_result.any?
            queried_user = query_result.first
            user = Entities::User::UserEntity.new()
            user.user_id = queried_user['user_id']
            user.name = queried_user['name']
            user.password = queried_user['password']
            user.birth_date = queried_user['birth_date']
            user.created = queried_user['created']
            user.updated = queried_user['updated']
            user
        else
            nil
        end
    end

end
