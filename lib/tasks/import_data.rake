namespace :import do
  desc "Import master data"
  task master_data: [:tournaments, :stadiums, :teams, :rounds, :players,
                    :matches, :questions] do
  end

  desc 'Import tournament data'
  task tournaments: :environment do
    tournament = Tournament.world_cup.aus_nzl.first_or_initialize
    tournament.start_date = '14-02-2015'
    tournament.start_date = '29-03-2015'
    tournament.save
    p "Imported Tournaments..."
  end

  desc 'Import stadiums'
  task stadiums: :environment do
    stadiums = %W(Adelaide Hobart Brisbane Auckland Christchurch
                  Canberra Napier Melbourne Nelson Hamilton Sydney
                  Dunedin Perth Wellington)
    stadiums.each do |statdium|
      stadium = Stadium.by_name(statdium).first_or_initialize
      stadium.save
    end
    p "Imported Stadiums..."
  end

  desc 'Import teams'
  task teams: :environment do
    teams = { 'Afghanistan' => 11, 'Australia' => 1, 'Bangladesh' => 9,
              'England' => 5, 'India' => 2, 'Ireland' => 12, 'New Zealand' => 6,
              'Pakistan' => 7, 'Scotland' => 13, 'South Africa' => 3,
              'Sri Lanka' => 4, 'United Arab Emirates' => 14, 'West Indies' => 8, 'Zimbabwe' => 10}
    teams.each do |team, rank|
      team = Team.by_name(team).first_or_initialize
      team.rank = rank
      team.save
    end
    p "Imported Teams..."
  end

  desc 'Import rounds'
  task rounds: :environment do
    %W(League #{'Quarter Final'} #{'Semi Final'} Final).each do |name|
      round = Round.by_name(name).first_or_initialize
      round.save
    end
    p "Imported Rounds..."
  end

  desc 'Import players'
  task players: :environment do
    # TODO
  end

  desc 'Import Matches'
  task matches: :environment do
    team_uae = Team.by_name('UAE').first
    team_uae.update_attributes(name: 'United Arab Emirates') if team_uae 
    Match.matches.each_with_index do |hash, match_no|
      match = Match.by_match_no(match_no).first_or_initialize
      team1 = Team.by_name(hash['team_one_long']).first || Team.by_name(hash['team_one_short']).first
      next if team1.blank?
      team1.update_attributes(short_name: hash['team_one_short'])
      team2 = Team.by_name(hash['team_two_long']).first || Team.by_name(hash['team_two_short']).first
      next if team2.blank?
      team2.update_attributes(short_name: hash['team_two_short'])
      match.team1_id = team1.id
      match.team2_id = team2.id
      stadium = Stadium.like_name(hash['city']).first
      match.stadium_id = stadium.try(:id)
      match.match_date = hash['match_datetime']
      match.save
    end
    p "Imported Matches..."
  end

  desc 'Import questions'
  task questions: :environment do
    questions = {
      'Who will win the match' => 3,
      'Who will win the toss' => 1,
      'Who will be batting first' => 1,
      'Runs will be scored by the team batting first' => 2,
      'Runs will be scored by the team batting second' => 2,
      'Who will be the man of the match' => 3,
      'Who will be the top scorer of the match' => 2,
      'Who will take the most wickets of the match' => 2,
      'Who will hit the most sixes of the match' => 2,
      'Who will hit the most boundaries of the match' => 2
    }
    questions.each do |question, weightage|
      question = Question.by_question(question).first_or_initialize
      question.weightage = weightage
      question.save
    end
    p "Imported Questions..."
  end
end