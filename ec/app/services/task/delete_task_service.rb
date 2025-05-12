class Task::DeleteTaskService
    def initialize
        task_repository = Rails.application.config.repositories[:task_repository]
        @delete_task = Usecases::Task::DeleteTask.new(task_repository)
    end

    def delete_task(task_id)
        begin
            task_id_int = task_id.to_i
            @delete_task.execute(task_id_int)
        rescue StandardError => e
            Rails.logger.error("タスクの削除に失敗しました: #{e.message}")
            raise Task::CannotDeleteException.new("タスクの削除に失敗しました: #{e.message}")
        end
    end
end
