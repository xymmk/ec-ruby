class Usecases::Task::GetTasksCriteria
    attr_reader :page, :per_page, :user_id,
    :priority_sort, :created_sort, :updated_sort

    ASC = "ASC".freeze
    DESC = "DESC".freeze
    SORT_TYPES = [ ASC, DESC ].freeze

    def initialize
        @priority_sort = DESC
        @created_sort = DESC
        @updated_sort = DESC
    end

    def set_priority_sort(sort_type)
        sort_type = sort_type.upcase
        sort_type_included?(sort_type)
        @priority_sort = sort_type
    end

    def set_created_sort(sort_type)
        sort_type = sort_type.upcase
        sort_type_included?(sort_type)
        @created_sort = sort_type
    end

    def set_updated_sort(sort_type)
        sort_type = sort_type.upcase
        sort_type_included?(sort_type)
        @updated_sort = sort_type
    end

    def set_user_id(user_id)
        if user_id.nil? || user_id.to_s.empty?
            raise Task::GetTasksException, "ユーザーIDはnilまたは空文字列にできません。"
        end
        @user_id = user_id
    end

    def set_page(page)
        if page.nil? || page < 1
            raise Task::GetTasksException, "ページは1以上の整数でなければなりません。"
        end
        @page = page
    end

    def set_per_page(per_page)
        if per_page.nil? || per_page < 1
            raise Task::GetTasksException, "ページあたりのタスク数は1以上の整数でなければなりません。"
        end
        if per_page > 100
            raise Task::GetTasksException, "ページあたりのタスク数は100以下でなければなりません。"
        end
        @per_page = per_page
    end

    private

    def sort_type_included?(sort_type)
        SORT_TYPES.include?(sort_type) || raise(Task::GetTasksException, "ソードタイプの設定は無効です。")
    end
end
