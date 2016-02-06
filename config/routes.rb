Rails.application.routes.draw do
  namespace :api,  defaults: {format: :json} do
    namespace :v1 do
      resources :payments, only: [:create, :index]
    end
  end
end
