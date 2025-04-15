class CreateAuthor < ActiveRecord::Migration[8.0]
  def up
    create_table :authors, id: false do |t|
      t.primary_key :user_id, :bigint
      t.string "name", null: false, limit: 500
      t.datetime "birth_date", null: false
    end
  end

  def down
    drop_table :authors
  end
end
