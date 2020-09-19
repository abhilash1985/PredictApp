# FanClubLeaderboard
module FanClubLeaderboard
  extend ActiveSupport::Concern

  included do
  end

  def fan_club_leader_board_data
    @leaderbord = ActiveRecord::Base.connection.select_all(fan_club_sql_statement)
  end

  def fan_club_sql_statement
    "SELECT
      us.id,
      CONCAT(us.name, ' (', us.short_name, ')') AS team_name,
      us.id AS user_id,
      b.total_points,
      b.paid_points,
      b.no_of_matches,
      b.total_match_points,
      b.prediction_percentage,
      b.no_of_zero_points,
      b.no_of_full_points
    FROM
      teams us
    LEFT JOIN
      (SELECT
          a.team_id,
        SUM(a.total_points) total_points,
        SUM(a.paid_points) AS paid_points,
        COUNT(a.match_id) AS no_of_matches,
        SUM(a.match_points) AS total_match_points,
        ROUND((SUM(a.total_points) * 100 / SUM(a.match_points)), 2) AS prediction_percentage,
        COUNT(CASE
            WHEN a.total_points = 0 THEN a.match_id
            ELSE NULL
        END) AS no_of_zero_points,
        SUM(a.no_of_full_points) no_of_full_points
      FROM
        (SELECT
          u.id, u.team_id,
            CONCAT(u.first_name, ' ', u.last_name) AS user,
            SUM(p.points) AS total_points,
            SUM(CASE
                WHEN uc.paid = TRUE THEN p.points
                ELSE 0
            END) AS paid_points,
            m.id AS match_id,
            SUM(mq.points) AS match_points,
            (CASE
                WHEN SUM(mq.points) = SUM(p.points) THEN 1
                ELSE 0
            END) AS no_of_full_points
        FROM
            users u
        INNER JOIN user_challenges uc ON uc.user_id = u.id
        INNER JOIN challenges c ON uc.challenge_id = c.id
        INNER JOIN matches m ON m.challenge_id = c.id
        INNER JOIN match_questions mq ON mq.match_id = m.id
        INNER JOIN predictions p ON p.user_challenge_id = uc.id
            AND p.match_question_id = mq.id
        WHERE
            p.points IS NOT NULL and c.tournament_id = #{id}
        GROUP BY u.id , user , m.id) a
      GROUP BY a.team_id
      ORDER BY a.team_id) b ON b.team_id = us.id
    ORDER BY us.name"
  end

  def fan_club_leader_board
    fan_club_leader_board_data
    @leaderbord.sort_by { |x| x['total_points'].to_i }.reverse
  end
end
