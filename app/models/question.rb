# frozen_string_literal: true

# Question
class Question < ApplicationRecord
  include CricketQuestions
  include CricketOptions
  include FifaQuestionScopes
  include FifaOptions
  # Associaltions
  has_many :match_questions, dependent: :destroy
  has_many :matches, through: :match_questions
  has_many :question_options
  # Scopes
  scope :by_question, ->(question) { where(question: question) }
  scope :order_by_question, -> { order(:question) }
end
