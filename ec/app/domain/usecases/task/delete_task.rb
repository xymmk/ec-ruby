class Usecases::Task::DeleteTask
    def initialize(task_repository)
        @task_repository = task_repository
    end

    # タスクを削除する
    # @param task_id [Integer] タスクID
    def execute(task_id)
        if task_id.nil?
            Rails.logger.error("task_idはnilです。")
            raise Task::DeleteTaskException, "task_idはnilにできません。"
        end
        @task_repository.delete_task(task_id)
    end
end
