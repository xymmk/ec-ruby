class Usecases::Task::CreateTask
  def initialize(task_repository)
    @task_repository = task_repository
  end

  # タスクを作成する
  # @param task [Entities::Task::TaskEntity] タスクエンティティ
  def execute(task)
    created_task = @task_repository.create_task(task)
  end
end
