# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :stacks, only: %i[show create]

  if Rails.env.cypress?
    require "reset_cypress"
    get "__cypress__/reset" => ResetCypress.new
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root to: redirect(
             (Rails.application.config.x.urls[:frontend][:https] ? "https://" : "http://") +
               Rails.application.config.x.urls[:frontend][:host]
           )
end
