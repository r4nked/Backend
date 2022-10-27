# frozen_string_literal: true

json.partial! "stack", stack: @stack

json.rankings(@rankings) do |(card, rating)|
  json.name card.name
  json.ranking rating
end
