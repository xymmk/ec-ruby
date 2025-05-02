class CreateTaskUser < ActiveRecord::Migration[7.0]
  def up
    create_table :task_user do |t|
      t.bigint :task_id, null: false
      t.bigint :user_id, null: false
      # プライマリーキーを設定
      t.foreign_key :tasks, column: :task_id, primary_key: "task_id"
      t.foreign_key :users, column: :user_id, primary_key: "user_id"
    end
  end

  def down
    drop_table :task_user
  end
end
