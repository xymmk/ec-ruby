class Usecases::Task::GetTasks
  def initialize(task_repository)
    @task_repository = task_repository
  end

  # ユーザーIDに紐づくタスクを取得する
  # @param get_tasks_criteria [Usecases::Task::GetTasksCriteria] タスク取得条件
  # @return [Array] タスクの配列
  # @raise [Task::GetTasksException] タスク取得条件がnilの場合
  def get_tasks(get_tasks_criteria)
    if get_tasks_criteria.nil?
      Rails.logger.error("get_tasks_criteriaはnilです。")
      raise Task::GetTasksException, "get_tasks_criteriaはnilにできません。"
    end
    @task_repository.get_tasks(get_tasks_criteria)
  end

  def count_tasks_with_user_id(user_id)
    if user_id.nil?
      Rails.logger.error("user_idはnilです。")
      raise Task::GetTasksException, "user_idはnilにできません。"
    end
    count = @task_repository.count_tasks_with_user_id(user_id).to_f
  end

  # タスクIDに紐づくタスクを取得する
  # @param task_id [Integer] タスクID
  # @return [Task] タスク
  def get_task_by_id(task_id)
    if task_id.nil?
      Rails.logger.error("task_idはnilです。")
      raise Task::GetTasksException, "task_idはnilにできません。"
    end
    @task_repository.get_task_by_id(task_id)
  end
end
