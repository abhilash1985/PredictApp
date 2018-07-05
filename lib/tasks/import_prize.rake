namespace :import do
  desc 'Import prize data'
  task prize_data: :environment do
    prize_details.each do |prize_type, amount|
      prize = Prize.where(prize_type: prize_type).first_or_initialize
      prize.amount = amount
      prize.save
    end
    p 'Imported Prize details...'
  end

  def prize_details
    {
      'Winner' => 500, 'Runner Up' => 350, '3rd Place' => 250,
      '4th Place' => 150, '5th Place' => 125, '6th Place' => 100,
      '7th Place' => 90, '8th Place' => 80, '9th Place' => 70,
      '10th Place' => 60, 'Best Prediction % (min 25 matches)' => 100,
      'Admin Charges' => 100
    }
  end
end
