# frozen_string_literal: true

FactoryBot.define do
  factory :skill do
    name { Faker::Lorem.word }
  end
end
