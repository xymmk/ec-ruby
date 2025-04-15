class Repositories::Author::AuthorModel < ApplicationRecord
  def self.create(name, birth_date)
      # Placeholder implementation for creating an author
      sql = "INSERT INTO authors (name, birth_date) VALUES (?, ?)"
      ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([ sql, name, birth_date ]))
      true
  end
end
