class Task::GetUserTasksService
  def initialize
    task_repository = Rails.application.config.repositories[:task_repository]
    @get_tasks = Usecases::Task::GetTasks.new(task_repository)
  end

  def get_tasks(user_id, page, per_page, priority_sort, created_sort, updated_sort)
    # タスクを取得するための条件を設定
    get_tasks_criteria = Usecases::Task::GetTasksCriteria.new
    get_tasks_criteria.set_priority_sort(priority_sort)
    get_tasks_criteria.set_created_sort(created_sort)
    get_tasks_criteria.set_updated_sort(updated_sort)
    get_tasks_criteria.set_user_id(user_id)
    get_tasks_criteria.set_page(page)
    get_tasks_criteria.set_per_page(per_page)

    begin
      tasks = @get_tasks.get_tasks(get_tasks_criteria)
      total_tasks = @get_tasks.count_tasks_with_user_id(user_id)
      total_pages = (total_tasks / per_page).ceil

      return { tasks: tasks, total_tasks: total_tasks, total_pages: total_pages }
    rescue Task::GetTasksException => e
      Rails.logger.error("タスクを取得できませんでした。 (user_id: #{user_id}): #{e.message}")
      return { tasks: [], total_tasks: 0, total_pages: 0 }
    rescue StandardError => e
      Rails.logger.error("予期しないエラーが発生しました (user_id: #{user_id}): #{e.message}")
      return { tasks: [], total_tasks: 0, total_pages: 0 }
    end
  end

  def get_task_by_id(task_id)
    begin
      @get_tasks.get_task_by_id(task_id)
    rescue Task::GetTasksException => e
      Rails.logger.error("タスクを取得できませんでした。 (task_id: #{task_id}): #{e.message}")
      return nil
    rescue StandardError => e
      Rails.logger.error("予期しないエラーが発生しました (task_id: #{task_id}): #{e.message}")
      return nil
    end
  end
end
