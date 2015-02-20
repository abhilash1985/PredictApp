class Match < ActiveRecord::Base
  # Associations
  belongs_to :challenge
  belongs_to :stadium
  belongs_to :team1, class_name: 'Team', foreign_key: :team1_id
  belongs_to :team2, class_name: 'Team', foreign_key: :team2_id
  has_many :match_questions
  has_many :questions, through: :match_questions
  # validations
  validates :match_no, :team1_id, :team2_id, presence: true
  # Scopes
  scope :by_match_no, ->(match_no) { where(match_no: match_no) }
  scope :id_in, ->(match_ids) { where(id: match_ids) }
  scope :no_in, ->(match_no) { where(match_no: match_no) }
  scope :by_challenge, ->(challenge) { where(challenge_id: challenge.id) }

  def self.by_team(team_id)
    where('team1_id = :team OR team2_id = :team_id', team: team_id)
  end

  def team1_name
    team1.try(:name)
  end

  def team2_name
    team2.try(:name)
  end

  def team_players(team)
    send(team).players.pluck(:id, :first_name, :player_style)
              .collect { |u| ["#{u[1]} (#{u[2].upcase})", u[0]] }
  end

  def team1_short_name
    team1.try(:short_name)
  end

  def team2_short_name
    team2.try(:short_name)
  end

  def full_name
    "Match #{match_no} : #{team1_short_name} VS #{team2_short_name}"
  end

  def stadium_name
    stadium.try(:name)
  end

  def total_points
    match_questions.sum(:points)
  end

  def started?
    match_date <= Time.now
  end

  class << self
    def matches
      [{"city"=>"Christchurch", "stadium"=>"Hagley Oval", "match_date"=>"2015-02-14",
        "match_day"=>"Saturday", "match_type"=>"D", "team_two_long"=>"Sri Lanka",
        "team_two_short"=>"SRI", "team_one_long"=>"New Zealand", "team_one_short"=>"NZ",
        "start_time"=>"11=>00 am", "match_datetime"=>"2015-02-14 03:00", "timezone"=>"Pacific/Auckland",
        "pool"=>"A"}, {"city"=>"Melbourne", "stadium"=>"MCG", "match_date"=>"2015-02-14",
          "match_day"=>"Saturday", "match_type"=>"DN", "team_one_long"=>"Australia",
          "team_one_short"=>"AUS", "team_two_long"=>"England", "team_two_short"=>"ENG",
          "start_time"=>"02=>30 pm", "match_datetime"=>"2015-02-14 07:30",
          "timezone"=>"Australia/Melbourne", "pool"=>"A"}, {"city"=>"Hamilton",
            "stadium"=>"Seddon Park", "match_date"=>"2015-02-15", "match_day"=>"Sunday",
            "match_type"=>"DN", "team_one_long"=>"South Africa", "team_one_short"=>"SA",
            "team_two_long"=>"Zimbabwe", "team_two_short"=>"ZIM", "start_time"=>"02=>00 pm",
            "match_datetime"=>"2015-02-15 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"B"},
            {"city"=>"Adelaide", "stadium"=>"Adelaide Oval", "match_date"=>"2015-02-15",
              "match_day"=>"Sunday", "match_type"=>"DN", "team_one_long"=>"India", "team_one_short"=>"IND",
              "team_two_long"=>"Pakistan", "team_two_short"=>"PAK", "start_time"=>"02=>00 pm",
              "match_datetime"=>"2015-02-15 07:30", "timezone"=>"Australia/Adelaide", "pool"=>"B"},
              {"city"=>"Nelson", "stadium"=>"Saxton Oval", "match_date"=>"2015-02-16", "match_day"=>"Monday",
                "match_type"=>"D", "team_one_long"=>"West Indies", "team_one_short"=>"WI", "team_two_long"=>"Ireland",
                "team_two_short"=>"IRE", "start_time"=>"11=>00 am", "match_datetime"=>"2015-02-16 03:00",
                "timezone"=>"Pacific/Auckland", "pool"=>"B"}, {"city"=>"Dunedin", "stadium"=>"University Oval",
                  "match_date"=>"2015-02-17", "match_day"=>"Tuesday", "match_type"=>"D", "team_one_long"=>"New Zealand",
                  "team_one_short"=>"NZ", "team_two_long"=>"Scotland", "team_two_short"=>"SCO",
                  "start_time"=>"11=>00 am", "match_datetime"=>"2015-02-17 03:00", "timezone"=>"Pacific/Auckland",
                  "pool"=>"A"}, {"city"=>"Canberra", "stadium"=>"Manuka Oval", "match_date"=>"2015-02-18",
                    "match_day"=>"Wednesday", "match_type"=>"DN", "team_one_long"=>"Bangladesh", "team_one_short"=>"BAN",
                    "team_two_long"=>"Afghanistan", "team_two_short"=>"AFG", "start_time"=>"02=>30 pm",
                    "match_datetime"=>"2015-02-18 07:30", "timezone"=>"Australia/Hobart", "pool"=>"A"},
                    {"city"=>"Nelson", "stadium"=>"Saxton Oval", "match_date"=>"2015-02-19", "match_day"=>"Thursday",
                      "match_type"=>"D", "team_one_long"=>"Zimbabwe", "team_one_short"=>"ZIM",
                      "team_two_long"=>"United Arab Emirates", "team_two_short"=>"UAE", "start_time"=>"11=>00 am",
                      "match_datetime"=>"2015-02-19 03:00", "timezone"=>"Pacific/Auckland", "pool"=>"B"},
                      {"city"=>"Wellington", "stadium"=>"Regional Stadium", "match_date"=>"2015-02-20",
                        "match_day"=>"Friday", "match_type"=>"DN", "team_two_long"=>"England", "team_two_short"=>"ENG",
                        "team_one_long"=>"New Zealand", "team_one_short"=>"NZ", "start_time"=>"02=>00 pm",
                        "match_datetime"=>"2015-02-20 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"A"},
                        {"city"=>"Christchurch", "stadium"=>"Hagley Oval", "match_date"=>"2015-02-21",
                          "match_day"=>"Saturday", "match_type"=>"D", "team_one_long"=>"Pakistan", "team_one_short"=>"PAK",
                          "team_two_long"=>"West Indies", "team_two_short"=>"WI", "start_time"=>"11=>00 am",
                          "match_datetime"=>"2015-02-21 03:00", "timezone"=>"Pacific/Auckland", "pool"=>"B"},
                          {"city"=>"Brisbane", "stadium"=>"Gabba", "match_date"=>"2015-02-21", "match_day"=>"Saturday",
                            "match_type"=>"DN", "team_one_long"=>"Australia", "team_one_short"=>"AUS",
                            "team_two_long"=>"Bangladesh", "team_two_short"=>"BAN", "start_time"=>"01=>30 pm",
                            "match_datetime"=>"2015-02-21 08:00", "timezone"=>"Australia/Brisbane", "pool"=>"A"},
                            {"city"=>"Dunedin", "stadium"=>"University Oval", "match_date"=>"2015-02-22",
                              "match_day"=>"Sunday", "match_type"=>"D", "team_one_long"=>"Sri Lanka", "team_one_short"=>"SRI",
                              "team_two_long"=>"Afghanistan", "team_two_short"=>"AFG", "start_time"=>"11=>00 am",
                              "match_datetime"=>"2015-02-22 03:00", "timezone"=>"Pacific/Auckland", "pool"=>"A"},
                              {"city"=>"Melbourne", "stadium"=>"MCG", "match_date"=>"2015-02-22", "match_day"=>"Sunday",
                                "match_type"=>"DN", "team_one_long"=>"South Africa", "team_one_short"=>"SA",
                                "team_two_long"=>"India", "team_two_short"=>"IND", "start_time"=>"02=>30 pm",
                                "match_datetime"=>"2015-02-22 07:30", "timezone"=>"Australia/Melbourne", "pool"=>"B"},
                                {"city"=>"Christchurch", "stadium"=>"Hagley Oval", "match_date"=>"2015-02-23",
                                  "match_day"=>"Monday", "match_type"=>"D", "team_one_long"=>"England", "team_one_short"=>"ENG",
                                  "team_two_long"=>"Scotland", "team_two_short"=>"SCO", "start_time"=>"11=>00 am",
                                  "match_datetime"=>"2015-02-23 03:00", "timezone"=>"Pacific/Auckland", "pool"=>"A"},
                                  {"city"=>"Canberra", "stadium"=>"Manuka Oval", "match_date"=>"2015-02-24",
                                    "match_day"=>"Tuesday", "match_type"=>"DN", "team_one_long"=>"West Indies", "team_one_short"=>"WI", "team_two_long"=>"Zimbabwe", "team_two_short"=>"ZIM", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-02-24 07:30", "timezone"=>"Australia/Hobart", "pool"=>"B"}, {"city"=>"Brisbane", "stadium"=>"Gabba", "match_date"=>"2015-02-25", "match_day"=>"Wednesday", "match_type"=>"DN", "team_one_long"=>"Ireland", "team_one_short"=>"IRE", "team_two_long"=>"United Arab Emirates", "team_two_short"=>"UAE", "start_time"=>"01=>30 pm", "match_datetime"=>"2015-02-25 08:00", "timezone"=>"Australia/Brisbane", "pool"=>"B"}, {"city"=>"Dunedin", "stadium"=>"University Oval", "match_date"=>"2015-02-26", "match_day"=>"Thursday", "match_type"=>"D", "team_one_long"=>"Afghanistan", "team_one_short"=>"AFG", "team_two_long"=>"Scotland", "team_two_short"=>"SCO", "start_time"=>"11=>00 am", "match_datetime"=>"2015-02-26 03:00", "timezone"=>"Pacific/Auckland", "pool"=>"A"}, {"city"=>"Melbourne", "stadium"=>"MCG", "match_date"=>"2015-02-26", "match_day"=>"Thursday", "match_type"=>"DN", "team_one_long"=>"Sri Lanka", "team_one_short"=>"SRI", "team_two_long"=>"Bangladesh", "team_two_short"=>"BAN", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-02-26 07:30", "timezone"=>"Australia/Melbourne", "pool"=>"A"}, {"city"=>"Sydney", "stadium"=>"SCG", "match_date"=>"2015-02-27", "match_day"=>"Friday", "match_type"=>"DN", "team_one_long"=>"South Africa", "team_one_short"=>"SA", "team_two_long"=>"West Indies", "team_two_short"=>"WI", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-02-27 07:30", "timezone"=>"Australia/Sydney", "pool"=>"B"}, {"city"=>"Auckland", "stadium"=>"Eden Park", "match_date"=>"2015-02-28", "match_day"=>"Saturday", "match_type"=>"DN", "team_two_long"=>"Australia", "team_two_short"=>"AUS", "team_one_long"=>"New Zealand", "team_one_short"=>"NZ", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-02-28 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"A"}, {"city"=>"Perth", "stadium"=>"WACA", "match_date"=>"2015-02-28", "match_day"=>"Saturday", "match_type"=>"DN", "team_one_long"=>"India", "team_one_short"=>"IND", "team_two_long"=>"United Arab Emirates", "team_two_short"=>"UAE", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-02-28 10:30", "timezone"=>"Australia/Perth", "pool"=>"B"}, {"city"=>"Wellington", "stadium"=>"Regional Stadium", "match_date"=>"2015-03-01", "match_day"=>"Sunday", "match_type"=>"D", "team_one_long"=>"England", "team_one_short"=>"ENG", "team_two_long"=>"Sri Lanka", "team_two_short"=>"SRI", "start_time"=>"11=>00 am", "match_datetime"=>"2015-03-01 03:00", "timezone"=>"Pacific/Auckland", "pool"=>"A"}, {"city"=>"Brisbane", "stadium"=>"Gabba", "match_date"=>"2015-03-01", "match_day"=>"Sunday", "match_type"=>"DN", "team_one_long"=>"Pakistan", "team_one_short"=>"PAK", "team_two_long"=>"Zimbabwe", "team_two_short"=>"ZIM", "start_time"=>"01=>30 pm", "match_datetime"=>"2015-03-01 08:00", "timezone"=>"Australia/Brisbane", "pool"=>"B"}, {"city"=>"Canberra", "stadium"=>"Manuka Oval", "match_date"=>"2015-03-03", "match_day"=>"Tuesday", "match_type"=>"DN", "team_one_long"=>"South Africa", "team_one_short"=>"SA", "team_two_long"=>"Ireland", "team_two_short"=>"IRE", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-03 07:30", "timezone"=>"Australia/Hobart", "pool"=>"B"}, {"city"=>"Napier", "stadium"=>"McLean Park", "match_date"=>"2015-03-04", "match_day"=>"Wednesday", "match_type"=>"DN", "team_one_long"=>"Pakistan", "team_one_short"=>"PAK", "team_two_long"=>"United Arab Emirates", "team_two_short"=>"UAE", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-04 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"B"}, {"city"=>"Perth", "stadium"=>"WACA", "match_date"=>"2015-03-04", "match_day"=>"Wednesday", "match_type"=>"DN", "team_one_long"=>"Australia", "team_one_short"=>"AUS", "team_two_long"=>"Afghanistan", "team_two_short"=>"AFG", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-04 10:30", "timezone"=>"Australia/Perth", "pool"=>"A"}, {"city"=>"Nelson", "stadium"=>"Saxton Oval", "match_date"=>"2015-03-05", "match_day"=>"Thursday", "match_type"=>"D", "team_one_long"=>"Bangladesh", "team_one_short"=>"BAN", "team_two_long"=>"Scotland", "team_two_short"=>"SCO", "start_time"=>"11=>00 am", "match_datetime"=>"2015-03-05 03:00", "timezone"=>"Pacific/Auckland", "pool"=>"A"}, {"city"=>"Perth", "stadium"=>"WACA", "match_date"=>"2015-03-06", "match_day"=>"Friday", "match_type"=>"DN", "team_one_long"=>"India", "team_one_short"=>"IND", "team_two_long"=>"West Indies", "team_two_short"=>"WI", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-06 10:30", "timezone"=>"Australia/Perth", "pool"=>"B"}, {"city"=>"Auckland", "stadium"=>"Eden Park", "match_date"=>"2015-03-07", "match_day"=>"Saturday", "match_type"=>"DN", "team_one_long"=>"South Africa", "team_one_short"=>"SA", "team_two_long"=>"Pakistan", "team_two_short"=>"PAK", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-07 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"B"}, {"city"=>"Hobart", "stadium"=>"Bellerive Oval", "match_date"=>"2015-03-07", "match_day"=>"Saturday", "match_type"=>"DN", "team_one_long"=>"Zimbabwe", "team_one_short"=>"ZIM", "team_two_long"=>"Ireland", "team_two_short"=>"IRE", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-07 07:30", "timezone"=>"Australia/Hobart", "pool"=>"B"}, {"city"=>"Napier", "stadium"=>"McLean Park", "match_date"=>"2015-03-08", "match_day"=>"Sunday", "match_type"=>"D", "team_one_long"=>"New Zealand", "team_one_short"=>"NZ", "team_two_long"=>"Afghanistan", "team_two_short"=>"AFG", "start_time"=>"11=>00 am", "match_datetime"=>"2015-03-08 03:00", "timezone"=>"Pacific/Auckland", "pool"=>"A"}, {"city"=>"Sydney", "stadium"=>"SCG", "match_date"=>"2015-03-08", "match_day"=>"Sunday", "match_type"=>"DN", "team_one_long"=>"Australia", "team_one_short"=>"AUS", "team_two_long"=>"Sri Lanka", "team_two_short"=>"SRI", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-08 07:30", "timezone"=>"Australia/Sydney", "pool"=>"A"}, {"city"=>"Adelaide", "stadium"=>"Adelaide Oval", "match_date"=>"2015-03-09", "match_day"=>"Monday", "match_type"=>"DN", "team_one_long"=>"England", "team_one_short"=>"ENG", "team_two_long"=>"Bangladesh", "team_two_short"=>"BAN", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-09 07:30", "timezone"=>"Australia/Adelaide", "pool"=>"A"}, {"city"=>"Hamilton", "stadium"=>"Seddon Park", "match_date"=>"2015-03-10", "match_day"=>"Tuesday", "match_type"=>"DN", "team_one_long"=>"India", "team_one_short"=>"IND", "team_two_long"=>"Ireland", "team_two_short"=>"IRE", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-10 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"B"}, {"city"=>"Hobart", "stadium"=>"Bellerive Oval", "match_date"=>"2015-03-11", "match_day"=>"Wednesday", "match_type"=>"DN", "team_one_long"=>"Sri Lanka", "team_one_short"=>"SRI", "team_two_long"=>"Scotland", "team_two_short"=>"SCO", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-11 07:30", "timezone"=>"Australia/Hobart", "pool"=>"A"}, {"city"=>"Wellington", "stadium"=>"Regional Stadium", "match_date"=>"2015-03-12", "match_day"=>"Thursday", "match_type"=>"DN", "team_one_long"=>"South Africa", "team_one_short"=>"SA", "team_two_long"=>"United Arab Emirates", "team_two_short"=>"UAE", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-12 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"B"}, {"city"=>"Hamilton", "stadium"=>"Seddon Park", "match_date"=>"2015-03-13", "match_day"=>"Sunday", "match_type"=>"DN", "team_two_long"=>"Bangladesh", "team_two_short"=>"BAN", "team_one_long"=>"New Zealand", "team_one_short"=>"NZ", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-13 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"A"}, {"city"=>"Sydney", "stadium"=>"SCG", "match_date"=>"2015-03-13", "match_day"=>"Friday", "match_type"=>"DN", "team_one_long"=>"England", "team_one_short"=>"ENG", "team_two_long"=>"Afghanistan", "team_two_short"=>"AFG", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-13 07:30", "timezone"=>"Australia/Sydney", "pool"=>"A"}, {"city"=>"Auckland", "stadium"=>"Eden Park", "match_date"=>"2015-03-14", "match_day"=>"Saturday", "match_type"=>"DN", "team_one_long"=>"India", "team_one_short"=>"IND", "team_two_long"=>"Zimbabwe", "team_two_short"=>"ZIM", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-14 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"B"}, {"city"=>"Hobart", "stadium"=>"Bellerive Oval", "match_date"=>"2015-03-14", "match_day"=>"Saturday", "match_type"=>"DN", "team_one_long"=>"Australia", "team_one_short"=>"AUS", "team_two_long"=>"Scotland", "team_two_short"=>"SCO", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-14 07:30", "timezone"=>"Australia/Hobart", "pool"=>"A"}, {"city"=>"Napier", "stadium"=>"McLean Park", "match_date"=>"2015-03-15", "match_day"=>"Sunday", "match_type"=>"D", "team_one_long"=>"West Indies", "team_one_short"=>"WI", "team_two_long"=>"United Arab Emirates", "team_two_short"=>"UAE", "start_time"=>"11=>00 am", "match_datetime"=>"2015-03-15 03:00", "timezone"=>"Pacific/Auckland", "pool"=>"B"}, {"city"=>"Adelaide", "stadium"=>"Adelaide Oval", "match_date"=>"2015-03-15", "match_day"=>"Sunday", "match_type"=>"DN", "team_one_long"=>"Pakistan", "team_one_short"=>"PAK", "team_two_long"=>"Ireland", "team_two_short"=>"IRE", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-15 07:30", "timezone"=>"Australia/Adelaide", "pool"=>"B"}, {"city"=>"Sydney", "stadium"=>"SCG", "match_date"=>"2015-03-18", "match_day"=>"Wednesday", "match_type"=>"DN", "team_one_long"=>"A1", "team_one_short"=>"A1", "team_two_long"=>"B4", "team_two_short"=>"B4", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-18 07:30", "timezone"=>"Australia/Sydney", "pool"=>"F"}, {"city"=>"Melbourne", "stadium"=>"MCG", "match_date"=>"2015-03-19", "match_day"=>"Thursday", "match_type"=>"DN", "team_one_long"=>"A2", "team_one_short"=>"A2", "team_two_long"=>"B3", "team_two_short"=>"B3", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-19 07:30", "timezone"=>"Australia/Melbourne", "pool"=>"F"}, {"city"=>"Adelaide", "stadium"=>"Adelaide Oval", "match_date"=>"2015-03-20", "match_day"=>"Friday", "match_type"=>"DN", "team_one_long"=>"A3", "team_one_short"=>"A3", "team_two_long"=>"B2", "team_two_short"=>"B2", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-20 07:30", "timezone"=>"Australia/Adelaide", "pool"=>"F"}, {"city"=>"Wellington", "stadium"=>"Regional Stadium", "match_date"=>"2015-03-21", "match_day"=>"Saturday", "match_type"=>"DN", "team_one_long"=>"A4", "team_one_short"=>"A4", "team_two_long"=>"B1", "team_two_short"=>"B1", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-21 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"F"}, {"city"=>"Auckland", "stadium"=>"Eden Park", "match_date"=>"2015-03-24", "match_day"=>"Tuesday", "match_type"=>"DN", "team_one_long"=>"TBC", "team_one_short"=>"TBC", "team_two_long"=>"TBC", "team_two_short"=>"TBC", "start_time"=>"02=>00 pm", "match_datetime"=>"2015-03-24 06:00", "timezone"=>"Pacific/Auckland", "pool"=>"F"}, {"city"=>"Sydney", "stadium"=>"SCG", "match_date"=>"2015-03-26", "match_day"=>"Thursday", "match_type"=>"DN", "team_one_long"=>"TBC", "team_one_short"=>"TBC", "team_two_long"=>"TBC", "team_two_short"=>"TBC", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-26 07:30", "timezone"=>"Australia/Sydney", "pool"=>"F"}, {"city"=>"Melbourne", "stadium"=>"MCG", "match_date"=>"2015-03-29", "match_day"=>"Sunday", "match_type"=>"DN", "team_one_long"=>"TBC", "team_one_short"=>"TBC", "team_two_long"=>"TBC", "team_two_short"=>"TBC", "start_time"=>"02=>30 pm", "match_datetime"=>"2015-03-29 07:30", "timezone"=>"Australia/Melbourne", "pool"=>"F"}]
    end
  end

  rails_admin do
    # list do
      # field :team1_short_name
      # field :team2_short_name
      # field :created_at
    # end
  end
end
