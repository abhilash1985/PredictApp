# FifaChallenges
module FifaChallenges
  extend ActiveSupport::Concern

  included do
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
    when 12
      %w(2018-06-30\ 00:00 2018-06-30\ 19:25)
    when 13
      %w(2018-07-01\ 00:00 2018-07-01\ 19:25)
    when 14
      %w(2018-07-02\ 00:00 2018-07-02\ 19:25)
    when 15
      %w(2018-07-03\ 00:00 2018-07-03\ 19:25)
    when 16
      %w(2018-07-06\ 00:00 2018-07-06\ 19:25)
    when 17
      %w(2018-07-07\ 00:00 2018-07-07\ 19:25)
    when 18
      %w(2018-07-10\ 00:00 2018-07-10\ 23:25)
    when 19
      %w(2018-07-11\ 00:00 2018-07-11\ 23:25)
    when 20
      %w(2018-07-14\ 00:00 2018-07-14\ 19:25)
    when 21
      %w(2018-07-15\ 00:00 2018-07-15\ 20:25)
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
      when 12
        %w(49 50)
      when 13
        %w(51 52)
      when 14
        %w(53 54)
      when 15
        %w(55 56)
      when 16
        %w(57 58)
      when 17
        %w(59 60)
      when 18
        %w(61)
      when 19
        %w(62)
      when 20
        %w(63)
      when 21
        %w(64)
      end
    Match.no_in(match_ids).update_all(challenge_id: id)
  end

  def self.add_challenges
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

  def self.add_eng_tour_challenges
    eng_tour = Tournament.india_tour_of_england.first
    return if eng_tour.blank?
    name = '3rd ODI'
    challenge = by_name(name).first_or_initialize
    challenge.tournament_id = eng_tour.id
    challenge.start_time = '2018-07-17 00:00'
    challenge.end_time = '2018-07-17 16:25'
    if challenge.save
      Match.by_match_no(4018).update_all(challenge_id: challenge.id)
    end
  end

  def self.find_challenges(play = 'ko')
    if play == 'ko'
      (12..15)
    elsif play == 'quarter'
      (16..17)
    elsif play == 'semi'
      (18..19)
    elsif play == 'finals'
      (20..21)
    else
      (1..11)
    end
  end

  def self.add_fifa_challenges(play = 'ko')
    world_cup = Tournament.fifa_world_cup.first
    return if world_cup.blank?
    find_challenges(play).each do |number|
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
