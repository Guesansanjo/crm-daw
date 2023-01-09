# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    list
    title { Faker::Lorem.word }
  end
end
