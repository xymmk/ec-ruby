class FormValidationException < StandardError
    def initialize(field_name = "", message = "エラー発生しました")
        @field_name = field_name
        super(message)
    end

    def get_field_name
        @field_name
    end
end
