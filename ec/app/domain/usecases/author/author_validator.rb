class Usecases::Author::AuthorValidator
  def validate(author)
    errors = []
    errors << validate_name(author)
    errors << validate_birth_date(author)
    errors.compact
  end

  private

  def validate_name(author)
    if author.name.length > 500 || author.name.length < 1
      { name: "ユーザー名が1文字以上500文字以下と設定してください" }
    end
  end

  def validate_birth_date(author)
    unless author.birth_date.match(BIRTH_DATE_REGEX)
      { birth_date: "生年月日のフォーマットが無効です" }
    end
  end

  BIRTH_DATE_REGEX = /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\z/.freeze
end
