# This will guess the User class
FactoryGirl.define do
  factory :post do 
    description 'cool pic'

  end

  # This will use the User class (Admin would have been guessed)
end