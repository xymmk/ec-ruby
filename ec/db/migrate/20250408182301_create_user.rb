class CreateUser < ActiveRecord::Migration[7.0]
  def up
    create_table :users, id: false do |t|
      t.primary_key :user_id, :bigint
      t.string :name, null: false, limit: 500
      t.string :password, null: false
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
