namespace :import do
  desc "Import master data"
  task master_data: [:tournaments, :stadiums, :teams, :rounds, :players,
                     :matches, :questions, :match_questions, :challenges] do
    # for initial run include :questions, :match_questions, :challenges
  end

  desc 'Import tournament data'
  task tournaments: :environment do
    # tournament = Tournament.world_cup.aus_nzl.first_or_initialize
    tournament = Tournament.india_tour_of_england.first_or_initialize
    tournament.start_date = '27-06-2018'
    tournament.end_date = '07-09-2018'
    tournament.save
    p "Imported Tournaments..."
  end

  desc 'Import stadiums'
  task stadiums: :environment do
    stadiums = %W(Lords Leeds)
    stadiums.each do |stadium|
      stadium = Stadium.by_name(stadium).first_or_initialize
      stadium.save
    end
    p "Imported Stadiums..."
  end

  desc 'Import teams'
  task teams: :environment do
    teams = { 'Afghanistan' => 10, 'Australia' => 6, 'Bangladesh' => 7,
              'England' => 1, 'India' => 2, 'Ireland' => 12, 'New Zealand' => 4,
              'Pakistan' => 5, 'Scotland' => 13, 'South Africa' => 3,
              'Sri Lanka' => 8, 'United Arab Emirates' => 14, 'West Indies' => 9, 'Zimbabwe' => 11 }
    teams.each do |team, rank|
      team = Team.by_name(team).first_or_initialize
      team.rank = rank
      team.save
    end
    p "Imported Teams..."
  end

  desc 'Import rounds'
  task rounds: :environment do
    %W(3rd\ ODI).each do |name|
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
    rescue => e
      puts "Error while importing #{e} #{e.backtrace}"
    end
  end

  desc 'Import Matches'
  task matches: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE matches'
    team_uae = Team.by_name('UAE').first
    team_uae.update_attributes(name: 'United Arab Emirates') if team_uae
    # Match.matches.each_with_index do |hash, match_no|
    #   match = Match.by_match_no(match_no + 1).first_or_initialize
    #   team1 = Team.by_name(hash['team_one_long']).first || Team.by_name(hash['team_one_short']).first
    #   next if team1.blank?
    #   team1.update_attributes(short_name: hash['team_one_short'])
    #   team2 = Team.by_name(hash['team_two_long']).first || Team.by_name(hash['team_two_short']).first
    #   next if team2.blank?
    #   team2.update_attributes(short_name: hash['team_two_short'])
    #   match.team1_id = team1.id
    #   match.team2_id = team2.id
    #   stadium = Stadium.like_name(hash['city']).first
    #   match.stadium_id = stadium.try(:id)
    #   match.match_date = hash['match_datetime']
    #   match.save
    # end

    Match.india_tour_of_england.each_with_index do |hash, match_no|
      match = Match.by_match_no(4018).first_or_initialize
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
    # ActiveRecord::Base.connection.execute 'TRUNCATE questions'
    questions = {
      # Defaults
      'Who will win the match?' => 25,
      'Who will win the toss?' => 2,
      'Who will be the man of the match?' => 5,
      # Runs
      # 'Runs will be scored by the team batting first?' => 5,
      # 'Runs will be scored by the team batting second?' => 5,
      # 'Runs will be scored by the team AFG?' => 2,
      # 'Runs will be scored by the team BAN?' => 2,
      'Runs will be scored by England?' => 5,
      # 'Runs will be scored by the team NZ?' => 2,
      'Runs will be scored by India?' => 5,
      # 'Runs will be scored by the team PAK?' => 2,
      # 'Runs will be scored by the team SA?' => 2,
      # 'Runs will be scored by the team AUS?' => 2,
      # 'Runs will be scored by the team SRI?' => 2,
      # 'Runs will be scored by the team UAE?' => 2,
      # 'Runs will be scored by the team ZIM?' => 2,
      # 'Runs will be scored by the team WI?' => 2,
      # 'Runs will be scored by the team SCO?' => 2,
      # 'Runs will be scored by the team IRE?' => 2,

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
      # 'How many runs will be scored in the Power Play3 by the team batting first?' => 2,
      # 'How many runs will be scored in the Power Play1 by the team batting second?' => 2,
      # 'How many runs will be scored in the Power Play2 by the team batting second?' => 2,
      # 'How many runs will be scored in the first 25 overs by the team batting first?' => 2,
      # 'How many runs will be scored in the first 25 overs by the team batting second?' => 2,

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
    p "Imported Questions..."
  end

  desc 'Import match questions'
  task match_questions: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE match_questions'
    MatchQuestion.new.add_eng_tour_match_questions
    p "Imported Match Questions..."
  end

  desc 'Import challenges'
  task challenges: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE challenges'
    Challenge.add_eng_tour_challenges
    p "Imported Challenges..."
  end
end