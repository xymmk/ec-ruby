class Author::AuthorService
  def initialize
    @create_author = Usecases::Author::CreateAuthor.new(Rails.application.config.repositories[:author_repository])
    @author_validator = Usecases::Author::AuthorValidator.new
  end
  def create_author(name, birth_date)
    author_entity = Entities::Author::AuthorEntity.new(name, birth_date)
    errors = @author_validator.validate(author_entity)
    unless errors.empty?
      return { success: false, errors: errors }
    end
    @create_author.create(author_entity)
  end
end
