Rails.application.routes.draw do
  resources :stacks, only: %i[show create]

  if Rails.env.cypress?
    require 'reset_cypress'
    get 'cypress/reset' => ResetCypress.new
  end

  root to: redirect(Rails.application.config.x.urls[:frontend])
end
