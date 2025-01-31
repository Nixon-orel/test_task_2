# frozen_string_literal: true

FactoryBot.define do
  factory :interest do
    name { Faker::Lorem.word }
  end
end
