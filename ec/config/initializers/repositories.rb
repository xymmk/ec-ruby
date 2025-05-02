# リポジトリのインスタンスを生成する

Rails.application.config.after_initialize do
  Rails.application.config.repositories = {
    user_repository: Repositories::User::UserRepository.new,
    task_repository: Repositories::Task::TaskRepository.new,
  }
end
