
class Author::AuthorsController < ApplicationController
    def index
        create_author_service = Author::AuthorService.new
        create_author_service.create_author("John Doe", "1980-01-01 12:11:10")
        render json: { ok: true }
    end
end
