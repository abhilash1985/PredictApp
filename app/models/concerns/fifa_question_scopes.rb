# FifaQuestionScopes
module FifaQuestionScopes
  extend ActiveSupport::Concern

  included do
    # FIFA QUESTION SCOPES
    scope :fifa_team_score, ->(name) { where(question: "Goals scored by #{name}?") }
    scope :fifa_defaults, -> { where(question: 'Who will win the match?') }
    scope :fifa_not_defaults, -> { where('question not like ?', '%Who will win the%') }
    scope :fifa_cards, ->(name) { where('question = ?', "Total shots by #{name}?") }
    scope :fifa_shots, -> { where('question like ?', 'Total shots%') }
    scope :fifa_possession, -> { where('question like ?', 'Possession percentage by%') }
    scope :match_ends_in, -> { where('question like ?', 'This Match ends in%') }

    scope :fifa_cards_percentage, lambda { |_name1, _name2|
      where('question like ? or question = ? or question = ?', 'No of%in the match%')
    }

    scope :fifa_ko_cards_defensive_only, lambda {
      where('(question like ? or question like ? or question like ?) and question not like ?',
            'No of%in the match%', 'Total no. of%',
            'Total no. of balls recovered in the match%',
            '%Red cards%').order('id desc')
    }

    scope :fifa_shots_first_goal_percentage, lambda { |name1, name2|
      where('question = ? or question = ? or
             question = ? or question = ? or
             question = ? or question = ? or
             question = ? or question = ? or
             question = ? or question = ? or
             question like ?', "Total shots by #{name1}?",
            "Total shots by #{name2}?",
            "Total shots on Target by #{name1}?",
            "Total shots on Target by #{name2}?",
            "Time of first goal by #{name1}?",
            "Time of first goal by #{name2}?",
            "Possession percentage by #{name1}?",
            "Possession percentage by #{name2}?",
            "Total pass accuracy by #{name1} in the match?",
            "Total pass accuracy by #{name2} in the match?",
            'Total goal attempts in the match%')
    }

    scope :fifa_shots_first_goal, lambda { |name1, name2|
      where('question = ? or question = ? or
             question = ? or question = ? or
             question = ? or question = ?', "Total shots by #{name1}?",
            "Total shots by #{name2}?",
            "Total shots on Target by #{name1}?",
            "Total shots on Target by #{name2}?",
            "Time of first goal by #{name1}?",
            "Time of first goal by #{name2}?")
    }

    scope :total_fouls, lambda {
      where('question like ?', 'No of Fouls%')
    }

    scope :corners, lambda {
      where('question like ?', 'No of Corners in the match%')
    }

    scope :total_cards, lambda {
      where('question like ?', 'Total no. of cards%')
    }

    scope :recovered_balls, lambda {
      where('question like ?', 'Total no. of balls recovered in the match%')
    }

    scope :tackled_balls, lambda {
      where('question like ?', 'Total no. of tackles in the match%')
    }

    scope :blocked_balls, lambda {
      where('question like ?', 'Total no. of blocks in the match%')
    }

    scope :cleared_balls, lambda {
      where('question like ?', 'Total no. of clearances in the match%')
    }

    scope :first_goal, lambda { |name1, name2|
      where('question = ? or question = ?', "Who will score first goal for #{name1}?",
            "Who will score first goal for #{name2}?")
    }

    scope :pass_accuracy, lambda { |name1, name2|
      where('question = ? or question = ?', "Total pass accuracy by #{name1} in the match?",
            "Total pass accuracy by #{name2} in the match?")
    }

    scope :time_of_first_goal, lambda { |name1, name2|
      where('question = ? or question = ?', "Time of first goal by #{name1}?",
            "Time of first goal by #{name2}?")
    }

    scope :possession_percentage, lambda { |name1, name2|
      where('question = ? or question = ?', "Possession percentage by #{name1}?",
            "Possession percentage by #{name2}?")
    }

    scope :distance_covered, lambda { |name1, name2|
      where('question = ? or question = ?', "Total distance(km) covered by #{name1}?",
            "Total distance(km) covered by #{name2}?")
    }

    scope :woodworks, lambda {
      where('question like ?', 'Total no. of woodworks in the match%')
    }

    scope :penalties, lambda {
      where('question like ?', 'Total no. of penalties in the match%')
    }

    scope :goal_attempts, lambda {
      where('question like ?', 'Total goal attempts in the match%')
    }

    scope :goal_type, lambda {
      where('question like ?', 'First goal in the match will be from%')
    }

    scope :mom, lambda {
      where('question like ?', 'Who will be Man of the Match%')
    }

    scope :golden_ball, lambda {
      where('question like ?', 'Who will win Golden Ball of the tournament%')
    }

    scope :third_place, lambda {
      where('question like ?', 'Who will win 3rd Place%')
    }

    scope :total_team_score, ->(name) { where(question: "Total Goals scored by #{name}?") }

    scope :first_goal_in_match, lambda { |name|
      where('question like ?', "Who will score first goal for #{name} in the match%")
    }

    scope :first_goal_by_any_team, lambda {
      where('question like ?', 'Who will score first goal in the Match%')
    }

    scope :pass_accuracy_in_match, lambda { |name|
      where('question like ?', "Total pass accuracy by #{name} in the match%")
    }

    scope :budweiser_mom, lambda {
      where('question like ?', 'Who will be Budweiser Man of the Match%')
    }

    scope :final_winner, lambda {
      where('question like ?', 'Who will win Fifa World Cup 2018%')
    }
  end
end
