class Challenge < ActiveRecord::Base
  # Associations
  belongs_to :tournament
  has_many :matches
  has_many :user_challenges
  has_many :users, through: :user_challenges
  # Scopes
  scope :by_name, ->(name) { where(name: name) }

  def time_for(number)
    case number.to_i
    when 1
      %W(#{'2015-02-13 00:00'} #{'2015-02-13 23:59'})
    when 2
      %W(#{'2015-02-16 00:00'} #{'2015-02-17 23:59'})
    when 3
      %W(#{'2015-02-18 00:00'} #{'2015-02-19 23:59'})
    when 4
      %W(#{'2015-02-20 00:00'} #{'2015-02-20 23:59'})
    end
  end

  def update_match_for(number)
    match_ids = case number.to_i
    when 1
      %w(1 2 3 4 5)
    when 2
      %w(6 7 8)
    when 3
      %w(9 10 11)
    when 4
      %w(12 13 14)
    end
    Match.id_in(match_ids).update_all(challenge_id: id)
  end

  class << self
    def add_challenges
      world_cup = Tournament.world_cup.first
      return if world_cup.blank?
      %w(1 2 3 4).each do |number|
        name = 'Challenge ' + number
        challenge = by_name(name).first_or_initialize
        challenge.tournament_id = world_cup.id
        start_time, end_time = challenge.time_for(number)
        challenge.start_time = start_time
        challenge.end_time = end_time
        challenge.update_match_for(number) if challenge.save
      end
    end
  end
end
