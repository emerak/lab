Rails.application.routes.draw do
  namespace :api,  defaults: {format: :json} do
    namespace :v1 do
      resources :payments, only: [:create, :index]
    end
  end

  namespace :external_resources do
    post :payment
  end
end
