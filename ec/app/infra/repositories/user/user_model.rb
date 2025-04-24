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
end
