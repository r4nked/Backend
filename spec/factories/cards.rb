# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    stack
    sequence(:name) { |i| "Card #{i}" }
  end
end
