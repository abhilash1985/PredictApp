namespace :import do
  desc "Import master data"
  task master_data: [:tournaments, :stadiums, :teams, :rounds, :players,
                    :matches, :questions, :match_questions, :challenges] do
  end

  desc 'Import tournament data'
  task tournaments: :environment do
    tournament = Tournament.world_cup.aus_nzl.first_or_initialize
    tournament.start_date = '14-02-2015'
    tournament.end_date = '29-03-2015'
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
    begin
      file = "db/data/players.xls"
      Spreadsheet.open(file) do |sheet|
        sheet1 = sheet.worksheet 0
        sheet1.each 1 do |row|
          next if row[0].blank?
          team = Team.by_name(row[0].strip).first
          next if team.blank?
          player = team.players.by_first_name(row[1].strip).first_or_initialize
          player.player_style = row[2].strip
          player.save
        end
      end
      p "Imported players"
    rescue Exception => e
      puts "Error while importing #{e} #{e.backtrace}"
    end
  end

  desc 'Import Matches'
  task matches: :environment do
    ActiveRecord::Base.connection.execute 'TRUNCATE matches'
    team_uae = Team.by_name('UAE').first
    team_uae.update_attributes(name: 'United Arab Emirates') if team_uae 
    Match.matches.each_with_index do |hash, match_no|
      match = Match.by_match_no(match_no + 1).first_or_initialize
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
    ActiveRecord::Base.connection.execute 'TRUNCATE questions'
    questions = {
      # defaults
      'Who will win the match?' => 3,
      'Who will win the toss?' => 1,
      'Who will be the man of the match?' => 3,
      # runs
      'Runs will be scored by the team batting first?' => 2,
      'Runs will be scored by the team batting second?' => 2,
      'Runs will be scored by the team AFG will be?' => 2,
      'Runs will be scored by the team BAN will be?' => 2,
      'Runs will be scored by the team ENG will be?' => 2,
      'Runs will be scored by the team NZ will be?' => 2,
      'Runs will be scored by the team IND will be?' => 2,
      'Runs will be scored by the team PAK will be?' => 2,
      'Runs will be scored by the team SA will be?' => 2,
      'Runs will be scored by the team AUS will be?' => 2,
      'Runs will be scored by the team SRI will be?' => 2,
      'Runs will be scored by the team UAE will be?' => 2,
      'Runs will be scored by the team ZIM will be?' => 2,
      'Runs will be scored by the team WI will be?' => 2,
      'Runs will be scored by the team SCO will be?' => 2,
      'Runs will be scored by the team IRE will be?' => 2,
      # outs
      'No. of bowled outs that can happen in the match?' => 2,
      'No. of caught outs that can happen in the match?' => 2,
      'No. of run outs that can happen in the match?' => 2,
      'No. of LBW outs that can happen in the match?' => 2,
      # poer plays
      'How many runs will be scored in the batting power play by the team batting first?' => 1,
      'How many runs will be scored in the mandatory power play by the team batting first?' => 1,
      'How many runs will be scored in the batting power play by the team batting second?' => 1,
      'How many runs will be scored in the mandatory power play by the team batting second?' => 1,
      'How many runs will be scored in the slog overs by the team batting first?' => 1,
      'How many runs will be scored in the first 25 overs by the team batting first?' => 1,
      'How many runs will be scored in the first 25 overs by the team batting second?' => 1,
      # others
      'Winning margin will be?' => 2,
      'Who will the best bowler of the match?' => 2,
      'Who will be the top scorer of the match?' => 2,
      'Who will hit the most sixes of the match?' => 2,
      'Who will hit the most boundaries of the match?' => 2,
      'How many sixes will be hit by both the teams in the match?' => 2,
      'Highest individual score in the match will be?' => 2,
      'Who will be batting first?' => 2,
      'How many wickets will fell in the first innings of the match?' => 2,
      'How many wickets will fell in the first 25 overs of the match?' => 2
    }
    questions.each do |question, weightage|
      question = Question.by_question(question).first_or_initialize
      question.weightage = weightage
      question.save
    end
    p "Imported Questions..."
  end

  desc 'Import match questions'
  task match_questions: :environment do
    ActiveRecord::Base.connection.execute 'TRUNCATE match_questions'
    MatchQuestion.add_match_questions
    p "Imported Match Questions..."
  end

  desc 'Import challenges'
  task challenges: :environment do
    ActiveRecord::Base.connection.execute 'TRUNCATE challenges'
    Challenge.add_challenges
  end
end