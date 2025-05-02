class Repositories::Task::TaskRepository

    def create_task(task)
        Repositories::Task::TaskModel.create(task)
    end

    def update_task(task)
        Repositories::Task::TaskModel.update(task)
    end

    def get_tasks(get_tasks_criteria)
        Repositories::Task::TaskModel.get_tasks(get_tasks_criteria)
    end

    def count_tasks_with_user_id(user_id)
        Repositories::Task::TaskModel.count_tasks_with_user_id(user_id)
    end

    def delete_task(task_id)
        Repositories::Task::TaskModel.delete(task_id)
    end

    def get_task_by_id(task_id)
        Repositories::Task::TaskModel.get_task_by_id(task_id)
    end

end
