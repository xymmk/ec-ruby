class Task::CannotCreateException < StandardError
  def initialize(message)
    super(message)
  end
end
