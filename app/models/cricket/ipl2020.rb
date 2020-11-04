# module Cricket for cricket related questions and answers
module Cricket
  # Ipl2020
  class Ipl2020 < Cwc2019
    # All other questions are imported from Cwc2019 & BasicClass
    prepend ::Cricket::IplBasicQuestions
    prepend ::Cricket::IplBasicOptions
    prepend ::Cricket::IplBasicPoints
    prepend ::Cricket::IplBonusQuestions
  end
end
