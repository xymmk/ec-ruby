class CreateUser < ActiveRecord::Migration[7.0]
  def up
    create_table :users, id: false do |t|
      t.primary_key :user_id, :bigint
      t.string :name, null: false, limit: 500
      t.string :password, null: false
      t.datetime :birth_date, false
      t.datetime :created, null: false
      t.datetime :updated, null: false
    end
  end

  def down
    drop_table :users
  end
end
