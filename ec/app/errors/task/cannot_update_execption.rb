class Task::CannotUpdateException < StandardError
    def initialize(message)
      super(message)
    end
end
