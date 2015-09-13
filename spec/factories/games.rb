FactoryGirl.define do
  factory :game do
    trait :with_players do
      after(:create) do |game|
        create_list :player, 4, game: game
      end
    end

    trait :with_three_players do
      after(:create) do |game|
        create_list :player, 3, game: game
      end
    end
  end
end
