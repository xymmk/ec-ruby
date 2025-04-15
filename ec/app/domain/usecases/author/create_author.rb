class Usecases::Author::CreateAuthor
  def initialize(author_repo)
    if author_repo.nil?
      raise ArgumentError, "Author repository cannot be nil"
    end
    @author_repo = author_repo
  end
  def create(author)
    @author_repo.create_author(author)
  end
end
