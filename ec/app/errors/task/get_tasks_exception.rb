class Task::GetTasksException < StandardError
  def initialize(message)
    super(message)
  end
end
