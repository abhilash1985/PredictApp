# PredictClass
class PredictClass
  attr_accessor :tournament, :tournament_name, :tournament_type

  def initialize(tournament, tournament_name, tournament_type)
    @tournament = tournament
    @tournament_name = tournament_name
    @tournament_type = tournament_type
  end

  def klass_name
    new_klass_name = "#{tournament_type.capitalize}::#{tournament_name.capitalize}"
    if Object.const_defined?(new_klass_name)
      Object.const_get(new_klass_name)
    else
      new_klass_name.constantize
    end
  rescue
    raise "Class #{new_klass_name} not defined"
  end

  def import_match_questions
    predict_app = klass_name
    tournament.matches.order(:id).each do |match|
      predict_app.new(match: match).import_match_questions
    end
  end

  def import_semi_match_questions
    predict_app = klass_name
    matches = tournament.matches.includes(:round).references(:round)
                        .where('rounds.name = ?', 'SEMI-FINAL')
    matches.order(:id).each_with_index do |match, index|
      predict_app.new(match: match, index: index).import_semi_match_questions
    end
  end

  def import_final_match_questions
    predict_app = klass_name
    matches = tournament.matches.includes(:round).references(:round)
                        .where('rounds.name = ?', 'FINAL')
    matches.order(:id).each_with_index do |match, index|
      predict_app.new(match: match, index: index).import_final_match_questions
    end
  end

  def import_challenges
    predict_app = klass_name
    grouped_matches = tournament.matches.order(:id).group_by { |x| x.match_date.to_date }
    grouped_matches.each_with_index do |(date, matches), index|
      predict_app.new(date: date, matches: matches, tournament: tournament, index: index,
                      challenge: 'VIVO IPL2020')
                 .import_challenges
    end
  end
end
