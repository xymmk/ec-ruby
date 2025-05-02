class Entities::Task::TaskEntity
  # タスクエンティティ
  # プロパティ
  # - task_id: タスクID
  # - priority: 優先度
  # - name: タスク名
  # - description: タスク内容
  # - status: ステータス
  # - user_id: ユーザーID
  # - created: 作成日時
  # - updated: 更新日時
  attr_accessor :task_id, :priority,
                :name, :description,
                :status, :user_id, 
                :created, :updated

  # タスクエンティティの初期化
  def initialize
    @user_id = nil
  end

  def create_new_task(priority, name, description, status, user_id)
    set_new_task_priority(priority)
    set_new_task_name(name)
    set_new_task_description(description)
    set_new_task_status(status)
    set_new_task_user_id(user_id)
    @created = Time.now
    @updated = Time.now
    return self
  end

  def update_task(priority, name, description, status)
    if @task_id.nil?
      raise Task::CannotCreateException.new("タスクIDは必須です")
    end    
    set_new_task_priority(priority)
    set_new_task_name(name)
    set_new_task_description(description)
    set_new_task_status(status)
    @updated = Time.now
    return self
  end

  private

  def set_new_task_priority(priority)
    @priority = Entities::Task::TaskPriority.new(priority)
  end

  def set_new_task_name(name)
    if name.blank?
      raise Task::CannotCreateException.new("タスク名は必須です")
    elsif name.to_s.length > 500 || name.to_s.length < 1
      raise Task::CannotCreateException.new("タスク名は1文字以上500文字以下で設定してください")
    end
    @name = name
  end

  def set_new_task_description(description)
    if description.blank?
      raise Task::CannotCreateException.new("タスク内容は必須です")
    elsif description.to_s.length > 500 || description.to_s.length < 1
      raise Task::CannotCreateException.new("タスク内容は1文字以上500文字以下で設定してください")
    end
    @description = description
  end

  def set_new_task_status(status)
    @status = Entities::Task::TaskPriority.new(status)
  end

  def set_new_task_user_id(user_id)
    if user_id.nil? || user_id < 1
      raise Task::CannotCreateException.new("ユーザーIDは1以上の整数でなければなりません。")
    end
    @user_id = user_id
  end
end
