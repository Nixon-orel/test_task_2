# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name        { Faker::FunnyName.name }
    surname     { Faker::Lorem.word }
    patronymic  { Faker::Lorem.word }
    email       { Faker::Internet.email }
    gender      { %w[male female].sample }
    nationality { Faker::Lorem.word }
    country     { Faker::Address.country }
    age         { rand(0..90).to_s }

    after(:create) do |user, _evaluator|
      create_list(
        :interest,
        1,
        users: [ user ]
      )
      create_list(
        :skill,
        1,
        users: [ user ]
      )
    end
  end
end
