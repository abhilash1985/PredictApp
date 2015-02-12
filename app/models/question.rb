class Question < ActiveRecord::Base
  scope :by_question, ->(question) { where(question: question) }
end
