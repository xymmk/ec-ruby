# ユーザーエンティティ
# プロパティ
# - user_id: ユーザーID
# - name: ユーザー名
# - task_id: タスクID
# - password: パスワード
# - birth_date: 生年月日
# - created: 作成日時
# - updated: 更新日時
require "bcrypt"
class Entities::User::UserEntity
    attr_accessor :user_id, :name, :password, :birth_date, :task_id, :created, :updated

    BIRTH_DATE_REGEX = /\A\d{4}-\d{2}-\d{2}\z/.freeze

    # ユーザーエンティティの初期化
    # タスクIDは空の配列で初期化
    def initialize
        @task_id = []
    end

    def create_new_user(name, password, birth_date)
        set_new_user_name(name)
        set_new_user_password(password)
        set_new_user_birth_date(birth_date)
        @created = Time.now
        @updated = Time.now
        self
    end

    private

    def set_new_user_name(name)
        if name.blank?
            raise User::CannotCreateException.new("ユーザー名は必須です")
        elsif name.to_s.length > 500 || name.to_s.length < 1
            raise User::CannotCreateException.new("ユーザー名は1文字以上500文字以下で設定してください")
        end
        @name = name
    end

    def set_new_user_password(password)
        if password.blank?
            raise User::CannotCreateException.new("パスワードは必須です")
        elsif password.to_s.length > 500 || password.to_s.length < 1
            raise User::CannotCreateException.new("パスワードは1文字以上500文字以下で設定してください")
        end
        @password = encrypt_password(password)
    end

    def set_new_user_birth_date(birth_date)
        if birth_date.blank?
            raise User::CannotCreateException.new("生年月日は必須です")
        elsif !birth_date.to_s.match(BIRTH_DATE_REGEX)
            raise User::CannotCreateException.new("生年月日はYYYY-MM-DD形式で設定してください")
        elsif Date.parse(birth_date.to_s) >= Date.today
            raise User::CannotCreateException.new("生年月日は今日以前の日付で設定してください")
        end
        @birth_date = birth_date
    end

    # パスワードをハッシュ化するメソッド
    # @param password [String] パスワード
    # @return [String] ハッシュ化されたパスワード
    # @example
    #   encrypt_password("my_password") #=> "$2a$12$EIX5Z1Q0v8x5J6z4F7G3eOe5Y5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z"
    def encrypt_password(password)
        BCrypt::Password.create(password)
    end
end
