FactoryBot.define do
  factory :discount do
    # percentage { Faker::Number.between(from: 0.10, to: 0.50) }
    # threshold { Faker::Number.between(from: 10, to: 50, increment: 5) }
    percentage { [10.0,15.0,20.0,25.0,30.0,35.0,40.0,45.0,50.0].sample}
    threshold { [10,15,20,25,30,35,40,45,50].sample }


  end
end

#sample
