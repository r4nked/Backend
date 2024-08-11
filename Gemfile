# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.3.4"

# FRAMEWORK
gem "bootsnap"
gem "kredis"
gem "puma"
gem "rack-cors"
gem "rails"
gem "redis"

# MODELS
gem "pg"

# CONTROLLERS
gem "responders"

# VIEWS
gem "jbuilder"

# ERRORS
gem "bugsnag"

group :development do
  # LINTING
  gem "brakeman", require: false

  # ERRORS
  gem "binding_of_caller"

  # FRAMEWORK
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
end

group :test do
  # SPECS
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "rspec-rails"

  # ISOLATION
  gem "database_cleaner"
  gem "ffaker"
  gem "webmock"

  # ASSERTIONS
  gem "json_expressions", require: "json_expressions/rspec"
end

group :doc do
  gem "redcarpet", require: false
  gem "yard", require: false
end

gem "dockerfile-rails", ">= 1.6", group: :development
