# ユーザー作成エラー
# プロパティ
# - validate_errors: ユーザー作成時のバリデーションエラー
class User::CannotCreateException < StandardError
  attr_accessor :validate_errors

  def initialize(args)
    case args
    when String
      super(args)
    when Hash
      @validate_errors = args
    end
  end

end
