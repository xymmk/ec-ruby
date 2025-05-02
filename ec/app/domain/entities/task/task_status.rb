class Entities::Task::TaskStatus
    NOT_STARTED = 3.freeze
    DOING = 2.freeze
    COMPLETED = 1.freeze
    TASK_TYPES = [NOT_STARTED, DOING, COMPLETED].freeze

    def initialize(value)
        unless TASK_TYPES.include?(value)
            raise Task::CannotCreateException.new("ステータスは#{TASK_TYPES.join(",")}のいずれかでなければなりません。")
        end
        @value = value
    end

    def to_name
        if @value == NOT_STARTED
            return "NOT_STARTED"
        elsif @value == DOING
            return "DOING"
        elsif @value == COMPLETED
            return "COMPLETED"
        end
    end

    def to_i
        @value
    end
end
