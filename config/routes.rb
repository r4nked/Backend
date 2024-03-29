# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :stacks, only: %i[show create]

  if Rails.env.cypress?
    require "reset_cypress"
    get "cypress/reset" => ResetCypress.new
  end

  root to: redirect(Rails.application.config.x.urls[:frontend])
end
