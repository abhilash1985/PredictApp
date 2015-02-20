class MatchQuestion < ActiveRecord::Base
  has_many :predictions
  belongs_to :question #added by Ashik

  scope :by_match, ->(match) { where(match_id: match.id) }
  scope :by_question, ->(question) { where(question_id: question.id) }

  serialize :options, Hash

  class << self
    def add_match_questions
      Match.order(:id).each do |match|
        all_questions = [Question.defaults,
                         Question.others.offset(rand(7)).limit(3),
                         Question.outs.offset(rand(3)).limit(1),
                         Question.power_plays.offset(rand(6)).limit(1),
                         Question.team_score(match.team1_short_name.upcase),
                         Question.team_score(match.team2_short_name.upcase)]
        all_questions.each do |questions|
          questions.each do |question|
            create_match_question_for(match, question)
          end
        end
      end
    end

    def create_match_question_for(match, question)
      match_question = by_match(match).by_question(question).first_or_initialize
      match_question.options = question.all_options_for(match)
      match_question.points = question.weightage
      match_question.save
    end
  end
end
