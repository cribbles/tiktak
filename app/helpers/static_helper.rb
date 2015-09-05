module StaticHelper
  def fake_question
    Faker::Lorem.sentence(3, false, 10).gsub('.', '?')
  end

  def fake_answer
    Faker::Lorem.sentence(18)
  end
end
