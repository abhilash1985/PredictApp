# EnglandTourMatchQuestion
module EnglandTourMatchQuestion
  extend ActiveSupport::Concern

  included do
  end

  def add_eng_tour_match_questions
    Match.by_match_no(4018).order(:id).each do |match|
      eng_tour_questions(match).each do |questions|
        questions.each do |question|
          self.class.create_match_question_for(match, question)
        end
      end
    end
  end

  def eng_tour_questions(match)
    [Question.defaults, Question.mom,
     Question.team_score(match.team1_name), Question.team_score(match.team2_name),
     Question.power_play2_batting_first, Question.caught_out, Question.extras,
     Question.drs, Question.winning_margin]
  end
end
