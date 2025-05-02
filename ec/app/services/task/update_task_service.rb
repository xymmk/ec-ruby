class Task::UpdateTaskService
    def initialize
        task_repository = Rails.application.config.repositories[:task_repository]
        @update_task = Usecases::Task::UpdateTask.new(task_repository)
        @get_tasks = Usecases::Task::GetTasks.new(task_repository)
    end


    def update_task(task_id, name, description, priority, status)
        task = @get_tasks.get_task_by_id(task_id)

        begin
            # タスクの更新
            priority_int = priority.to_i
            status_int = status.to_i
            task.update_task(priority_int, name, description, status_int)
            @update_task.execute(task)
        rescue StandardError => e
            Rails.logger.error("タスクの更新に失敗しました: #{e.message}")
            raise Task::CannotUpdateException.new("タスクの更新に失敗しました: #{e.message}")
        end
    end
end
