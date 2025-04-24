class CreateTask < ActiveRecord::Migration[7.0]
  def up
    create_table :tasks, id: false do |t|
      t.primary_key :task_id, :bigint
      t.integer :priority, null: false
      t.string :name, null: false
      t.string :description, null: false
      t.integer :status, default: 0
      t.datetime :create_date, null: false
      t.datetime :update_date, null: false
    end
  end

  def down
    drop_table :tasks
  end
end
