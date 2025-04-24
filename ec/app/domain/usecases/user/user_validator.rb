require 'active_model'
class Usecases::User::UserValidator
  def validate(user)
    @errors = {}
    validate_name(user)
    validate_password(user)
    validate_birth_date(user)
    @errors.compact!
    @errors
  end

  private

  def validate_name(user)
    if user.name.blank?
     @errors[:name] = "ユーザー名は必須です"
    elsif user.name.to_s.length > 500 || user.name.to_s.length < 1
     @errors[:name] = "ユーザー名が1文字以上500文字以下と設定してください"
    end
  end

  def validate_password(user)
    if user.password.blank?
      @errors[:password] = "パスワードは必須です"
    elsif user.password.to_s.length > 500 || user.password.to_s.length < 1
      @errors[:password] = "パスワードが1文字以上500文字以下と設定してください"
    end
  end

  def validate_birth_date(user)
    if user.birth_date.blank?
      @errors[:birth_date] = "生年月日は必須です。"
    elsif !user.birth_date.to_s.match(BIRTH_DATE_REGEX)
      @errors[:birth_date] = "生年月日が正しい形式ではありません。YYYY-MM-DDの形式で入力してください。"
    elsif Date.parse(user.birth_date.to_s) >= Date.today
      @errors[:birth_date] = "生年月日は現在の日時より前の日付を設定してください。"
    end
  end

    BIRTH_DATE_REGEX = /\A\d{4}-\d{2}-\d{2}\z/.freeze
end
