require "rails_helper" 

RSpec.describe Usecases::Author::AuthorValidator do
  author_validator = Usecases::Author::AuthorValidator.new
  let(:valid_author) { Entities::Author::AuthorEntity.new("John Doe", "2000-01-01 00:00:00") }
  let(:invalid_author) { Entities::Author::AuthorEntity.new("", "2000-01-01 00:00:00") }
  describe "#validate" do
    it "returns true for a valid author" do
      validated_result = author_validator.validate(valid_author)
      expect(validated_result).to be_empty
    end

    it "returns false for an invalid author" do
      validated_result = author_validator.validate(valid_author)
      validated_result.each do |error|
        expect(error[:name].eql?("ユーザー名が1文字以上500文字以下と設定してください")).to be_truthy
      end
    end
  end
end
