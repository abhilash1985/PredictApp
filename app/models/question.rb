class Question < ActiveRecord::Base
  has_many :match_questions
  has_many :matches, through: :match_questions
  scope :by_question, ->(question) { where(question: question) }
end
