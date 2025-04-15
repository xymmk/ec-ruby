class Entities::Author::AuthorEntity
  attr_accessor :name, :birth_date
  def initialize(name, birth_date)
    @name = name
    @birth_date = birth_date
  end
end
