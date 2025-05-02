class Task::CreateTaskService
    def initialize
        task_repository = Rails.application.config.repositories[:task_repository]
        @create_task = Usecases::Task::CreateTask.new(task_repository)
    end

  # タスクを作成する
  # @param task [Entities::Task::TaskEntity] タスクエンティティ
  def create_task(user_id, name, description, priority, status)
    begin
      priority_int = priority.to_i
      status_int = status.to_i
      task = Entities::Task::TaskEntity.new.create_new_task(priority_int, name, description, status_int, user_id)
      created_task = @create_task.execute(task)
    rescue StandardError => e
      Rails.logger.error("タスクの作成に失敗しました: #{e.message}")
      raise Task::CannotCreateException.new("タスクの作成に失敗しました: #{e.message}")
    end
  end
end
