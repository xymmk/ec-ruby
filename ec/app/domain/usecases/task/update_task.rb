class Usecases::Task::UpdateTask
  def initialize(task_repository)
    @task_repository = task_repository
  end

  # タスクを更新する
  # @param task [Entities::Task::TaskEntity] タスクエンティティ
  def execute(task)
    updated_task = @task_repository.update_task(task)
  end
end
