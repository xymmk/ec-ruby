Rails.application.config.after_initialize do
  Rails.application.config.repositories = {
    author_repository: Repositories::Author::AuthorRepository.new
  }  
end
