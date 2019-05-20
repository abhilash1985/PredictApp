namespace :import_cwc2019 do
  desc 'Import master data'
  task master_data: [:tournaments, :stadiums, :teams, :rounds, # :players,
                     :matches, :questions, :match_questions, :challenges] do
    # for initial run include :questions, :match_questions, :challenges
  end

  desc 'Import tournaments'
  task tournaments: :environment do
    tournament_type = TournamentType.cwc2019.first
    tournament = tournament_type.tournaments.cricket_2019.first_or_initialize
    tournament.start_date = '30-05-2019'
    tournament.end_date = '14-07-2019'
    tournament.location = 'England & Wales'
    tournament.save
    p 'Imported Tournaments...'
  end

  desc 'Import stadiums'
  task stadiums: :environment do
    stadiums = %w(Lords Leeds)
    stadiums.each do |stadium|
      stadium = Stadium.by_name(stadium).first_or_initialize
      stadium.save
    end
    p 'Imported Stadiums...'
  end

  desc 'Import teams'
  task teams: :environment do
    teams = { 'Afghanistan' => [10, 'AFG'], 'Australia' => [5, 'AUS'], 'Bangladesh' => [7, 'BAN'],
              'England' => [1, 'ENG'], 'India' => [2, 'IND'], 'New Zealand' => [4, 'NZ'],
              'Pakistan' => [6, 'PAK'], 'South Africa' => [3, 'SA'],
              'Sri Lanka' => [9, 'SL'], 'West Indies' => [8, 'WI'] }
    teams.each do |name, rank|
      team = Team.by_name(name).first_or_initialize
      team.rank = rank[0]
      team.short_name = rank[1]
      p "Team: #{name}(#{rank[1]}) - Rank: #{rank[0]}"
      team.save
    end
    p 'Imported Teams...'
  end

  desc 'Import rounds'
  task rounds: :environment do
    %w(GROUP-STAGE SEMI-FINAL FINAL).each do |name|
      round = Round.by_name(name).first_or_initialize
      round.save
      p "Round: #{name}"
    end
    p 'Imported Rounds...'
  end

  desc 'Import players'
  task players: :environment do
    begin
      file = 'db/data/players.xls'
      Spreadsheet.open(file) do |sheet|
        sheet1 = sheet.worksheet 0
        sheet1.each 1 do |row|
          next if row[0].blank?
          team = Team.by_name(row[0]).first
          next if team.blank?
          player = team.players.by_first_name(row[1].strip).first_or_initialize
          player.player_style = row[2].strip
          player.save
        end
      end
      p 'Imported players'
    rescue => e
      puts "Error while importing #{e} #{e.backtrace}"
    end
  end

  desc 'Import Matches'
  task matches: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE matches'
    # ActiveRecord::Base.connection.execute 'TRUNCATE stadia'
    begin
      file = 'db/data/matches.xls'
      Spreadsheet.open(file) do |sheet|
        sheet1 = sheet.worksheet 0
        sheet1.each 1 do |row|
          next if row[0].blank?
          match = Match.by_match_no(row[0]).first_or_initialize
          team1 = Team.by_name(row[1].strip).first
          next if team1.blank?
          team2 = Team.by_name(row[2].strip).first
          next if team2.blank?
          match.team1_id = team1.id
          match.team2_id = team2.id
          stadium = Stadium.by_name(row[3].strip).first_or_initialize
          stadium.save
          match.stadium_id = stadium.try(:id)
          match.match_date = row[4].to_time
          match.save!
          p "#{row[0]}: #{row[1]} V #{row[2]} at #{row[3]} on #{row[4]}"
        end
      end
      p 'Imported Matches...'
    rescue => e
      puts "Error while importing #{e} #{e.backtrace}"
    end
  end

  desc 'Import questions'
  task questions: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE questions'
    questions = {
      # Defaults
      'Who will win the match?' => 10,
      'Who will win the toss?' => 2,
      'Who will be the man of the match?' => 5,
      # Runs
      'Runs will be scored by the team batting first?' => 5,
      'Runs will be scored by the team batting second?' => 5,
      'Runs will be scored by the team AFG?' => 2,
      'Runs will be scored by the team BAN?' => 2,
      'Runs will be scored by England?' => 5,
      # 'Runs will be scored by the team NZ?' => 2,
      'Runs will be scored by India?' => 5,
      'Runs will be scored by the team PAK?' => 2,
      'Runs will be scored by the team SA?' => 2,
      'Runs will be scored by the team AUS?' => 2,
      'Runs will be scored by the team SRI?' => 2,
      'Runs will be scored by the team UAE?' => 2,
      'Runs will be scored by the team ZIM?' => 2,
      'Runs will be scored by the team WI?' => 2,
      'Runs will be scored by the team SCO?' => 2,
      'Runs will be scored by the team IRE?' => 2,

      # Outs
      'Total No. of Bowled outs in the match?' => 2,
      'Total No. of Caught outs in the match?' => 2,
      'Total No. of Run outs in the match?' => 2,
      'Total No. of Stumped outs in the match?' => 2,
      'Total No. of LBW outs in the match?' => 2,

      # Extras
      'Total No. of Extras in the match?' => 2,
      'Total No. of Wides in the match?' => 2,
      'Total No. of No Balls in the match?' => 2,

      # Power Plays
      # 'How many runs will be scored in the Power Play1 by the team batting first?' => 2,
      'How many runs will be scored in the Power Play2 by the team batting first?' => 2,
      'How many runs will be scored in the Power Play3 by the team batting first?' => 2,
      'How many runs will be scored in the Power Play1 by the team batting second?' => 2,
      'How many runs will be scored in the Power Play2 by the team batting second?' => 2,
      'How many runs will be scored in the first 25 overs by the team batting first?' => 2,
      'How many runs will be scored in the first 25 overs by the team batting second?' => 2,

      # DRS
      'Total No. of DRS usage in the match?' => 2,

      # Others
      'Winning margin will be?' => 2,
      'Who will the best bowler of the match?' => 2,
      'Who will be the top scorer of the match?' => 2,
      'Who will hit the most no. of sixes of the match?' => 2,
      'Who will hit the most no. of boundaries of the match?' => 2,
      'Total no. of sixes in the match?' => 2,
      'Total no. of boundaries in the match?' => 2,
      'Highest individual score in the match will be?' => 2,
      # 'Who will be batting first?' => 2,
      'How many wickets will fell in the first innings of the match?' => 2,
      'How many wickets will fell in the first 25 overs of the match?' => 2
    }
    questions.each do |question, weightage|
      question = Question.by_question(question).first_or_initialize
      question.weightage = weightage
      question.save
    end
    p 'Imported Questions...'
  end

  desc 'Import match questions'
  task match_questions: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE match_questions'
    MatchQuestion.new.add_cwc2019_match_questions
    p 'Imported Match Questions...'
  end

  desc 'Import challenges'
  task challenges: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE challenges'
    Challenge.add_cwc2019_tour_challenges
    p 'Imported Challenges...'
  end
end
