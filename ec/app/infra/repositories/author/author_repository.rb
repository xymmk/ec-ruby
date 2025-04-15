class Repositories::Author::AuthorRepository
  def create_author(author)
    Repositories::Author::AuthorModel.create(
      author.name,
      author.birth_date
    )
  end
end
