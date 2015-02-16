class MatchQuestion < ActiveRecord::Base
  has_many :predictions
  belongs_to :question #added by Ashik

  scope :by_match, ->(match) { where(match_id: match.id) }
  scope :by_question, ->(question) { where(question_id: question.id) }

  serialize :options, Hash

  class << self
    def add_match_questions
      Match.order(:id).each do |match|
        Question.order(:id).each do |question|
          match_question = by_match(match).by_question(question).first_or_initialize
          match_question.options = question.all_options_for(match)
          match_question.save
        end
      end
    end
  end
end
