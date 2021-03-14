namespace :import_ipl_2021 do
  desc 'Import master data'
  task master_data: [:tournaments, :stadiums, :teams, :rounds, :players,
                     :matches, :questions, :match_questions, :challenges] do
    # for initial run include :questions, :match_questions, :challenges
  end

  desc 'Import tournaments'
  task tournaments: :environment do
    tournament_type = TournamentType.where(name: 'ipl2021', game: 'cricket')
                                    .first_or_initialize
    tournament_type.save
    tournament = tournament_type.tournaments.ipl2021.first_or_initialize
    tournament.start_date = '09-04-2021'
    tournament.end_date = '30-05-2021'
    tournament.location = 'India'
    tournament.save
    p 'Imported Tournaments...'
  end

  desc 'Import stadiums'
  task stadiums: :environment do
    stadiums = %w[Chennai Mumbai Ahmedabad Delhi Bengaluru Kolkata]
    stadiums.each do |stadium|
      stadium = Stadium.by_name(stadium).first_or_initialize
      stadium.save
    end
    p 'Imported Stadiums...'
  end

  desc 'Import teams'
  task teams: :environment do
    teams = { 'Mumbai Indians' => [1, 'MI'],
              'Delhi Capitals' => [2, 'DC'],
              'Sunrisers Hyderabad' => [3, 'SRH'],
              'Royal Challengers Bangalore' => [4, 'RCB']
              'Kolkata Knight Riders' => [5, 'KKR'],
              'Punjab Kings' => [6, 'PBKS'],
              'Chennai Super Kings' => [7, 'CSK'],
              'Rajasthan Royals' => [8, 'RR'] }
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
    %w(GROUP-STAGE QUALIFIER1 ELIMINATOR QUALIFIER2 FINAL).each do |name|
      round = Round.by_name(name).first_or_initialize
      round.save
      p "Round: #{name}"
    end
    p 'Imported Rounds...'
  end

  desc 'Import players'
  task players: :environment do
    begin
      file = 'db/data/ipl_2021_players.xls'
      Spreadsheet.open(file) do |sheet|
        sheet1 = sheet.worksheet 0
        sheet1.each 1 do |row|
          next if row[0].blank?
          team = Team.by_name(row[0]).first
          next if team.blank?
          player = team.players.by_first_name(row[1].strip).first_or_initialize
          player.player_style = row[2].strip
          p "Team: #{row[0]}, Player: #{row[1]}, Style: #{row[2]}"
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
      file = 'db/data/ipl_2021_matches.xls'
      tournament = Tournament.ipl2021.first
      return if tournament.blank?
      Spreadsheet.open(file) do |sheet|
        sheet1 = sheet.worksheet 0
        sheet1.each 1 do |row|
          next if row[0].blank?
          team1 = Team.by_name(row[1].strip).first
          next if team1.blank?
          team2 = Team.by_name(row[2].strip).first
          next if team2.blank?
          match = tournament.matches.by_match_no(row[0])
                            .where(team1_id: team1.id, team2_id: team2.id)
                            .first_or_initialize
          stadium = Stadium.by_name(row[3].strip).first_or_initialize
          stadium.save
          match.stadium_id = stadium.try(:id)
          round = Round.by_name('GROUP-STAGE').first
          match.round_id = round.try(:id)
          match.match_date = row[4].to_time.in_time_zone('Chennai')
          match.save!
          p "#{match.id}: #{row[0]}: #{row[1]} V #{row[2]} at #{row[3]} on #{row[4]}"
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
    predict_app = generate_predict_class.klass_name.new
    questions = predict_app.all_questions
    questions.each do |quest, weightage|
      question = Question.by_question(quest).first_or_initialize
      question.weightage = weightage[0]
      question.save
      p "#{question.id}: Question: #{quest}, Weightage: #{weightage[0]}, Options: #{weightage[1]}"
    end
    p 'Imported Questions...'
  end

  desc 'Import match questions'
  task match_questions: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE match_questions'
    generate_predict_class
    @predict_class.import_match_questions
    p 'Imported Match Questions...'
  end

  desc 'Import challenges'
  task challenges: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE challenges'
    # ActiveRecord::Base.connection.execute 'TRUNCATE predictionss'
    generate_predict_class
    @predict_class.import_challenges
    p 'Imported Challenges...'
  end

  def generate_predict_class
    tournament = Tournament.ipl2021.first
    tournament_type = TournamentType.ipl2021.first
    @predict_class = PredictClass.new(tournament, tournament_type.name, tournament_type.game)
  end
end
