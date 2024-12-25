# frozen_string_literal: true

# Rack application that an endpoint allowing the Cypress front-end to reset the
# database before each E2E test run. Only mounted in the `cypress` environment.

class ResetCypress

  # @private
  def call(_env)
    reset
    return response
  end

  private

  def reset
    models.each { truncate it }
    create_fixtures
    reset_emails
  end

  def response = [200, {"Content-Type" => "text/plain"}, ["Cypress reset finished"]]

  def models = ApplicationRecord.subclasses

  def truncate(model)
    model.connection.execute "TRUNCATE #{model.quoted_table_name} CASCADE"
    model.connection.execute "ALTER SEQUENCE #{model.sequence_name} RESTART WITH 1"
  end

  def create_fixtures
    Stack.create! name:       "Sci-fi shows",
                  card_names: [
                      "The Expanse", "Firefly", "Star Trek: Discovery", "Star Trek: The Next Generation",
                      "Battlestar Galactica", "Star Trek: Deep Space Nine", "Star Trek: Picard", "Enterprise",
                      "Star Trek: Voyager", "Caprica", "Battlestar Galactica: Blood and Chrome"
                  ].join("\n")
  end

  def reset_emails
    Dir.glob(maildir.join("*").to_s).each { FileUtils.rm it }
  end

  def maildir = Rails.root.join("tmp", "mails")
end
