class Repositories::Task::TaskModel < ApplicationRecord
    def self.get_tasks(get_tasks_criteria)
        user_id = get_tasks_criteria.user_id
        page = get_tasks_criteria.page
        per_page = get_tasks_criteria.per_page
        priority_sort = get_tasks_criteria.priority_sort
        created_sort = get_tasks_criteria.created_sort
        updated_sort = get_tasks_criteria.updated_sort


        # SQLクエリを生成
        sql = "SELECT * FROM tasks
               JOIN TASK_USER
               ON tasks.task_id = task_user.task_id
               WHERE task_user.user_id = ?
               ORDER BY priority #{priority_sort},
                        created #{created_sort},
                        updated #{updated_sort}
               LIMIT ?
               OFFSET ?
        "
        query_result = ActiveRecord::Base.connection.execute(
            ActiveRecord::Base.sanitize_sql_array([
              sql, user_id, per_page, (page - 1) * per_page
            ])
        )

        if query_result.any?
            query_result.map do |queried_task|
                task = Entities::Task::TaskEntity.new()
                task.task_id = queried_task["task_id"]
                task.user_id = queried_task["user_id"]
                task.priority = Entities::Task::TaskPriority.new(queried_task["priority"])
                task.name = queried_task["name"]
                task.description = queried_task["description"]
                task.status = Entities::Task::TaskStatus.new(queried_task["status"])
                task.user_id = user_id
                task.created = queried_task["created"]
                task.updated = queried_task["updated"]
                task
            end
        else
            []
        end
    end

    def self.count_tasks_with_user_id(user_id)
        # SQLクエリを生成
        sql = "SELECT count(*) FROM tasks
               JOIN TASK_USER
               ON tasks.task_id = task_user.task_id
               WHERE task_user.user_id = ?
        "
        query_result = ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([ sql, user_id ]))

        if query_result.any?
            query_result.first["count"].to_i
        else
            0
        end
    end

    def self.create(task)
        ApplicationRecord.transaction do
            # taskにインサートする
            Rails.logger.debug "insert task:#{task}"
            sql = "INSERT INTO tasks (priority, name, description, status, created, updated) VALUES (?, ?, ?, ?, ?, ?) RETURNING task_id"
            insert_task_result = ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([ sql, task.priority.to_i,
            task.name, task.description,
            task.status.to_i, task.created, task.updated ]))

            task_id = insert_task_result.first["task_id"].to_i

            # task_userにインサートする
            Rails.logger.debug "insert task_user:#{task}"
            sql = "INSERT INTO task_user (user_id, task_id) VALUES (?, ?)"
            ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([ sql, task.user_id,
            task_id ]))
        end
        true
    rescue Exception => e
        Rails.logger.error("Transaction failed: #{e.message}")
        raise Task::CannotCreateException.new("タスクの作成に失敗しました: #{e.message}")
    end

    def self.update(task)
        ApplicationRecord.transaction do
            Rails.logger.debug "task:#{task}"
            sql = "UPDATE tasks SET priority = ?, name = ?, description = ?, status = ?, updated = ? WHERE task_id = ?"
            ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([ sql, task.priority.to_i,
            task.name, task.description,
            task.status.to_i, task.updated, task.task_id ]))
        end
        true
    rescue Exception => e
        Rails.logger.error("Transaction failed: #{e.message}")
        raise Task::CannotUpdateException.new("タスクの更新に失敗しました: #{e.message}")
    end

    def self.delete(task_id)
        ApplicationRecord.transaction do
            Rails.logger.debug "task:#{task_id}"
            sql = "DELETE FROM tasks WHERE task_id = ?"
            ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([ sql, task_id ]))
        end
        true
    rescue Exception => e
        Rails.logger.error("Transaction failed: #{e.message}")
        raise Task::CannotDeleteException.new("タスクの削除に失敗しました: #{e.message}")
    end

    def self.get_task_by_id(task_id)
        # SQLクエリを生成
        sql = "SELECT * FROM tasks
               JOIN TASK_USER
               ON tasks.task_id = task_user.task_id
               WHERE tasks.task_id = ?"
        query_result = ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([ sql, task_id ]))

        queried_task = query_result.first
        if queried_task.any?
            task = Entities::Task::TaskEntity.new()
            task.task_id = queried_task["task_id"]
            task.user_id = queried_task["user_id"]
            task.priority = Entities::Task::TaskPriority.new(queried_task["priority"])
            task.name = queried_task["name"]
            task.description = queried_task["description"]
            task.status = Entities::Task::TaskStatus.new(queried_task["status"])
            task.created = queried_task["created"]
            task.updated = queried_task["updated"]
            task
        else
            nil
        end
    end
end
