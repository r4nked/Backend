# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

ActiveSupport::Reloader.to_prepare do
  ApplicationController.renderer.defaults.merge!(
    http_host: Rails.application.config.x.urls[:backend][:host],
    https:     Rails.application.config.x.urls[:backend][:https]
  )
end
