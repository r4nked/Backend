# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.3.3"
gem "net-pop", github: "ruby/net-pop" # 3.3.3 hack fix

# FRAMEWORK
gem "bootsnap"
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
  gem "redcarpet", require: nil
  gem "yard", require: nil
end
