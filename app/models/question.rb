# Question
class Question < ApplicationRecord
  include CricketQuestions
  include CricketOptions
  include FifaQuestionScopes
  include FifaOptions
  # Associaltions
  has_many :match_questions, dependent: :destroy
  has_many :matches, through: :match_questions
  # Scopes
  scope :by_question, ->(question) { where(question: question) }
end
