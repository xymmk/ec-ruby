# タスクの優先度クラス
class Entities::Task::TaskPriority
    HIGH = 3.freeze
    MEDIUM = 2.freeze
    LOW = 1.freeze
    PRIORITY_TYPES = [HIGH, MEDIUM, LOW].freeze

    def initialize(value)
        unless PRIORITY_TYPES.include?(value)
            raise Task::CannotCreateException.new("優先度は#{PRIORITY_TYPES.join(",")}のいずれかでなければなりません。")
        end
        @value = value
    end

    def to_name
        if @value == HIGH
            return "HIGH"
        elsif @value == MEDIUM
            return "MEDIUM"
        elsif @value == LOW
            return "LOW"
        end
    end

    def to_i
        @value
    end
end
