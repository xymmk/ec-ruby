Rails.application.config.after_initialize do
  Rails.application.config.repositories = {
    author_repository: Repositories::Author::AuthorRepository.new,
    user_repository: Repositories::User::UserRepository.new
  }
end
