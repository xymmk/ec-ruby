class Task::CannotDeleteException < StandardError
    def initialize(message)
      super(message)
    end
  end
  
