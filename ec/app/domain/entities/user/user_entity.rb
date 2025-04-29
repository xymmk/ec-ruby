# ユーザーエンティティ
# プロパティ
# - user_id: ユーザーID
# - name: ユーザー名
# - task_id: タスクID
# - password: パスワード
# - birth_date: 生年月日
# - created: 作成日時
# - updated: 更新日時
class Entities::User::UserEntity
    attr_accessor :user_id, :name,
                  :task_id, :password,
                  :birth_date, :created,
                  :updated
                  
    # ユーザーエンティティの初期化
    # タスクIDは空の配列で初期化
    def initialize
        @task_id = []
    end
end
