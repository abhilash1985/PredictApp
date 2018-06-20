class Challenge < ActiveRecord::Base
  # Associations
  belongs_to :tournament
  has_many :matches
  has_many :user_challenges
  has_many :users, through: :user_challenges
  # Scopes
  scope :by_name, ->(name) { where(name: name) }
  scope :ids_in, ->(ids) { where(id: ids) }
  scope :current, -> { where('end_time > ?', DateTime.now).includes(matches: [{ team1: :players }, { team2: :players }, :stadium, :match_questions]) }
  scope :previous, -> { where('end_time < ?', DateTime.now).includes(matches: [{ team1: :players }, { team2: :players }, :stadium, :match_questions]) }
  scope :knockout, -> { where('id > ?', 26) }
  scope :completed, -> { where('end_time < ?', DateTime.now) }

  def name_with_date
    "#{name} - #{start_time.to_s(:date_only)}"
  end

  def started?
    end_time <= DateTime.now
  end

  def total_points
    matches.reduce(0) { |a, e| a + e.total_points }
  end

  def time_for(number)
    case number.to_i
    when 1
      %w(2015-02-20 00:00 2015-02-20 23:59)
    when 2
      %w(2015-02-20 00:00 2015-02-21 23:59)
    when 3
      %w(2015-02-20 00:00 2015-02-22 23:59)
    when 4
      %w(2015-02-23 00:00 2015-02-23 23:59)
    end
  end

  def fifa_time_for(number)
    case number.to_i
    when 1
      %w(2018-06-18\ 00:00 2018-06-18\ 17:25)
    when 2
      %w(2018-06-19\ 00:00 2018-06-19\ 17:25)
    when 3
      %w(2018-06-20\ 00:00 2018-06-20\ 17:25)
    when 4
      %w(2018-06-21\ 00:00 2018-06-21\ 17:25)
    when 5
      %w(2018-06-22\ 00:00 2018-06-22\ 17:25)
    when 6
      %w(2018-06-23\ 00:00 2018-06-23\ 17:25)
    when 7
      %w(2018-06-24\ 00:00 2018-06-24\ 17:25)
    when 8
      %w(2018-06-25\ 00:00 2018-06-25\ 19:25)
    when 9
      %w(2018-06-26\ 00:00 2018-06-26\ 19:25)
    when 10
      %w(2018-06-27\ 00:00 2018-06-27\ 19:25)
    when 11
      %w(2018-06-28\ 00:00 2018-06-28\ 19:25)
    end
  end

  def update_match_for(number)
    match_ids =
      case number.to_i
      when 1
        %w(12 13 14)
      when 2
        %w(15 16 17)
      when 3
        %w(18 19 20)
      when 4
        %w(21 22 23)
      when 5
        %w(24 25 26)
      when 6
        %w(27 28 29)
      when 7
        %w(30 31 32)
      when 8
        %w(33 34 35 36)
      when 9
        %w(37 38 39 40)
      when 10
        %w(41 42 43 44)
      when 11
        %w(45 46 47 48)
      end
    Match.no_in(match_ids).update_all(challenge_id: id)
  end

  class << self
    def add_challenges
      world_cup = Tournament.world_cup.first
      return if world_cup.blank?
      %w(1 2 3 4 5).each do |number|
        name = 'Challenge ' + number
        challenge = by_name(name).first_or_initialize
        challenge.tournament_id = world_cup.id
        start_time, end_time = challenge.fifa_time_for(number)
        challenge.start_time = start_time
        challenge.end_time = end_time
        if challenge.save
          challenge.matches.update_all(challenge_id: nil)
          challenge.update_match_for(number)
        end
      end
    end

    def add_fifa_challenges
      world_cup = Tournament.fifa_world_cup.first
      return if world_cup.blank?
      (1..11).each do |number|
        name = 'Challenge ' + number.to_s
        challenge = by_name(name).first_or_initialize
        challenge.tournament_id = world_cup.id
        start_time, end_time = challenge.fifa_time_for(number)
        challenge.start_time = start_time
        challenge.end_time = end_time
        if challenge.save
          challenge.matches.update_all(challenge_id: nil)
          challenge.update_match_for(number)
        end
      end
    end
  end
end
