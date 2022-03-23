# frozen_string_literal: true

# module Cricket for cricket related questions and answers
module Cricket
  # Ipl2020 # Ipl2021 # Ipl2022
  class Ipl2022 < Cwc2019
    # All other questions are imported from Cwc2019 & BasicClass
    prepend ::Cricket::IplBasicQuestions
    prepend ::Cricket::IplBasicOptions
    prepend ::Cricket::IplBasicPoints
    prepend ::Cricket::IplBonusQuestions
  end
end
