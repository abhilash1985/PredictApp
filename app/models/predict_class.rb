# PredictClass
class PredictClass
  attr_accessor :tournament, :tournament_name, :tournament_type

  def initialize(tournament, tournament_name, tournament_type)
    @tournament = tournament
    @tournament_name = tournament_name
    @tournament_type = tournament_type
  end

  def klass_name
    new_klass_name = "#{tournament_type.capitalize}::#{tournament_type.capitalize}"
    if Object.const_defined?(new_klass_name)
      Object.const_get(new_klass_name).new(tournament)
    else
      raise "Class #{new_klass_name} not defined"
    end
  end
end
